Received: from eggs.gnu.org ([2001:4830:134:3::10]:44231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkD1p-0006K6-6N
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkD1o-00051j-EX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:31:49 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:37099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkD1o-000517-8g
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:31:48 -0400
Received: by mail-wr0-x235.google.com with SMTP id z91so127664468wrc.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 10:31:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503406059-7280-1-git-send-email-thuth@redhat.com>
References: <1503406059-7280-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 18:31:26 +0100
Message-ID: <CAFEAcA-p2q=-b5nW2MF9m7dMeX+dmDqMO5OYC51RDEAiC0d6jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/aspeed_soc: Mark devices as
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2017 at 13:47, Thomas Huth <thuth@redhat.com> wrote:
> QEMU currently aborts if the user is accidentially trying to
> do something like this:
>
> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
> QEMU 2.9.93 monitor - type 'help' for more information
> (qemu) device_add ast2400
> Unexpected error in error_set_from_qdev_prop_error()
>  at hw/core/qdev-properties.c:1032:
> Aborted (core dumped)
>
> The ast2400 SoC devices are clearly not creatable by the user since
> they are using the serial_hds and nd_table arrays directly in their
> realize function, so mark them with user_creatable = false.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/aspeed_soc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 5529024..7f1be04 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -338,6 +338,8 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
>
>      sc->info = (AspeedSoCInfo *) data;
>      dc->realize = aspeed_soc_realize;
> +    /* Reason: Uses serial_hds and nd_table in realize() directly */
> +    dc->user_creatable = false;
>  }
>
>  static const TypeInfo aspeed_soc_type_info = {
> --
> 1.8.3.1

Applied to target-arm.next for 2.11, thanks.

-- PMM
