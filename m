Received: from eggs.gnu.org ([2001:4830:134:3::10]:44564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzm3h-0008At-QU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzm3d-0003DE-Jr
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dzm3d-0003BU-A6
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16D847E427
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 15:58:00 +0000 (UTC)
References: <20171004114008.14849-1-berrange@redhat.com>
	<20171004114008.14849-3-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8ac64a27-8e89-d131-b388-8ac557ab5ce6@redhat.com>
Date: Wed, 4 Oct 2017 11:57:58 -0400
MIME-Version: 1.0
In-Reply-To: <20171004114008.14849-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] ide: support reporting of rotation
 rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>



On 10/04/2017 07:40 AM, Daniel P. Berrange wrote:
> The Linux kernel will query the ATA IDENTITY DEVICE data, word 217
> to determine the rotations per minute of the disk. If this has
> the value 1, it is taken to be an SSD and so Linux sets the
> 'rotational' flag to 0 for the I/O queue and will stop using that
> disk as a source of random entropy. Other operating systems may
> also take into account rotation rate when setting up default
> behaviour.
> 
> Mgmt apps should be able to set the rotation rate for virtualized
> block devices, based on characteristics of the host storage in use,
> so that the guest OS gets sensible behaviour out of the box. This
> patch thus adds a 'rotation-rate' parameter for 'ide-hd' device
> types.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/ide/core.c             | 1 +
>  hw/ide/qdev.c             | 1 +
>  include/hw/ide/internal.h | 8 ++++++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 5f1cd3b91f..a04766aee7 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -208,6 +208,7 @@ static void ide_identify(IDEState *s)
>      if (dev && dev->conf.discard_granularity) {
>          put_le16(p + 169, 1); /* TRIM support */
>      }
> +    put_le16(p + 217, dev->rotation_rate); /* Nominal media rotation rate */
>  
>      ide_identify_size(s);
>      s->identify_set = 1;
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index d60ac25be0..a5181b4448 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -299,6 +299,7 @@ static Property ide_hd_properties[] = {
>      DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
>      DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
>                  IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
> +    DEFINE_PROP_UINT16("rotation_rate", IDEDrive, dev.rotation_rate, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
> index e641012b48..31851b44d1 100644
> --- a/include/hw/ide/internal.h
> +++ b/include/hw/ide/internal.h
> @@ -508,6 +508,14 @@ struct IDEDevice {
>      char *serial;
>      char *model;
>      uint64_t wwn;
> +    /*
> +     * 0x0000        - rotation rate not reported
> +     * 0x0001        - non-rotating medium (SSD)
> +     * 0x0002-0x0400 - reserved
> +     * 0x0401-0xffe  - rotations per minute
> +     * 0xffff        - reserved
> +     */
> +    uint16_t rotation_rate;
>  };
>  
>  /* These are used for the error_status field of IDEBus */
> 

With Eric's comment addressed:

Reviewed-by: John Snow <jsnow@redhat.com>

It'd be nice if we could have a magic autodetect value, but this is a
strict improvement anyway.

(Actually, probably most of the identify data needs to be audited, but
the perceived cost:benefit ratio doesn't look too favorable.)
