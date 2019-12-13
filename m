Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFF1C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 08:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA1A206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhTbE829"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA1A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifgSL-0004Ui-7P
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 03:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ifgRa-0003kw-U1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 03:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ifgRX-0004i4-67
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 03:37:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ifgRW-0004fa-Om
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 03:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576226217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWhu3zHP09Eka+Sj5NW0fZ3uBsgRE8fRjutvtjkvpsU=;
 b=bhTbE829DQxX+W4MuVivu51N1TM826k4P0Ith5uQzM7VGuA3KQJD6ZVYP7vQJteCaxwJ5a
 D8j7/yetvyUWQAcMMHV68CNWCkuZWS5tJtxCApAcsAik554u9wY2I8OZ9I8jf+NJl1gmWI
 Ehtb4LLu/uCGP23f8ulKQsh/vXSX3HQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-XksrmEWHNOGl5qMpclsC2g-1; Fri, 13 Dec 2019 03:36:56 -0500
Received: by mail-qk1-f198.google.com with SMTP id 12so955143qkf.20
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 00:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AGjJCJi/Nl3yRxGre4wbgV0X/iogYyHFMvJQLljnkzc=;
 b=YC7TnOObKVL74eVM+o4A4uZq+1JCXKllKLqx2dVSRUkyHEsoE3U19XufK1eUJyyt0F
 4M2np1MvoHEkEZVcd+jHoSMnbej30UywyHQ8YQb9N0F+XbJH3UcqelmlJOtXYnjtbcVV
 BMSTaSBDTJyjwEvaesRGq+iGNod+9ii+WySCptn+YrQ8xTmZoT+f7BE4duuxGXLLv5Wj
 B8Oh77kO8Wyr2+L9ZgGRg0itU/tVV2pCBJulyM48u3jrdwWv9VfRh8Qt7n8dZ4s1hFGY
 FYe/0GT+sDvlQFGYPo94O2e2lpTrRcWKx9sOtpS+yzhVpR0jQzV7ZGo6kHUgRxmn8LHB
 3WqQ==
X-Gm-Message-State: APjAAAU5YmzMRjrDRR5tnEAPWkjXT+wj9ivotfKN7r8VEADrfOf12VdV
 n3PIImMTAt4cuD/5r+oLnqrzyNz8zHF6tCvFodbodCbzSpQf27aPQnDFyH1+LclIEjfl+9EHgN/
 JQnjXMn+wVoS2+cs=
X-Received: by 2002:ac8:695a:: with SMTP id n26mr10407854qtr.367.1576226215614; 
 Fri, 13 Dec 2019 00:36:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxznsEhSNklYg4JKeeNCO7L/yOFC91SiFJFjYicCphYlWpyvQUos/wUG3faM9IQbP68PkUP5g==
X-Received: by 2002:ac8:695a:: with SMTP id n26mr10407835qtr.367.1576226215232; 
 Fri, 13 Dec 2019 00:36:55 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id u57sm3212909qth.68.2019.12.13.00.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 00:36:54 -0800 (PST)
Date: Fri, 13 Dec 2019 03:36:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: virtio capabilities
Message-ID: <20191213033620-mutt-send-email-mst@kernel.org>
References: <823b58f1-f17e-6645-11be-406ad1494e06@ozlabs.ru>
 <20191213021820-mutt-send-email-mst@kernel.org>
 <aff36770-9f21-988f-91ea-b106a8d5f1be@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <aff36770-9f21-988f-91ea-b106a8d5f1be@ozlabs.ru>
X-MC-Unique: XksrmEWHNOGl5qMpclsC2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 07:29:40PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 13/12/2019 18:24, Michael S. Tsirkin wrote:
> > On Fri, Dec 13, 2019 at 05:05:05PM +1100, Alexey Kardashevskiy wrote:
> >> Hi!
> >>
> >> I am having an issue with capabilities (hopefully the chunk formatting
> >> won't break).
> >>
> >> The problem is that when virtio_pci_find_capability() reads
> >> pci_find_capability(dev, PCI_CAP_ID_VNDR), 0 is returned; if repeated,
> >> it returns a valid number (0x84). Timing seems to matter. pci_cfg_read
> >> trace shows that that first time read does not reach QEMU but others d=
o
> >> reach QEMU and return what is expected.
> >>
> >> How to debug this, any quick ideas?
> >> The config space is not a MMIO BAR
> >> or KVM memory slot or anything like this, right? :) Thanks,
> >=20
> > Depends on the platform.
> >=20
> > E.g. on x86, when using cf8/cfc pair, if guest doesn't
>=20
>=20
> Is there an easy way to tell if it is this "cf8/cfc" case?
>=20
> I have these bars, is any of them related to cf8/cfc? Thanks,
>=20
> root@le-dbg:~# (qemu) info mtree -f
> FlatView #0
>  AS "memory", root: system
>  AS "cpu-memory-0", root: system
>  Root memory region: system
>   0000000000000000-00000000ffffffff (prio 0, ram): ppc_spapr.ram kvm
>   0000200080000000-000020008000002f (prio 0, i/o): msix-table
>   0000200080000800-0000200080000807 (prio 0, i/o): msix-pba
>   0000210000000000-0000210000000fff (prio 0, i/o): virtio-pci-common
>   0000210000001000-0000210000001fff (prio 0, i/o): virtio-pci-isr
>   0000210000002000-0000210000002fff (prio 0, i/o): virtio-pci-device
>   0000210000003000-0000210000003fff (prio 0, i/o): virtio-pci-notify
>=20


