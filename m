Received: from eggs.gnu.org ([2001:4830:134:3::10]:58999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daDhI-0008VK-Nt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daDhF-0001jf-Hm
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:13:20 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:35180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daDhF-0001jE-Cy
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:13:17 -0400
Received: by mail-qk0-x231.google.com with SMTP id d145so73329306qkc.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:13:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
Date: Wed, 26 Jul 2017 01:13:12 -0300
MIME-Version: 1.0
In-Reply-To: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] hw/core/loader-fit.c:105:41: error: expected
 expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi John,

On 07/25/2017 07:55 PM, Programmingkid wrote:
> While compiling the mips64el-softmmu target I encountered these errors:
> 
>    CC      hw/display/g364fb.o
> hw/core/loader-fit.c:105:41: error: expected expression
>          *addr = fdt32_to_cpu(*(fdt32_t *)prop);
>                                          ^
> hw/core/loader-fit.c:105:32: error: use of undeclared identifier 'fdt32_t'

It seems you are missing the libfdt headers, so indeed you found bug.

Replacing CONFIG_FITLOADER by CONFIG_FDT in hw/core/Makefile.objs and 
default-configs/mips64el-softmmu.mak should fix it, can you try?

>          *addr = fdt32_to_cpu(*(fdt32_t *)prop);
>                                 ^
> hw/core/loader-fit.c:108:41: error: expected expression
>          *addr = fdt64_to_cpu(*(fdt64_t *)prop);
>                                          ^
> hw/core/loader-fit.c:108:32: error: use of undeclared identifier 'fdt64_t'
>          *addr = fdt64_to_cpu(*(fdt64_t *)prop);
>                                 ^
> hw/core/loader-fit.c:278:19: warning: implicit declaration of function
>        'fdt_first_subnode' is invalid in C99 [-Wimplicit-function-declaration]
>              off = fdt_first_subnode(itb, configs);
>                    ^
> hw/core/loader-fit.c:286:23: warning: implicit declaration of function
>        'fdt_next_subnode' is invalid in C99 [-Wimplicit-function-declaration]
>                  off = fdt_next_subnode(itb, off);
>                        ^
> 2 warnings and 4 errors generated.
> make: *** [hw/core/loader-fit.o] Error 1
> make: *** Waiting for unfinished jobs….

It'd be useful if next time you also tell which compiler/version are you 
using.

> Steps to reproduce the error:
> ./configure --target-list=mips64el-softmmu && make

And also the ./configure output, I'm interested by:

"fdt support       no"

Regards,

Phil.
