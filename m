Received: from eggs.gnu.org ([2001:4830:134:3::10]:43328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e7Pya-0006M2-8J
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e7PyV-0007BP-9F
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e7PyU-00079V-NB
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:00:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FD7FA8A2
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:00:17 +0000 (UTC)
Date: Wed, 25 Oct 2017 19:00:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171025173526.GE2484@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Crash with odd chardev setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Dan,
  I've got a crash in head (and 2.10) which is a bit of a heisenbug;
I can trigger it with:

./qemu-system-x86_64 -netdev tap,id=hostnet0,vhost=on,fd=10   -chardev socket,id=charchannel0,path=/tmp/org.qemu.guest_agent.0,server,nowait  -monitor stdio -vnc :0

and then 'q' to quit.

Note I'm not doing a redirect in of fd 10.
It goes away if I remove either the -netdev or the -chardev option.

It doesn't trigger under gdb, but fortunately we get a core:

#0  0x000055a226d94a2e in socket_listen_cleanup (fd=<optimized out>, errp=errp@entry=0x7fff3585e8c0)
    at /root/qemu/util/qemu-sockets.c:1077
    1077	    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
    1078	        && addr->u.q_unix.path) {
    1079	        if (unlink(addr->u.q_unix.path) < 0 && errno != ENOENT) {

#1  0x000055a226d4242b in qio_channel_socket_finalize (obj=<optimized out>) at /root/qemu/io/channel-socket.c:388
#2  0x000055a226cbca92 in object_unref (type=<optimized out>, obj=0x55a2290ab400) at /root/qemu/qom/object.c:462
#3  0x000055a226cbca92 in object_unref (data=0x55a2290ab400) at /root/qemu/qom/object.c:476
#4  0x000055a226cbca92 in object_unref (obj=0x55a2290ab400) at /root/qemu/qom/object.c:911
#5  0x000055a226d334c9 in char_socket_finalize (obj=<optimized out>) at /root/qemu/chardev/char-socket.c:805
#6  0x000055a226cbca92 in object_unref (type=<optimized out>, obj=0x55a2290aa7f0) at /root/qemu/qom/object.c:462
#7  0x000055a226cbca92 in object_unref (data=0x55a2290aa7f0) at /root/qemu/qom/object.c:476
#8  0x000055a226cbca92 in object_unref (obj=0x55a2290aa7f0) at /root/qemu/qom/object.c:911
#9  0x000055a226cbcacc in object_unref (obj=0x55a2290ab7a0) at /root/qemu/qom/object.c:413
#10 0x000055a226cbcacc in object_unref (data=0x55a2290ab7a0) at /root/qemu/qom/object.c:475
#11 0x000055a226cbcacc in object_unref (obj=0x55a2290ab7a0) at /root/qemu/qom/object.c:911
#12 0x000055a226cbba87 in object_property_del_child (obj=0x55a22909e770, child=0x55a2290ab7a0, errp=0x0)
    at /root/qemu/qom/object.c:436
#13 0x000055a226cbc2e4 in object_unparent (obj=<optimized out>) at /root/qemu/qom/object.c:455
#14 0x000055a226d2e7e5 in qemu_chr_cleanup () at /root/qemu/chardev/char.c:1090
#15 0x000055a2269c73ff in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at /root/qemu/vl.c:4914

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
