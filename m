Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duYuK-0000Oe-CS
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duYuB-0001Er-V0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duYuB-0001Cb-MR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:54:43 -0400
Date: Wed, 20 Sep 2017 14:54:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920065434.GW3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-8-git-send-email-peterx@redhat.com>
	<5c8217a4-c169-c580-f461-e7173a772e31@redhat.com>
	<dd2bfb4d-2899-fad1-00a0-ffb833588618@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd2bfb4d-2899-fad1-00a0-ffb833588618@redhat.com>
Subject: Re: [Qemu-devel] [RFC 07/15] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Stefan Hajnoczi <shajnocz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Sep 19, 2017 at 04:48:35PM -0500, Eric Blake wrote:
> On 09/19/2017 04:35 PM, Eric Blake wrote:
> > On 09/14/2017 02:50 AM, Peter Xu wrote:
> >> There are many places for monitor init its globals, at least:
> >>
> 
> > Are we sure that this new function is called sooner than any access to
> > monitor_lock,
> > 
> >> -static void __attribute__((constructor)) monitor_lock_init(void)
> >> -{
> >> -    qemu_mutex_init(&monitor_lock);
> >> -}
> > 
> > especially since the old code initialized the lock REALLY early?
> 
> (Partially) answering myself:
> 
> > 
> > Pre-patch, a breakpoint on main() and on monitor_lock_init() fires on
> > monitor_lock_init() first, prior to main.
> > 
> > Breakpoint 2, monitor_lock_init () at /home/eblake/qemu/monitor.c:4089
> > 4089	    qemu_mutex_init(&monitor_lock);
> > (gdb) c
> > Continuing.
> > [New Thread 0x7fffce225700 (LWP 26380)]
> > 
> > Thread 1 "qemu-system-x86" hit Breakpoint 1, main (argc=5,
> >     argv=0x7fffffffdc88, envp=0x7fffffffdcb8) at vl.c:3077
> > 3077	{
> 
> Also, pre-patch, 'watch monitor_lock.initialized' and 'watch
> monitor_lock.lock.__data.__lock' show that the lock is first utilized at:
> 
> (gdb) bt
> #0  0x00007fffdac59e12 in __GI___pthread_mutex_lock
> (mutex=0x555556399340 <monitor_lock>) at ../nptl/pthread_mutex_lock.c:80
> #1  0x0000555555ce01ed in qemu_mutex_lock (mutex=0x555556399340
> <monitor_lock>)
>     at util/qemu-thread-posix.c:65
> #2  0x00005555557bc8b8 in monitor_init (chr=0x55555690bf70, flags=4)
>     at /home/eblake/qemu/monitor.c:4126
> #3  0x000055555591ae80 in mon_init_func (opaque=0x0,
> opts=0x55555688e3d0, errp=0x0) at vl.c:2482
> #4  0x0000555555cf3e63 in qemu_opts_foreach (list=0x555556225200
> <qemu_mon_opts>, func=0x55555591ad33 <mon_init_func>, opaque=0x0, errp=0x0)
>     at util/qemu-option.c:1104
> #5  0x0000555555920128 in main (argc=5, argv=0x7fffffffdc88,
> envp=0x7fffffffdcb8) at vl.c:4670
> 
> and double-checking qemu_mutex_lock, our .initialized member provides
> NICE runtime checking that we don't use an uninitialized lock.  So the
> fact that your patch doesn't assert means your later initialization is
> still fine.

Yeah, that's something I liked as well.

> 
> [TIL: the gdb 'watch' command is cool, but it's better if you watch only
> 4 or 8 bytes at a time; I first tried 'watch monitor_lock', but that's
> hundreds of times slower as hardware can't watch that much data at once,
> at which point gdb emulates it by single-stepping the entire program]

Good to learn it!

Thanks for digging the whole thing up.

> 
> > 
> > Post-patch, the mutex is not initialized until well after main().  So
> > the real question is what (if anything) is using the lock in between
> > those two points?
> 
> According to gdb watchpoints, no.
> 
> > 
> > Hmm - it may be that we needed it back before commit 05875687, when we
> > really did depend on MODULE_INIT_QAPI, but it is something we forgot to
> > cleanup in the meantime?
> 
> So what I didn't debug was whether the constructor attribute was
> mandatory in the past, and if so, which commit made it no longer
> mandatory (my mention of commit 05875687 is only a guess).
> 
> > 
> > If nothing else, the commit message should call out that dropping
> > __attribute__((constructor)) nonsense is intentional (if it was indeed
> > nonsense).
> > 
> 
> This part is still true.

If this patch is doable, I'll add explicit reason to commit message.

Paolo/Markus, would any of you help confirm this change? (considering
Paolo introduced commit d622cb587)

One thing I slightly not sure of is that, some device realization has
this code path (take fsl_imx25_realize() as example):

  fsl_imx25_realize
    qemu_chr_new
      qemu_chr_new_noreplay
        char is_mux?
          monitor_init

(note: I never know why we create the monitor in chardev
 creation... would there be a better place?)

Especially considering some integrated devices can be created along
with machine init.

Anyway, this patch was trying to cleanup the things a bit, and also
more convenient for me to add new codes upon.  If any of us think it's
not safe enough, please say explicitly, and I can drop it and do the
rest in "the ugly way".

Thanks,

-- 
Peter Xu
