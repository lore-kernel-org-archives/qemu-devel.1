Received: from eggs.gnu.org ([209.51.188.92]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2XH6-0000jq-Sb
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 03:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2XH5-0001h3-Th
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 03:24:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2XH5-0001fr-FQ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 03:24:07 -0500
From: Thomas Huth <thuth@redhat.com>
References: <1552119170-15474-1-git-send-email-thuth@redhat.com>
Message-ID: <5c06cc96-d585-acaa-4889-a7ce8d538f26@redhat.com>
Date: Sat, 9 Mar 2019 09:24:01 +0100
MIME-Version: 1.0
In-Reply-To: <1552119170-15474-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/char/parallel: Make it possible to
 compile also without CONFIG_PARALLEL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Miroslav Rezanina <mrezanin@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 09/03/2019 09.12, Thomas Huth wrote:
> For the downstream distribution of QEMU, we want to compile without
> CONFIG_PARALLEL. Commit 9157eee1b1c076ff3 already moved the function
> parallel_hds_isa_init() (which is still required for linking) into a file
> that is included anyway, but commit bb3d5ea858e7f888563a moved it
> to a separate file which is only compiled again if CONFIG_PARALLEL is
> set. To be able to link QEMU again without CONFIG_PARALLEL, let's
> move this file unconditionally to common-obj-y again. And while we're
> at it, also rename it to parallel-helper.c (since parallel.c is also
> about ISA already), add a proper comment in there with the rationale
> for the separate file, and a check via object_class_by_name() to see
> whether the device class is available in the binary or not.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/char/Makefile.objs                         |  2 +-
>  hw/char/{parallel-isa.c => parallel-helper.c} | 10 +++++++++-
>  hw/char/parallel.c                            |  1 -
>  hw/i386/Kconfig                               |  2 --
>  include/hw/char/parallel.h                    |  2 ++
>  5 files changed, 12 insertions(+), 5 deletions(-)
>  rename hw/char/{parallel-isa.c => parallel-helper.c} (70%)
> 
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index c4947d7..5476803 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -2,7 +2,7 @@ common-obj-$(CONFIG_IPACK) += ipoctal232.o
>  common-obj-$(CONFIG_ESCC) += escc.o
>  common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
>  common-obj-$(CONFIG_PARALLEL) += parallel.o
> -common-obj-$(CONFIG_PARALLEL) += parallel-isa.o
> +common-obj-y += parallel-helper.o

Self-NACK.

This has to be "common-obj-$(CONFIG_ISA_BUS) += parallel-helper.o" since
it uses the function isa_create(). ... thus, maybe I should also not
rename the file here... I'll ponder about that in a v2...

 Thomas
