Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE926C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978C0206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TWVJhJw/";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="OjqK81US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978C0206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvkB-0002Gp-Jo
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=336187d25f=bbhushan2@marvell.com>)
 id 1jJvjH-0001kW-0G
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=336187d25f=bbhushan2@marvell.com>)
 id 1jJvjE-000894-CF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:01:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:31588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=336187d25f=bbhushan2@marvell.com>)
 id 1jJvjD-00088B-HC; Thu, 02 Apr 2020 05:01:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 032916f7021528; Thu, 2 Apr 2020 02:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NkUACl3n2On6yFv3onEkF8DwkWU05vpPa8YQ8Lw2z9Y=;
 b=TWVJhJw/TKumKTma4GI1HDcpmR/7tld9C9cD1Dtdf3pCZHX9KCSMfRmsAv6KNqaIy0yj
 6yG/PeElqUJFjuYzecJEB3tR0P1HBBseJQ1mJmdQv6ioEOvjJ0fJPnljBg2z8u51o9EM
 8T9igaZmbKzp5r2NaFC4PByGMWIzlwrzDIGkpZawn781TZ8dplrcoNHRpZW+Tkfmbfag
 cGVNdK4BiWvqakXGmtkIST52Zu1RmOmq0wU7mP3/nKMy9SYl6hthS9yHYtrKhmZ9/hQI
 KFBCQUcM9h/YkRR/yipdDZUwpkGP/i8X3VN7Sytuh8INH4X7tNONOnY1ZRENCt0vEci4 NQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0b-0016f401.pphosted.com with ESMTP id 3046h61jf7-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 02:01:25 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 02:01:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 2 Apr 2020 02:01:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmDX1mxxr+99mtWk5Jg1xikapDC44k8zKeSkdwSUPr6qIdGEd+Y10heq9aer+HWSl1LF0r4YfrfkJKleHlrZmHRTAQg3LoPVVfRVf7VYy6SwuqRBB1/5e6VVWbkxrEqwD32eE1n58gn6It8ZJmB8cSwL+LhSR9ig42sbt9CNLca7OLcw3MqINgUBK9/RGvBrHJCcGrb2XnC6jt1e966M5yU1gjZRfTehasIUOhYnyncmrAfQEDjaqeRUAuHvtm/jNjWDqDTHvWsN8jIGIBSDqNFsA12k53X9N6tM/nFNx3fuke4zsUJrYNM1NFmKqKzXzqKdjioQWH1JwmhflhUGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkUACl3n2On6yFv3onEkF8DwkWU05vpPa8YQ8Lw2z9Y=;
 b=VV0cOJePS+/IfncVtF99LY8EDcVXd1PicDADfVdBgyNBpofzO7xO6GIKAWt0IVGytVoe0LFtegV4QQITQDBmDsDNaNe/7XrkrixcDRCla1FvzJsC+JEvXFlHM1+tY9kBpZtxQEUY6Y1ngf9extwAYkW0dNHgT0UA71sDDNmzQlKEYA+FajHVaLPaqZ9zi5fEqjJCc6baJdNd/JXjRknAdk3WXof9EWJCxWDBwUA/iBY/kbSHGZp1Ez8b5oYDGGXXgUCMk6Qyqvd8dt3tWTQ2HgHt0CHw0iowk8LQZU4QaADsRHu4AEPqZoUpTBWro/slWjQ6CAf98GFsQmVJCiVLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkUACl3n2On6yFv3onEkF8DwkWU05vpPa8YQ8Lw2z9Y=;
 b=OjqK81US55nU/WUbkVZKkxtP91Lz366QCYHr4pjjlv69jiF04cXx91v6URqn5q4SPlh20cpdkcDUh4c0hC2GIqBpxNZgY96evtVadhR1aBTnEcsRbAgm4Yra/TpSrrc7TofI45A2bjaHXrvITc7YbN5caGrvRpUabLyEfonVSmU=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB1888.namprd18.prod.outlook.com
 (2603:10b6:301:68::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 2 Apr
 2020 09:01:21 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 09:01:21 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Alex Williamson <alex.williamson@redhat.com>, Auger Eric
 <eric.auger@redhat.com>
Subject: RE: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on
 mmio region translation by viommu
Thread-Topic: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on
 mmio region translation by viommu
Thread-Index: AQHWAO+QkxQYttOMmkGEh3oW5XA+3qhWzhWAgARaBACAAATkAIAKaXPQ
Date: Thu, 2 Apr 2020 09:01:21 +0000
Message-ID: <MWHPR1801MB196612966851882A99A6D3F3E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-2-bbhushan2@marvell.com>
 <20200323170835.5021f845@w520.home>
 <8ec6af3c-6bd7-a3dc-c531-16db6b2089c5@redhat.com>
 <20200326115318.094ab79a@x1.home>
In-Reply-To: <20200326115318.094ab79a@x1.home>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.179.45.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 016e18ba-d24a-4e3f-b0af-08d7d6e469e9
x-ms-traffictypediagnostic: MWHPR1801MB1888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1801MB1888CF4C2093E631E3CDDC38E3C60@MWHPR1801MB1888.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:321;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1801MB1966.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66556008)(33656002)(2906002)(8936002)(66446008)(8676002)(316002)(76116006)(6506007)(53546011)(66476007)(478600001)(64756008)(71200400001)(5660300002)(81166006)(81156014)(86362001)(9686003)(66946007)(186003)(26005)(7696005)(7416002)(55016002)(52536014)(54906003)(110136005)(4326008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zIyUKzEd3yOdlLT4vAikiNBjRmt3P4CBPBe10tmB73iV+whNChMQb8BWTFza8lNDgt1LeZ7ZdE5vFuNtTmIe9Yqix9SpW5B3VQB1wIbbYvtQjKuhOGCRtGjMb/SRsvqSlb51jDMQPmZno0t93SiTUmHVBmo/r5X0dOd61TZMjcYsFriEW1Ypu0PbGEMYNosxmKHkDdKi0W1teWnYtg8ay+Yjc+VdNoz/MOyS7C/CpQYRIZUN4x1ZMbGvHiCEAHhcHzU1RR8PLDSe/iV5Sg61H3uHlTyjD/QEe8z9KqTACemSyMWYl7r44h2WtpVIcBVuLFET0azqolpDD7Dtcqx0i6hXbIkjdw3EsH9K/G9ianDcq7v/5WLw3MhTvqX3hX22njcamP4Vflpewl+TzVEVzikRekUzsPFdppBgYLr2rWmkjOgPG1yWG4/xu8DFPUp
x-ms-exchange-antispam-messagedata: BMXEjc7uFnw16Ck+y3RUrWeanCRLYGOZyvf03WuLV6583xGvg6u153IpeHQO/mtjpXK/psAKigJbPSe8h+ufwYIltCf+f/bToc+fHtcanotj+7NiTzduWjSQyR/jdlggMwU7/IB6OCP9wjV8iCBsyw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 016e18ba-d24a-4e3f-b0af-08d7d6e469e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 09:01:21.1946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUsjhc3QWhDbEtp3OrqJUxryDWD0t5wozfQyd0Y+izfFsSFYTgPcLczqUMePOlgnLrVvoqhQzlEx9osIzkw8pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1888
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-02_01:2020-03-31,
 2020-04-02 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.156.173
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
Cc: "yang.zhong@intel.com" <yang.zhong@intel.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "Tomasz Nowicki \[C\]" <tnowicki@marvell.com>,
 "mst@redhat.com" <mst@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bharatb.linux@gmail.com" <bharatb.linux@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric/Alex,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Thursday, March 26, 2020 11:23 PM
> To: Auger Eric <eric.auger@redhat.com>
> Cc: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
> peterx@redhat.com; eric.auger.pro@gmail.com; kevin.tian@intel.com;
> mst@redhat.com; Tomasz Nowicki [C] <tnowicki@marvell.com>;
> drjones@redhat.com; linuc.decode@gmail.com; qemu-devel@nongnu.org; qemu-
> arm@nongnu.org; bharatb.linux@gmail.com; jean-philippe@linaro.org;
> yang.zhong@intel.com; David Gibson <david@gibson.dropbear.id.au>
> Subject: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on m=
mio
> region translation by viommu
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, 26 Mar 2020 18:35:48 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
>=20
> > Hi Alex,
> >
> > On 3/24/20 12:08 AM, Alex Williamson wrote:
> > > [Cc +dwg who originated this warning]
> > >
> > > On Mon, 23 Mar 2020 14:16:09 +0530
> > > Bharat Bhushan <bbhushan2@marvell.com> wrote:
> > >
> > >> On ARM, the MSI doorbell is translated by the virtual IOMMU.
> > >> As such address_space_translate() returns the MSI controller MMIO
> > >> region and we get an "iommu map to non memory area"
> > >> message. Let's remove this latter.
> > >>
> > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > >> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > >> ---
> > >>  hw/vfio/common.c | 2 --
> > >>  1 file changed, 2 deletions(-)
> > >>
> > >> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
> > >> 5ca11488d6..c586edf47a 100644
> > >> --- a/hw/vfio/common.c
> > >> +++ b/hw/vfio/common.c
> > >> @@ -426,8 +426,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb,
> void **vaddr,
> > >>                                   &xlat, &len, writable,
> > >>                                   MEMTXATTRS_UNSPECIFIED);
> > >>      if (!memory_region_is_ram(mr)) {
> > >> -        error_report("iommu map to non memory area %"HWADDR_PRIx"",
> > >> -                     xlat);
> > >>          return false;
> > >>      }
> > >>
> > >
> > > I'm a bit confused here, I think we need more justification beyond
> > > "we hit this warning and we don't want to because it's ok in this
> > > one special case, therefore remove it".  I assume the special case
> > > is that the device MSI address is managed via the SET_IRQS ioctl and
> > > therefore we won't actually get DMAs to this range.
> > Yes exactly. The guest creates a mapping between one giova and this
> > gpa (corresponding to the MSI controller doorbell) because MSIs are
> > mapped on ARM. But practically the physical device is programmed with
> > an host chosen iova that maps onto the physical MSI controller's
> > doorbell. so the device never performs DMA accesses to this range.
> >
> >   But I imagine the case that
> > > was in mind when adding this warning was general peer-to-peer
> > > between and assigned and emulated device.
> > yes makes sense.
> >
> >   Maybe there's an argument to be made
> > > that such a p2p mapping might also be used in a non-vIOMMU case.  We
> > > skip creating those mappings and drivers continue to work, maybe
> > > because nobody attempts to do p2p DMA with the types of devices we
> > > emulate, maybe because p2p DMA is not absolutely reliable on bare
> > > metal and drivers test it before using it.
> > MSI doorbells are mapped using the IOMMU_MMIO flag (dma-iommu.c
> > iommu_dma_get_msi_page).
> > One idea could be to pass that flag through the IOMMU Notifier
> > mechanism into the iotlb->perm. Eventually when we get this in
> > vfio_get_vaddr() we would not print the warning. Could that make sense?
>=20
> Yeah, if we can identify a valid case that doesn't need a warning, that's=
 fine by me.
> Thanks,

Let me know if I understood the proposal correctly:

virtio-iommu driver in guest will make map (VIRTIO_IOMMU_T_MAP) with VIRTIO=
_IOMMU_MAP_F_MMIO flag for MSI mapping.
In qemu, virtio-iommu device will set a new defined flag (say IOMMU_MMIO) i=
n iotlb->perm in memory_region_notify_iommu(). vfio_get_vaddr() will check =
same flag and will not print the warning.

Is above correct?

Thanks
-Bharat

>=20
> Alex


