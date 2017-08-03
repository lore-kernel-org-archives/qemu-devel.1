Received: from eggs.gnu.org ([2001:4830:134:3::10]:36551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddJFY-0005iY-2N
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddJFU-0008Lq-TU
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddJFU-0008KZ-O9
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:45:24 -0400
Date: Thu, 3 Aug 2017 17:45:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170803164516.GG3673@work-vm>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170802144229.GA5821@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802144229.GA5821@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com

* Alberto Garcia (berto@igalia.com) wrote:
> On Thu, Jul 13, 2017 at 08:01:16PM +0100, Dr. David Alan Gilbert (git) wrote:
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -4787,8 +4787,8 @@ int main(int argc, char **argv, char **envp)
> >      replay_disable_events();
> >      iothread_stop_all();
> >  
> > -    bdrv_close_all();
> >      pause_all_vcpus();
> > +    bdrv_close_all();
> >      res_free();
> 
> I haven't debugged it yet, but in my computer iotest 093 stops working
> (it never finishes) after this change.

Yes, I can reproduce that here (I've got to explicitly run 093 - it
doesn't do it automatically for me):

(gdb) where
#0  0x00007feee3780b76 in ppoll () at /lib64/libc.so.6
#1  0x0000564aed293199 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>)
    at /usr/include/bits/poll2.h:77
#2  0x0000564aed293199 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=<optimized out>)
    at /home/dgilbert/git/qemu/util/qemu-timer.c:322
#3  0x0000564aed294de1 in aio_poll (ctx=ctx@entry=0x564aefa578e0, blocking=<optimized out>)
    at /home/dgilbert/git/qemu/util/aio-posix.c:622
#4  0x0000564aed215924 in bdrv_drain_recurse (bs=bs@entry=0x564aefa6c320) at /home/dgilbert/git/qemu/block/io.c:188
#5  0x0000564aed216345 in bdrv_drain_all_begin () at /home/dgilbert/git/qemu/block/io.c:353
#6  0x0000564aed2164b9 in bdrv_drain_all () at /home/dgilbert/git/qemu/block/io.c:382
#7  0x0000564aed1c9b63 in bdrv_close_all () at /home/dgilbert/git/qemu/block.c:3113
#8  0x0000564aeceb04fe in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at /home/dgilbert/git/qemu/vl.c:4795

Dave

> Berto
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
