Received: from eggs.gnu.org ([2001:4830:134:3::10]:54189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYLyF-0002vk-AQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYLyA-0006mt-Du
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:43:39 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYLyA-0006mY-8d
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:43:34 -0400
Received: by mail-qt0-x244.google.com with SMTP id a18-v6so3413309qtj.4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 18:43:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-9-f4bug@amsat.org>
	<6f75cd0a-1a5f-5915-a8a1-8279eeb1d6fd@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c152e852-26ad-e2c6-8027-c814ea2edf00@amsat.org>
Date: Wed, 27 Jun 2018 22:43:29 -0300
MIME-Version: 1.0
In-Reply-To: <6f75cd0a-1a5f-5915-a8a1-8279eeb1d6fd@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/11] linux-user/strace: improve
 gettimeofday() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>, qemu-devel@nongnu.org

Hi Laurent,

On 02/17/2018 02:21 PM, Laurent Vivier wrote:
> Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  linux-user/strace.c    | 13 +++++++++++++
>>  linux-user/strace.list |  2 +-
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index 4b8ab6bcfb..b7c4cfae58 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -1526,6 +1526,19 @@ print_futimesat(const struct syscallname *name,
>>  }
>>  #endif
>>  
>> +#ifdef TARGET_NR_gettimeofday
>> +static void
>> +print_gettimeofday(const struct syscallname *name,
>> +                   abi_long arg0, abi_long arg1, abi_long arg2,
>> +                   abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
>> +    print_syscall_prologue(name);
>> +    print_pointer(arg0, 0);
>> +    print_pointer(arg1, 1);
>> +    print_syscall_epilogue(name);
>> +}
>> +#endif
>> +
>>  #ifdef TARGET_NR_link
>>  static void
>>  print_link(const struct syscallname *name,
>> diff --git a/linux-user/strace.list b/linux-user/strace.list
>> index 958d10d48f..f90c0e8ee4 100644
>> --- a/linux-user/strace.list
>> +++ b/linux-user/strace.list
>> @@ -384,7 +384,7 @@
>>  { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
>>  #endif
>>  #ifdef TARGET_NR_gettimeofday
>> -{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
>> +{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, print_gettimeofday, NULL },
>>  #endif
>>  #ifdef TARGET_NR_getuid
>>  { TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
>>
> 
> There is a print_timeval(), and you could add a print_timezone(), and
> update the result() function pointer to call them.

The result prototype is:

  void (*result)(const struct syscallname *, abi_long);

So we don't have access to the address of the struct timeval argument as
the call() function.

> 
> And once it is done, you can also display them for settimeofday().

OK.
