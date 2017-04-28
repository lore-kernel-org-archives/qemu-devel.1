Received: from eggs.gnu.org ([2001:4830:134:3::10]:40485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d42o6-0000ft-IM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d42o2-00083d-Ik
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d42o2-000833-Cd
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:07:18 -0400
Date: Fri, 28 Apr 2017 18:07:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170428100700.GC22801@pxdev.xzpeter.org>
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065754eucas1p1f51713373ce8c2d19945a4f91c52bd5c@eucas1p1.samsung.com>
	<1493362658-8179-5-git-send-email-a.perevalov@samsung.com>
	<20170428093825.GA22801@pxdev.xzpeter.org>
	<3a95fb33-f496-7e9d-50cb-6286d23dbdf6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a95fb33-f496-7e9d-50cb-6286d23dbdf6@samsung.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 4/6] migration: add postcopy
 downtime into MigrationIncommingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com, f4bug@amsat.org

On Fri, Apr 28, 2017 at 01:03:45PM +0300, Alexey Perevalov wrote:

[...]

> >>diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >>index 21e7150..f3688f5 100644
> >>--- a/migration/postcopy-ram.c
> >>+++ b/migration/postcopy-ram.c
> >>@@ -132,6 +132,14 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> >>          return false;
> >>      }
> >>+#ifdef UFFD_FEATURE_THREAD_ID
> >>+    if (mis && UFFD_FEATURE_THREAD_ID & supported_features) {
> >>+        /* kernel supports that feature */
> >>+        mis->downtime_ctx = downtime_context_new();
> >>+        new_features |= UFFD_FEATURE_THREAD_ID;
> >So here I know why in patch 2 new_features == 0...
> >
> >If I were you, I would like the series be done in below 4 patches:
> >
> >1. update header
> >2. introduce THREAD_ID feature, and enable it conditionally
> >3. squash all the downtime thing (downtime context, calculation) in
> >    one patch here
> >4. introduce trace
> >
> >IMHO that's clearer and easier for review. But I'm okay with current
> >as well as long as the maintainers (Dave/Juan) won't disagree. :)
> In previous series, David asked me to split one patch into 2
> [Qemu-devel] [PATCH 3/6] migration: add UFFD_FEATURE_THREAD_ID feature
> support
> 
> >There seem to be two parts to this:
> >  a) Adding the mis parameter to ufd_version_check
> >  b) Asking for the feature
> 
> >Please split it into two patches.
> 
> So in current patch set, I also added re-factoring, which was missed before
> "migration: split ufd_version_check onto receive/request features part"

Sure. As long as Dave agrees, I'm okay with either way.

-- 
Peter Xu
