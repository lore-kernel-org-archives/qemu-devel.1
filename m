Received: from eggs.gnu.org ([2001:4830:134:3::10]:54525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e81vs-0007CY-5c
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e81vo-0004fH-VM
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:32:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e81vo-0004au-MV
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:32:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D6B54ACA0
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 10:32:03 +0000 (UTC)
Date: Fri, 27 Oct 2017 11:31:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171027103158.GA5904@work-vm>
References: <20171025173526.GE2484@work-vm> <20171025212302.GE30132@redhat.com>
	<20171026134128.GA3523@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026134128.GA3523@work-vm>
Subject: Re: [Qemu-devel] Crash with odd chardev setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Wed, Oct 25, 2017 at 07:00:14PM +0100, Dr. David Alan Gilbert wrote:
> > > Hi Dan,
> > >   I've got a crash in head (and 2.10) which is a bit of a heisenbug;
> > > I can trigger it with:
> > > 
> > > ./qemu-system-x86_64 -netdev tap,id=hostnet0,vhost=on,fd=10   -chardev socket,id=charchannel0,path=/tmp/org.qemu.guest_agent.0,server,nowait  -monitor stdio -vnc :0
> > > 
> > > and then 'q' to quit.
> > 
> > Hmm, that doesn't trigger for me on git master at least.
> 
> Hmm.
> 
> > > Note I'm not doing a redirect in of fd 10.
> > 
> > So it's trying & failing to setup the tap dev, right ?
> > 
> > eg you see this:
> > 
> > #  ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=hostnet0,vhost=on,fd=10   -chardev socket,id=charchannel0,path=/tmp/org.qemu.guest_agent.0,server,nowait  -monitor stdio -vnc :0
> > qemu-system-x86_64: -netdev tap,id=hostnet0,vhost=on,fd=10: TUNGETIFF ioctl() failed: Invalid argument
> > QEMU 2.10.50 monitor - type 'help' for more information
> > (qemu) qemu-system-x86_64: warning: netdev hostnet0 has no peer
> > 
> > (qemu) q
> > 
> > 
> > Except it crashes at the end ?
> 
> Right.
> 
> > 
> > 
> > > It goes away if I remove either the -netdev or the -chardev option.
> > > 
> > > It doesn't trigger under gdb, but fortunately we get a core:
> > > 
> > > #0  0x000055a226d94a2e in socket_listen_cleanup (fd=<optimized out>, errp=errp@entry=0x7fff3585e8c0)
> > >     at /root/qemu/util/qemu-sockets.c:1077
> > >     1077	    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
> > >     1078	        && addr->u.q_unix.path) {
> > >     1079	        if (unlink(addr->u.q_unix.path) < 0 && errno != ENOENT) {
> > 
> > Can you see from the core whether one of those pointers is NULL, or is there
> > a complete garbage pointer ?
> 
> Gdb showed all the pointers as optimised out I think.
> 
> > I wonder if it triggers if you run QEMU under valgrind ? 
> 
> It does, but it shows: 
> ==29930== Thread 1:
> ==29930== Invalid read of size 4
> ==29930==    at 0x6F3A2E: socket_listen_cleanup (qemu-sockets.c:1077)
> ==29930==    by 0x6A142A: qio_channel_socket_finalize (channel-socket.c:388)
> ==29930==    by 0x61BA91: object_deinit (object.c:462)
> ==29930==    by 0x61BA91: object_finalize (object.c:476)
> ==29930==    by 0x61BA91: object_unref (object.c:911)
> ==29930==    by 0x6924C8: char_socket_finalize (char-socket.c:805)
> ==29930==    by 0x61BA91: object_deinit (object.c:462)
> ==29930==    by 0x61BA91: object_finalize (object.c:476)
> ==29930==    by 0x61BA91: object_unref (object.c:911)
> ==29930==    by 0x61BACB: object_property_del_all (object.c:413)
> ==29930==    by 0x61BACB: object_finalize (object.c:475)
> ==29930==    by 0x61BACB: object_unref (object.c:911)
> ==29930==    by 0x61AA86: object_property_del_child.isra.7 (object.c:436)
> ==29930==    by 0x3263FE: main (vl.c:4914)
> ==29930==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> 
> so I guess one of the pointers is NULL;   I guess I need a few printf's.

I can get rid of the actual crash by changing socket_listen_cleanup;

@@ -1074,7 +1074,7 @@ void socket_listen_cleanup(int fd, Error **errp)

     addr = socket_local_address(fd, errp);

-    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
+    if (addr && addr->type == SOCKET_ADDRESS_TYPE_UNIX
         && addr->u.q_unix.path) {

socket_local_address is failing with :
socket_listen_cleanup: fd=10 addr=(nil)
qemu-system-x86_64: Unable to query local socket address: Bad file descriptor

The difference under gdb seems to be the fd in cleanup is fd=14 so isn't
the same one as the bad fd passed in (I don't really understand why).

Dave
> Dave
> 
> > 
> > Regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
