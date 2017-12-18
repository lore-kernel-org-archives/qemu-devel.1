Received: from eggs.gnu.org ([2001:4830:134:3::10]:42173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQm5J-0007ze-7M
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQm5G-00036g-3b
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:27:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQm5F-00035p-RG
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:27:18 -0500
Date: Mon, 18 Dec 2017 11:27:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218032702.GI22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-8-peterx@redhat.com>
	<20171213154806.GH7173@stefanha-x1.localdomain>
	<20171215081141.GN7780@xz-mi>
	<20171215124711.GF26982@stefanha-x1.localdomain>
	<20171216035228.GT7780@xz-mi>
	<20171216090112.GA12533@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171216090112.GA12533@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 07/26] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Sat, Dec 16, 2017 at 09:01:12AM +0000, Stefan Hajnoczi wrote:
> On Sat, Dec 16, 2017 at 11:52:28AM +0800, Peter Xu wrote:
> > On Fri, Dec 15, 2017 at 12:47:11PM +0000, Stefan Hajnoczi wrote:
> > > On Fri, Dec 15, 2017 at 04:11:41PM +0800, Peter Xu wrote:
> > > > On Wed, Dec 13, 2017 at 03:48:06PM +0000, Stefan Hajnoczi wrote:
> > > > > On Tue, Dec 05, 2017 at 01:51:41PM +0800, Peter Xu wrote:
> > > > > > diff --git a/vl.c b/vl.c
> > > > > > index 1ad1c04637..1ec995a6ae 100644
> > > > > > --- a/vl.c
> > > > > > +++ b/vl.c
> > > > > > @@ -3144,7 +3144,6 @@ int main(int argc, char **argv, char **envp)
> > > > > >      qemu_init_exec_dir(argv[0]);
> > > > > >  
> > > > > >      module_call_init(MODULE_INIT_QOM);
> > > > > > -    monitor_init_qmp_commands();
> > > > > >  
> > > > > >      qemu_add_opts(&qemu_drive_opts);
> > > > > >      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> > > > > > @@ -4690,6 +4689,8 @@ int main(int argc, char **argv, char **envp)
> > > > > >      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
> > > > > >      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> > > > > >  
> > > > > > +    monitor_init_globals();
> > > > > 
> > > > > Why did you move monitor_init_qmp_commands() down here?
> > > > > 
> > > > > There are many function calls between the old position and the new
> > > > > position.  Did you check all of them to make sure they don't touch the
> > > > > monitor which is now totally uninitialized?
> > > > 
> > > > Yeh, this patch is a bit hairy, but I really think we should do it.
> > > > Because there are too many places (as you have seen) that we inited
> > > > monitor stuff in different places.
> > > 
> > > But why did you move it down here?  Can you replace the
> > > monitor_init_qmp_commands() call instead?
> > 
> > I just moved it closer to (actually, right above) initializations of
> > monitors to be clear that these globals will never be touched until
> > this point.  Or do you want me to move this call exactly back to the
> > place where monitor_init_qmp_commands() was called before?  Thanks,
> 
> Hmm...now that we're discussing this patch in detail I found an ordering
> dependency:
> 
> qtest_enabled() only works after configure_accelerator(current_machine),
> so the monitor_qapi_event_init() cannot be moved to the
> monitor_init_qmp_commands() location.
> 
> Everything else has no dependencies.  I would be best to remove the
> self-contained init from vl.c:main() so we don't have to worry about
> dependencies again.  How about:
> 
> -static void __attribute__((constructor)) monitor_lock_init(void)
> +static void __attribute__((constructor)) monitor_init_ctr(void)

(Curious: why name it "ctr"?)

>  {
>      qemu_mutex_init(&monitor_lock);
> +    monitor_init_qmp_commands();
> +    monitor_qapi_event_init();
> +    sortcmdlist();

Though I still need to init monitor iothreads, I'm not sure whether it
can be put into a constructor function since I think IOThead has not
yet been initialized now (it's done until module_call_init() in
main()).

>  }
> 
> Now vl.c:main() doesn't need to initialize the monitor.
> 
> We still need to handle the qtest_enabled() dependency:
> 
> -static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
> +static inline QEMUClockType event_clock_type(void)
> +{
> +    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
> +}
> 
> This way the qtest_enabled() call is deferred until later when the
> accelerators have been initialized.

Or... to be much simpler... How about we just use my patch?  IMHO it
calls monitor_init_globals() after configure_accelerator() so
monitor_qapi_event_init() and everything else would just work as
expected?

Thanks,

-- 
Peter Xu
