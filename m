Received: from eggs.gnu.org ([2001:4830:134:3::10]:34633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2Yyi-0008Eu-Il
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2Yyf-00083T-Cu
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d2Yyf-00083L-3E
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:04:09 -0400
Date: Mon, 24 Apr 2017 16:03:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170424080353.GA31384@pxdev.xzpeter.org>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131739eucas1p27a3eed795ae545efff380d7c5f8358c3@eucas1p2.samsung.com>
	<1492175840-5021-4-git-send-email-a.perevalov@samsung.com>
	<20170421102453.GD2908@work-vm>
	<20170421152212.GB5101@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170421152212.GB5101@aperevalov-ubuntu>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, i.maximets@samsung.com, aarcange@redhat.com, qemu-devel@nongnu.org

On Fri, Apr 21, 2017 at 06:22:12PM +0300, Alexey wrote:
> On Fri, Apr 21, 2017 at 11:24:54AM +0100, Dr. David Alan Gilbert wrote:
> > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > Userfaultfd mechanism is able to provide process thread id,
> > > in case when client request it with UFDD_API ioctl.
> > > 
> > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > 
> > There seem to be two parts to this:
> >   a) Adding the mis parameter to ufd_version_check
> >   b) Asking for the feature
> > 
> > Please split it into two patches.
> > 
> > Also....
> > 
> > > ---
> > >  include/migration/postcopy-ram.h |  2 +-
> > >  migration/migration.c            |  2 +-
> > >  migration/postcopy-ram.c         | 12 ++++++------
> > >  migration/savevm.c               |  2 +-
> > >  4 files changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
> > > index 8e036b9..809f6db 100644
> > > --- a/include/migration/postcopy-ram.h
> > > +++ b/include/migration/postcopy-ram.h
> > > @@ -14,7 +14,7 @@
> > >  #define QEMU_POSTCOPY_RAM_H
> > >  
> > >  /* Return true if the host supports everything we need to do postcopy-ram */
> > > -bool postcopy_ram_supported_by_host(void);
> > > +bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
> > >  
> > >  /*
> > >   * Make all of RAM sensitive to accesses to areas that haven't yet been written
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index ad4036f..79f6425 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -802,7 +802,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
> > >           * special support.
> > >           */
> > >          if (!old_postcopy_cap && runstate_check(RUN_STATE_INMIGRATE) &&
> > > -            !postcopy_ram_supported_by_host()) {
> > > +            !postcopy_ram_supported_by_host(NULL)) {
> > >              /* postcopy_ram_supported_by_host will have emitted a more
> > >               * detailed message
> > >               */
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index dc80dbb..70f0480 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -60,13 +60,13 @@ struct PostcopyDiscardState {
> > >  #include <sys/eventfd.h>
> > >  #include <linux/userfaultfd.h>
> > >  
> > > -static bool ufd_version_check(int ufd)
> > > +static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> > >  {
> > >      struct uffdio_api api_struct;
> > >      uint64_t ioctl_mask;
> > >  
> > >      api_struct.api = UFFD_API;
> > > -    api_struct.features = 0;
> > > +    api_struct.features = UFFD_FEATURE_THREAD_ID;
> > >      if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> > >          error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
> > >                       strerror(errno));
> > 
> > You're not actually using the 'mis' here - what I'd expected was
> > something that was going to check if the UFFDIO_API return said that it really
> > had the feature, and if so store a flag in the MIS somewhere.
> > 
> > Also, I'm not sure it's right to set 'api_struct.features' on the input - what
> > happens if this is run on an old kernel - we don't want postcopy to fail on
> > an old kernel without your feature.
> > I'm not 100% sure of the interface, but I think the way it works is you set
> > features = 0 before the call, and then check the api_struct.features in the
> > return - in the same way that I check for UFFD_FEATURE_MISSING_HUGETLBFS.
> > 
> We need to ask kernel about that feature,
> right,
> kernel returns back available features
> uffdio_api.features = UFFD_API_FEATURES
> but it also stores requested features

I feel like this does not against Dave's comment, maybe we just need
to send the UFFDIO_API twice? Like:

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 85fd8d7..fd0905f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -64,6 +64,7 @@ static bool ufd_version_check(int ufd)
 {
     struct uffdio_api api_struct;
     uint64_t ioctl_mask;
+    uint64_t features = 0;

     api_struct.api = UFFD_API;
     api_struct.features = 0;
@@ -92,6 +93,27 @@ static bool ufd_version_check(int ufd)
             return false;
         }
     }
+
+#ifdef UFFD_FEATURE_THREAD_ID
+    if (api_struct.features & UFFD_FEATURE_THREAD_ID) {
+        features |= UFFD_FEATURE_THREAD_ID;
+    }
+#endif
+
+    if (features) {
+        /*
+         * If there are new features to be enabled from userspace,
+         * trigger another UFFDIO_API ioctl.
+         */
+        api_struct.api = UFFD_API;
+        api_struct.features = features;
+        if (ioctl(ufd, UFFDIO_API, &api_struct)) {
+            error_report("UFFDIO_API failed to setup features: 0x%"PRIx64,
+                         features);
+            return false;
+        }
+    }
+
     return true;
 }

> /* only enable the requested features for this uffd context */
>  ctx->features = uffd_ctx_features(features);
> 
> so, at the time when process thread id is going to be sent
> kernel checks if it was requested
> +       if (features & UFFD_FEATURE_THREAD_ID)
> +               msg.arg.pagefault.ptid = task_pid_vnr(current);

I am slightly curious about why we need this if block, after all
userspace should know whether the ptid is valid from the fist
UFFDIO_API feature list...

Thanks,

> 
> from patch message:
> 
>  Process's thread id is being provided when user requeste it
> by setting UFFD_FEATURE_THREAD_ID bit into uffdio_api.features.
> 
> UFFD_FEATURE_MISSING_HUGETLBFS - look like default, unconditional
> behavior (I didn't find any usage of that define in kernel).

-- 
Peter Xu
