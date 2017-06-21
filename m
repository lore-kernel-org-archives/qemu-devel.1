Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dNbyv-0003UK-Ql
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dNbyg-0007S8-5r
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dNbyf-0007Rb-U6
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC0144E4C3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:31:08 +0000 (UTC)
Date: Wed, 21 Jun 2017 17:31:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170621093103.GB2247@pxdev.xzpeter.org>
References: <1497426958-20871-1-git-send-email-peterx@redhat.com>
	<786c6bcf-2b85-1faa-bc70-66cbe404cbfa@redhat.com>
	<a386f13f-2a82-b84f-b17f-ff28dcad561c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a386f13f-2a82-b84f-b17f-ff28dcad561c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: fix incorrect enable return path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Mon, Jun 19, 2017 at 01:12:36PM +0200, Laurent Vivier wrote:
> On 15/06/2017 18:54, Laurent Vivier wrote:
> > On 14/06/2017 09:55, Peter Xu wrote:
> >> 0425dc9 is actually v1 of that patch, but it was accidentally
> >> merged (while there was a v2). That will cause problem when we try to
> >> migrate to some old QEMUs when return path is not really there. Let's
> >> fix it, then squashing this patch with 0425dc9 will be exactly patch
> >> content of v2.
> >>
> >> Fixes: 0425dc9 ("migration: isolate return path on src")
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  migration/migration.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 8ef6d6c..f9053b0 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1814,7 +1814,11 @@ static void *migration_thread(void *opaque)
> >>  
> >>      qemu_savevm_state_header(s->to_dst_file);
> >>  
> >> -    if (s->to_dst_file) {
> >> +    /*
> >> +     * If we opened the return path, we need to make sure dst has it
> >> +     * opened as well.
> >> +     */
> >> +    if (s->rp_state.from_dst_file) {
> >>          /* Now tell the dest that it should open its end so it can reply */
> >>          qemu_savevm_send_open_return_path(s->to_dst_file);
> >>  
> >>
> > 
> > Tested-by: Laurent Vivier <lvivier@redhat.com>
> > 
> > This also fixes migration of pseries guest, using the same
> > binary/machine type on both side, the error was:
> > 
> > qemu-system-ppc64: Failed to load spapr_iommu:mig_table
> > qemu-system-ppc64: error while loading state for instance 0x80000001 of
> > device 'spapr_iommu'
> > qemu-system-ppc64: load of migration failed: Input/output error
> 
> The error is an IEO because the file descriptor is closed on source. It
> seems the source closes the stream too early without this patch.
> For test purpose, I have disabled the qemu_fclose() on the source, and
> the error disappears from the destination.

Thanks for confirming this, Laurent!

-- 
Peter Xu
