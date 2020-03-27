Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C809C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047D220714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bGV2we7r";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="CutrgFSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047D220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHhl3-0007mB-8M
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 01:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhjr-0006ph-5n
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhjp-0005Dw-0W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:41:03 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:16654
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhjk-0004ls-6B; Fri, 27 Mar 2020 01:40:56 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02R5Z17m027549; Thu, 26 Mar 2020 22:40:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=a8nlN1nQ+ObstmRUAnHVYcnyoqpsuFNFr5IqbgNebUM=;
 b=bGV2we7rw7P+eiUZsLBNeys5iQzEtXSK55F6er0z7/J624Tc3PFFhFCL4UIIBGKW2RkL
 4cmkIKUq4bre/Eqlj/fqBTOry0sWkRvgYrStmJvH2DPJOp4teQU/d3wSRvmyt3qDOH1V
 Fo1bMxpx3AhOwWFR8H3TxMLTRYNYvsxiHDQZkMMjGQh1ZYU1e962bkv/RMVLzju1mVbi
 e9aQdVmnLZ1kF2I7R7lOYAM4AtM/pdHsTmjSLd6KoO00g6al4Fj/S45uNvcTaN/8Gr2b
 8QoXDqDwpw440oaMlM7OoDNjcCQJ8Q5FodjDXvX3rnTM9+FbMgKvsdRreeEQzh6ACla0 sQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0a-0016f401.pphosted.com with ESMTP id 2ywg9p1cej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2020 22:40:52 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 26 Mar
 2020 22:40:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 26 Mar 2020 22:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5PN9Dizuf7mwbekDrwuRz/zfi6QOkuT6yhv+rBqNgUFD4ypLeMPegADXUIMwW8UqtZ7A1kXC6jLZySweSRQJLMa8vBOFcryDLALdOaltrXzzlefVjKOVnNI0E/jSiNv9U3AvxTDTc6QXErwniAmgFIyAnPZ9mMt9mR0K8+5WCi/gqiZmzQu+JpP40F9x7n+Cv95mkfcGtKVLPzsRgIzYeJ8Jyzk3Pbk6AdMPv9fGDCjXkiwLTHVj/YG8a7c6Z+1j6xeUAHXtf6wbjb+lKA+d5x7tmz3/4JsmJ1BVcVb6zIxkojMj+6uyEY/WyYBTcnhOMxqaCePaIdclFaxqVVvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8nlN1nQ+ObstmRUAnHVYcnyoqpsuFNFr5IqbgNebUM=;
 b=DepNjI/uXWRRfEk1PKX5zbBISLXHaC9SCAvg3xltqy+sd4BRPP0bAWg95sV3QOTLePoTA6sQlfkn5dgVHEf06pB98hzDk4y7Us2wuQ5jUEZO0cWRkgtMruHrWuvlh2N5CFskfwF1s4RXaWPSO7lQMrN9AwK9cm82lQwN8dBukDWSqUgiIOxpmlsuUgdrQMShhCjnpNPVDp0uQ4cCLrf2IMJRvahOtyGLLroalCVr1nNnS7M6JtFlS9HKS1bI3x/B03C3p0jrzThl2VJI9LBDij1xWjXNdJreebRohZa2pIErvJqM54oJOsrFp7r0JWhh1o2B6GchFfa6PTJqDtMj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8nlN1nQ+ObstmRUAnHVYcnyoqpsuFNFr5IqbgNebUM=;
 b=CutrgFShvNSKYVG9kXLG5J8kQLEdGCBr7hta7cm+FGw/kdKSeFl51WDUjVB95jcFC4aO4rTdCOViebYZB/ztwJYw7vEmzgaIYDmUPC0lV+8djCOO/cBHhk8d8WJftkxq1OE115cMeXsD4mcUvLNSrpD7oLJ03uKytu0iIncGhSU=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com (10.164.203.148) by
 MWHPR1801MB1839.namprd18.prod.outlook.com (10.164.192.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Fri, 27 Mar 2020 05:40:49 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 05:40:49 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Auger Eric <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com"
 <mst@redhat.com>, "Tomasz Nowicki [C]" <tnowicki@marvell.com>,
 "drjones@redhat.com" <drjones@redhat.com>, "linuc.decode@gmail.com"
 <linuc.decode@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "bharatb.linux@gmail.com"
 <bharatb.linux@gmail.com>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "yang.zhong@intel.com" <yang.zhong@intel.com>
Subject: RE: [EXT] Re: [PATCH v9 8/9] virtio-iommu: Implement probe request
Thread-Topic: [EXT] Re: [PATCH v9 8/9] virtio-iommu: Implement probe request
Thread-Index: AQHWAO+rl5lexFqj/kup6Aju78A4EKhbCf6AgADnGLA=
Date: Fri, 27 Mar 2020 05:40:49 +0000
Message-ID: <MWHPR1801MB196670FB91F76E7775BF597CE3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-9-bbhushan2@marvell.com>
 <401ead7e-884e-e4a8-9e5a-ceaa3c868f61@redhat.com>
In-Reply-To: <401ead7e-884e-e4a8-9e5a-ceaa3c868f61@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.182.231.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a847853-89a1-4ba3-8181-08d7d2116819
x-ms-traffictypediagnostic: MWHPR1801MB1839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1801MB1839E3897302C686E4B18B74E3CC0@MWHPR1801MB1839.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(186003)(81166006)(2906002)(81156014)(71200400001)(30864003)(8676002)(8936002)(316002)(110136005)(66556008)(53546011)(33656002)(66476007)(64756008)(66946007)(86362001)(66446008)(7416002)(6506007)(52536014)(26005)(76116006)(478600001)(5660300002)(55016002)(9686003)(7696005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1801MB1839;
 H:MWHPR1801MB1966.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4ZJPkbvL0flm9b3udC3MS5XGLn72KNepai8W2NYPOumXbEUGGJhI67Yd8m6pUg8sy7PKiKai2c8J3G6xcDhMsxDMtl9zLnqdnVk7joSlvXqX1k2DRSrX6HupjPldKC/f1lXoBjyuHhNbIpCDWHK8qn/xw24nSIy72/q4u/+ha1dz+rHpu8fnXogr86v1k5oNQW3hFaXkW9E9pgqMF4VbpSOByjNooDD2n23oxGA+THnpMbh014/H30HOMv22OvSWfSZAhNRRuug3xy/CVd04Va4X4fnazhbSlRNRzfDVp8Nm0D6melKOfqd1AXtZZ/UyA/gFWJpzlCXQ5X92ZcCrHDMPWxFZKhS/U7WcusYeoAZxGFZiFNyr/SOhOyoFucEBK9CivpAU2CCGJiRkGSB18Y9xgVFOVnsUjrwqlL2mtlAF1nQ06K2pDnSKqZwOTsEGWLFI7OC5zVtuBfVdTL8KfoJd9EIzB4+9CIcVG0fOtdYl3cQHQeBnEYI+NpLR0nz
x-ms-exchange-antispam-messagedata: dtO8MqkrxF2aDWKP2Uir2iqijdona+Fzz4GFJag+QUL24y09doq2vJUwfNj5YP4p9G1/QP0dZ5VYNM3ERjuRvso18sgTEDIgUjxe7nlA7X6lsc91S2Ub09rRCNlhJhvvcHNWL0KZMEbmhqOcDITKlA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a847853-89a1-4ba3-8181-08d7d2116819
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 05:40:49.7564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOEAslyQm01d1qFUFNr1uJR1YyS0Q4CW19ggm9uv0srdJFmF7Zczhz0HzO7GQku+IEcVsHg/hWDmo6hbF/EKAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1839
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-26_14:2020-03-26,
 2020-03-26 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.148.174
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
> From: Auger Eric <eric.auger@redhat.com>
> Sent: Thursday, March 26, 2020 9:18 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
> peterx@redhat.com; eric.auger.pro@gmail.com; alex.williamson@redhat.com;
> kevin.tian@intel.com; mst@redhat.com; Tomasz Nowicki [C]
> <tnowicki@marvell.com>; drjones@redhat.com; linuc.decode@gmail.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; bharatb.linux@gmail.com; jean-
> philippe@linaro.org; yang.zhong@intel.com
> Subject: [EXT] Re: [PATCH v9 8/9] virtio-iommu: Implement probe request
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hi Bharat
>=20
> On 3/23/20 9:46 AM, Bharat Bhushan wrote:
> > This patch implements the PROBE request. Currently supported page size
> > mask per endpoint is returned. Also append a NONE property in the end.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  include/standard-headers/linux/virtio_iommu.h |   6 +
> Changes to virtio_iommu.h should be in a separate patch you should use
> ./scripts/update-linux-headers.sh See for instance:
> ddda37483d  linux-headers: update
> until the uapi updates are not upstream you can link to your kernel branc=
h and
> mention this is a temporary linux header update or partial if you just wa=
nt to pick
> up the iommu.h changes.

yes, I am sorry.

>=20
> >  hw/virtio/virtio-iommu.c                      | 161 +++++++++++++++++-
> >  hw/virtio/trace-events                        |   2 +
> >  3 files changed, 166 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/standard-headers/linux/virtio_iommu.h
> > b/include/standard-headers/linux/virtio_iommu.h
> > index b9443b83a1..8a0d47b907 100644
> > --- a/include/standard-headers/linux/virtio_iommu.h
> > +++ b/include/standard-headers/linux/virtio_iommu.h
> > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> >
> >  #define VIRTIO_IOMMU_PROBE_T_NONE		0
> >  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> >
> >  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> >
> > @@ -130,6 +131,11 @@ struct virtio_iommu_probe_resv_mem {
> >  	uint64_t					end;
> >  };
> >
> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property      head;
> > +	uint64_t				pgsize_bitmap;
> > +};
> > +
> >  struct virtio_iommu_req_probe {
> >  	struct virtio_iommu_req_head		head;
> >  	uint32_t					endpoint;
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
> > 747e3cf1da..63fbacdcdc 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -38,6 +38,10 @@
> >
> >  /* Max size */
> >  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
> > +#define VIOMMU_PROBE_SIZE 512
> > +
> > +#define SUPPORTED_PROBE_PROPERTIES (\
> > +    1 << VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK)
> >
> >  typedef struct VirtIOIOMMUDomain {
> >      uint32_t id;
> > @@ -62,6 +66,13 @@ typedef struct VirtIOIOMMUMapping {
> >      uint32_t flags;
> >  } VirtIOIOMMUMapping;
> >
> > +typedef struct VirtIOIOMMUPropBuffer {
> > +    VirtIOIOMMUEndpoint *endpoint;
> > +    size_t filled;
> > +    uint8_t *start;
> > +    bool error;
> > +} VirtIOIOMMUPropBuffer;
> > +
> >  static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)  {
> >      return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn); @@
> > -490,6 +501,114 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
> >      return ret;
> >  }
> >
> > +static int virtio_iommu_fill_none_prop(VirtIOIOMMUPropBuffer
> > +*bufstate) {
> > +    struct virtio_iommu_probe_property *prop;
> > +
> > +    prop =3D (struct virtio_iommu_probe_property *)
> > +                (bufstate->start + bufstate->filled);
> > +    prop->type =3D 0;
> > +    prop->length =3D 0;
> > +    bufstate->filled +=3D sizeof(*prop);
> > +    trace_virtio_iommu_fill_none_property(bufstate->endpoint->id);
> > +    return 0;
> > +}
> > +
> > +static int virtio_iommu_fill_page_size_mask(VirtIOIOMMUPropBuffer
> > +*bufstate) {
> > +    struct virtio_iommu_probe_pgsize_mask *page_size_mask;
> > +    size_t prop_size =3D sizeof(*page_size_mask);
> > +    VirtIOIOMMUEndpoint *ep =3D bufstate->endpoint;
> > +    VirtIOIOMMU *s =3D ep->viommu;
> > +    IOMMUDevice *sdev;
> > +
> > +    if (bufstate->filled + prop_size >=3D VIOMMU_PROBE_SIZE) {
> > +        bufstate->error =3D true;
> > +        /* get the traversal stopped by returning true */
> > +        return true;
> > +    }
> > +
> > +    page_size_mask =3D (struct virtio_iommu_probe_pgsize_mask *)
> > +                     (bufstate->start + bufstate->filled);
> > +
> > +    page_size_mask->head.type =3D VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK;
> > +    page_size_mask->head.length =3D prop_size;
> > +    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
> > +        if (ep->id =3D=3D sdev->devfn) {
> > +            page_size_mask->pgsize_bitmap =3D sdev->page_size_mask;
> > +	}
> > +    }
> > +    bufstate->filled +=3D sizeof(*page_size_mask);
> > +    trace_virtio_iommu_fill_pgsize_mask_property(bufstate->endpoint->i=
d,
> > +                                                 page_size_mask->pgsiz=
e_bitmap,
> > +                                                 bufstate->filled);
> > +    return false;
> > +}
> > +
> > +/* Fill the properties[] buffer with properties of type @type */
> > +static int virtio_iommu_fill_property(int type,
> > +                                      VirtIOIOMMUPropBuffer
> > +*bufstate) {
> > +    int ret =3D -ENOSPC;
> > +
> > +    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
> > +            >=3D VIOMMU_PROBE_SIZE) {
> > +        /* no space left for the header */
> > +        bufstate->error =3D true;
> > +        goto out;
> > +    }
> > +
> > +    switch (type) {
> > +    case VIRTIO_IOMMU_PROBE_T_NONE:
> > +        ret =3D virtio_iommu_fill_none_prop(bufstate);
> > +        break;
> > +    case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +    {
> > +        ret =3D virtio_iommu_fill_page_size_mask(bufstate);
> I don't think you want to fill the property of each EP. Only for those wh=
ose sdev-
> >page_size_mask was properly set. For instance if you mix virtio and vfio=
 devices,
> virtio ones won't have this field set.

This something I am looking for clarification ( asked in spec document patc=
h). Copy pasting same here:

What some clarification about two page-size-mask configurations available.
 - Global configuration for page-size-mask
 - per endpoint page-size-mask configuration

PAGE_SIZE_MASK probe for and endpoint can return zero or non-zero value.
If it returns non-zero value than it will override the global configuration=
.
If PAGE_SIZE_MASK probe for and endpoint return zero value than global page=
-size-mask configuration will be used.

Is that correct?

Thanks
-Bharat

> > +	break;
> > +    }
> > +    default:
> > +        ret =3D -ENOENT;
> > +        break;
> > +    }
> > +out:
> > +    if (ret) {
> > +        error_report("%s property of type=3D%d could not be filled (%d=
),"
> > +                     " remaining size =3D 0x%lx",
> > +                     __func__, type, ret, bufstate->filled);
> > +    }
> > +    return ret;
> > +}
> > +
> > +/**
> > + * virtio_iommu_probe - Fill the probe request buffer with all
> > + * the properties the device is able to return and add a NONE
> > + * property at the end. @buf points to properties[].
> > + */
> > +static int virtio_iommu_probe(VirtIOIOMMU *s,
> > +                              struct virtio_iommu_req_probe *req,
> > +                              uint8_t *buf) {
> > +    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
> > +    VirtIOIOMMUEndpoint *ep =3D virtio_iommu_get_endpoint(s, ep_id);
> > +    int16_t prop_types =3D SUPPORTED_PROBE_PROPERTIES, type;
> > +    VirtIOIOMMUPropBuffer bufstate =3D {.start =3D buf, .filled =3D 0,
> > +                                       .error =3D false, .endpoint =3D
> > +ep};
> > +
> > +    while ((type =3D ctz32(prop_types)) !=3D 32) {
> > +        if (virtio_iommu_fill_property(type, &bufstate)) {
> > +            goto failure;
> > +        }
> > +        prop_types &=3D ~(1 << type);
> > +    }
> > +    if (virtio_iommu_fill_property(VIRTIO_IOMMU_PROBE_T_NONE, &bufstat=
e))
> {
> > +        goto failure;
> > +    }
> > +    return VIRTIO_IOMMU_S_OK;
> > +failure:
> > +    return VIRTIO_IOMMU_S_INVAL;
> > +}
> > +
> >  static int virtio_iommu_iov_to_req(struct iovec *iov,
> >                                     unsigned int iov_cnt,
> >                                     void *req, size_t req_sz) @@
> > -519,6 +638,17 @@ virtio_iommu_handle_req(detach)
> >  virtio_iommu_handle_req(map)
> >  virtio_iommu_handle_req(unmap)
> >
> > +static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
> > +                                     struct iovec *iov,
> > +                                     unsigned int iov_cnt,
> > +                                     uint8_t *buf) {
> > +    struct virtio_iommu_req_probe req;
> > +    int ret =3D virtio_iommu_iov_to_req(iov, iov_cnt, &req,
> > +sizeof(req));
> > +
> > +    return ret ? ret : virtio_iommu_probe(s, &req, buf); }
> > +
> >  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue
> > *vq)  {
> >      VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev); @@ -564,17 +694,33 @@ stati=
c
> > void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
> >          case VIRTIO_IOMMU_T_UNMAP:
> >              tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt)=
;
> >              break;
> > +        case VIRTIO_IOMMU_T_PROBE:
> > +        {
> > +            struct virtio_iommu_req_tail *ptail;
> > +            uint8_t *buf =3D g_malloc0(s->config.probe_size +
> > + sizeof(tail));
> > +
> > +            ptail =3D (struct virtio_iommu_req_tail *)
> > +                        (buf + s->config.probe_size);
> > +            ptail->status =3D virtio_iommu_handle_probe(s, iov,
> > + iov_cnt, buf);
> > +
> > +            sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
> > +                              buf, s->config.probe_size + sizeof(tail)=
);
> > +            g_free(buf);
> > +            assert(sz =3D=3D s->config.probe_size + sizeof(tail));
> > +            goto push;
> > +        }
> >          default:
> >              tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
> >          }
> > -        qemu_mutex_unlock(&s->mutex);
> >
> >  out:
> >          sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
> >                            &tail, sizeof(tail));
> >          assert(sz =3D=3D sizeof(tail));
> >
> > -        virtqueue_push(vq, elem, sizeof(tail));
> > +push:
> > +        qemu_mutex_unlock(&s->mutex);
> > +        virtqueue_push(vq, elem, sz);
> >          virtio_notify(vdev, vq);
> >          g_free(elem);
> >      }
> > @@ -634,16 +780,23 @@ static IOMMUTLBEntry
> virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >      VirtIOIOMMUEndpoint *ep;
> >      uint32_t sid, flags;
> >      bool bypass_allowed;
> > +    hwaddr addr_mask;
> >      bool found;
> >
> >      interval.low =3D addr;
> >      interval.high =3D addr + 1;
> >
> > +    if (sdev->page_size_mask) {
> > +        addr_mask =3D (1 << ctz32(sdev->page_size_mask)) - 1;
> > +    } else {
> > +        addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1;
> > +    }
> This change does not belong ot this patch. Rather belongs to
> "virtio-iommu: set supported page size mask"

