Received: from eggs.gnu.org ([2001:4830:134:3::10]:38333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2Juk-00053X-Jw
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2Juh-0000OE-E5
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:03:38 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2Juh-0000Lv-52
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:03:35 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20180331162336.20158-1-jcmvbkbc@gmail.com>
	<8500c798-619a-54f8-7073-abeae0427b67@vivier.eu>
Message-ID: <771016f3-6675-da1c-8c5a-3d9f95f4fb4f@vivier.eu>
Date: Sat, 31 Mar 2018 19:03:06 +0200
MIME-Version: 1.0
In-Reply-To: <8500c798-619a-54f8-7073-abeae0427b67@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix mq_getsetattr
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Aurelien Jarno <aurelien@aurel32.net>

Le 31/03/2018 à 18:57, Laurent Vivier a écrit :
> Le 31/03/2018 à 18:23, Max Filippov a écrit :
>> mq_getsetattr implementation does not set errno correctly in case of
>> error. Also in the presence of both 2nd and 3rd arguments it calls both
>> mq_getattr and mq_setattr, whereas only the latter call would suffice.
>>
>> Don't call mq_getattr in the presence of the 3rd argument. Use get_errno
>> to set errno value.
>>
>> This fixes test rt/tst-mqueue2 from the glibc testsuite.
>>
>> Cc: Lionel Landwerlin <lionel.landwerlin@openwide.fr>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Riku Voipio <riku.voipio@iki.fi>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  linux-user/syscall.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 18ea79140f16..8b364551c311 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -12092,15 +12092,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>          {
>>              struct mq_attr posix_mq_attr_in, posix_mq_attr_out;
>>              ret = 0;
> 
> you can remove this line

in fact, you must keep this line because ret is not update if arg2 ==
NULL and arg3 == NULL.

Thanks,
Laurent
