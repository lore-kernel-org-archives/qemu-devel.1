Received: from eggs.gnu.org ([2001:4830:134:3::10]:55777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYM51-0004Cw-7X
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYM4w-0004iv-BV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:50:39 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYM4w-0004il-6b
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:50:34 -0400
Received: by mail-qt0-x244.google.com with SMTP id y20-v6so3412151qto.8
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 18:50:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-4-f4bug@amsat.org>
	<147860fa-3867-eb37-71a2-5cd03935b6f8@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1dceecb0-7ce2-0657-4bb4-7e731529127f@amsat.org>
Date: Wed, 27 Jun 2018 22:50:27 -0300
MIME-Version: 1.0
In-Reply-To: <147860fa-3867-eb37-71a2-5cd03935b6f8@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/11] linux-user/strace: add
 print_sockaddr_ptr() to handle plain/pointer addrlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Hi Laurent,

On 02/17/2018 03:10 PM, Laurent Vivier wrote:
> Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
>> since this argument differs between sendto()/recvfrom()
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  linux-user/strace.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index e7272f4ede..9726d9b378 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -335,12 +335,15 @@ static void print_siginfo(const target_siginfo_t *tinfo)
>>  }
>>  
>>  static void
>> -print_sockaddr(abi_ulong addr, abi_long addrlen)
>> +print_sockaddr_ptr(abi_ulong addr, abi_long addrlen, bool addrlen_ptr)
>>  {
>>      struct target_sockaddr *sa;
>>      int i;
>>      int sa_family;
>>  
>> +    if (addrlen_ptr) {
>> +        get_user_ual(addrlen, addrlen);
>> +    }
>>      sa = lock_user(VERIFY_READ, addr, addrlen, 1);
>>      if (sa) {
>>          sa_family = tswap16(sa->sa_family);
>> @@ -417,7 +420,17 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
>>      } else {
>>          print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
>>      }
>> -    gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
>> +    if (addrlen_ptr) {
>> +        gemu_log(", ["TARGET_ABI_FMT_ld"]", addrlen);
>> +    } else {
>> +        gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
>> +    }
>> +}
>> +
>> +static void
>> +print_sockaddr(abi_ulong addr, abi_long addrlen)
>> +{
>> +    print_sockaddr_ptr(addr, addrlen, false);
>>  }
>>  
>>  static void
>>
> 
> Why not only something like:
> 
> static void
> print_sockaddr_ptr(abi_ulong addr, abi_long addrlen_ptr)
> {
>     abi_ulong addrlen;
> 
>     get_user_ual(addrlen, addrlen_ptr);
>     print_sockaddr(addr, addrlen);
> }
> 
> ?

Because we loose the [] around addrlen.

> You should also check addrlen_ptr != NULL (it's allowed with recvfrom()).

OK.

> 
> Thanks,
> Laurent
> 
