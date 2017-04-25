Received: from eggs.gnu.org ([2001:4830:134:3::10]:32773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2yQd-0008Vn-9D
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2yQZ-0000Qz-Tm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2yQZ-0000Qi-KJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:14:39 -0400
Date: Tue, 25 Apr 2017 12:14:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170425111432.GC2103@work-vm>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131739eucas1p27a3eed795ae545efff380d7c5f8358c3@eucas1p2.samsung.com>
	<1492175840-5021-4-git-send-email-a.perevalov@samsung.com>
	<20170421102453.GD2908@work-vm>
	<20170421152212.GB5101@aperevalov-ubuntu>
	<20170424081229.GB31384@pxdev.xzpeter.org>
	<20170424083849.GA27768@aperevalov-ubuntu>
	<20170424171001.GL2362@work-vm>
	<20170425075544.GA22179@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425075544.GA22179@aperevalov-ubuntu>
Subject: Re: [Qemu-devel] [PATCH 3/6] migration: add UFFD_FEATURE_THREAD_ID
 feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey <a.perevalov@samsung.com>
Cc: aarcange@redhat.com, i.maximets@samsung.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

* Alexey (a.perevalov@samsung.com) wrote:
> + Andrea Arcangeli
> 
> On Mon, Apr 24, 2017 at 06:10:02PM +0100, Dr. David Alan Gilbert wrote:
> > * Alexey (a.perevalov@samsung.com) wrote:
> > > On Mon, Apr 24, 2017 at 04:12:29PM +0800, Peter Xu wrote:
> > > > On Fri, Apr 21, 2017 at 06:22:12PM +0300, Alexey wrote:
> > > > > On Fri, Apr 21, 2017 at 11:24:54AM +0100, Dr. David Alan Gilbert wrote:
> > > > > > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > > > > > Userfaultfd mechanism is able to provide process thread id,
> > > > > > > in case when client request it with UFDD_API ioctl.
> > > > > > > 
> > > > > > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > > > > 
> > > > > > There seem to be two parts to this:
> > > > > >   a) Adding the mis parameter to ufd_version_check
> > > > > >   b) Asking for the feature
> > > > > > 
> > > > > > Please split it into two patches.
> > > > > > 
> > > > > > Also....
> > > > > > 
> > > > > > > ---
> > > > > > >  include/migration/postcopy-ram.h |  2 +-
> > > > > > >  migration/migration.c            |  2 +-
> > > > > > >  migration/postcopy-ram.c         | 12 ++++++------
> > > > > > >  migration/savevm.c               |  2 +-
> > > > > > >  4 files changed, 9 insertions(+), 9 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
> > > > > > > index 8e036b9..809f6db 100644
> > > > > > > --- a/include/migration/postcopy-ram.h
> > > > > > > +++ b/include/migration/postcopy-ram.h
> > > > > > > @@ -14,7 +14,7 @@
> > > > > > >  #define QEMU_POSTCOPY_RAM_H
> > > > > > >  
> > > > > > >  /* Return true if the host supports everything we need to do postcopy-ram */
> > > > > > > -bool postcopy_ram_supported_by_host(void);
> > > > > > > +bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
> > > > > > >  
> > > > > > >  /*
> > > > > > >   * Make all of RAM sensitive to accesses to areas that haven't yet been written
> > > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > index ad4036f..79f6425 100644
> > > > > > > --- a/migration/migration.c
> > > > > > > +++ b/migration/migration.c
> > > > > > > @@ -802,7 +802,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
> > > > > > >           * special support.
> > > > > > >           */
> > > > > > >          if (!old_postcopy_cap && runstate_check(RUN_STATE_INMIGRATE) &&
> > > > > > > -            !postcopy_ram_supported_by_host()) {
> > > > > > > +            !postcopy_ram_supported_by_host(NULL)) {
> > > > > > >              /* postcopy_ram_supported_by_host will have emitted a more
> > > > > > >               * detailed message
> > > > > > >               */
> > > > > > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > > > > > index dc80dbb..70f0480 100644
> > > > > > > --- a/migration/postcopy-ram.c
> > > > > > > +++ b/migration/postcopy-ram.c
> > > > > > > @@ -60,13 +60,13 @@ struct PostcopyDiscardState {
> > > > > > >  #include <sys/eventfd.h>
> > > > > > >  #include <linux/userfaultfd.h>
> > > > > > >  
> > > > > > > -static bool ufd_version_check(int ufd)
> > > > > > > +static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> > > > > > >  {
> > > > > > >      struct uffdio_api api_struct;
> > > > > > >      uint64_t ioctl_mask;
> > > > > > >  
> > > > > > >      api_struct.api = UFFD_API;
> > > > > > > -    api_struct.features = 0;
> > > > > > > +    api_struct.features = UFFD_FEATURE_THREAD_ID;
> > > > > > >      if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> > > > > > >          error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
> > > > > > >                       strerror(errno));
> > > > > > 
> > > > > > You're not actually using the 'mis' here - what I'd expected was
> > > > > > something that was going to check if the UFFDIO_API return said that it really
> > > > > > had the feature, and if so store a flag in the MIS somewhere.
> > > > > > 
> > > > > > Also, I'm not sure it's right to set 'api_struct.features' on the input - what
> > > > > > happens if this is run on an old kernel - we don't want postcopy to fail on
> > > > > > an old kernel without your feature.
> > > > > > I'm not 100% sure of the interface, but I think the way it works is you set
> > > > > > features = 0 before the call, and then check the api_struct.features in the
> > > > > > return - in the same way that I check for UFFD_FEATURE_MISSING_HUGETLBFS.
> > > > > > 
> > > > > We need to ask kernel about that feature,
> > > > > right,
> > > > > kernel returns back available features
> > > > > uffdio_api.features = UFFD_API_FEATURES
> > > > > but it also stores requested features
> > > > 
> > > > I feel like this does not against Dave's comment, maybe we just need
> > > > to send the UFFDIO_API twice? Like:
> > > yes, ioctl with UFFDIO_API will fail on old kernel if we will request
> > > e.g. UFFD_FEATURE_THREAD_ID or other new feature.
> > > 
> > > So in general way need a per feature request, for better error handling.
> > 
> > No, we don't need to - I think the way the kernel works is that you pass
> > features = 0 in, and it sets api_struct.features on the way out;
> > so if you always pass 0 in, you can then just check the features that
> > it returns.
> >
> Without explicitly set UFFD_FEATURE_THREAD_ID, ptid will not sent back
> to user space.
> 
> Also it's impossible to call ioctl UFFD_API more than one time, due to
> internal state of userfault_ctx inside kernel is changing
> UFFD_STATE_WAIT_API -> UFFD_STATE_RUNNING, 
> but ioctl UFFD_API expects UFFD_STATE_WAIT_API
> ^^^
> 
> So looks like no way to provide backward compatibility for old kernels.
> I even don't know how to be with new kernels, because point of extension
> should be for new kernels (e.g. I want to add new feature in future,
> UFFD_FEATURE_ALLOW_PADDING which will allow UFFD_COPY for lesser page
> size than was registered).
> So how to be in this case, add new UFFD feature, like
> UFFD_FEATURE_ALLOW_CALL_API_AGAIN (allow set not always/persistent feature,
> like UFFD_FEATURE_THREAD_ID)
> 
> or just remove condition in kernel while sending ptid.
> 
> Or it's even not a problem, just close ufd/reopen and resend
> UFFD_FEATURE_THREAD_ID.

Yes, I think you'll have to do that;  so I guess you need to:
   a) Change ufd_version_check to open the ufd in the first place
      and remove the other syscalls that open it
   b) Make it pass features = 0 in to start with so that you can
      see if the kernel supports it
   c) Close the ufd and then do the API call again with the
      features you need.

