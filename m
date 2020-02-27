Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C2C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1ED0222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJNPGXev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ED0222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Eba-0007nd-2s
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7EaL-0006wW-Td
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7EaK-0006j2-Me
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:31:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7EaK-0006fd-IF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582792315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmQY4eabl3QdJOcsL6pGL1m4HP0v2CQwawqKSckWrXs=;
 b=XJNPGXev3l9lorZr15fOB0+pdVazQ2XA/v6oGo5Ir5y2ASbfEOezz0bLf0HvL04WCR/68K
 G0ThnQzjWXO9i7LEPnVPP2RnnBiXUz45BLKnmoflnyWQ0BA3mZ/go2Anq7ncOy8ImH/dSe
 ISq7c3w+7AP1mY1OF6VQesXOnFKSQYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ZlBmv2EAPHel2BP6om_Z_Q-1; Thu, 27 Feb 2020 03:31:54 -0500
X-MC-Unique: ZlBmv2EAPHel2BP6om_Z_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17CE51005514;
 Thu, 27 Feb 2020 08:31:53 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3685F60BE1;
 Thu, 27 Feb 2020 08:31:49 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] hw/arm/smmu-common: Simplify
 smmu_find_smmu_pcibus() logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200227075111.15275-1-philmd@redhat.com>
 <20200227075111.15275-3-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7ba75891-33c2-fb50-a57d-6f23e9e656d5@redhat.com>
Date: Thu, 27 Feb 2020 09:31:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200227075111.15275-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,
On 2/27/20 8:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The smmu_find_smmu_pcibus() function was introduced (in commit
> cac994ef43b) in a code format that could return an incorrect
> pointer, which was then fixed by the previous commit.
> We could have avoid this by writing the if() statement differently.
nit: avoided
> Do it now, in case this function is re-used. The code is easier to
> review (harder to miss bugs).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This patch is easier to review with 'git-diff -w' (--ignore-all-space)
> ---
>  hw/arm/smmu-common.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 67d7b2d0fd..e13a5f4a7c 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -290,20 +290,21 @@ inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t i=
ova, IOMMUAccessFlags perm,
>  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
>  {
>      SMMUPciBus *smmu_pci_bus =3D s->smmu_pcibus_by_bus_num[bus_num];
> +    GHashTableIter iter;
> =20
> -    if (!smmu_pci_bus) {
> -        GHashTableIter iter;
> -
> -        g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
> -        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bu=
s)) {
> -            if (pci_bus_num(smmu_pci_bus->bus) =3D=3D bus_num) {
> -                s->smmu_pcibus_by_bus_num[bus_num] =3D smmu_pci_bus;
> -                return smmu_pci_bus;
> -            }
> -        }
> -        smmu_pci_bus =3D NULL;
> +    if (smmu_pci_bus) {
> +        return smmu_pci_bus;
>      }
> -    return smmu_pci_bus;
> +
> +    g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
> +    while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) =
{
> +        if (pci_bus_num(smmu_pci_bus->bus) =3D=3D bus_num) {
> +            s->smmu_pcibus_by_bus_num[bus_num] =3D smmu_pci_bus;
> +            return smmu_pci_bus;
> +        }
> +    }
> +
> +    return NULL;
>  }
> =20
>  static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int dev=
fn)
>=20
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric




