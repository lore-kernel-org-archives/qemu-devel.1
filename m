Received: from eggs.gnu.org ([2001:4830:134:3::10]:50604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d43bO-0006yp-P7
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d43bL-0007Wt-MG
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:58:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d43bL-0007VZ-Dg
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:58:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OP400E8P94ZF590@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:58:11 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <474d4dd4-e9b9-3a6d-e7a2-15d48f8bd7ca@samsung.com>
Date: Fri, 28 Apr 2017 13:58:07 +0300
MIME-version: 1.0
In-reply-to: <20170428090153.GB24485@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065753eucas1p1524aa2bd8e469e6c94a88ee80eb54a6e@eucas1p1.samsung.com>
	<1493362658-8179-4-git-send-email-a.perevalov@samsung.com>
	<20170428090153.GB24485@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 3/6] migration: split
 ufd_version_check onto receive/request features part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com, f4bug@amsat.org

On 04/28/2017 12:01 PM, Peter Xu wrote:
> On Fri, Apr 28, 2017 at 09:57:35AM +0300, Alexey Perevalov wrote:
>> This modification is necessary for userfault fd features which are
>> required to be requested from userspace.
>> UFFD_FEATURE_THREAD_ID is a one of such "on demand" feature, which will
>> be introduced in the next patch.
>>
>> QEMU need to use separate userfault file descriptor, due to
>> userfault context has internal state, and after first call of
>> ioctl UFFD_API it changes its state to UFFD_STATE_RUNNING (in case of
>> success), but
>> kernel while handling ioctl UFFD_API expects UFFD_STATE_WAIT_API. So
>> only one ioctl with UFFD_API is possible per ufd.
>>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
>>   migration/postcopy-ram.c | 68 ++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 63 insertions(+), 5 deletions(-)
>>
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 4c859b4..21e7150 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -60,15 +60,51 @@ struct PostcopyDiscardState {
>>   #include <sys/eventfd.h>
>>   #include <linux/userfaultfd.h>
>>   
>> -static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
>> +
>> +/*
>> + * Check userfault fd features, to request only supported features in
>> + * future.
>> + * __NR_userfaultfd - should be checked before
>> + * Return obtained features
>> + */
>> +static bool receive_ufd_features(__u64 *features)
>>   {
>> -    struct uffdio_api api_struct;
>> -    uint64_t ioctl_mask;
>> +    struct uffdio_api api_struct = {0};
>> +    int ufd;
>> +    bool ret = true;
>>   
>> +    /* if we are here __NR_userfaultfd should exists */
>> +    ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
>> +    if (ufd == -1) {
> This check should be <0 rather than -1?
right, kernel could return any type of error,
if (error < 0)
     return error;

>
>> +        return false;
>> +    }
>> +
>> +    /* ask features */
>>       api_struct.api = UFFD_API;
>>       api_struct.features = 0;
>>       if (ioctl(ufd, UFFDIO_API, &api_struct)) {
>> -        error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
>> +        error_report("receive_ufd_features: UFFDIO_API failed: %s",
>> +                strerror(errno));
>> +        ret = false;
>> +        goto release_ufd;
>> +    }
>> +
>> +    *features = api_struct.features;
>> +
>> +release_ufd:
>> +    close(ufd);
>> +    return ret;
>> +}
>> +
>> +static bool request_ufd_features(int ufd, __u64 features)
>> +{
>> +    struct uffdio_api api_struct = {0};
>> +    uint64_t ioctl_mask;
>> +
>> +    api_struct.api = UFFD_API;
>> +    api_struct.features = features;
>> +    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
>> +        error_report("request_ufd_features: UFFDIO_API failed: %s",
>>                        strerror(errno));
>>           return false;
>>       }
>> @@ -81,11 +117,33 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
>>           return false;
>>       }
>>   
>> +    return true;
>> +}
>> +
>> +static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> This is not only a check not... It enables something in the kernel. So
> I'll suggest change the function name correspondingly.
yes, after that small changes, the meaning of the function has changed
maybe it's ufd_assign_and_check_features
>
>> +{
>> +    __u64 new_features = 0;
>> +
>> +    /* ask features */
>> +    __u64 supported_features;
>> +
>> +    if (!receive_ufd_features(&supported_features)) {
>> +        error_report("ufd_version_check failed");
>> +        return false;
>> +    }
>> +
>> +    /* request features */
>> +    if (new_features && !request_ufd_features(ufd, new_features)) {
> Firstly, looks like new_features == 0 here always, no?
I will use it in next patch.
>
> Second, I would suggest we enable feature explicitly. For this series,
> it's only for the THREAD_ID thing. I would mask the rest. The problem
> is, what if new features introduced in the future that we don't really
> want to enable for postcopy?
right now I think to rename new_features to enabled_features
or features_to_request,
if we don't want to enable feature - don't set according bit in 
enabled_features

>
> Thanks,
>
>> +        error_report("ufd_version_check failed: features %" PRIu64,
>> +                (uint64_t)new_features);
>> +        return false;
>> +    }
>> +
>>       if (getpagesize() != ram_pagesize_summary()) {
>>           bool have_hp = false;
>>           /* We've got a huge page */
>>   #ifdef UFFD_FEATURE_MISSING_HUGETLBFS
>> -        have_hp = api_struct.features & UFFD_FEATURE_MISSING_HUGETLBFS;
>> +        have_hp = supported_features & UFFD_FEATURE_MISSING_HUGETLBFS;
>>   #endif
>>           if (!have_hp) {
>>               error_report("Userfault on this host does not support huge pages");
>> -- 
>> 1.9.1
>>


-- 
Best regards,
Alexey Perevalov
