Received: from eggs.gnu.org ([2001:4830:134:3::10]:49311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYRkJ-0006ng-V6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYRkI-00073s-VN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:49:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170721041952.45950-1-aik@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b3ed544c-a576-7a74-b7b0-8067873cf11e@amsat.org>
Date: Fri, 21 Jul 2017 03:48:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170721041952.45950-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] Revert "elf-loader: warn about
 invalid endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Paul Burton <paul.burton@imgtec.com>, Alistair Francis <alistair.francis@xilinx.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Hi Alexey,

On 07/21/2017 01:19 AM, Alexey Kardashevskiy wrote:
> This reverts c8e1158cf611 "elf-loader: warn about invalid endianness"
> as it produces a useless message every time an LE kernel image is
> passed via -kernel on a ppc64-pseries machine. The pseries machine
> already checks for ELF_LOAD_WRONG_ENDIAN and tries with big_endian=0.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   hw/core/loader.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index c17ace0a2e..e5e8cbb638 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -480,7 +480,6 @@ int load_elf_ram(const char *filename,
>       }
>   
>       if (target_data_order != e_ident[EI_DATA]) {
> -        fprintf(stderr, "%s: wrong endianness\n", filename);
>           ret = ELF_LOAD_WRONG_ENDIAN;
>           goto fail;
>       }
> 

I submitted this patch because I spent some time debugging while QEMU 
was failing silently using a MIPS kernel image which used to work, after 
realizing I was in an incorrect build_dir using qemu-system-mipsel to 
load a big endian image and felt stupid [1]. This dumb error can happen 
to other people so I added this warning here.
I was not aware of the ELF_LOAD_WRONG_ENDIAN related code, and at least 
the MIPS arch is not using it.
As I can see in MAINTAINERS, sPAPR is "Supported" meaning "Someone is 
actually paid to look after this", while there is no such paid person 
for the MIPS part.
It seems each arch had a different way to load images and 
hw/core/loader.c was an effort to merge common code but mostly 
"Supported" arch are using it.
While your revert does fixes your sPAPR warning issue, looking at the 
problem roots I think the correct fix is to improve the MIPS port and 
eventually the less loved archs to unify the loader.c calls and avoid 
such problems.
I don't object reverting this patch for 2.10 and improve the loader.c 
usage during 2.11 cycle, I only wonder if this is another 
corporate/hobbyist conflict of interest with corporate crushing on 
hobbyist instead of helping, motivating contribution improving common 
code usage.

Cc'ed MIPS and loader.c maintainers (both "Maintained" and not "Supported").

Phil.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05926.html
