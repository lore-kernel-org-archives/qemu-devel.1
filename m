Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A64C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E83C20728
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="PBQCYFAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E83C20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irifJ-00067h-M1
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2768d130c=pdurrant@amazon.co.uk>)
 id 1ire70-0006IR-Tj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 03:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2768d130c=pdurrant@amazon.co.uk>)
 id 1ire6v-0007SI-Sd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 03:33:14 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:62446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=2768d130c=pdurrant@amazon.co.uk>)
 id 1ire6v-0007RC-OB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 03:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1579077190; x=1610613190;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ocWGvKzT9rHeLGLw56o19WY9tgHhZErb9cLkoBLDMQs=;
 b=PBQCYFACm6nZ37+pre+YvqPOXwl8fE2N0cTo1bPapwFTlzBafIjlLxra
 2sovSGMxyfWv/33DdrrP1s0UsJoDfw6S/CyfYPxQRvGFPEfjgH5eNRYoF
 Zylju2IelxxOQBKB/QgbH1uM4P9kK+JnMWzQNc4qT3te8+vB0Ale/ndLX s=;
IronPort-SDR: wvOOn/x2BXteConQ492U+xceQNdCh5lUsbwyrpFZL4Y3+BfSDXeps520clpjxzNWVPkesNhQqb
 oX1fkcFm18RQ==
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; d="scan'208";a="12455655"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 15 Jan 2020 08:33:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS
 id AECA2A1DEB; Wed, 15 Jan 2020 08:33:04 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 15 Jan 2020 08:33:04 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 15 Jan 2020 08:33:03 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Wed, 15 Jan 2020 08:33:02 +0000
From: "Durrant, Paul" <pdurrant@amazon.co.uk>
To: =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>, Jason Andryuk
 <jandryuk@gmail.com>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, Stefano Stabellini
 <sstabellini@kernel.org>, "marmarek@invisiblethingslab.com"
 <marmarek@invisiblethingslab.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Simon Gaiser <simon@invisiblethingslab.com>, Anthony
 Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>
Subject: RE: [Xen-devel] [PATCH 6/6] xen-pt: Round pci regions sizes to
 XEN_PAGE_SIZE
Thread-Topic: [Xen-devel] [PATCH 6/6] xen-pt: Round pci regions sizes to
 XEN_PAGE_SIZE
Thread-Index: AQHVykQofKTNIgpPpkmSOKKDUKIMmKfp72EAgABNlACAADjFgIAA8bAw
Date: Wed, 15 Jan 2020 08:33:02 +0000
Message-ID: <ed1ca41d72bd49c59e5e25044a0a85e0@EX13D32EUC003.ant.amazon.com>
References: <ee0da83d3f054e72ae450437c8834d04@AMSPEX02CL02.citrite.net>
 <CAKf6xpujVs3RPJcb+2vqPZFcYwhdDcjbt=S_+awjPuPFpFHsPw@mail.gmail.com>
 <57dc1083d20a469785f05a2e5250a820@AMSPEX02CL02.citrite.net>
 <cd5f1ecc-576f-b7d0-3090-4f3e4faf6148@citrix.com>
 <CAKf6xpt4XYXn2xHJoVY_ibcaHSw-ED10V7ZGNKuDdkiJ93RS0A@mail.gmail.com>
 <20190322030936.fkiajz5ifgaejkd4@MacBook-Air-de-Roger.local>
 <CAKf6xptP_b-+FuscjsTK9G7pMeVS8drvA_t+xb5bdF2zxxmWfA@mail.gmail.com>
 <CAKf6xpscx9Yukphv7mfK2BPM8HoGW0ddt9zbOZxpV+9LzWxz4g@mail.gmail.com>
 <20200114100406.GF11756@Air-de-Roger>
 <CAKf6xpuDo=FGTOJ9ipmk7nY+qs+pKBWESqY0ah6B1vS3kZsT=A@mail.gmail.com>
 <20200114180457.GG11756@Air-de-Roger>
In-Reply-To: <20200114180457.GG11756@Air-de-Roger>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.165]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 72.21.198.25
X-Mailman-Approved-At: Wed, 15 Jan 2020 08:23:46 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
>=20
> > Linux PCI subsytem has an option resource_alignment that can be
> > applied to either a single device or all devices.  Booting with
> > pci=3Dresource_aligment=3D4096 will align each device to a page.  Do yo=
u
> > think pciback should force resource_alignment=3D4096 for dom0?
>

That sounds like a good idea.
=20
> Ideally Xen should keep track of the BARs position and size and refuse
> to passthrough devices that have BARs sharing a page with other
> devices BARs.
>=20
> > Are
> > there other MMIO ranges to be concerned about adjacent to BARs?
>=20
> IIRC you can have two BARs of different devices in the same 4K page,
> BARs are only aligned to it's size, so BARs smaller than 4K are not
> required to be page aligned.

If we had a notion of assignment groups for this, as well as devices sharin=
g requester id, then Xen would not need to refuse pass-through, it would ju=
st require that all devices sharing the page were passed through as a unit.

  Paul

