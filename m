Received: from eggs.gnu.org ([2001:4830:134:3::10]:55903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ddFc8-0006jY-P7
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ddFc5-0006YV-8O
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ddFc5-0006XU-30
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:52:29 -0400
Date: Thu, 3 Aug 2017 15:52:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170803155042-mutt-send-email-mst@kernel.org>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-2-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501285073-2215-2-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Sat, Jul 29, 2017 at 02:37:49AM +0300, Aleksandr Bezzubikov wrote:
> Unmask previously masked SHPC feature in _OSC method.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>

This does not do what the subject says - it enables
SHPC unconditionally. And I think it will actually break
ACPI hotplug for the PC unless we add an interface to
disable ACPI hotplug and enable SHPC.

Pls limit to Q35 only.

> ---
>  hw/i386/acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6b7bade..2ab32f9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1848,9 +1848,9 @@ static Aml *build_q35_osc_method(void)
>  
>      /*
>       * Always allow native PME, AER (no dependencies)
> -     * Never allow SHPC (no SHPC controller in this system)
> +     * Allow SHPC (PCI bridges can have SHPC controller)
>       */
> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
>  
>      if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>      /* Unknown revision */
> -- 
> 2.7.4
