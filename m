Received: from eggs.gnu.org ([2001:4830:134:3::10]:52057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbQv-0002vc-Ah
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbQs-00052X-6Q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gDbQr-00051Q-Tv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:42 -0400
From: Liam Merwick <liam.merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
	<1d34f37c-94cb-61af-58a6-dae10ddc2ce5@redhat.com>
Message-ID: <27a60d5c-481a-c8c1-88e7-853ff441b144@oracle.com>
Date: Fri, 19 Oct 2018 21:32:05 +0100
MIME-Version: 1.0
In-Reply-To: <1d34f37c-94cb-61af-58a6-dae10ddc2ce5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] qemu-img: potential Null pointer
 deref in img_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org



On 12/10/18 15:51, Max Reitz wrote:
> On 31.08.18 20:16, Liam Merwick wrote:
>> The function block_job_get() may return NULL so before dereferencing
>> the 'job' pointer in img_commit() it should be checked.
> 
> It may not because the job yields before executing anything (if it
> started successfully; but otherwise, commit_active_start() would have
> returned an error).  Therefore, I think the better solution is to
> assert(job) here.
> 


Switched patch to use assert()

Regards,
Liam


> (It would be a serious bug if block_job_get() returned NULL here, so
> it's definitely not something we can be quiet about.  But this patch
> makes it so the user doesn't even notice.)
> 
> Max
> 
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
>> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
>> ---
>>   qemu-img.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index b12f4cd19b0a..51fe09bd08ed 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1029,6 +1029,9 @@ static int img_commit(int argc, char **argv)
>>       }
>>   
>>       job = block_job_get("commit");
>> +    if (job == NULL) {
>> +        goto unref_backing;
>> +    }
>>       run_block_job(job, &local_err);
>>       if (local_err) {
>>           goto unref_backing;
>>
> 
> 
