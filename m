Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3651D2065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ac/9yihR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3651D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsl0E-0003Wn-Gv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1jskzN-0002Mf-JB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:38:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:21836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1jskzJ-00067u-Mx
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:38:13 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 067AaH7X010688; Tue, 7 Jul 2020 03:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=68SNL55or8Ri2uCK00neGUoChdUp9lmnPv+NYO/x6uM=;
 b=ac/9yihRiEbNZo9fg0tKJ3FLLtnAM8peImWxz8rJJjy7pY9183TfelbgtC8QO/40WLtd
 V8zrdnqdR564uFMurafw5t7LqTVSQ2WiHlHJYB/zxs0DS9xqUVF6mS/eYwRqmil9/+wJ
 pgG1QhKyriaIB3yfQ1fszEsFkeTN36pCVSnZJVEyOpH0AUkKqMfT3nKOyrIHddmTx6Zt
 0THStlJ5e4oonfX5OfWUKmLz6lRUzjDR4tlNGRaIbl+lBg1d/wkdMyvwLTmd3/FGgZXC
 zxG+RmVSNniyNlbHCVP5xoETea1Af9yJFWS2eOhLAqT/r1UUWXvRYi/HXhL/RSvkgLXs 5Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0b-002c1b01.pphosted.com with ESMTP id 322qaa5mqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 03:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSTCXxhc6/iTdYmqL//9BOBagPkWtD6+NkKKPQv8D/iAvL8SBDGXRBe3kVBZWPENblKsXhLg7oK10H1rScAyG7FTyq6v13t0O1s7OVZVtiq0l5o0Lsxzo73IjyBb/Q2pSp7PSjn572GnvqYgN/nHPDtT3ZeT4IDg8o4PO49HDz/cJbhXE7cp0aNqT8tXhJsf+C6OnY6uxs9Ej7OdgWWn56agtgctmJQ/h8PmOdr/iOdsCUyOrSJFdHTaW8oaaBangM1+i7XbqKhILbGdE3FaVaMuMcftwC7Cvz58G/20kkM9Avjx4Y4+leZsuAKDcBl0PXzoalV/rrKpSHDu+YhIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68SNL55or8Ri2uCK00neGUoChdUp9lmnPv+NYO/x6uM=;
 b=Ghk4gGOBnNwv13xOHAeZ/j1gVKORjUq5NRewtV9NfTW9ROGVQrc+3NcNYu+dq896OVr4XeLHDBwZ79Pn2zEzErGxjeu7di3AOivi0f1Kk9oO/hbuNlbWgZ8rm/fFrkNnwbTSRCxELOB+LJ35z2AmtWUqwdH1aeKBLWwBLD9jVGXaQNQ1HxOD/XA0MksjMh9HiWmrpBozZJWX/Wfv+XynA7/siIupaaBRyw4SYWyi8LrB0k7n85kWxYMkfHVGf3rODFL1fSffOJ8h+sNwVrZiGV06y9u404tdGGq4R+e3IvLExD6oR+gnmMXFtFVk6lKHbqNR2tLDo6xLNFuq72FtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4358.namprd02.prod.outlook.com (2603:10b6:a03:11::17)
 by BY5PR02MB6754.namprd02.prod.outlook.com (2603:10b6:a03:213::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 10:38:01 +0000
Received: from BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::ac30:926:2dff:b777]) by BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::ac30:926:2dff:b777%7]) with mapi id 15.20.3174.020; Tue, 7 Jul 2020
 10:38:01 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: DMA region abruptly removed from PCI device
Thread-Topic: DMA region abruptly removed from PCI device
Thread-Index: AdZTg3uLE9L5RNQrTJ25kTkeyN20cwAHQ8YAACqJBoA=
Date: Tue, 7 Jul 2020 10:38:01 +0000
Message-ID: <9F290836-753A-4ACF-A593-F736C2FA0508@nutanix.com>
References: <MW2PR02MB3723509CC4795066274C9D4C8B690@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200706082004.5c887c67@x1.home>
In-Reply-To: <20200706082004.5c887c67@x1.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc95f092-d98d-492e-4d5a-08d82261d2c2
x-ms-traffictypediagnostic: BY5PR02MB6754:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB675426354B5EE67B4EEF59D2D7660@BY5PR02MB6754.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ab8uVVYVfr0+sJOpi8pZVIJPetAtJejilecec8UdC81LO3YbvjzimHU2TMeqIMfU67Vi2i9tjb8/jKIRP+PbXacKBU5V2v7aj1gwqJ/GwLebaf/2OgiXrpRejMr5eeoeyNogh4pGFuu83Oudq8w8eFIQ7FlR9SCY46PYF5152zLuQaqAnAVrwEsKlYIXkupHzhTDwvCvdYniRnVfM2FgR2TYoGXOG06FOqXMcQM/poR9CHGBRhywcf5sDob7OKZR4bTAYyj7DLbYo9jru0q7rpBwqu4PNTCQQkxoWs3Ew6+HRgIbR7ne5vqWnsRncke6OfgO21kcmahUml9neO4QtxvFxBDf0I7CLbzmezD/1Ul5rJ9/uONcImWyslDMjuWZF7WRex8d4hfZwcSzgXnFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4358.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(5660300002)(6916009)(6486002)(86362001)(26005)(54906003)(36756003)(6512007)(6506007)(186003)(53546011)(8676002)(2906002)(316002)(76116006)(66946007)(64756008)(66446008)(66476007)(4326008)(2616005)(8936002)(71200400001)(83380400001)(33656002)(478600001)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: aZf50fXNa688F+K9hj5VZAPQm+cA5ha7yekjbG294/BddFwlvLcYj5Kj1989MCbhpByB5+h7uuekkQ0UVM9lrq4q9cO0/NcCLx//bPwOQdGxfXG0TGVUFm7IUBkw2bawcuYkHY+9JtE0tNH/ZcqBbVbogNEBihdVhdKsJrfopgpLHAAM2xujyjPVb1FDculep/28Pc7F7yy7F057dN8Mp8ra9Ooys3FHmenYKmRbnYGDKzeySiIYFIY8zybj+MpTKea5djd1/idKvZX7bRofXDfLWoWQyyUAN7VS7dutG6geXlDaqW/qekQjI9DNHg0d0rWj5MLR8N9l3AnbszatrhGSmUuGs+5ygOhgUuhJEkReDxLXIb98sRVJe5XdlnGfBcOCxc4K+Xyh2p/GIrtKaxmeGBXgTyd3jgZgD4UzWz6x+n8HucjIVIh+CZsd4TfhoJ0VssEgwey9YLIl+XMsmF7j/qLngCgFtEgf6HEBbkU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6F368BBE3115E469F0CC11B9FD4474C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4358.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc95f092-d98d-492e-4d5a-08d82261d2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 10:38:01.3587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BIpfrtgF+tcG2Sk08rizZuLtgHbR3ch0rRIEda2sfeGp012jnVPyK/V3bA6492v2Y96t565crEqnt3h3Pz+vDtE37Hua/YpRpF26KZj0mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6754
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-07_06:2020-07-07,
 2020-07-07 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=felipe@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:38:07
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Liu, 
 Changpeng" <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jul 6, 2020, at 3:20 PM, Alex Williamson <alex.williamson@redhat.com> =
