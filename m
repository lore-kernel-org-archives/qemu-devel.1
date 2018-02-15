Received: from eggs.gnu.org ([2001:4830:134:3::10]:42668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emKpO-0007AE-GP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emKpJ-0008Lr-GR
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:48:02 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emKpJ-0008Id-6q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:47:57 -0500
References: <151799695576.147.5866177190489987115@bdbb90650ae5>
	<381c5681-a194-6750-06ac-7afeda9173f7@vivier.eu>
	<56e236398cf70cc2f2b431ea7660b3bd@linux.vnet.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b6000e1f-ccae-9adc-bbde-5a1f4c715482@vivier.eu>
Date: Thu, 15 Feb 2018 15:47:44 +0100
MIME-Version: 1.0
In-Reply-To: <56e236398cf70cc2f2b431ea7660b3bd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [patch] linux-user/syscall.c: Fix missing break
 for host_to_target_cmsg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

Le 08/02/2018 à 10:56, Nageswara R Sastry a écrit :
> On 2018-02-07 19:27, Laurent Vivier wrote:
>> Le 07/02/2018 à 10:49, no-reply@patchew.org a écrit :
>>> Hi,
>>>
>>> This series failed build test on s390x host. Please find the details
>>> below.
>> ...
>>>   CC      aarch64_be-linux-user/linux-user/syscall.o
>>> In file included from
>>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/qemu.h:16:0,
>>>                  from
>>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:118:
>>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c: In
>>> function ‘do_sendrecvmsg_locked’:
>>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall_defs.h:308:61:
>>> error: ‘tgt_len’ may be used uninitialized in this function
>>> [-Werror=maybe-uninitialized]
>>>  #define TARGET_CMSG_LEN(len) (sizeof(struct target_cmsghdr) + (len))
>>>                                                              ^
>>> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:1797:13: note:
>>> ‘tgt_len’ was declared here
>>>          int tgt_len, tgt_space;
>>>              ^~~~~~~
>>
>> it seems gcc disagrees with Coverity...
>>
>> I think this should fixed like:
>>
>>  diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 74378947f0..d7fbe334eb 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -1824,8 +1824,10 @@ static inline abi_long host_to_target_cmsg(struct
>> target_msghdr *target_msgh,
>>                  tgt_len = sizeof(struct target_timeval);
>>                  break;
>>              default:
>> +                tgt_len = len;
>>                  break;
> 
> In my view this will result in assigning a wrong value to ‘tgt_len’ at
> this ‘switch-case’ condition.
> Instead looking at the option of initializing ‘tgt_len' to ‘0’.

According to the comment above the switch():

        /* Payload types which need a different size of payload on
         * the target must adjust tgt_len here.
         */

So "tgt_len" must be "len" by default, except if it needs to be adjusted
(currently only for SO_TIMESTAMP), so I don't understand why it should
be set to "0".

Thanks,
Laurent
