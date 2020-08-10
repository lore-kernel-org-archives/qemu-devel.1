Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75EC206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Imi1P5OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75EC206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5866-00052w-5F
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k5859-00046p-Kl
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k5857-0001xj-JI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597066996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaKx2OZ1h0VrAiH41NlcpdXiDkDnFX+49omO/QQAGiA=;
 b=Imi1P5OAKaWOG8oEJSDGX4H4sSlN1vIqmYsBElH0i39SwcOeQa0ZmnbSl5vSK0SBZaoOWk
 99ccvLR57YLCin2G2DeCmxljjnmvUCCofjE+LRJJgej1lpU7lZ+ZN7RNMjdiiWEHyrthFd
 5r3jtmZWGYCxt4uWxyxH282AprBgUYs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-sJJ_fbYdOZqpWgDp-rKJnw-1; Mon, 10 Aug 2020 09:43:12 -0400
X-MC-Unique: sJJ_fbYdOZqpWgDp-rKJnw-1
Received: by mail-ej1-f69.google.com with SMTP id gg11so3872787ejb.6
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 06:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oaKx2OZ1h0VrAiH41NlcpdXiDkDnFX+49omO/QQAGiA=;
 b=Xd9eQoT3cTeDtKmIqqDXj1RYVIkKgxA0rcOuFzDwyXcSOfWwzkJt82xHnczhkN+v3Z
 aygP4iTL1hAelmhUDkKyj1V6gtB8HLgeVobhrtcxazBZ1gD39C2WsdFTn5O3163P28w/
 HTcD4XQRU4b7Zyd8Bu61nQ5UMIz425WqwSsLkyVUVkrIMsfpqMtWgWrdd7H2kT8ZeAYK
 KhEwrwGV/1XvLg1k0yey34qOwThozhYzDlNM7FBGeeB48ldl/e++fTApvB3xRt/wavd5
 feT94t8tSAd6nqt+HSjojQY0zMt2MciTtW9cvvsprUDCKrZJbNlZqc/9ixWItTXfYxrQ
 1jbA==
X-Gm-Message-State: AOAM533JhVQILNHvXnKdZnLf7zt4dpx1NfZ3aU8H5UYn3NQodtELMYH8
 eGjLYnIcDIczTwPtAjdHAd0VHRdELDPT7eGLjSZcMkTu9Udd1sEao6pv14MkZmpAXmgLl1rXlZr
 T+zJHPS15LjK+0N834C9Zk6i41aGnEl4=
X-Received: by 2002:a17:906:4dcb:: with SMTP id
 f11mr21244341ejw.454.1597066991060; 
 Mon, 10 Aug 2020 06:43:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFruMGOAs4ld4KO2jTC2j9NTgZ3sTXR6pFDql2aso4NtP9jFJo8ZShy7tp9AKHatP0fuFC2XanQql+4eT6EKk=
X-Received: by 2002:a17:906:4dcb:: with SMTP id
 f11mr21244320ejw.454.1597066990808; 
 Mon, 10 Aug 2020 06:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-15-clg@kaod.org>
In-Reply-To: <20200806132106.747414-15-clg@kaod.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 10 Aug 2020 15:43:00 +0200
Message-ID: <CAA8xKjVfG8cp_g6FDNxUCQ6dqiMHnf17eMNCE2Wz+Vr+grAprw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 14/19] ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcascell@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:35:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 6, 2020 at 3:21 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> When inserting the VLAN tag in packets, memmove() can generate an
> integer overflow for packets whose length is less than 12 bytes.
>
> Check length against the size of the ethernet header (14 bytes) to
> avoid the crash and return FTGMAC100_INT_XPKT_LOST status. This seems
> like a good modeling choice even if Aspeed does not specify anything
> in that case.
>
> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/net/ftgmac100.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 280aa3d3a1e2..987b843fabc4 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -540,10 +540,21 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint=
32_t tx_ring,
>                  s->isr |=3D FTGMAC100_INT_XPKT_LOST;
>                  len =3D  sizeof(s->frame) - frame_size - 4;
>              }
> -            memmove(ptr + 16, ptr + 12, len - 12);
> -            stw_be_p(ptr + 12, ETH_P_VLAN);
> -            stw_be_p(ptr + 14, bd.des1);
> -            len +=3D 4;
> +
> +            if (len < sizeof(struct eth_header)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                         "%s: frame too small for VLAN insertion : %d by=
tes\n",
> +                         __func__, len);
> +                s->isr |=3D FTGMAC100_INT_XPKT_LOST;
> +            } else {
> +                uint8_t *vlan_hdr =3D ptr + (ETH_ALEN * 2);
> +                uint8_t *payload =3D vlan_hdr + sizeof(struct vlan_heade=
r);
> +
> +                memmove(payload, vlan_hdr, len - (ETH_ALEN * 2));
> +                stw_be_p(vlan_hdr, ETH_P_VLAN);
> +                stw_be_p(vlan_hdr + 2, FTGMAC100_TXDES1_VLANTAG_CI(bd.de=
s1));
> +                len +=3D sizeof(struct vlan_header);
> +            }
>          }
>
>          ptr +=3D len;
> --
> 2.25.4
>

I can confirm that I can't reproduce the issue with the above patch. Thank =
you.

--=20
Mauro Matteo Cascella, Red Hat Product Security
6F78 E20B 5935 928C F0A8  1A9D 4E55 23B8 BB34 10B0


