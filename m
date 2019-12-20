Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E6C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C54206CB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ToFcqBQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C54206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJO3-0001Zu-Kp
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iiJ3S-0004ua-HP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iiJ3Q-00085l-EF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:14:57 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:2584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iiJ3P-00082y-OR
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:14:56 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBKE9WMr017105; Fri, 20 Dec 2019 06:14:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=ATyMGJaXO8V5VDmSGSPmaHHFn8V34ABTTM9iQ1QWhYw=;
 b=ToFcqBQE/189MDHJ6TQ8WCoTKvOTOW+fWFh+4aHEiUIayIAV4xCzgWgeONfZpO6Lf3yl
 XS89ff0I2l0W1+W+eBHjr9uWteqlUNSb49zzm4trawjTRJDaHwTauOuCNaEiCbJ87oRQ
 9jXx6v5nu09Q/ragB4xupTzO47wIgLglvGO7N1nnb++jtI8SV8sqwMw41ACnsbYRxKp4
 wRGYyRji3r37Mu++rH+z02vUTzypNgCi9W4+Fb1Lh58BRrL+8wQmD0mhwRjgdednA0fS
 4lu6nv3MWURbq6rhIIFBTYRpG1ycRmeEnDmFAHI2hL3iTDkOBOtwECBNTR/UQXrLkCn/ 6w== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2wvyppwcj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2019 06:14:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emw4T2jcy+wv44HvQtPfN5ydnrhDVIhQeE2+s6CNA/n2GRijl/c6yVNUS/4x8H+6LbUEyFibxX6uhhvVnTNEpKOR+1T0S1rXRp5d2HA3BT5yrMgyvtaMPAwOu8cqGQqOxZwCJfjTk3h2AdsWMZT5YRKuKOhQPh2kmxJPactApHnJcmWSrvUHril5KDimQzzqPyz2DQAvpLXKPiejPH90CFl1HQnKhkR/aHoKZgXMSeHV8f2+Q+WkYsQjBEN3e/bZX/tHXL9KWD06hZRPeLN8/nXw1CqhASIMtRphd98l+FtoUZue0wF47f7h0LGapJJFbhW35UotqCMiGbrgJxo9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATyMGJaXO8V5VDmSGSPmaHHFn8V34ABTTM9iQ1QWhYw=;
 b=g7v0dk8ahAq5CacVZzgpJZL7eUIx2p6wvnvNI/0kzSQhIgCYHhUS5aIkubjOfrJ1UXHDQu0DWrMlp/ZHj646/ct4WCBoz3ypy0YEU7QIO77pD50FyYiGEYlaXTBg38VFaCLmg6iGh+PsnA0QmZE3P1l/S8zGzt1UBBg+z+Ez15fVFC4LLtntBy6EamaPWX7obhjLLC9HDAFJWXK7hoEBaY3WqHHdhE+mFNg7ZUwsaOPDbgreQ18ccdLjsXPvqFdDdNJbmkMNzCRRhZ2B8R7281AcLQEEYv6RZ8lNQFD1YsYMT7E6c/Ys5UUfSPDHNpuHJkZobP+vwSEojaFOSyQrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2671.namprd02.prod.outlook.com (10.175.49.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 14:14:33 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.016; Fri, 20 Dec
 2019 14:14:33 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Topic: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Index: AQHVryW4uEZJ1V/hTUic5+7Y9QnlRqe35WUAgAVPdACAAAL3CIABWUIAgABrS4CAAmvVgIAACnqAgAAGGACAAV3YAIAAAQkAgABJqAA=
Date: Fri, 20 Dec 2019 14:14:33 +0000
Message-ID: <9540FF2A-FC7E-40AE-9259-46EF431ED65F@nutanix.com>
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
In-Reply-To: <bfaf0b42-513c-08f2-2d4f-d99437b7041d@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c51303d2-b421-4c69-8d30-08d78556efea
x-ms-traffictypediagnostic: MWHPR02MB2671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2671641DD87CC24C41B193B2D72D0@MWHPR02MB2671.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(6512007)(6486002)(81166006)(478600001)(8676002)(316002)(6506007)(5660300002)(71200400001)(36756003)(2616005)(54906003)(2906002)(6916009)(4326008)(66446008)(64756008)(66556008)(66476007)(7416002)(33656002)(53546011)(81156014)(8936002)(26005)(966005)(86362001)(186003)(76116006)(66946007)(91956017)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2671;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcEkFby5/B88cVX7apGUwjM+cLgYGXWRvjLN3Jhxfosg2oLtpl1rDL1Wl3GG9DdhCZC0EamwZfsmaO1q9iddhBSdoxJMOV5NtEH/dddaXX1k+QfwAt/0eK0qAI69BxX4enqCLVQ854fI47wfhgO9UGY10IfelCL7Rut+hThDLWTOStWC/3zRGVP1OgvCdVaj/EQ7zHEz/xEg27wtbyT9+/5CWHepraMMDS4ZeTdVHwjiRHTB2T1DqVjyWpkPQ1ApZfuoGeW+ZiUFCjchv7vD/jKZUXpBbGAEWnHsvChWsheWNSdope6TaChkRrLpMI8mbFJlhRkPd6heUIUCA7YmXbCYJOcNUjcr3D/mSGGFsi4CR+Gy3r5qnPf7zXcCJT8jsttPWyYwP4gYiFAY5mv/xtfVdzPODciOt5RIl6KtGnnehoJTdm6A+XMdnfcqsnQDv0Wmu2W5ovVqByyXBYJNOH+nt5vMZWErheQx/UryGq1/SuWt88H59eUda0RNMreENRiZ7MrA7r12eRFd5EfCPe8jkQfoZa4Pg4f49KEZwWQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E0CA95550333C644BC2EA16140B23D98@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51303d2-b421-4c69-8d30-08d78556efea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 14:14:33.3363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yagQgTs7y+FG2BBiyCGMYSz3460HP0Cv1IrPgdXZsM3vUFMwU5UctEjOkrSSqqhYdr/P2qOcv53D+OEPdIPqHBWT92VGIkjSB2di5guOJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2671
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_02:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.151.68
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
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Dec 20, 2019, at 9:50 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 20/12/19 10:47, Stefan Hajnoczi wrote:
>>> If it doesn't create too large of a burden to support both, then I thin=
k
>>> it is very desirable. IIUC, this is saying a kernel based solution as t=
he
>>> optimized/optimal solution, and userspace UNIX socket based option as t=
he
>>> generic "works everywhere" fallback solution.
>> I'm slightly in favor of the kernel implementation because it keeps us
>> better aligned with VFIO.  That means solving problems in one place only
>> and less reinventing the wheel.
>=20
> I think there are anyway going to be some differences with VFIO.
>=20
> For example, currently VFIO requires pinning user memory.  Is that a
> limitation for muser too?  If so, that would be a big disadvantage; if
> not, however, management tools need to learn that muser devices unlike
> other VFIO devices do not prevent overcommit.

More or less. We pin them today, but I think we don't really have to.
I created an issue to look into it:
https://github.com/nutanix/muser/issues/28

In any case, if Qemu is ballooning and calls UNMAP_DMA for memory that
has been ballooned out, then we would release it.

The reason we keep it pinned is to support libmuser restarts. IIRC,
VFIO doesn't need to pin pages for mdev devices (that's the job of the
mdev driver on the other end via vfio_pin_pages()). It only keeps the
DMA entries in a RB tree.

If my understanding is right, then we can probably just keep the map
Qemu registered (without holding the pages) and call vfio_pin_pages()
on demand when libmuser restarts.

For context, this is how the DMA memory registration works today:

1) Qemu calls ioctl(vfio_fd, IOMMU_MAP_DMA, &vm_map);

2) The iommu driver notifies muser.ko

3) Muser.ko pins the pages (in get_dma_map(), called from below)
(https://github.com/nutanix/muser/blob/master/kmod/muser.c#L711)

4) Muser.ko notifies libmuser about the memory registration
(The iommu driver context goes to sleep, hence the pinning)

5) Libmuser wakes up and calls mmap() on muser.ko

6) Muser.ko inserts the VM memory in libmuser's context
(https://github.com/nutanix/muser/blob/master/kmod/muser.c#L543)

7) Libmuser tells muser.ko that it's done

8) Muser.ko iommu callback context that was sleeping wakes up

9) Muser.ko places the memory in a "dma_list" for the mudev and returns.

We could potentially modify the last step to unpin and keep only what
we need for a future call to vfio_pin_pages(), but I need to check if
that works.

Cheers,
Felipe

>=20
> Paolo
>=20


