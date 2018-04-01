Received: from eggs.gnu.org ([2001:4830:134:3::10]:47294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2kJu-00089I-UF
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2kJr-0003fT-ON
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:15:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2kJr-0003ev-EE
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:15:19 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20180401203739.31670-1-jcmvbkbc@gmail.com>
	<26d50d9e-20a4-08e5-a860-e0cae22efd29@vivier.eu>
Message-ID: <32d29a7b-9f00-fa10-618c-88f6c0b5abce@vivier.eu>
Date: Sun, 1 Apr 2018 23:15:09 +0200
MIME-Version: 1.0
In-Reply-To: <26d50d9e-20a4-08e5-a860-e0cae22efd29@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix error propagation in
 clock_gettime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 01/04/2018 à 23:05, Laurent Vivier a écrit :
> Le 01/04/2018 à 22:37, Max Filippov a écrit :
>> host_to_target_timespec may return error if target address could not be
>> locked, but it is ignored.
>> Propagate return value of host_to_target_timespec to the caller of
>> clock_gettime.
>>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  linux-user/syscall.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index d51e2a00ee31..52e2f9c16479 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -11884,7 +11884,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>          struct timespec ts;
>>          ret = get_errno(clock_gettime(arg1, &ts));
>>          if (!is_error(ret)) {
>> -            host_to_target_timespec(arg2, &ts);
>> +            ret = host_to_target_timespec(arg2, &ts);
>>          }
>>          break;
>>      }
>>
> 
> Could you also update in the same way clock_getres?

Ignore this, clock_getres() accepts a NULL pointer.

so:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


Thanks,
Laurent