Thanks for pointing, will change.

Thanks
-Bharat

> > +
> >      IOMMUTLBEntry entry =3D {
> >          .target_as =3D &address_space_memory,
> >          .iova =3D addr,
> >          .translated_addr =3D addr,
> > -        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
> > +        .addr_mask =3D addr_mask,
> >          .perm =3D IOMMU_NONE,
> >      };
> >
> > @@ -831,6 +984,7 @@ static void virtio_iommu_device_realize(DeviceState
> *dev, Error **errp)
> >      s->config.page_size_mask =3D TARGET_PAGE_MASK;
> >      s->config.input_range.end =3D -1UL;
> >      s->config.domain_range.end =3D 32;
> > +    s->config.probe_size =3D VIOMMU_PROBE_SIZE;
> >
> >      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
> >      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC); @@
> > -840,6 +994,7 @@ static void virtio_iommu_device_realize(DeviceState *d=
ev,
> Error **errp)
> >      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
> >      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
> >      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
> > +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
> >
> >      qemu_mutex_init(&s->mutex);
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events index
> > 8bae651191..b0a6e4bda3 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -76,3 +76,5 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t
> > flags, uint32_t endpoint, uin  virtio_iommu_notify_map(const char
> > *name, uint64_t iova, uint64_t paddr, uint64_t map_size) "mr=3D%s
> > iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64
> virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_s=
ize)
> "mr=3D%s iova=3D0x%"PRIx64" size=3D0x%"PRIx64  virtio_iommu_remap(uint64_=
t iova,
> uint64_t pa, uint64_t size) "iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D=
0x%"PRIx64""
> > +virtio_iommu_fill_none_property(uint32_t devid) "devid=3D%d"
> > +virtio_iommu_fill_pgsize_mask_property(uint32_t devid, uint64_t pgsize=
_mask,
> size_t filled) "dev=3D %d, pgsize_mask=3D0x%"PRIx64" filled=3D0x%lx"
> >
> Thanks
>=20
> Eric