wrote:
>=20
> On Mon, 6 Jul 2020 10:55:00 +0000
> Thanos Makatos <thanos.makatos@nutanix.com> wrote:
>=20
>> We have an issue when using the VFIO-over-socket libmuser PoC
>> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg692251.html) inst=
ead of
>> the VFIO kernel module: we notice that DMA regions used by the emulated =
device
>> can be abruptly removed while the device is still using them.
>>=20
>> The PCI device we've implemented is an NVMe controller using SPDK, so it=
 polls
>> the submission queues for new requests. We use the latest SeaBIOS where =
it tries
>> to boot from the NVMe controller. Several DMA regions are registered
>> (VFIO_IOMMU_MAP_DMA) and then the admin and a submission queues are crea=
ted.
>> From this point SPDK polls both queues. Then, the DMA region where the
>> submission queue lies is removed (VFIO_IOMMU_UNMAP_DMA) and then re-adde=
d at the
>> same IOVA but at a different offset. SPDK crashes soon after as it acces=
ses
>> invalid memory. There is no other event (e.g. some PCI config space or N=
VMe
>> register write) happening between unmapping and mapping the DMA region. =
My guess
>> is that this behavior is legitimate and that this is solved in the VFIO =
kernel
>> module by releasing the DMA region only after all references to it have =
been
>> released, which is handled by vfio_pin/unpin_pages, correct? If this is =
the case
>> then I suppose we need to implement the same logic in libmuser, but I ju=
st want
>> to make sure I'm not missing anything as this is a substantial change.
>=20
> The vfio_{pin,unpin}_pages() interface only comes into play for mdev
> devices and even then it's an announcement that a given mapping is
> going away and the vendor driver is required to release references.
> For normal PCI device assignment, vfio-pci is (aside from a few quirks)
> device agnostic and the IOMMU container mappings are independent of the
> device.  We do not have any device specific knowledge to know if DMA
> pages still have device references.  The user's unmap request is
> absolute, it cannot fail (aside from invalid usage) and upon return
> there must be no residual mappings or references of the pages.
>=20
> If you say there's no config space write, ex. clearing bus master from
> the command register, then something like turning on a vIOMMU might
> cause a change in the entire address space accessible by the device.
> This would cause the identity map of IOVA to GPA to be replaced by a
> new one, perhaps another identity map if iommu=3Dpt or a more restricted
> mapping if the vIOMMU is used for isolation.
>=20
> It sounds like you have an incomplete device model, physical devices
> have their address space adjusted by an IOMMU independent of, but
> hopefully in collaboration with a device driver.  If a physical device
> manages to bridge this transition, do what it does.  Thanks,

Hi,

That's what we are trying to work out. IIUC, the problem we are having
is that a mapping removal was requested but the device was still
operational. We can surely figure out how to handle that gracefully,
but I'm trying to get my head around how real hardware handles that.
Maybe you can add some colour here. :)

What happens when a device tries to write to a physical address that
has no memory behind it? Is it an MCE of sorts?

I haven't really ever looked at memory hot unplug in detail, but
after reading some QEMU code this is my understanding:

1) QEMU makes an ACPI request to the guest OS for mem unplug
2) Guest OS acks that memory can be pulled out
3) QEMU pulls the memory from the guest

Before step 3, I'm guessing that QEMU tells all device backends that
this memory is going away. I suppose that in normal operation, the
Guest OS will have already stopped using the memory (ie. before step
2), so there shouldn't be much to it. But I also suppose a malicious
guest could go "ah, you want to remove this dimm? sure, let me just
ask all these devices to start using it first... ok, there you go."

Is this understanding correct?

I don't think that's the case we're running into, though, but I think
we need to consider it at this time. What's probably happening here is
that the guest went from SeaBIOS to the kernel, a PCI reset happened
and we didn't plumb that message through correctly. While we are at
it, we should review the memory hot unplug business.

Thanks,
Felipe

>=20
> Alex
>=20