Does that work?

Note we must never break QEMU working on old kernels.

Dave

> > Dave
> > 
> > > 
> > > > 
> > > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > > index 85fd8d7..fd0905f 100644
> > > > --- a/migration/postcopy-ram.c
> > > > +++ b/migration/postcopy-ram.c
> > > > @@ -64,6 +64,7 @@ static bool ufd_version_check(int ufd)
> > > >  {
> > > >      struct uffdio_api api_struct;
> > > >      uint64_t ioctl_mask;
> > > > +    uint64_t features = 0;
> > > > 
> > > >      api_struct.api = UFFD_API;
> > > >      api_struct.features = 0;
> > > > @@ -92,6 +93,27 @@ static bool ufd_version_check(int ufd)
> > > >              return false;
> > > >          }
> > > >      }
> > > > +
> > > > +#ifdef UFFD_FEATURE_THREAD_ID
> > > > +    if (api_struct.features & UFFD_FEATURE_THREAD_ID) {
> > > > +        features |= UFFD_FEATURE_THREAD_ID;
> > > > +    }
> > > > +#endif
> > > > +
> > > > +    if (features) {
> > > > +        /*
> > > > +         * If there are new features to be enabled from userspace,
> > > > +         * trigger another UFFDIO_API ioctl.
> > > > +         */
> > > > +        api_struct.api = UFFD_API;
> > > > +        api_struct.features = features;
> > > > +        if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> > > > +            error_report("UFFDIO_API failed to setup features: 0x%"PRIx64,
> > > > +                         features);
> > > > +            return false;
> > > > +        }
> > > > +    }
> > > > +
> > > >      return true;
> > > >  }
> > > > 
> > > > > /* only enable the requested features for this uffd context */
> > > > >  ctx->features = uffd_ctx_features(features);
> > > > > 
> > > > > so, at the time when process thread id is going to be sent
> > > > > kernel checks if it was requested
> > > > > +       if (features & UFFD_FEATURE_THREAD_ID)
> > > > > +               msg.arg.pagefault.ptid = task_pid_vnr(current);
> > > > 
> > > > (I am slightly curious about why we need this if block, after all
> > > >  userspace should know whether the ptid field would be valid from the
> > > >  first UFFDIO_API ioctl, right?)
> > > If I correctly understand you question ) that condition was suggested,
> > > due to page faulting is performance critical part (in general, not only postcopy
> > > case ), that's why it should be enabled from userspace, 
> > > only for statistics/debug purpose.
> > > Also looks like David want to see that feature on QEMU as not always
> > > feature too.
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > from patch message:
> > > > > 
> > > > >  Process's thread id is being provided when user requeste it
> > > > > by setting UFFD_FEATURE_THREAD_ID bit into uffdio_api.features.
> > > > > 
> > > > > UFFD_FEATURE_MISSING_HUGETLBFS - look like default, unconditional
> > > > > behavior (I didn't find any usage of that define in kernel).
> > > > 
> > > > -- 
> > > > Peter Xu
> > > > 
> > > 
> > > -- 
> > > 
> > > BR
> > > Alexey
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> -- 
> 
> BR
> Alexey
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
