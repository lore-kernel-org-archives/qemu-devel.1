Received: from eggs.gnu.org ([2001:4830:134:3::10]:58512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etPcA-0001Ro-SB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etPc9-00073c-K2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:19:38 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-16-jsnow@redhat.com>
	<20180228170454.GI4855@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <1879d3f8-202a-3cd9-f282-e487d3730bc7@redhat.com>
Date: Tue, 6 Mar 2018 22:19:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180228170454.GI4855@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 02/28/2018 12:04 PM, Kevin Wolf wrote:
> Am 24.02.2018 um 00:51 hat John Snow geschrieben:
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
>>   (added in a forthcoming commit)
>> - All jobs prepare to call either commit/abort
>> - If any job fails, is canceled, or fails preparation, all jobs
>>   call their .abort callback.
>> - All jobs enter the PENDING state, awaiting manual intervention
>>   (also added in a forthcoming commit)
>> - block-job-finalize is issued by the user/management layer
>> - All jobs call their commit callbacks.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> You almost made me believe the scary thought that we need transactional
> graph modifications, but after writing half of the reply, I think it's
> just that your order here is wrong.
>=20

Sorry, yes, this blurb was outdated. I regret that it wasted your time.

> So .prepare is the last thing in the whole process that is allowed to
> fail. Graph manipulations such as bdrv_replace_node() can fail. Graph
> manipulations can also only be made in response to block-job-finalize
> because the management layer must be aware of them. Take them together
> and you have a problem.
>=20
> Didn't we already establish earlier that .prepare/.commit/.abort must b=
e
> called together and cannot be separated by waiting for a QMP command
> because of locking and things?
>=20

Right; so what really happens is that in response to the FINALIZE verb,
the prepare loop is done first to check for success, and then commit or
abort are dispatched as appropriate.

> So if you go to PENDING first, then wait for block-job-finalize and onl=
y
> then call .prepare/.commit/.abort, we should be okay for both problems.
>=20
> And taking a look at the final state, that seems to be what you do, so
> in the end, it's probably just the commit message that needs a fix.

Yep, sorry.

>=20
>>  blockjob.c                   | 34 +++++++++++++++++++++++++++++++---
>>  include/block/blockjob_int.h | 10 ++++++++++
>>  2 files changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/blockjob.c b/blockjob.c
>> index 8f02c03880..1c010ec100 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -394,6 +394,18 @@ static void block_job_update_rc(BlockJob *job)
>>      }
>>  }
>> =20
>> +static int block_job_prepare(BlockJob *job)
>> +{
>> +    if (job->ret) {
>> +        goto out;
>> +    }
>> +    if (job->driver->prepare) {
>> +        job->ret =3D job->driver->prepare(job);
>> +    }
>> + out:
>> +    return job->ret;
>> +}
>=20
> Why not just if (job->ret =3D=3D 0 && job->driver->prepare) and save th=
e
> goto?
>=20

Churn. =C2=AF\_(=E3=83=84)_/=C2=AF

> Kevin
>=20
