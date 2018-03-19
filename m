Received: from eggs.gnu.org ([2001:4830:134:3::10]:40620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1exyyM-0008CZ-Tt
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1exyyJ-00019B-Sd
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:53:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44490
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1exyyJ-000175-MS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:53:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2JHjBKG114419
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 13:53:21 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gtern9fbj-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 13:53:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 19 Mar 2018 17:53:19 -0000
References: <20180319093509.50881-1-haoqf@linux.vnet.ibm.com>
	<20180319093509.50881-2-haoqf@linux.vnet.ibm.com>
	<CAJSP0QVe4gXCvPdw15x3D_yp2v4mi8QqYujo5qgxyeGcCbGfpw@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 19 Mar 2018 18:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVe4gXCvPdw15x3D_yp2v4mi8QqYujo5qgxyeGcCbGfpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1cc764c9-7bc1-365e-8af4-fe5357677aed@de.ibm.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>



On 03/19/2018 05:10 PM, Stefan Hajnoczi wrote:
> On Mon, Mar 19, 2018 at 9:35 AM, QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
>> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_shutdown()".
>> It's because of the newly introduced function vm_shutdown calls bdrv_drain_all,
>> which is called later by bdrv_close_all. bdrv_drain_all resumes the jobs
>> that doubles the speed and offset is doubled.
>> Some jobs' status are changed as well.
>>
>> Thus, let's not call bdrv_drain_all in vm_shutdown.
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> ---
>>  cpus.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 2e6701795b..ae2962508c 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1006,8 +1006,9 @@ static int do_vm_stop(RunState state, bool send_stop)
>>              qapi_event_send_stop(&error_abort);
>>          }
>>      }
>> -
>> -    bdrv_drain_all();
>> +    if (send_stop) {
>> +        bdrv_drain_all();
>> +    }
> 
> Thanks for looking into this bug!
> 
> This if statement breaks the contract of the function when send_stop
> is false.  Drain ensures that pending I/O completes and that device
> emulation finishes before this function returns.  This is important
> for live migration, where there must be no more guest-related activity
> after vm_stop().
> 
> This patch relies on the caller invoking bdrv_close_all() immediately
> after do_vm_stop(), which is not documented and could lead to more
> bugs in the future.
> 
> I suggest a different solution:
> 
> Test 185 relies on internal QEMU behavior which can change from time
> to time.  Buffer sizes and block job iteration counts are
> implementation details that are not part of qapi-schema.json or other
> documented behavior.
> 
> In fact, the existing test case was already broken in IOThread mode
> since iothread_stop_all() -> bdrv_set_aio_context() also includes a
> bdrv_drain() with the side-effect of an extra blockjob iteration.
> 
> After 4486e89c219 ("vl: introduce vm_shutdown()") both IOThread and
> non-IOThread mode perform the drain.  This has caused the test
> failure.
> 
> Instead of modifying QEMU to keep the same arbitrary internal behavior
> as before, please send a patch that updates tests/qemu-iotests/185.out
> with the latest output.

Wouldnt it be better if the test actually masks out the values the are not
really part of the "agreed upon" behaviour? Wouldnt block_job_offset from
common.filter be what we want?
