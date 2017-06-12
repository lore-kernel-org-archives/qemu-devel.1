Received: from eggs.gnu.org ([2001:4830:134:3::10]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKFt6-0001iu-Pw
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 23:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKFt5-00059C-RX
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 23:19:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAPhXLnv2g_80gi1o6p-QUbKJQ5m+6gkLDN8TWtE-B=70uacDEw@mail.gmail.com>
	<CAPhXLnuNAqwQHdns2Sxv4UuFz9WhGH1ZM4E4TN87e31cDpZ7gQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fec4ddf7-f316-675b-bccb-236f281a174a@amsat.org>
Date: Mon, 12 Jun 2017 00:19:21 -0300
MIME-Version: 1.0
In-Reply-To: <CAPhXLnuNAqwQHdns2Sxv4UuFz9WhGH1ZM4E4TN87e31cDpZ7gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Fwd: [BUG] Failed to compile using gcc7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tsung-en Hsiao <tsn@cs.nctu.edu.tw>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Qu Wenruo <quwenruo@cn.fujitsu.com>

Hi Tsung-en,

On 06/11/2017 04:08 PM, Tsung-en Hsiao wrote:
> Hi all,
> I encountered the same problem on gcc 7.1.1 and found Qu's mail in
> this list from google search.
>
> Temporarily fix it by specifying the string length in snprintf
> directive. Hope this is helpful to other people encountered the same
> problem.

Thank your for sharing this.

>
> @@ -1,9 +1,7 @@
> ---
> --- a/block/blkdebug.c
> -                 "blkdebug:%s:%s", s->config_file ?: "",
> --- a/block/blkverify.c
> -                 "blkverify:%s:%s",
> --- a/hw/usb/bus.c
> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
> -        snprintf(downstream->path, sizeof(downstream->path), "%d", portnr);
> --
> +++ b/block/blkdebug.c
> +                 "blkdebug:%.2037s:%.2037s", s->config_file ?: "",

It is a rather funny way to silent this warning :) Truncating the 
filename until it fits.

However I don't think it is the correct way since there is indeed an 
overflow of bs->exact_filename.

Apparently exact_filename from "block/block_int.h" is defined to hold a 
pathname:
     char exact_filename[PATH_MAX];

but is used for more than that (for example in blkdebug.c it might use 
until 10+2*PATH_MAX chars).

I suppose it started as a buffer to hold a pathname then more block 
drivers were added and this buffer ended used differently.

If it is a multi-purpose buffer one safer option might be to declare it 
as a GString* and use g_string_printf().

I CC'ed the block folks to have their feedback.

Regards,

Phil.

> +++ b/block/blkverify.c
> +                 "blkverify:%.2038s:%.2038s",
> +++ b/hw/usb/bus.c
> +        snprintf(downstream->path, sizeof(downstream->path), "%.12s.%d",
> +        snprintf(downstream->path, sizeof(downstream->path), "%.12d", portnr);
>
> Tsung-en Hsiao
>
>> Qu Wenruo Wrote:
>>
>> Hi all,
>>
>> After upgrading gcc from 6.3.1 to 7.1.1, qemu can't be compiled with gcc.
>>
>> The error is:
>>
>> ------
>>  CC      block/blkdebug.o
>> block/blkdebug.c: In function 'blkdebug_refresh_filename':
>>
>> block/blkdebug.c:693:31: error: '%s' directive output may be truncated writing up to 4095 bytes into a region of size 4086 [-Werror=format-truncation=]
>>
>>                  "blkdebug:%s:%s", s->config_file ?: "",
>>                               ^~
>> In file included from /usr/include/stdio.h:939:0,
>>                 from /home/adam/qemu/include/qemu/osdep.h:68,
>>                 from block/blkdebug.c:25:
>>
>> /usr/include/bits/stdio2.h:64:10: note: '__builtin___snprintf_chk' output 11 or more bytes (assuming 4106) into a destination of size 4096
>>
>>   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>        __bos (__s), __fmt, __va_arg_pack ());
>>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/home/adam/qemu/rules.mak:69: block/blkdebug.o] Error 1
>> ------
>>
>> It seems that gcc 7 is introducing more restrict check for printf.
>>
>> If using clang, although there are some extra warning, it can at least pass the compile.
>>
>> Thanks,
>> Qu
>
