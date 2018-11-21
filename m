Received: from eggs.gnu.org ([2001:4830:134:3::10]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXKh-0005S8-1z
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXKc-0005BT-Pt
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:34:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPXKc-0005A5-KD
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:34:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so6749701wrt.7
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:34:34 -0800 (PST)
References: <20181121122910.20631-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4aceda96-cd6c-1c82-dfea-42ebf3eef963@redhat.com>
Date: Wed, 21 Nov 2018 19:34:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181121122910.20631-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: xtfpga: provide default
 memory sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

On 21/11/18 13:29, Max Filippov wrote:
> Provide default RAM sizes for all XTFPGA boards, so that when started
> without -m option they do the right thing.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - fix memory sizes for ml605 and kc705 with MMU
> 
>   hw/xtensa/xtfpga.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index b3161de32093..f9d41c5d1875 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -568,6 +568,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx60_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 64 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx60_type = {
> @@ -584,6 +585,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx60_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 64 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx60_nommu_type = {
> @@ -600,6 +602,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx200_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 96 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx200_type = {
> @@ -616,6 +619,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx200_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 96 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx200_nommu_type = {
> @@ -632,6 +636,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_ml605_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 384 * MiB;

Hmm this is now correct but I feel we are hidding information to further 
reviewers/developers. Without reading your v1 comment and looking at the 
new code I'd wonder why 384 and not 512.

What about adding a definition such:

#define XTENSA_CPU_MMU_RESERVED_IO_SIZE (128 * MiB)

Then use:

     mc->default_ram_size = 512 * MiB - XTENSA_CPU_MMU_RESERVED_IO_SIZE;

>   }
>   
>   static const TypeInfo xtfpga_ml605_type = {
> @@ -648,6 +653,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_ml605_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 256 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_ml605_nommu_type = {
> @@ -664,6 +670,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_kc705_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 896 * MiB;

Ditto:

     mc->default_ram_size = 1 * GiB - XTENSA_CPU_MMU_RESERVED_IO_SIZE;

>   }
>   
>   static const TypeInfo xtfpga_kc705_type = {
> @@ -680,6 +687,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_kc705_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 256 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_kc705_nommu_type = {
> 

If this patch goes thru your tree and you agree with the suggested 
changes, then you can directly add:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.
