Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cS209-0007Ui-Dl
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cS206-0008Nu-AX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:34:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cS206-0008NR-4N
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:34:38 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4586A4E4CF
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 13:34:37 +0000 (UTC)
Date: Fri, 13 Jan 2017 14:34:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170113143433.282c9a81@nial.brq.redhat.com>
In-Reply-To: <20170112182446.9600-2-lersek@redhat.com>
References: <20170112182446.9600-1-lersek@redhat.com>
	<20170112182446.9600-2-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 wave 2 1/3] hw/isa/lpc_ich9: add SMI
 feature negotiation via fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

On Thu, 12 Jan 2017 19:24:44 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

[...]
> +static void smi_features_ok_callback(void *opaque)
> +{
> +    ICH9LPCState *lpc = opaque;
> +    uint64_t guest_features;
> +
> +    if (lpc->smi_features_ok) {
> +        /* negotiation already complete, features locked */
> +        return;
> +    }
> +
> +    memcpy(&guest_features, lpc->smi_guest_features_le, sizeof guest_features);
> +    le64_to_cpus(&guest_features);
> +    if (guest_features & ~lpc->smi_host_features) {
> +        /* guest requests invalid features, leave @features_ok at zero */
> +        return;
> +    }
> +
> +    /* valid feature subset requested, lock it down, report success */
> +    lpc->smi_negotiated_features = guest_features;
> +    lpc->smi_features_ok = 1;
> +}
[...]

> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(smi_guest_features_le, ICH9LPCState,
> +                            sizeof(uint64_t)),
> +        VMSTATE_UINT8(smi_features_ok, ICH9LPCState),
> +        VMSTATE_UINT64(smi_negotiated_features, ICH9LPCState),

Couldn't smi_negotiated_features be derived from
smi_guest_features_le on target side?


> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_ich9_lpc = {
>      .name = "ICH9LPC",
>      .version_id = 1,
> @@ -683,6 +761,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
>      },
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_ich9_rst_cnt,
> +        &vmstate_ich9_smi_feat,
>          NULL
>      }
>  };
