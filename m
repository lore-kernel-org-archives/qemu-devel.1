Received: from eggs.gnu.org ([2001:4830:134:3::10]:54001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqm8B-0005mL-SZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqm8B-00057K-0R
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:45:47 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-16-jsnow@redhat.com>
	<fb23348b-977c-db0c-1d45-1d4904247413@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <35da90d4-42d1-8b6a-f0a3-c6e664799012@redhat.com>
Date: Tue, 27 Feb 2018 15:45:25 -0500
MIME-Version: 1.0
In-Reply-To: <fb23348b-977c-db0c-1d45-1d4904247413@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 15/21] blockjobs: add prepare callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 02:56 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> Some jobs upon finalization may need to perform some work that can
>> still fail. If these jobs are part of a transaction, it's important
>> that these callbacks fail the entire transaction.
>>
>> We allow for a new callback in addition to commit/abort/clean that
>> allows us the opportunity to have fairly late-breaking failures
>> in the transactional process.
>>
>> The expected flow is:
>>
>> - All jobs in a transaction converge to the WAITING state
>> =C2=A0=C2=A0 (added in a forthcoming commit)
>> - All jobs prepare to call either commit/abort
>> - If any job fails, is canceled, or fails preparation, all jobs
>> =C2=A0=C2=A0 call their .abort callback.
>> - All jobs enter the PENDING state, awaiting manual intervention
>> =C2=A0=C2=A0 (also added in a forthcoming commit)
>> - block-job-finalize is issued by the user/management layer
>> - All jobs call their commit callbacks.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 34 +++++++++++++=
++++++++++++++++++---
>> =C2=A0 include/block/blockjob_int.h | 10 ++++++++++
>> =C2=A0 2 files changed, 41 insertions(+), 3 deletions(-)
>>
>=20
>> @@ -467,17 +480,22 @@ static void block_job_cancel_async(BlockJob *job=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->cancelled =3D true;
>> =C2=A0 }
>> =C2=A0 -static void block_job_txn_apply(BlockJobTxn *txn, void fn(Bloc=
kJob *))
>> +static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *))
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AioContext *ctx;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob *job, *next;
>> +=C2=A0=C2=A0=C2=A0 int rc;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH_SAFE(job, &txn->jo=
bs, txn_list, next) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx =3D blk_get=
_aio_context(job->blk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_context_acq=
uire(ctx);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn(job);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D fn(job);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_context_rel=
ease(ctx);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> This short-circuits the application of the function to the rest of the
> group.=C2=A0 Is that ever going to be a problem?
>=20

With what I've written, I don't think so -- but I can't guarantee
someone won't misunderstand the semantics of it and it will become a
problem. It is a potentially dangerous function in that way.

--js
