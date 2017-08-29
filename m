Received: from eggs.gnu.org ([2001:4830:134:3::10]:33022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmoC1-0005K3-GH
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmoBy-0003ep-AP
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:37:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dmoBy-0003eD-1K
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:37:02 -0400
Date: Tue, 29 Aug 2017 18:36:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170829213657.GO27715@localhost.localdomain>
References: <20170824192315.5897-1-ehabkost@redhat.com>
	<20170824192315.5897-4-ehabkost@redhat.com>
	<20170829111345.GI3783@redhat.com>
	<20170829131258.GA30734@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829131258.GA30734@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] fixup! hostmem-file: Add "discard-data" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 29, 2017 at 10:12:58AM -0300, Eduardo Habkost wrote:
> On Tue, Aug 29, 2017 at 12:13:45PM +0100, Daniel P. Berrange wrote:
> > On Thu, Aug 24, 2017 at 04:23:15PM -0300, Eduardo Habkost wrote:
[...]
> > > @@ -4172,6 +4172,9 @@ the path to either a shared memory or huge page filesystem mount.
> > >  The @option{share} boolean option determines whether the memory
> > >  region is marked as private to QEMU, or shared. The latter allows
> > >  a co-operating external process to access the QEMU memory region.
> > > +Setting the @option{discard-data} boolean option to @var{on}
> > > +indicates that file contents can be destroyed when QEMU exits,
> > > +to avoid unnecessarily flushing data to the backing file.
> > 
> > We should note that this only works if QEMU shuts down normally. If QEMU
> > is aggressively killed (SIGKILL) or aborts for some reason, then we'll
> > never get a chance to invoke madvise(), so presumably the kernel will
> > still flush the data
> 
> Good point.  I tried to not give any guarantees by saying
> "contents _can_ be destroyed", but users may still have different
> expectations.
> 
> I will change it to:
> 
>   Setting the @option{discard-data} boolean option to @var{on}
>   indicates that file contents can be destroyed when QEMU exits,
>   to avoid unnecessarily flushing data to the backing file.  Note
>   that @option{discard-data} is only an optimization, and QEMU
>   might not discard file contents if it aborts unexpectedly or is
>   terminated using SIGKILL.

Fixup patch:

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-options.hx | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ad985e4..de9a18a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4174,7 +4174,10 @@ region is marked as private to QEMU, or shared. The latter allows
 a co-operating external process to access the QEMU memory region.
 Setting the @option{discard-data} boolean option to @var{on}
 indicates that file contents can be destroyed when QEMU exits,
-to avoid unnecessarily flushing data to the backing file.
+to avoid unnecessarily flushing data to the backing file.  Note
+that @option{discard-data} is only an optimization, and QEMU
+might not discard file contents if it aborts unexpectedly or is
+terminated using SIGKILL.
 
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
-- 
2.9.4
