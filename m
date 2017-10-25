Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7T8t-000061-2m
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7T8n-0007OS-Vp
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7T8n-0007MO-P2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:23:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EB4F7EBDB
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 21:23:06 +0000 (UTC)
Date: Wed, 25 Oct 2017 22:23:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171025212302.GE30132@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171025173526.GE2484@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171025173526.GE2484@work-vm>
Subject: Re: [Qemu-devel] Crash with odd chardev setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 25, 2017 at 07:00:14PM +0100, Dr. David Alan Gilbert wrote:
> Hi Dan,
>   I've got a crash in head (and 2.10) which is a bit of a heisenbug;
> I can trigger it with:
> 
> ./qemu-system-x86_64 -netdev tap,id=hostnet0,vhost=on,fd=10   -chardev socket,id=charchannel0,path=/tmp/org.qemu.guest_agent.0,server,nowait  -monitor stdio -vnc :0
> 
> and then 'q' to quit.

Hmm, that doesn't trigger for me on git master at least.

> Note I'm not doing a redirect in of fd 10.

So it's trying & failing to setup the tap dev, right ?

eg you see this:

#  ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=hostnet0,vhost=on,fd=10   -chardev socket,id=charchannel0,path=/tmp/org.qemu.guest_agent.0,server,nowait  -monitor stdio -vnc :0
qemu-system-x86_64: -netdev tap,id=hostnet0,vhost=on,fd=10: TUNGETIFF ioctl() failed: Invalid argument
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) qemu-system-x86_64: warning: netdev hostnet0 has no peer

(qemu) q


Except it crashes at the end ?


> It goes away if I remove either the -netdev or the -chardev option.
> 
> It doesn't trigger under gdb, but fortunately we get a core:
> 
> #0  0x000055a226d94a2e in socket_listen_cleanup (fd=<optimized out>, errp=errp@entry=0x7fff3585e8c0)
>     at /root/qemu/util/qemu-sockets.c:1077
>     1077	    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
>     1078	        && addr->u.q_unix.path) {
>     1079	        if (unlink(addr->u.q_unix.path) < 0 && errno != ENOENT) {

Can you see from the core whether one of those pointers is NULL, or is there
a complete garbage pointer ?

I wonder if it triggers if you run QEMU under valgrind ? 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
