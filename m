Received: from eggs.gnu.org ([2001:4830:134:3::10]:41512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eyUAx-000292-M7
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eyUAt-0006xk-Nm
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:12:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1eyUAt-0006xP-Fr
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:12:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2L3A09C010003
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 23:12:26 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2guf54g8nx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 23:12:25 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 20 Mar 2018 23:12:24 -0400
References: <20180319093509.50881-1-haoqf@linux.vnet.ibm.com>
	<20180319093509.50881-2-haoqf@linux.vnet.ibm.com>
	<CAJSP0QVe4gXCvPdw15x3D_yp2v4mi8QqYujo5qgxyeGcCbGfpw@mail.gmail.com>
	<1cc764c9-7bc1-365e-8af4-fe5357677aed@de.ibm.com>
	<20180320101101.GA4865@localhost.localdomain>
	<20180320143113.GD24329@stefanha-x1.localdomain>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 11:12:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180320143113.GD24329@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <2ad76fc0-6da9-9911-2dcd-335f7715fdef@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1 1/1] iotests: fix test case
 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, jcody@redhat.com



=E5=9C=A8 2018/3/20 22:31, Stefan Hajnoczi =E5=86=99=E9=81=93:
> On Tue, Mar 20, 2018 at 11:11:01AM +0100, Kevin Wolf wrote:
>> Am 19.03.2018 um 18:53 hat Christian Borntraeger geschrieben:
>>>
>>>
>>> On 03/19/2018 05:10 PM, Stefan Hajnoczi wrote:
>>>> On Mon, Mar 19, 2018 at 9:35 AM, QingFeng Hao <haoqf@linux.vnet.ibm.=
com> wrote:
>>>>> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm=
_shutdown()".
>>>>> It's because of the newly introduced function vm_shutdown calls bdr=
v_drain_all,
>>>>> which is called later by bdrv_close_all. bdrv_drain_all resumes the=
 jobs
>>>>> that doubles the speed and offset is doubled.
>>>>> Some jobs' status are changed as well.
>>>>>
>>>>> Thus, let's not call bdrv_drain_all in vm_shutdown.
>>>>>
>>>>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>>>> ---
>>>>>   cpus.c | 5 +++--
>>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/cpus.c b/cpus.c
>>>>> index 2e6701795b..ae2962508c 100644
>>>>> --- a/cpus.c
>>>>> +++ b/cpus.c
>>>>> @@ -1006,8 +1006,9 @@ static int do_vm_stop(RunState state, bool se=
nd_stop)
>>>>>               qapi_event_send_stop(&error_abort);
>>>>>           }
>>>>>       }
>>>>> -
>>>>> -    bdrv_drain_all();
>>>>> +    if (send_stop) {
>>>>> +        bdrv_drain_all();
>>>>> +    }
>>>>
>>>> Thanks for looking into this bug!
>>>>
>>>> This if statement breaks the contract of the function when send_stop
>>>> is false.  Drain ensures that pending I/O completes and that device
>>>> emulation finishes before this function returns.  This is important
>>>> for live migration, where there must be no more guest-related activi=
ty
>>>> after vm_stop().
>>>>
>>>> This patch relies on the caller invoking bdrv_close_all() immediatel=
y
>>>> after do_vm_stop(), which is not documented and could lead to more
>>>> bugs in the future.
>>>>
>>>> I suggest a different solution:
>>>>
>>>> Test 185 relies on internal QEMU behavior which can change from time
>>>> to time.  Buffer sizes and block job iteration counts are
>>>> implementation details that are not part of qapi-schema.json or othe=
r
>>>> documented behavior.
>>>>
>>>> In fact, the existing test case was already broken in IOThread mode
>>>> since iothread_stop_all() -> bdrv_set_aio_context() also includes a
>>>> bdrv_drain() with the side-effect of an extra blockjob iteration.
>>>>
>>>> After 4486e89c219 ("vl: introduce vm_shutdown()") both IOThread and
>>>> non-IOThread mode perform the drain.  This has caused the test
>>>> failure.
>>>>
>>>> Instead of modifying QEMU to keep the same arbitrary internal behavi=
or
>>>> as before, please send a patch that updates tests/qemu-iotests/185.o=
ut
>>>> with the latest output.
>>>
>>> Wouldnt it be better if the test actually masks out the values the ar=
e not
>>> really part of the "agreed upon" behaviour? Wouldnt block_job_offset =
from
>>> common.filter be what we want?
>>
>> The test case has the following note:
>>
>> # Note that the reference output intentionally includes the 'offset' f=
ield in
>> # BLOCK_JOB_CANCELLED events for all of the following block jobs. They=
 are
>> # predictable and any change in the offsets would hint at a bug in the=
 job
>> # throttling code.
>>
>> Now the question is if this particular change is okay rather than
>> hinting at a bug and we should update the reference output or whether =
we
>> need to change qemu again.
>>
>> I think the change isn't really bad, but we are doing more useless wor=
k
>> now than we used to do before, and we're exiting slower because we're
>> spawning additional I/O that we have to wait for. So the better state
>> was certainly the old one.
>=20
> Here is the reason for the additional I/O and how it could be
> eliminated:
>=20
> child_job_drained_begin() pauses and child_job_drained_end() resumes th=
e
> job.  Resuming the job cancels the timer (if pending) and enters the
> blockjob's coroutine.  This is why draining BlockDriverState forces an
> extra iteration of the blockjob.
>=20
> The current behavior is intended for the case where the job has I/O
> pending at child_job_drained_begin() time.  When the I/O completes, the
> job will see it must pause and it will yield at a pause point.  It make=
s
> sense for child_job_drained_end() to resume the job so it can start I/O
> again.
>=20
> In our case this behavior doesn't make sense though.  The job already
> yielded before child_job_drained_begin() and it doesn't need to resume
> at child_job_drained_end() time.  We'd prefer to wait for the timer
> expiry.
Thanks for all of your good comments! I think the better way is to=20
filter out this case but I am sure if this is a proper way to do it that
adds a yielded field in struct BlockJob to record if it's yielded by=20
block_job_do_yield. However, this way can only solve the offset problem=20
but not the status. Maybe we need also to change 185.out? I am bit=20
confused. thanks
>=20
> We need to distinguish these two cases to avoid resuming the job in the
> latter case.  I think this would be the proper way to avoid unnecessary
> blockjob activity across drain.
>=20
> I favor updating the test output though, because the code change adds
> complexity and the practical benefit is not obvious to me.
>=20
> QingFeng, if you decide to modify blockjobs, please CC Jeffrey Cody
> <jcody@redhat.com> and I'd also be happy to review the patch
>=20
> Stefan
>=20

--=20
Regards
QingFeng Hao
