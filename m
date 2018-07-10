Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fchtc-00023M-Ns
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fchtZ-0008JT-Kr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:56:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39056
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fchtZ-0008Iy-ER
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:56:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6A1tnYi013558
	for <qemu-devel@nongnu.org>; Mon, 9 Jul 2018 21:56:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k4d94peyf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 21:56:47 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 10 Jul 2018 02:56:45 +0100
Date: Tue, 10 Jul 2018 07:26:40 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705031755.3254-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705031755.3254-1-peterx@redhat.com>
Message-Id: <20180710015640.GA10680@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/9] migration: postcopy recovery
 unit test, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jul 05, 2018 at 11:17:46AM +0800, Peter Xu wrote:
> Based-on: <20180627132246.5576-1-peterx@redhat.com>
> 
> Based on the series to unbreak postcopy:
>   Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
>   Message-Id: <20180627132246.5576-1-peterx@redhat.com>
> 
> This series introduce a new postcopy recovery test.  The new test
> actually helped me to identify two bugs there so fix them as well
> before 3.0 release.
> 
> Patch 1: a trivial cleanup for existing postcopy ram load, which I
>          found a bit confusing during debugging the problem.
> 
> Patch 2-3: two bug fixes that address different issues.  Please see
>            the commit log for more information.
> 
> Patch 4-9: add the postcopy recovery unit test.
> 
> Please review.  Thanks,

Hi Peter, Dave,

I am sorry, I have missed to include Peter's postcopy-recover fix patchset,

migration: delay postcopy paused state
migration: move income process out of multifd
migration: unbreak postcopy recovery
migration: unify incoming processing

Postcopy migration with pause and recover is working fine.

# QTEST_QEMU_BINARY=./ppc64-softmmu/qemu-system-ppc64
# ./tests/migration-test
/ppc64/migration/deprecated: OK
/ppc64/migration/bad_dest: OK
/ppc64/migration/postcopy/unix: OK
/ppc64/migration/postcopy/recovery: OK
/ppc64/migration/precopy/unix: OK

But qtest patches in this patchset have to be rebased as commit
5fd4a9c97397bc0819a919de7a62ec972ec85260 (tests/migration: Skip tests
for ppc tcg) have gone in.

# git am ../postcopy_pause/4.patch 
Applying: tests: introduce migrate_postcopy_* helpers
error: patch failed: tests/migration-test.c:351
error: tests/migration-test.c: patch does not apply
Patch failed at 0001 tests: introduce migrate_postcopy_* helpers
The copy of the patch that failed is found in:
   /home/bala/qemu/.git/rebase-apply/patch
When you have resolved this problem, run "git am --resolved".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


I have manually reverted it to apply and test your patchset.

This Patchset is working without any issues.

Tested-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> 
> Peter Xu (9):
>   migration: simplify check to use qemu file buffer
>   migration: loosen recovery check when load vm
>   migration: fix incorrect bitmap size calculation
>   tests: introduce migrate_postcopy_* helpers
>   tests: allow migrate() to take extra flags
>   tests: introduce migrate_query*() helpers
>   tests: introduce wait_for_migration_status()
>   tests: add postcopy recovery test
>   tests: hide stderr for postcopy recovery test
> 
>  migration/ram.c        |  21 +++--
>  migration/savevm.c     |  16 ++--
>  tests/migration-test.c | 198 ++++++++++++++++++++++++++++++++---------
>  3 files changed, 176 insertions(+), 59 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
