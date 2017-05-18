Received: from eggs.gnu.org ([2001:4830:134:3::10]:45428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBKEV-0001cP-IM
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBKEU-0003zG-NR
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:08:43 -0400
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-10-pbonzini@redhat.com>
	<w51efvmgyj6.fsf@maestria.local.igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf5d85d7-26cc-2457-06fc-ca827ca1eaff@redhat.com>
Date: Thu, 18 May 2017 14:08:32 +0200
MIME-Version: 1.0
In-Reply-To: <w51efvmgyj6.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/18] throttle-groups:
 protect throttled requests with a CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com



On 18/05/2017 14:06, Alberto Garcia wrote:
> On Thu 11 May 2017 04:41:59 PM CEST, Paolo Bonzini wrote:
> 
>> --- a/include/sysemu/block-backend.h
>> +++ b/include/sysemu/block-backend.h
>> @@ -72,11 +72,8 @@ typedef struct BlockDevOps {
>>   * fields that must be public. This is in particular for QLIST_ENTRY() and
>>   * friends so that BlockBackends can be kept in lists outside block-backend.c */
>>  typedef struct BlockBackendPublic {
>> -    /* I/O throttling has its own locking, but also some fields are
>> -     * protected by the AioContext lock.
>> -     */
>> -
>> -    /* Protected by AioContext lock.  */
>> +    /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
>> +    CoMutex      throttled_reqs_lock;
>>      CoQueue      throttled_reqs[2];
>>  
>>      /* Nonzero if the I/O limits are currently being ignored; generally
>>       * it is zero.  */
>>      unsigned int io_limits_disabled;
> 
> Does io_limits_disabled need locking too?

It uses atomic access since patch 3.

Paolo
