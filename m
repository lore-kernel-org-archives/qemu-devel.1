Received: from eggs.gnu.org ([2001:4830:134:3::10]:51585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRzk5-0005T4-15
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRzk0-0005Ie-40
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:42:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dRzjz-0005IG-PG
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:42:08 -0400
References: <1499068251-6164-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<83e957bb-6064-e769-6ada-3846cbd77059@redhat.com>
	<0e91b7e7-5301-8b55-261c-bc4b822f82f7@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <14f79ebc-09bc-cbb2-537c-f2c8f1c55763@redhat.com>
Date: Mon, 3 Jul 2017 13:42:04 +0200
MIME-Version: 1.0
In-Reply-To: <0e91b7e7-5301-8b55-261c-bc4b822f82f7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com


>> Wonder if we should declare all these prototypes at the beginning of the
>> file.
>>
> Don't know either. Looking around in QEMU, forward declarations for
> static functions seem to be used sparsely (only when needed). I could
> have reordered the functions to get around without forward decls but
> this would have obscured the change. Maybe defer and clean up in a
> general cleanup/refactoring?

Yes, fine with me!
[...]

>>
>> Hmmmm, if this function fails, we will create the same error multiple
>> times (as there is no way to stop this function from iterating). And we
>> will fail to create a cpu model list in case there is no host cpu model,
>> which is a change in behavior (as we will report an error).
>>
>> Would it be better to simply get the max model in
>> arch_query_cpu_definitions() and pass it via CpuDefinitionInfoListData,
>> instead of the errp variable?Simplifies things, I like it.
>>
>> Then you could simply skip the checks and set
>> info->has_unavailable_features = false in case there is no max model
>> (get_max_cpu_model() returned NULL / an error). (same behavior as for now)
>>
>> Errors from get_max_cpu_model() then should be ignored and not reported.
>>
> Just to be sure: you suggest that I should call error_free() after
> calling get_max_cpu_model, in order to prevent that the QMP command
> query-cpu-definitions fails, right?

That would be my suggestion simply don't provide runability information,
if we can't tell (because the max model is not available - e.g. with old
KVM versions without complete CPU model support), hiding the error.

-- 

Thanks,

David
