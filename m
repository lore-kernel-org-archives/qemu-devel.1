Received: from eggs.gnu.org ([2001:4830:134:3::10]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzOPF-0005LS-3s
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzOPE-0006Sa-3w
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:42:45 -0400
References: <20171003031556.15173-1-jsnow@redhat.com>
	<f66d037c-67a3-30eb-05eb-fc105093ec80@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5824bb59-af5c-145a-9517-f9190b82e29c@redhat.com>
Date: Tue, 3 Oct 2017 10:42:29 -0400
MIME-Version: 1.0
In-Reply-To: <f66d037c-67a3-30eb-05eb-fc105093ec80@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] blockjobs: add explicit job culling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 10/03/2017 05:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.10.2017 06:15, John Snow wrote:
>> For jobs that complete when a monitor isn't looking, there's no way to
>> tell what the job's final return code was. We need to allow jobs to
>> remain in the list until queried for reliable management.
>>
>> This is an RFC; tests are on the way.
>> (Tested only manually via qmp-shell for now.)
>=20
> That's a cool feature!
> What about transactions support?
>=20

Didn't test that yet (!) but the intent is that it will be compatible.
The jobs in the transaction, whether using grouped-completion mode or
not, will simply hang around in the list after completion.

For grouped-completion=3Dfalse:

The jobs will complete individually and then remain in the list.

For grouped-completion=3Dtrue:

The jobs will remain in their ready-to-commit-or-abort state until all
jobs in the transaction are ready to commit-or-abort, then all jobs will
either commit or abort. After commit-or-abort, all jobs (that were
created with manual-cull=3Dtrue !) will remain in the query list.

The intended effect here is that this property changes NOTHING except
that the job will remain in the query list until it is dismissed, and
should not change anything about how it behaves during its lifetime.

One downside here is that since we have no universal "job creation
argument list" that I can't add it to all jobs universally. In the case
of transactions, though, I could at least add a property that *forces*
all jobs below to become manual-cull style jobs, and that way you'd only
have to specify it once instead of for each action.

--js

>>
>> John Snow (3):
>> =C2=A0=C2=A0 blockjob: add manual-cull property
>> =C2=A0=C2=A0 qmp: add block-job-cull command
>> =C2=A0=C2=A0 blockjob: expose manual-cull property
>>
>> =C2=A0 block/backup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 +++++++++---------
>> =C2=A0 block/commit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 block/mirror.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 block/replication.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 5 +++--
>> =C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 block/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++++=
++++++++----
>> =C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 46
>> +++++++++++++++++++++++++++++++++++++++--
>> =C2=A0 include/block/block_int.h=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++---
>> =C2=A0 include/block/blockjob.h=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++=
++++++++++
>> =C2=A0 include/block/blockjob_int.h |=C2=A0 2 +-
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 49
>> ++++++++++++++++++++++++++++++++++++--------
>> =C2=A0 tests/test-blockjob-txn.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 tests/test-blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 2 +-
>> =C2=A0 14 files changed, 155 insertions(+), 35 deletions(-)
>>
>=20
>=20

Oh, while I'm here, I should point out that another downside of this
patch is that it doesn't prevent "cancel" from attempting to re-enter
the job. Or rather, I had to patch that out specifically. The job
remains in a list of jobs that some portions of the code consider to be
"active" jobs. (look for any code that checks to see if the job has
started.)

A (perhaps) more provably cleaner approach would be to simply move any
completed job onto a different list upon completion, and patch
query-jobs to query both lists, and allow the cull command to remove any
jobs on that list. A downside of that approach, however, is that without
multiple job support, you may launch a second job that perhaps
overwrites the first job unless you're careful about how you manage that
data.

There are pros and cons to either way, but I'd rather not get in the
business of overhauling the blockjobs API unless it's for universal jobs.

--js
