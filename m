Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A644C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48A22467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d06bBHnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48A22467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7EPB-0003x0-16
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7EOV-0003RD-Qr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7EOU-0000Qf-GZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:19:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38360
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7EOU-0000Ph-2m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582791581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RObblKBf6mrz+eA4PkPspRr4IMEeVMvSrywem5dXJs=;
 b=d06bBHnHqrpucekKud8jljr/FMy3hS4XvTpCHuuPF61uMZdB4HR+pY1lx6WQEyl+L97iAP
 +y/bKYgxyw5G2MtNh5xePD5kPvI5ZmrljnQRMgJzZkAlRB3vX9WPwczW2bPlEZxk99N9KM
 fIFaTTm3u3njPVdiBnT5d5BXY3Hu1Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-HyYjPEu_M0-PkNobTuti7Q-1; Thu, 27 Feb 2020 03:19:39 -0500
X-MC-Unique: HyYjPEu_M0-PkNobTuti7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F2328017CC;
 Thu, 27 Feb 2020 08:19:38 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6E1077945;
 Thu, 27 Feb 2020 08:19:30 +0000 (UTC)
Subject: Re: [PATCH v3] hw/i386/intel_iommu: Simplify
 vtd_find_as_from_bus_num() logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200227074606.14272-1-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <782a5549-0b83-443c-6927-8cdbc03b1155@redhat.com>
Date: Thu, 27 Feb 2020 09:19:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200227074606.14272-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 2/27/20 8:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The vtd_find_as_from_bus_num() function was introduced (in commit
> dbaabb25f) in a code format that could return an incorrect pointer,
> which was later fixed by commit a2e1cd41ccf.
> We could have avoid this by writing the if() statement differently.
s/avoid/avoided
> Do it now, in case this function is re-used. The code is easier to
> review (harder to miss bugs).
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Since v2: Re-worded commit description, patch sent without -w.
> Since v3: patch send without diff
>=20
> This patch is easier to review with 'git-diff -w' (--ignore-all-space)
> ---
>  hw/i386/intel_iommu.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6258c58ac9..e720a8939c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -987,24 +987,26 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, =
uint32_t level)
>  static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_=
num)
>  {
>      VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
> -    if (!vtd_bus) {
> -        /*
> -         * Iterate over the registered buses to find the one which
> -         * currently hold this bus number, and update the bus_num
s/hold/holds
> -         * lookup table:
I would change the comment that way

Iterate over the registered buses to find the one which
currently holds this bus number and update the bus_num
lookup table

> -         */
> -        GHashTableIter iter;
> +    GHashTableIter iter;
> =20
> -        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> -        while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
> -            if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> -                s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> -                return vtd_bus;
> -            }
> -        }
> -        vtd_bus =3D NULL;
> +    if (vtd_bus) {
> +        return vtd_bus;
>      }
> -    return vtd_bus;
> +
> +    /*
> +     * Iterate over the registered buses to find the one which
> +     * currently hold this bus number, and update the bus_num
> +     * lookup table:
> +     */
> +    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> +    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
> +        if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> +            s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> +            return vtd_bus;
> +        }
> +    }
> +
> +    return NULL;
>  }
> =20
>  /* Given the @iova, get relevant @slptep. @slpte_level will be the last =
level
>=20

Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


