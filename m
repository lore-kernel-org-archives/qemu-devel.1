Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4826CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D7821D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vqPJaY2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D7821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKj4-0001Vk-4H
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iiKhn-0000g8-MB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iiKhk-0003Do-Vx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:00:42 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:59130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iiKhk-0003Ax-Md
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:00:40 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBKFuHih032235; Fri, 20 Dec 2019 08:00:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=wB448Zs23iaLziGiv+FOihhfkwXDArIN914EUae0PFo=;
 b=vqPJaY2kaf5kqE5BzX4KJ7fE4c5/So+odOcJ88Fm/qb5zgXLzKCi9G4bSZQkqCgGi1XA
 VDh7Pxr9C1gPi5na+0zaNtjplYY1D0C5U3vwY5iac/WdQYj7fjFs7jm9gM1+ClBsDLSX
 QVtmCZ8NjBqK/AMSnOdawbXgMkc1y1LOhNaK4VfIiAHxtcaD/gcM3OhOmiC9w/clcDtE
 z8zBQ0RtUBOruBIi6CFJrCYTnADAsK5z/dgyuqRsCarWJ7hu1SXrKvu0q6dOhZsRtl/L
 B4giajZkz3wEseI8WZAPyweOV2JPFi5TwKjxOXwXvDT1D4Jbw36RztFJ9fc8XBxtMp4E BQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2ww056nge2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2019 08:00:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcvBilUAV1wXFo5U8CAF6xwAl5AK2OAKpqPA4EW99gACDtkf+aZuSw/wPlAVMiXRPCQlsMpfX0h2u5KbYdE4ZUoWXA4xN4aFqTdBJxUqAZRTJavCMuLMurxxdl4ML+psrnEwllJZ4gffvEatlUY6lovJjod5F53BrjL29Gex+ytoK3L1zfmVZllcT2RTWonZFKx7sBprW1y5LrA0cvap3aleSi79oLL9NHKQwZ9keDXQIp7Ly9B0mJH3PjCtBuuQmqJGCI/KrXDPabhotXdkjGLg1UMrmpcRnmTs2EXkZSpF8J4eJ8naEYi4GFCT2VuuX0oSW0roeWUW6UF3Nv66dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB448Zs23iaLziGiv+FOihhfkwXDArIN914EUae0PFo=;
 b=BVTbzYlcgCD6zUAxz+DbpIo08kPha1G5aU2bQakv5WUG3pca+14NLau93M2J+4oaJlfE1CexWCN+k9+01rJuFPI1Uz/HDJTGsMq8O0MZpDDvTIvoMmtyALQaGSu5Nq19Z2o5+kKysGsPpuN9hX/qxemQUDPR81P2KZot2LoAVh3IcDiZSXKvy3Wt6qde4oUw3CITQVjWUt6Oq688bvXvyi6sjAni8z9Iu7az9cN+yj6TRm/G5yp7gJOyOjflZEe+cWCyKHJzDpdEQUgxjTpzznGblEcKe9F/866pmClc4KAICMyihMvmFcaY+ZxQWKSScqXf6/93FpQtAhjkm/T+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2717.namprd02.prod.outlook.com (10.175.49.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 16:00:13 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.016; Fri, 20 Dec
 2019 16:00:13 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Topic: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Index: AQHVryW4uEZJ1V/hTUic5+7Y9QnlRqe35WUAgAVPdACAAAL3CIABWUIAgABrS4CAAmvVgIAACnqAgAAGGACAAV3YAIAAAQkAgABJqACAABPxAIAACZMA
Date: Fri, 20 Dec 2019 16:00:12 +0000
Message-ID: <B7B48E4B-03CB-4134-9D43-E6897247A363@nutanix.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <bfaf0b42-513c-08f2-2d4f-d99437b7041d@redhat.com>
 <9540FF2A-FC7E-40AE-9259-46EF431ED65F@nutanix.com>
 <20191220082554.0c1bc63a@x1.home>
In-Reply-To: <20191220082554.0c1bc63a@x1.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89b1eb11-b6d2-45cb-6392-08d78565b295
x-ms-traffictypediagnostic: MWHPR02MB2717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB27171DA727ABDB3E24DC5AF4D72D0@MWHPR02MB2717.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(6916009)(8936002)(81156014)(186003)(8676002)(64756008)(316002)(6506007)(2616005)(71200400001)(76116006)(91956017)(66556008)(66476007)(66446008)(107886003)(7416002)(4326008)(81166006)(66946007)(5660300002)(478600001)(966005)(33656002)(86362001)(6512007)(26005)(6486002)(2906002)(54906003)(53546011)(36756003)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2717;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wk0MRmRrd4G+fGwGBuhAz3CX6Pxk1xGTJpI8N3MwYo01J+8328KDjR1HGQxDtnGsb/zbqHA1iF40xT58LxEz15eVf2dtBpzumdhaxOljpbH9DFJQfATKiNE770ZgLLIqPw6JFRpxa/GTjTGvVHo3U/M+ICOMwCzrpFiYXHamxHaa4skKi2xG7U5UDYHPUeZv2jDdcaJMXUk3xbuvKlYl5ubYEQLi9H9fF/GED0zHXUObVE9H3rxa7SPz1IRhfIMO+Sdjb4aWEq73AYj2jmx1fFN8khUJ9K2xoC04YaXSCkIjfXm6IUadbmuRS8CKVt615YZiMhh3JHd7LAsVkKtOpxDp0mtjSwl+SEJHkq2UuEkgA/2xtrY/fQR1kqrWz3j218K4Rcks/jjXhi/CxvDBCpFVecgrkBE+j/PTKUNBLK24yVVZEdCb15M4V3auZzsi6eBmQBT1ifNicOsKTffezYsVfv0ptHQ7Syluudw/r1ckSIdDJEciKHa/2HoDX+KIIBpqVr0+OccxYZcKYPBo/yRTCqQhzf2ZxANVEok3ON4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FB5ADBB89DD7F34BAD42CF78AEDFDB18@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b1eb11-b6d2-45cb-6392-08d78565b295
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 16:00:12.6092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lJ9r+JTAOJOAcddNQuc6KPBUtFE360YBCusQcL2nDpLaDkgKALBd9EGEXL9DbLXnkrdXM31Qx3c7PDkUlD8+S2nP3eBylyaAKYHaXbp1vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2717
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_03:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Heya,

> On Dec 20, 2019, at 3:25 PM, Alex Williamson <alex.williamson@redhat.com>=
 wrote:
>=20
> On Fri, 20 Dec 2019 14:14:33 +0000
> Felipe Franciosi <felipe@nutanix.com> wrote:
>=20
>>> On Dec 20, 2019, at 9:50 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>=20
>>> On 20/12/19 10:47, Stefan Hajnoczi wrote: =20
>>>>> If it doesn't create too large of a burden to support both, then I th=
ink
>>>>> it is very desirable. IIUC, this is saying a kernel based solution as=
 the
>>>>> optimized/optimal solution, and userspace UNIX socket based option as=
 the
>>>>> generic "works everywhere" fallback solution. =20
>>>> I'm slightly in favor of the kernel implementation because it keeps us
>>>> better aligned with VFIO.  That means solving problems in one place on=
ly
>>>> and less reinventing the wheel. =20
>>>=20
>>> I think there are anyway going to be some differences with VFIO.
>>>=20
>>> For example, currently VFIO requires pinning user memory.  Is that a
>>> limitation for muser too?  If so, that would be a big disadvantage; if
>>> not, however, management tools need to learn that muser devices unlike
>>> other VFIO devices do not prevent overcommit. =20
>>=20
>> More or less. We pin them today, but I think we don't really have to.
>> I created an issue to look into it:
>> https://github.com/nutanix/muser/issues/28=20
>>=20
>> In any case, if Qemu is ballooning and calls UNMAP_DMA for memory that
>> has been ballooned out, then we would release it.
>=20
> That's exactly the problem with ballooning and vfio, it doesn't unmap
> memory, it just zaps it out of the VM, to be demand faulted back in
> later.  It's very vCPU-centric.  Memory hotplug is the only case where
> we'll see a memory region get unmapped.
>=20
>> The reason we keep it pinned is to support libmuser restarts. IIRC,
>> VFIO doesn't need to pin pages for mdev devices (that's the job of the
>> mdev driver on the other end via vfio_pin_pages()). It only keeps the
>> DMA entries in a RB tree.
>>=20
>> If my understanding is right, then we can probably just keep the map
>> Qemu registered (without holding the pages) and call vfio_pin_pages()
>> on demand when libmuser restarts.
>>=20
>> For context, this is how the DMA memory registration works today:
>>=20
>> 1) Qemu calls ioctl(vfio_fd, IOMMU_MAP_DMA, &vm_map);
>>=20
>> 2) The iommu driver notifies muser.ko
>>=20
>> 3) Muser.ko pins the pages (in get_dma_map(), called from below)
>> (https://github.com/nutanix/muser/blob/master/kmod/muser.c#L711)
>=20
> Yikes, it pins every page??  vfio_pin_pages() intends for the vendor
> driver to be much smarter than this :-\  Thanks,

We can't afford a kernel round trip every time we need to translate
GPAs, so that's how we solved it. There's an action item to do pin in
groups of 512 (which is the limit we saw in vfio_pin_pages()). Can you
elaborate on the problems of the approach and whether there's
something better we can do?

F.

>=20
> Alex
>=20
>> 4) Muser.ko notifies libmuser about the memory registration
>> (The iommu driver context goes to sleep, hence the pinning)
>>=20
>> 5) Libmuser wakes up and calls mmap() on muser.ko
>>=20
>> 6) Muser.ko inserts the VM memory in libmuser's context
>> (https://github.com/nutanix/muser/blob/master/kmod/muser.c#L543)
>>=20
>> 7) Libmuser tells muser.ko that it's done
>>=20
>> 8) Muser.ko iommu callback context that was sleeping wakes up
>>=20
>> 9) Muser.ko places the memory in a "dma_list" for the mudev and returns.
>>=20
>> We could potentially modify the last step to unpin and keep only what
>> we need for a future call to vfio_pin_pages(), but I need to check if
>> that works.
>>=20
>> Cheers,
>> Felipe
>>=20
>>>=20
>>> Paolo


