Received: from eggs.gnu.org ([2001:4830:134:3::10]:37759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gUPqb-0007eg-Ox
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gUPqX-0001hq-Kz
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:35:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1gUPqX-0001Zo-AU
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:35:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id z18so11878925wmc.4
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 21:35:36 -0800 (PST)
References: <HE1P190MB00739AD5A654DAA3FE9B4662DEAF0@HE1P190MB0073.EURP190.PROD.OUTLOOK.COM>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <a3fe5633-d031-6a58-40c2-aee43b2bec45@tuxfamily.org>
Date: Wed, 5 Dec 2018 06:35:32 +0100
MIME-Version: 1.0
In-Reply-To: <HE1P190MB00739AD5A654DAA3FE9B4662DEAF0@HE1P190MB0073.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] i386: don't require elf64 for multiboot kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonzo FWS <fwsgonzo@hotmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 2018-12-04 17:55, Gonzo FWS wrote:
> Right now IncludeOS on x86_64 must use a chainloader for multiboot support. The chainloader is an ELF32 kernel that loads the real ELF64 kernel and jumps to it. As long as the ELF has the .multiboot section and conforms to the spec, meaning _start is be a 32-bit entry, it should be fine.
> 
> By removing the extra check in multiboot.c, we can also boot ELF64 files. As can be seen here:
> https://cloud.fwsnet.net/index.php/s/XrkBkC8zy7MLa9p
> 
> Signed-off-by: Alf-André Walla <fwsgonzo@hotmail.com>
> ---
>  hw/i386/multiboot.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 1a4344f5fc..d07ebf3361 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -194,11 +194,6 @@ int load_multiboot(FWCfgState *fw_cfg,
>          int kernel_size;
>          fclose(f);
> 
> -        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
> -            error_report("Cannot load x86-64 image, give a 32bit one.");
> -            exit(1);
> -        }
> -

Looks like the check has once been introduced explicitly:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=9696846600cac4bd0dfd6835

Maybe we should at least print out a warn_report() instead, so that
people who try to boot 64-bit kernel without 32-bit entry point still
get an idea why it is not working in that case?

  Thomas


PS: Please make sure to CC: the i386 maintainers when sending patches
that touch files in the hw/i386/ directory, thanks!
