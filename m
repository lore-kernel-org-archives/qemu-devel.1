Received: from eggs.gnu.org ([2001:4830:134:3::10]:34230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dtyLj-0003X9-RE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dtyLh-0003mv-79
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:52:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dtyLg-0003mW-Tc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:52:41 -0400
Date: Mon, 18 Sep 2017 16:52:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170918155232.GK2581@work-vm>
References: <CGME20170616191218eucas1p2bcc5ece2b03593f16ab599c4f12eaa5e@eucas1p2.samsung.com>
	<1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
	<20170918111527.GE2581@work-vm>
	<007210a5-de47-e873-7f23-63e052cbcbcd@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007210a5-de47-e873-7f23-63e052cbcbcd@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v9 0/8] calculate blocktime for postcopy
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> On 09/18/2017 02:15 PM, Dr. David Alan Gilbert wrote:
> > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > This is 9th version.
> > > 
> > > The rationale for that idea is following:
> > > vCPU could suspend during postcopy live migration until faulted
> > > page is not copied into kernel. Downtime on source side it's a value -
> > > time interval since source turn vCPU off, till destination start runnig
> > > vCPU. But that value was proper value for precopy migration it really shows
> > > amount of time when vCPU is down. But not for postcopy migration, because
> > > several vCPU threads could susppend after vCPU was started. That is important
> > > to estimate packet drop for SDN software.
> > Hi Alexey,
> >    I see that the UFFD_FEATURE_THREAD_ID has landed in kernel v4.14-rc1
> > over the weekend, so it's probably time to reheat this patchset.
> > 
> >    I think you should be able to generate a first patch by running
> >    scripts/update-linux-headers.sh
> Hi David,
> ok, I'll resend it tomorrow,
> I also added set capability postcopy-blocktime into tests/postcopy-test.c,
> but I don't check the result of the qmp there,
> I added it just to enable and test code path, is it ok for you?

It'd be better if you just ready the value in the test via qmp; that
would mean it'd be a basic check it was OK, and should be pretty
easy to glue into postcopy-test.c

Dave

> > 
> > Dave
> > 
> > > (V8 -> V9)
> > >      - rebase
> > >      - traces
> > > 
> > > (V7 -> V8)
> > >      - just one comma in
> > > "migration: fix hardcoded function name in error report"
> > > It was really missed, but fixed in futher patch.
> > > 
> > > (V6 -> V7)
> > >      - copied bitmap was placed into RAMBlock as another migration
> > > related bitmaps.
> > >      - Ordering of mark_postcopy_blocktime_end call and ordering
> > > of checking copied bitmap were changed.
> > >      - linewrap style defects
> > >      - new patch "postcopy_place_page factoring out"
> > >      - postcopy_ram_supported_by_host accepts
> > > MigrationIncomingState in qmp_migrate_set_capabilities
> > >      - minor fixes of documentation.
> > >      and huge description of get_postcopy_total_blocktime was
> > > moved. Davids comment.
> > > 
> > > (V5 -> V6)
> > >      - blocktime was added into hmp command. Comment from David.
> > >      - bitmap for copied pages was added as well as check in *_begin/_end
> > > functions. Patch uses just introduced RAMBLOCK_FOREACH. Comment from David.
> > >      - description of receive_ufd_features/request_ufd_features. Comment from David.
> > >      - commit message headers/@since references were modified. Comment from Eric.
> > >      - also typos in documentation. Comment from Eric.
> > >      - style and description of field in MigrationInfo. Comment from Eric.
> > >      - ufd_check_and_apply (former ufd_version_check) is calling twice,
> > > so my previous patch contained double allocation of blocktime context and
> > > as a result memory leak. In this patch series it was fixed.
> > > 
> > > (V4 -> V5)
> > >      - fill_destination_postcopy_migration_info empty stub was missed for none linux
> > > build
> > > 
> > > (V3 -> V4)
> > >      - get rid of Downtime as a name for vCPU waiting time during postcopy migration
> > >      - PostcopyBlocktimeContext renamed (it was just BlocktimeContext)
> > >      - atomic operations are used for dealing with fields of PostcopyBlocktimeContext
> > > affected in both threads.
> > >      - hardcoded function names in error_report were replaced to %s and __line__
> > >      - this patch set includes postcopy-downtime capability, but it used on
> > > destination, coupled with not possibility to return calculated downtime back
> > > to source to show it in query-migrate, it looks like a big trade off
> > >      - UFFD_API have to be sent notwithstanding need or not to ask kernel
> > > for a feature, due to kernel expects it in any case (see patch comment)
> > >      - postcopy_downtime included into query-migrate output
> > >      - also this patch set includes trivial fix
> > > migration: fix hardcoded function name in error report
> > > maybe that is a candidate for qemu-trivial mailing list, but I already
> > > sent "migration: Fixed code style" and it was unclaimed.
> > > 
> > > (V2 -> V3)
> > >      - Downtime calculation approach was changed, thanks to Peter Xu
> > >      - Due to previous point no more need to keep GTree as well as bitmap of cpus.
> > > So glib changes aren't included in this patch set, it could be resent in
> > > another patch set, if it will be a good reason for it.
> > >      - No procfs traces in this patchset, if somebody wants it, you could get it
> > > from patchwork site to track down page fault initiators.
> > >      - UFFD_FEATURE_THREAD_ID is requesting only when kernel supports it
> > >      - It doesn't send back the downtime, just trace it
> > > 
> > > This patch set is based on commit
> > > [PATCH v3 0/3] Add bitmap for received pages in postcopy migration
> > > 
> > > 
> > > Alexey Perevalov (8):
> > >    userfault: add pid into uffd_msg & update UFFD_FEATURE_*
> > >    migration: pass MigrationIncomingState* into migration check functions
> > >    migration: fix hardcoded function name in error report
> > >    migration: split ufd_version_check onto receive/request features part
> > >    migration: introduce postcopy-blocktime capability
> > >    migration: add postcopy blocktime ctx into MigrationIncomingState
> > >    migration: calculate vCPU blocktime on dst side
> > >    migration: postcopy_blocktime documentation
> > > 
> > >   docs/devel/migration.txt          |  10 ++
> > >   linux-headers/linux/userfaultfd.h |   4 +
> > >   migration/migration.c             |  12 +-
> > >   migration/migration.h             |   9 ++
> > >   migration/postcopy-ram.c          | 300 ++++++++++++++++++++++++++++++++++++--
> > >   migration/postcopy-ram.h          |   2 +-
> > >   migration/savevm.c                |   2 +-
> > >   migration/trace-events            |   5 +-
> > >   qapi-schema.json                  |   5 +-
> > >   9 files changed, 334 insertions(+), 15 deletions(-)
> > > 
> > > -- 
> > > 1.8.3.1
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> > 
> > 
> 
> -- 
> Best regards,
> Alexey Perevalov
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
