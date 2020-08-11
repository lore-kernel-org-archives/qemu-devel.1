Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624CFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 12:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FCF206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 12:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKCUMypy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FCF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5TIW-0002y5-8f
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 08:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k5THw-0002Z8-HU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:21:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k5THu-0004ZZ-Qj
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597148513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tasXQlAhulh1xqs4/Jtu33okRVHTUKddXMBo83ZXQx8=;
 b=EKCUMypyfULtAQI9sELMrSaRqrcLz61+eEBE0maianQgJQj3GgbFicJhZcyqUesFmM8w0K
 eLYpJBVrIPJzVsQ+hZXl9V3ERob+dg9ZkRlNQd2iCuq1+NT0sD2dQdDM+pLvEjKxF7NXXl
 bqFWKwGJMRCuKsVH/PAIM73iwR6wiNs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-MYQBAs8VN_2ytGAlOwJLzA-1; Tue, 11 Aug 2020 08:20:12 -0400
X-MC-Unique: MYQBAs8VN_2ytGAlOwJLzA-1
Received: by mail-ej1-f72.google.com with SMTP id g18so5088263ejm.4
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 05:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tasXQlAhulh1xqs4/Jtu33okRVHTUKddXMBo83ZXQx8=;
 b=VcQjpgPLS6X1bK6jUZC7ceU3k9grORBH8/s4rkeTf/pgWyNcLz5VWbmAopbWOGqoJ2
 0s03exUpxIsm8D7Armu1sb3RlyzLYc49moau7m5aG0gVaOfRARcu6hVxj3mHblr9Z17p
 JjdXRMLmr/qO9CiwvzOcW17iWivf7pXBwsHytQjoB+OHZSPLfAURqqeAx1N9rRBqW44w
 af5IRxI639sxibmHeiAVF6s01o6NZ1z8P5SYRkxtV9kICx14cG6iiDlbSNT9Q+81vftp
 dQ9LiF2IJVMQXXrIoIaL9VcbEqepz1+xuAZGvz0ut6F9WJf3F+jWVSZ67rQ3YBR0bs16
 Mwdw==
X-Gm-Message-State: AOAM5329q24SDyOuW4hrWH+pwbjp4FIq4YqE6EVUfkkiwC+VPcTx5FBF
 WUOUCwRS0BgtcQgpoIKHvTPDtxoBoWBBCTFHi7BsAcX3ep2mQ1qDFB5NrqTK3xJvUODI0ndvcQ3
 QJCXR/yNj9VrRSEMkeJKUFhh/zBsbxAQ=
X-Received: by 2002:a17:906:3816:: with SMTP id
 v22mr25710005ejc.105.1597148411110; 
 Tue, 11 Aug 2020 05:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv5n0KpemNvW81t0FwnlmFZd86TbHttVZCh9KSKzOvNu3vwNsMxjCWfDzBYfIfBy2JSq/HDGZnqOZBIdgn0sc=
X-Received: by 2002:a17:906:3816:: with SMTP id
 v22mr25709981ejc.105.1597148410782; 
 Tue, 11 Aug 2020 05:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-15-clg@kaod.org>
 <CAA8xKjVfG8cp_g6FDNxUCQ6dqiMHnf17eMNCE2Wz+Vr+grAprw@mail.gmail.com>
 <b0e8e4d3-5250-ec81-7ce5-146bba1d5130@kaod.org>
In-Reply-To: <b0e8e4d3-5250-ec81-7ce5-146bba1d5130@kaod.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 11 Aug 2020 14:20:00 +0200
Message-ID: <CAA8xKjW0GBdCeJ7=ApmAAEpVMJQLMJwTt2C60YZYSBUq0kdWZg@mail.gmail.com>
Subject: Re: [PATCH for-5.2 14/19] ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcascell@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

On Mon, Aug 10, 2020 at 7:14 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 8/10/20 3:43 PM, Mauro Matteo Cascella wrote:
> > On Thu, Aug 6, 2020 at 3:21 PM C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
> >>
> >> When inserting the VLAN tag in packets, memmove() can generate an
> >> integer overflow for packets whose length is less than 12 bytes.
> >>
> >> Check length against the size of the ethernet header (14 bytes) to
> >> avoid the crash and return FTGMAC100_INT_XPKT_LOST status. This seems
> >> like a good modeling choice even if Aspeed does not specify anything
> >> in that case.
> >>
> >> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
> >> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> >> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/net/ftgmac100.c | 19 +++++++++++++++----
> >>  1 file changed, 15 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> >> index 280aa3d3a1e2..987b843fabc4 100644
> >> --- a/hw/net/ftgmac100.c
> >> +++ b/hw/net/ftgmac100.c
> >> @@ -540,10 +540,21 @@ static void ftgmac100_do_tx(FTGMAC100State *s, u=
int32_t tx_ring,
> >>                  s->isr |=3D FTGMAC100_INT_XPKT_LOST;
> >>                  len =3D  sizeof(s->frame) - frame_size - 4;
> >>              }
> >> -            memmove(ptr + 16, ptr + 12, len - 12);
> >> -            stw_be_p(ptr + 12, ETH_P_VLAN);
> >> -            stw_be_p(ptr + 14, bd.des1);
> >> -            len +=3D 4;
> >> +
> >> +            if (len < sizeof(struct eth_header)) {
> >> +                qemu_log_mask(LOG_GUEST_ERROR,
> >> +                         "%s: frame too small for VLAN insertion : %d=
 bytes\n",
> >> +                         __func__, len);
> >> +                s->isr |=3D FTGMAC100_INT_XPKT_LOST;
> >> +            } else {
> >> +                uint8_t *vlan_hdr =3D ptr + (ETH_ALEN * 2);
> >> +                uint8_t *payload =3D vlan_hdr + sizeof(struct vlan_he=
ader);
> >> +
> >> +                memmove(payload, vlan_hdr, len - (ETH_ALEN * 2));
> >> +                stw_be_p(vlan_hdr, ETH_P_VLAN);
> >> +                stw_be_p(vlan_hdr + 2, FTGMAC100_TXDES1_VLANTAG_CI(bd=
.des1));
> >> +                len +=3D sizeof(struct vlan_header);
> >> +            }
> >>          }
> >>
> >>          ptr +=3D len;
> >> --
> >> 2.25.4
> >>
> >
> > I can confirm that I can't reproduce the issue with the above patch. Th=
ank you.
> >
>
> Can I count that as a Tested-by ?
>
> Thanks,
>
> C.
>
>

Sure. I wonder whether we should make 'len' unsigned, though I think
it doesn't really matter due to FTGMAC100_TXDES0_TXBUF_SIZE. What do
you think?

Tested-by: Mauro Matteo Cascella <mcascell@redhat.com>


--
Mauro Matteo Cascella, Red Hat Product Security
6F78 E20B 5935 928C F0A8  1A9D 4E55 23B8 BB34 10B0


