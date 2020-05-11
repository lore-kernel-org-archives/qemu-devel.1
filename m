Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA28C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D4B207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="Naxw6iWA";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="cXd8nTZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D4B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY27q-0004pC-I3
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4400c99de5=bbhushan2@marvell.com>)
 id 1jY24z-0001hC-FC; Mon, 11 May 2020 02:38:21 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36452
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4400c99de5=bbhushan2@marvell.com>)
 id 1jY24t-0007Ca-G8; Mon, 11 May 2020 02:38:16 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04B6Z10T029768; Sun, 10 May 2020 23:38:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=yw80EQ1QIDfh4OV3EYh0xrIXzFiIFDmvJhWkAO86+C8=;
 b=Naxw6iWAO/g8FND/8sp8aG6bxXHtezy+Qi67a33VHHbeD82/7Uz4oO0al12Vpl2pH5y/
 SxZOY/FwsNZxrHuFJ8tcBhpMagDL0BAyWJ5Xn65AN9r3S31+QbAjhUAMz4j7lYznidd3
 HhIHArRv5SzRhNXu/i4YklzVPjByT9gGNerHbpDju0r4BJuSvZyC6VvTUQ7XA1AD6VFk
 eDNFeRZxwv9cxdmNeqoG508SqSEMG5Du2DAQtjlFdG3JVi6OVRtL3doq7ubSlO5FvCLB
 7YntVjumpHNXnVwD004fWYrklu8hEZfaMDS+QilJUZ3DCimgAld9QrHImwKK1ncsCGPN hQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 30wsvqdrw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 10 May 2020 23:38:10 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 10 May 2020 23:38:08 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 10 May 2020 23:38:08 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 10 May 2020 23:38:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuq92uKz7zegbfdV9nUWzKjzC+FR/VEKHiAn+4rr5F2Y7NoGKp7BErJyqKZ0683Btsw5nUwz23IkyPDdMgHV8bUriTUTR9veKBJC23Mw9/iGGspeSmKqJ26PWirKn4xze39aWksYPPorOkdDqT4tpzIr0PRjjpnhgfK+eGSSeCPqyseLISG8361RX1LyW9EI6OVC5foAirzNl/e2dzEaKg5bsY6MFp60vIWo5hVHLbjIIMYNmiQgFmIytHevX2ZTKKbhyWQek+sIRb7RUJFuHYTJHEYL2GULNhTfGiUumSaggwS5O80BAYbZCdSC2ZrpyuWgM7pTb+X0pfGIAx9w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw80EQ1QIDfh4OV3EYh0xrIXzFiIFDmvJhWkAO86+C8=;
 b=B0n5KHEpNKMKJl4ueC17LdUeq3b4zjWrenz8QmQm+6Qery9+2A+ytIDQUVNdlYKFO3KGOvsDKqVZi1dwhBscZTg2xNXtgRcpNr0g+EYDyhtj+PE5Jc6gRFL/EnFlaoytY9a5PJNQTapLxFKuzXMR0j0e9+Q3GnrA4p5do30Y7gFrIqHa4IFMQle+soP8UlpVkCAgs5s7B3YIApaDx4kBBp/wbKYOEryL4bgJaLmM4x9FVtcjZNHW9PTV7wwzY7Y3nCeCFS3s9wwUKd/AR3s5ZT6rsHQDlaep8q4JxDErMWYq2uVcq5Yr0ZJeG1jAaYgafcbLeFmmtPSBS/m/1b6qPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw80EQ1QIDfh4OV3EYh0xrIXzFiIFDmvJhWkAO86+C8=;
 b=cXd8nTZFDq/FLCXMlsEUxPJE1x4IUuujOFzOoNSvSRf600u6ZiS7u7W+pIXV2gZ4kLcQZF6fmY3H6m2yNyT9Ync8FDAAXrTh2RsetBMs5kyZCnipkfdXDL+4HQhsD9SMDwkyo6i9q9zK09UbKRWsLXHVYr8cVtMc0XNcwmGRvUA=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB1903.namprd18.prod.outlook.com
 (2603:10b6:301:6c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 06:38:06 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 06:38:05 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [EXT] [PATCH v2 2/5] virtio-iommu: Implement RESV_MEM probe
 request
Thread-Topic: [EXT] [PATCH v2 2/5] virtio-iommu: Implement RESV_MEM probe
 request
Thread-Index: AQHWJV6G7q81t6809kGgvGezOKtQUqiicegg
Date: Mon, 11 May 2020 06:38:05 +0000
Message-ID: <MWHPR1801MB19669FBFAD49AD36460B0756E3A10@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200508173057.32215-1-eric.auger@redhat.com>
 <20200508173057.32215-3-eric.auger@redhat.com>
In-Reply-To: <20200508173057.32215-3-eric.auger@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.171.209.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8dd0743-2aac-4c2f-7dfa-08d7f575dcb4
x-ms-traffictypediagnostic: MWHPR1801MB1903:
x-microsoft-antispam-prvs: <MWHPR1801MB1903AAC17936E2BD6F9CDD2CE3A10@MWHPR1801MB1903.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4GiOKXMswdta8Qus+lw3xuTZTa+j0l8+tmDTJJVETLOa19KkppNGvExAag14VGy3SiGEsC0lPyzraND3J5WWvHm0PEYE+UZXpnAkD5gKjgJltWHBr7JN5CQAozzJ3AShd/Wpr00Q0mtkSdSghXqatWPuMs98mfvzLhX51LAlvk3sdo988h58bRXsXzXCy8um1xIQIDOm4FMhEgheUjuXHzUdTijcESwTbaXVxbHHaeSQOVWY0MUQjlT4erUJaEBXHtWvvyXwzv4EhedfAvM5EkL+m6yb2hv9lp/Kdxai1GEtf5NInP3EZEDdmQN9FR+5qnybIofQkcMsYTtOQL56vKBS1j05Qu5+8Gp5MI7Xqf6E8fzqYN4UxagGKtglGNM67maKpmKj/oicgd3+ouKB42vW7EqHRZ6m1YZKsnA+UKOsJUm6Ncadfsao8o2NDrATMVt35Yj8pWsTz11h4vKSpOApXYURsxk5Gh98zbD4KhMKU7Maj6XsExtpBWx9dmYq9XbB2wNoVWFEjdOdZYhxcuTEzUHUcKRtHlcYcuFqfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1801MB1966.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(33430700001)(53546011)(5660300002)(6506007)(7416002)(8936002)(26005)(186003)(8676002)(71200400001)(2906002)(55016002)(9686003)(66556008)(110136005)(316002)(76116006)(33440700001)(33656002)(66446008)(64756008)(7696005)(52536014)(86362001)(66946007)(66476007)(478600001)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lE3CjnaXULwbwsXx/4tistS3e7gyuYv/C1Qgg7RsrxxudNp723Xjrid1VY0U72aYfUIF/pWdTCIUsG8Nd6Qgop47kQeuMieciYRQWm8wMpNH2KL+VfjF3ZS0oS88eMC3HTk09EVKfC8MUj8xB4car96aNZudSUhn00hUP4R/b4OAoJVV+Jgy54P94uFSx8VoK5jMl7jkX51va/BTcnY+p2ARLAcz70aGgokmupdHCaWmmKMsIeJjSpNuSjprYsf1lS8VQGb8lguS95cffCQqOVXnt384nQnSBEZ5s83olRS147HW5GtIotXijzuGesenT59zFGwXSsRMeceJye9n//AQ/INEKoutg8PCbxfmtFQkbqpB3Lk8M2q+xheLrOBkiUsvlgl7KWfzvIho3xkD/vzYUnuN9ItiaXz/zyabY7W7vSlgJzWCBx4GiFgwmE1jgT7KwwntOIGP0ncZOk7hllWBP98cB5vcJRkubDGMhwCQTBO+wuAY8IEtEYsj7Mmf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dd0743-2aac-4c2f-7dfa-08d7f575dcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 06:38:05.7570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6l3mnFifFGKuYY8DhNU49Yt1Ee6Af0W5yzRhvvm5Ar+KrxE52mP5Sddb1FR6TRbX4v6G2cj2pQU5Sh+/mZKdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1903
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-11_01:2020-05-08,
 2020-05-11 signatures=0
Received-SPF: pass client-ip=67.231.148.174;
 envelope-from=prvs=4400c99de5=bbhushan2@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:38:12
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: Friday, May 8, 2020 11:01 PM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-devel@nongnu.or=
g;
> qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com; jean-
> philippe@linaro.org; Bharat Bhushan <bbhushan2@marvell.com>;
> peterx@redhat.com; armbru@redhat.com; pbonzini@redhat.com
> Subject: [EXT] [PATCH v2 2/5] virtio-iommu: Implement RESV_MEM probe requ=
est
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> This patch implements the PROBE request. At the moment, only THE RESV_MEM
> property is handled. The first goal is to report iommu wide reserved regi=
ons such as
> the MSI regions set by the machine code. On x86 this will be the IOAPIC M=
SI region,
> [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS doorbell.
>=20
> In the future we may introduce per device reserved regions.
> This will be useful when protecting host assigned devices which may expos=
e their
> own reserved regions
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v1 -> v2:
> - move the unlock back to the same place
> - remove the push label and factorize the code after the out label
> - fix a bunch of cpu_to_leX according to the latest spec revision
> - do not remove sizeof(last) from free space
> - check the ep exists
> ---
>  include/hw/virtio/virtio-iommu.h |  2 +
>  hw/virtio/virtio-iommu.c         | 94 ++++++++++++++++++++++++++++++--
>  hw/virtio/trace-events           |  1 +
>  3 files changed, 93 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-=
iommu.h
> index e653004d7c..49eb105cd8 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -53,6 +53,8 @@ typedef struct VirtIOIOMMU {
>      GHashTable *as_by_busptr;
>      IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>      PCIBus *primary_bus;
> +    ReservedRegion *reserved_regions;
> +    uint32_t nb_reserved_regions;
>      GTree *domains;
>      QemuMutex mutex;
>      GTree *endpoints;
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
> 22ba8848c2..35d772e021 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -38,6 +38,7 @@
>=20
>  /* Max size */
>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
> +#define VIOMMU_PROBE_SIZE 512
>=20
>  typedef struct VirtIOIOMMUDomain {
>      uint32_t id;
> @@ -378,6 +379,65 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>      return ret;
>  }
>=20
> +static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t =
ep,
> +                                               uint8_t *buf, size_t
> +free) {
> +    struct virtio_iommu_probe_resv_mem prop =3D {};
> +    size_t size =3D sizeof(prop), length =3D size - sizeof(prop.head), t=
otal;
> +    int i;
> +
> +    total =3D size * s->nb_reserved_regions;
> +
> +    if (total > free) {
> +        return -ENOSPC;
> +    }
> +
> +    for (i =3D 0; i < s->nb_reserved_regions; i++) {
> +        prop.head.type =3D cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
> +        prop.head.length =3D cpu_to_le16(length);
> +        prop.subtype =3D s->reserved_regions[i].type;
> +        prop.start =3D cpu_to_le64(s->reserved_regions[i].low);
> +        prop.end =3D cpu_to_le64(s->reserved_regions[i].high);
> +
> +        memcpy(buf, &prop, size);
> +
> +        trace_virtio_iommu_fill_resv_property(ep, prop.subtype,
> +                                              prop.start, prop.end);
> +        buf +=3D size;
> +    }
> +    return total;
> +}
> +
> +/**
> + * virtio_iommu_probe - Fill the probe request buffer with
> + * the properties the device is able to return and add a NONE
> + * property at the end.
> + */
> +static int virtio_iommu_probe(VirtIOIOMMU *s,
> +                              struct virtio_iommu_req_probe *req,
> +                              uint8_t *buf) {
> +    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
> +    size_t free =3D VIOMMU_PROBE_SIZE;
> +    ssize_t count;
> +
> +    if (!virtio_iommu_mr(s, ep_id)) {
> +        return VIRTIO_IOMMU_S_NOENT;
> +    }
> +
> +    count =3D virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
> +    if (count < 0) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +    buf +=3D count;
> +    free -=3D count;
> +
> +    /* Fill the rest with zeroes */
> +    memset(buf, 0, free);

No need to fill with zero here as "buf" is set to zero on allocation, no?

Thanks
-Bharat

> +
> +    return VIRTIO_IOMMU_S_OK;
> +}
> +
>  static int virtio_iommu_iov_to_req(struct iovec *iov,
>                                     unsigned int iov_cnt,
>                                     void *req, size_t req_sz) @@ -407,15 =
+467,27 @@
> virtio_iommu_handle_req(detach)
>  virtio_iommu_handle_req(map)
>  virtio_iommu_handle_req(unmap)
>=20
> +static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
> +                                     struct iovec *iov,
> +                                     unsigned int iov_cnt,
> +                                     uint8_t *buf) {
> +    struct virtio_iommu_req_probe req;
> +    int ret =3D virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req))=
;
> +
> +    return ret ? ret : virtio_iommu_probe(s, &req, buf); }
> +
>  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *v=
q)  {
>      VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
>      struct virtio_iommu_req_head head;
>      struct virtio_iommu_req_tail tail =3D {};
> +    size_t output_size =3D sizeof(tail), sz;
>      VirtQueueElement *elem;
>      unsigned int iov_cnt;
>      struct iovec *iov;
> -    size_t sz;
> +    void *buf =3D NULL;
>=20
>      for (;;) {
>          elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement)); @@ -452,6 =
+524,17 @@
> static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq=
)
>          case VIRTIO_IOMMU_T_UNMAP:
>              tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt);
>              break;
> +        case VIRTIO_IOMMU_T_PROBE:
> +        {
> +            struct virtio_iommu_req_tail *ptail;
> +
> +            output_size =3D s->config.probe_size + sizeof(tail);
> +            buf =3D g_malloc0(output_size);
> +
> +            ptail =3D (struct virtio_iommu_req_tail *)
> +                        (buf + s->config.probe_size);
> +            ptail->status =3D virtio_iommu_handle_probe(s, iov, iov_cnt,=
 buf);
> +        }
>          default:
>              tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
>          }
> @@ -459,12 +542,13 @@ static void
> virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>=20
>  out:
>          sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
> -                          &tail, sizeof(tail));
> -        assert(sz =3D=3D sizeof(tail));
> +                          buf ? buf : &tail, output_size);
> +        assert(sz =3D=3D output_size);
>=20
> -        virtqueue_push(vq, elem, sizeof(tail));
> +        virtqueue_push(vq, elem, sz);
>          virtio_notify(vdev, vq);
>          g_free(elem);
> +        g_free(buf);
>      }
>  }
>=20
> @@ -667,6 +751,7 @@ static void virtio_iommu_device_realize(DeviceState *=
dev,
> Error **errp)
>      s->config.page_size_mask =3D TARGET_PAGE_MASK;
>      s->config.input_range.end =3D -1UL;
>      s->config.domain_range.end =3D 32;
> +    s->config.probe_size =3D VIOMMU_PROBE_SIZE;
>=20
>      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
>      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC); @@ -6=
76,6
> +761,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error
> **errp)
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
>=20
>      qemu_mutex_init(&s->mutex);
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events index
> e83500bee9..5550475691 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -73,3 +73,4 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc
> domain=3D%d"
>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint3=
2_t sid)
> "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
>  virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpo=
int,
> uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D0x%=
"PRIx64
> +virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype,
> +uint64_t start, uint64_t end) "dev=3D %d, type=3D%d start=3D0x%"PRIx64"
> +end=3D0x%"PRIx64
> --
> 2.20.1


