Received: from eggs.gnu.org ([2001:4830:134:3::10]:38232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f0fLX-0006hn-4b
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f0fLT-000118-Vm
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:32:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1f0fLT-00010K-NF
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:32:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2R3TTIm008389
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 23:32:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gycbabhcr-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 23:32:21 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 26 Mar 2018 23:32:20 -0400
References: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
	<20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
	<CAJSP0QUtM4HrvTDgK_u8hDSSy4KaeCjskDdM7-AZjShd50Qw5g@mail.gmail.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 11:32:00 +0800
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUtM4HrvTDgK_u8hDSSy4KaeCjskDdM7-AZjShd50Qw5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57467bb4-9143-2239-87a2-4bada0e1719d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Jeff Cody <jcody@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


=E5=9C=A8 2018/3/23 18:04, Stefan Hajnoczi =E5=86=99=E9=81=93:
> On Fri, Mar 23, 2018 at 3:43 AM, QingFeng Hao <haoqf@linux.vnet.ibm.com=
> wrote:
>> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_sh=
utdown()".
>> It's because of the newly introduced function vm_shutdown calls bdrv_d=
rain_all,
>> which is called later by bdrv_close_all. bdrv_drain_all resumes the jo=
bs
>> that doubles the speed and offset is doubled.
>> Some jobs' status are changed as well.
>>
>> The fix is to not resume the jobs that are already yielded and also ch=
ange
>> 185.out accordingly.
>>
>> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> ---
>>   blockjob.c                 | 10 +++++++++-
>>   include/block/blockjob.h   |  5 +++++
>>   tests/qemu-iotests/185.out | 11 +++++++++--
>=20
> If drain no longer forces the block job to iterate, shouldn't the test
> output remain the same?  (The means the test is fixed by the QEMU
> patch.)
>=20
>>   3 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/blockjob.c b/blockjob.c
>> index ef3ed69ff1..fa9838ac97 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -206,11 +206,16 @@ void block_job_txn_add_job(BlockJobTxn *txn, Blo=
ckJob *job)
>>
>>   static void block_job_pause(BlockJob *job)
>>   {
>> -    job->pause_count++;
>> +    if (!job->yielded) {
>> +        job->pause_count++;
>> +    }
>=20
> The pause cannot be ignored.  This change introduces a bug.
>=20
> Pause is not a synchronous operation that stops the job immediately.
> Pause just remembers that the job needs to be paused.   When the job
> runs again (e.g. timer callback, fd handler) it eventually reaches
> block_job_pause_point() where it really pauses.
>=20
> The bug in this patch is:
>=20
> 1. The job has a timer pending.
> 2. block_job_pause() is called during drain.
> 3. The timer fires during drain but now the job doesn't know it needs
> to pause, so it continues running!
>=20
> Instead what needs to happen is that block_job_pause() remains
> unmodified but block_job_resume if extended:
>=20
> static void block_job_resume(BlockJob *job)
> {
>      assert(job->pause_count > 0);
>      job->pause_count--;
>      if (job->pause_count) {
>          return;
>      }
> +    if (job_yielded_before_pause_and_is_still_yielded) {
Thanks a lot for your great comments! But I can't figure out how to=20
check this.
>      block_job_enter(job);
> +    }
> }
>=20
> This handles the case I mentioned above, where the yield ends before
> pause ends (therefore resume must enter the job!).
>=20
> To make this a little clearer, there are two cases to consider:
>=20
> Case 1:
> 1. Job yields
> 2. Pause
> 3. Job is entered from timer/fd callback
How do I know that if job is entered from ...? thanks
> 4. Resume (enter job? yes)
>=20
> Case 2:
> 1. Job yields
> 2. Pause
> 3. Resume (enter job? no)
> 4. Job is entered from timer/fd callback
>=20
> Stefan
>=20

--=20
Regards
QingFeng Hao
