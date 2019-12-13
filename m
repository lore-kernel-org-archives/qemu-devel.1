Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE0C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2479422527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuOEG/se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2479422527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iffKy-0001xd-8U
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 02:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iffK0-0001Qe-1I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iffJy-0006jx-Bk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:25:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iffJu-0006gT-L8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576221901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Na3N2WXXqvUnmunnAoOZJLOkQIIflLK7Tc2r4I2RqgU=;
 b=TuOEG/se98jhKLtPW/DlJDWvRe56uEJE2UB3j5gnPmPumMEMlD7AjmiztcSBVJfpbSvqrN
 9u4rEsdhDbAtAPd017tRf8lxTkq+MrFZCv/lCurfYdt4orjw80Xa4/4lVWBmIH/twQD9kw
 SV8A9kTSZJj0l/q3YuRHRrQb2Rsa4N8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-cZUSpixPOfGs6ENkbQHnxw-1; Fri, 13 Dec 2019 02:25:00 -0500
Received: by mail-qt1-f198.google.com with SMTP id e37so1248927qtk.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 23:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rX886d0pBx2+lV5vTKvUPai/BzNutvZN6o5uaESUZ3M=;
 b=oyB2pZttyhFqluZZXpjG/mpZTrcCZWDmWB/afmaaHxk5vA5oocsBlaLb86JxE1n1MW
 jRrXR8mStEO3HaGjJSNqFBkZoYmVvgTb+ygY3xIcclC9xgFEasyU8ywq/3I35QCEyHcl
 zSgY8uSZBIGtPsiaZanjjHf3x+vTv7N8a3tzKtBaJrdJsPqbuQ/8aWK04bWLDQMrb2Kx
 zt0wibq/kkKmEjZXV25L0uSANcrBIBxXITAEd/MJYFBmiC/iJpNMYbaz7gL1OhSo44MF
 GYTG0HAdBO93sU9fqOQtOVFloPCcM76CDw3s/qZWDDZq78X8sVg1JV5SaNABEOzgH8j9
 LpZA==
X-Gm-Message-State: APjAAAUnGFrbwF3lKT8RPsyZs/jKXg78faGsBK1HJLel7L8mxEU0jzuY
 gUUN2VCpFgNOO4seWF+JFPVCxhAHUgwR7K30QMi8VAKSoTyQdN6OBwqY8oGniBCnuBlxaac9AQ+
 OBHAqGrPvOpxOvrI=
X-Received: by 2002:ac8:41c3:: with SMTP id o3mr11257196qtm.88.1576221899300; 
 Thu, 12 Dec 2019 23:24:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJ2Jh+2/F1d2/LHgt04MCKI7ksbBJhi8QCKBlbn/MCCEDi4c7DsmTKCFmr8wtEXgNE2mutUw==
X-Received: by 2002:ac8:41c3:: with SMTP id o3mr11257190qtm.88.1576221899088; 
 Thu, 12 Dec 2019 23:24:59 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id n7sm2573471qke.121.2019.12.12.23.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 23:24:58 -0800 (PST)
Date: Fri, 13 Dec 2019 02:24:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: virtio capabilities
Message-ID: <20191213021820-mutt-send-email-mst@kernel.org>
References: <823b58f1-f17e-6645-11be-406ad1494e06@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <823b58f1-f17e-6645-11be-406ad1494e06@ozlabs.ru>
X-MC-Unique: cZUSpixPOfGs6ENkbQHnxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 05:05:05PM +1100, Alexey Kardashevskiy wrote:
> Hi!
>=20
> I am having an issue with capabilities (hopefully the chunk formatting
> won't break).
>=20
> The problem is that when virtio_pci_find_capability() reads
> pci_find_capability(dev, PCI_CAP_ID_VNDR), 0 is returned; if repeated,
> it returns a valid number (0x84). Timing seems to matter. pci_cfg_read
> trace shows that that first time read does not reach QEMU but others do
> reach QEMU and return what is expected.
>=20
> How to debug this, any quick ideas?
> The config space is not a MMIO BAR
> or KVM memory slot or anything like this, right? :) Thanks,

Depends on the platform.

E.g. on x86, when using cf8/cfc pair, if guest doesn't
have a lock around programming the pair of registers,
then one access can conflict with another one.

When using express it's MMIO so shouldn't be a problem.

>=20
> [    3.489492] ___K___ (0) virtio_pci_modern_probe 642
> [    3.489697] ___K___ (0) virtio_pci_find_capability 492: FIND a cap
> [    3.490070] ___K___ (0) virtio_pci_find_capability 494: cap is at 0
> [    3.490335] ___K___ (0) virtio_pci_find_capability 492: FIND a cap
> 10909@1576216763.643271:pci_cfg_read virtio-net-pci 00:0 @0x6 -> 0x10
> 10909@1576216763.643431:pci_cfg_read virtio-net-pci 00:0 @0x34 -> 0x98
> 10909@1576216763.643591:pci_cfg_read virtio-net-pci 00:0 @0x98 -> 0x8411
> 10909@1576216763.643747:pci_cfg_read virtio-net-pci 00:0 @0x84 -> 0x7009
> [    3.491264] ___K___ (0) virtio_pci_find_capability 494: cap is at 132
> 10909@1576216763.644140:pci_cfg_read virtio-net-pci 00:0 @0x87 -> 0x5
> 10909@1576216763.644287:pci_cfg_read virtio-net-pci 00:0 @0x88 -> 0x0
> [    3.491803] ___K___ (0) virtio_pci_find_capability 506: 5 0
> 10909@1576216763.644632:pci_cfg_read virtio-net-pci 00:0 @0x85 -> 0x70
> 10909@1576216763.644786:pci_cfg_read virtio-net-pci 00:0 @0x70 -> 0x6009
> 10909@1576216763.644942:pci_cfg_read virtio-net-pci 00:0 @0x73 -> 0x2
> 10909@1576216763.645092:pci_cfg_read virtio-net-pci 00:0 @0x74 -> 0x4
> [    3.492607] ___K___ (0) virtio_pci_find_capability 506: 2 4
>=20
>=20
>=20
>=20
>=20
> diff --git a/drivers/virtio/virtio_pci_modern.c
> b/drivers/virtio/virtio_pci_modern.c
> index 7abcc50838b8..85b2a7ce96e9 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -486,9 +486,14 @@ static const struct virtio_config_ops
> virtio_pci_config_ops =3D {
>  static inline int virtio_pci_find_capability(struct pci_dev *dev, u8
> cfg_type,
>                                              u32 ioresource_types, int
> *bars)
>  {
> -       int pos;
> +       int pos =3D 0;// =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
>=20
> -       for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +       while (!pos) {
> +               pr_err("___K___ (%u) %s %u: FIND a cap\n",
> smp_processor_id(), __func__, __LINE__);
> +               pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +               pr_err("___K___ (%u) %s %u: cap is at %d\n",
> smp_processor_id(), __func__, __LINE__, pos);
> +       }
> +       for (;
>              pos > 0;
>              pos =3D pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR))=
 {
>                 u8 type, bar;
>=20
>=20
> --=20
> Alexey


