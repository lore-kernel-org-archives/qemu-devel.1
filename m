Received: from eggs.gnu.org ([2001:4830:134:3::10]:42236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eyUG6-0003lH-Uw
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eyUG2-0008Rs-Ve
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:17:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33808
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1eyUG2-0008Rk-Pu
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:17:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2L3HPZa032541
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 23:17:45 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2guawrfkwa-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 23:17:45 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 20 Mar 2018 23:17:44 -0400
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
References: <20180319093509.50881-1-haoqf@linux.vnet.ibm.com>
	<20180319093509.50881-2-haoqf@linux.vnet.ibm.com>
	<CAJSP0QVe4gXCvPdw15x3D_yp2v4mi8QqYujo5qgxyeGcCbGfpw@mail.gmail.com>
	<1cc764c9-7bc1-365e-8af4-fe5357677aed@de.ibm.com>
	<20180320101101.GA4865@localhost.localdomain>
	<20180320143113.GD24329@stefanha-x1.localdomain>
	<2ad76fc0-6da9-9911-2dcd-335f7715fdef@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 11:17:33 +0800
MIME-Version: 1.0
In-Reply-To: <2ad76fc0-6da9-9911-2dcd-335f7715fdef@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c4b58739-bfd3-6d2f-f464-8ffd66b75ff1@linux.vnet.ibm.com>
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
Cc: Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>



=E5=9C=A8 2018/3/21 11:12, QingFeng Hao =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2018/3/20 22:31, Stefan Hajnoczi =E5=86=99=E9=81=93:
>> On Tue, Mar 20, 2018 at 11:11:01AM +0100, Kevin Wolf wrote:
>>> Am 19.03.2018 um 18:53 hat Christian Borntraeger geschrieben:
>>>>
>>>>
>>>> On 03/19/2018 05:10 PM, Stefan Hajnoczi wrote:
>>>>> On Mon, Mar 19, 2018 at 9:35 AM, QingFeng Hao=20
>>>>> <haoqf@linux.vnet.ibm.com> wrote:
>>>>>> Test case 185 failed since commit 4486e89c219 --- "vl: introduce=20
>>>>>> vm_shutdown()".
>>>>>> It's because of the newly introduced function vm_shutdown calls=20
>>>>>> bdrv_drain_all,
>>>>>> which is called later by bdrv_close_all. bdrv_drain_all resumes=20
>>>>>> the jobs
>>>>>> that doubles the speed and offset is doubled.
>>>>>> Some jobs' status are changed as well.
>>>>>>
>>>>>> Thus, let's not call bdrv_drain_all in vm_shutdown.
>>>>>>
>>>>>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>>>>> ---
>>>>>> =C2=A0 cpus.c | 5 +++--
>>>>>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/cpus.c b/cpus.c
>>>>>> index 2e6701795b..ae2962508c 100644
>>>>>> --- a/cpus.c
>>>>>> +++ b/cpus.c
>>>>>> @@ -1006,8 +1006,9 @@ static int do_vm_stop(RunState state, bool=20
>>>>>> send_stop)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 qapi_event_send_stop(&error_abort);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> -
>>>>>> -=C2=A0=C2=A0=C2=A0 bdrv_drain_all();
>>>>>> +=C2=A0=C2=A0=C2=A0 if (send_stop) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_drain_all();
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> Thanks for looking into this bug!
>>>>>
>>>>> This if statement breaks the contract of the function when send_sto=
p
>>>>> is false.=C2=A0 Drain ensures that pending I/O completes and that d=
evice
>>>>> emulation finishes before this function returns.=C2=A0 This is impo=
rtant
>>>>> for live migration, where there must be no more guest-related activ=
ity
>>>>> after vm_stop().
>>>>>
>>>>> This patch relies on the caller invoking bdrv_close_all() immediate=
ly
>>>>> after do_vm_stop(), which is not documented and could lead to more
>>>>> bugs in the future.
>>>>>
>>>>> I suggest a different solution:
>>>>>
>>>>> Test 185 relies on internal QEMU behavior which can change from tim=
e
>>>>> to time.=C2=A0 Buffer sizes and block job iteration counts are
>>>>> implementation details that are not part of qapi-schema.json or oth=
er
>>>>> documented behavior.
>>>>>
>>>>> In fact, the existing test case was already broken in IOThread mode
>>>>> since iothread_stop_all() -> bdrv_set_aio_context() also includes a
>>>>> bdrv_drain() with the side-effect of an extra blockjob iteration.
>>>>>
>>>>> After 4486e89c219 ("vl: introduce vm_shutdown()") both IOThread and
>>>>> non-IOThread mode perform the drain.=C2=A0 This has caused the test
>>>>> failure.
>>>>>
>>>>> Instead of modifying QEMU to keep the same arbitrary internal behav=
ior
>>>>> as before, please send a patch that updates tests/qemu-iotests/185.=
out
>>>>> with the latest output.
>>>>
>>>> Wouldnt it be better if the test actually masks out the values the=20
>>>> are not
>>>> really part of the "agreed upon" behaviour? Wouldnt block_job_offset=
=20
>>>> from
>>>> common.filter be what we want?
>>>
>>> The test case has the following note:
>>>
>>> # Note that the reference output intentionally includes the 'offset'=20
>>> field in
>>> # BLOCK_JOB_CANCELLED events for all of the following block jobs.=20
>>> They are
>>> # predictable and any change in the offsets would hint at a bug in=20
>>> the job
>>> # throttling code.
>>>
>>> Now the question is if this particular change is okay rather than
>>> hinting at a bug and we should update the reference output or whether=
 we
>>> need to change qemu again.
>>>
>>> I think the change isn't really bad, but we are doing more useless wo=
rk
>>> now than we used to do before, and we're exiting slower because we're
>>> spawning additional I/O that we have to wait for. So the better state
>>> was certainly the old one.
>>
>> Here is the reason for the additional I/O and how it could be
>> eliminated:
>>
>> child_job_drained_begin() pauses and child_job_drained_end() resumes t=
he
>> job.=C2=A0 Resuming the job cancels the timer (if pending) and enters =
the
>> blockjob's coroutine.=C2=A0 This is why draining BlockDriverState forc=
es an
>> extra iteration of the blockjob.
>>
>> The current behavior is intended for the case where the job has I/O
>> pending at child_job_drained_begin() time.=C2=A0 When the I/O complete=
s, the
>> job will see it must pause and it will yield at a pause point.=C2=A0 I=
t makes
>> sense for child_job_drained_end() to resume the job so it can start I/=
O
>> again.
>>
>> In our case this behavior doesn't make sense though.=C2=A0 The job alr=
eady
>> yielded before child_job_drained_begin() and it doesn't need to resume
>> at child_job_drained_end() time.=C2=A0 We'd prefer to wait for the tim=
er
>> expiry.
> Thanks for all of your good comments! I think the better way is to=20
> filter out this case but I am sure if this is a proper way to do it tha=
t
> adds a yielded field in struct BlockJob to record if it's yielded by=20
> block_job_do_yield. However, this way can only solve the offset problem=
=20
> but not the status. Maybe we need also to change 185.out? I am bit=20
> confused. thanks
What I did is setting job->yielded in block_job_do_yield and adding the=20
check for it in block_job_pause and block_job_resume that if yielded is
true, just return.
>>
>> We need to distinguish these two cases to avoid resuming the job in th=
e
>> latter case.=C2=A0 I think this would be the proper way to avoid unnec=
essary
>> blockjob activity across drain.
>>
>> I favor updating the test output though, because the code change adds
>> complexity and the practical benefit is not obvious to me.
>>
>> QingFeng, if you decide to modify blockjobs, please CC Jeffrey Cody
>> <jcody@redhat.com> and I'd also be happy to review the patch
>>
>> Stefan
>>
>=20

--=20
Regards
QingFeng Hao