No, you want stuff in hw/ppc/spapr_pci.c

>=20
>=20
> > have a lock around programming the pair of registers,
> > then one access can conflict with another one.
> >=20
> > When using express it's MMIO so shouldn't be a problem.
> >=20
> >>
> >> [    3.489492] ___K___ (0) virtio_pci_modern_probe 642
> >> [    3.489697] ___K___ (0) virtio_pci_find_capability 492: FIND a cap
> >> [    3.490070] ___K___ (0) virtio_pci_find_capability 494: cap is at 0
> >> [    3.490335] ___K___ (0) virtio_pci_find_capability 492: FIND a cap
> >> 10909@1576216763.643271:pci_cfg_read virtio-net-pci 00:0 @0x6 -> 0x10
> >> 10909@1576216763.643431:pci_cfg_read virtio-net-pci 00:0 @0x34 -> 0x98
> >> 10909@1576216763.643591:pci_cfg_read virtio-net-pci 00:0 @0x98 -> 0x84=
11
> >> 10909@1576216763.643747:pci_cfg_read virtio-net-pci 00:0 @0x84 -> 0x70=
09
> >> [    3.491264] ___K___ (0) virtio_pci_find_capability 494: cap is at 1=
32
> >> 10909@1576216763.644140:pci_cfg_read virtio-net-pci 00:0 @0x87 -> 0x5
> >> 10909@1576216763.644287:pci_cfg_read virtio-net-pci 00:0 @0x88 -> 0x0
> >> [    3.491803] ___K___ (0) virtio_pci_find_capability 506: 5 0
> >> 10909@1576216763.644632:pci_cfg_read virtio-net-pci 00:0 @0x85 -> 0x70
> >> 10909@1576216763.644786:pci_cfg_read virtio-net-pci 00:0 @0x70 -> 0x60=
09
> >> 10909@1576216763.644942:pci_cfg_read virtio-net-pci 00:0 @0x73 -> 0x2
> >> 10909@1576216763.645092:pci_cfg_read virtio-net-pci 00:0 @0x74 -> 0x4
> >> [    3.492607] ___K___ (0) virtio_pci_find_capability 506: 2 4
> >>
> >>
> >>
> >>
> >>
> >> diff --git a/drivers/virtio/virtio_pci_modern.c
> >> b/drivers/virtio/virtio_pci_modern.c
> >> index 7abcc50838b8..85b2a7ce96e9 100644
> >> --- a/drivers/virtio/virtio_pci_modern.c
> >> +++ b/drivers/virtio/virtio_pci_modern.c
> >> @@ -486,9 +486,14 @@ static const struct virtio_config_ops
> >> virtio_pci_config_ops =3D {
> >>  static inline int virtio_pci_find_capability(struct pci_dev *dev, u8
> >> cfg_type,
> >>                                              u32 ioresource_types, int
> >> *bars)
> >>  {
> >> -       int pos;
> >> +       int pos =3D 0;// =3D pci_find_capability(dev, PCI_CAP_ID_VNDR)=
;
> >>
> >> -       for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
> >> +       while (!pos) {
> >> +               pr_err("___K___ (%u) %s %u: FIND a cap\n",
> >> smp_processor_id(), __func__, __LINE__);
> >> +               pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
> >> +               pr_err("___K___ (%u) %s %u: cap is at %d\n",
> >> smp_processor_id(), __func__, __LINE__, pos);
> >> +       }
> >> +       for (;
> >>              pos > 0;
> >>              pos =3D pci_find_next_capability(dev, pos, PCI_CAP_ID_VND=
R)) {
> >>                 u8 type, bar;
> >>
> >>
> >> --=20
> >> Alexey
> >=20
>=20
> --=20
> Alexey


