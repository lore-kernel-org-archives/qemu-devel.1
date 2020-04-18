Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA47C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8411721D91
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hd23Y1Dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8411721D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPeCN-00087l-N7
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 23:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPe7G-0006CL-1m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPe7A-000391-Nc
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:25:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:46248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1jPe7A-00031S-83
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:25:56 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03I3Eltc008023; Fri, 17 Apr 2020 20:25:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=jRo5XsEfN1VQlXiTrTNiHeWZtYDHocH1sMrHgVIVANY=;
 b=hd23Y1Dyti1AvzStMwfv2KotLSTlpRTAHQC/czSE1wXygKzmTJ7VV7NXmqVA3K/xvazj
 Q0qQ3hDwrm+x65yEka7br/pVr0L/NvCOHCQWWkcHjHP3EKbWxN6DMcvNkklNhKoq/nUF
 cDRDMBliqprxE0V1bUWk61D2j/dVy6Ldroh82z3XkNP+fSotdWj0MicqmdXJdsPWQW3V
 OS+ihY8MpWd90qPik4zXwv4sn6uaZaevWKvXqfyinfgJPYNqq498k1NjxiPOgJNd93uq
 lhXHGow88UbA452CMhzW7nlfLmWv+lW4DkTe/GFfVy//uoCD77R2RQ2I8Dkd3L5ix6pu xw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30dn9yrd0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2020 20:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COXWCqVH0S+uGIWUQZ9KencV8ZsloPe2C71TyVM/ZoZLX4g+/U6UEcjq/9wI4qZurbtbHSEY2eaPW+Sr9Ui34WMno6VcD0evq6uyKr5/Y8S48H13aYEe9CjovKZDTGAnoWcCf/0fmRi+XWWEJmh0u/EiKqe3s267wjY6Y/itS0vCm9UBUYyrCL3lADKbwYFpRMKdvRRtrUvJpeazNZObuG2NxtRXKDawRNpA/YRlWIdDBfPhVSjtwpElp+fZuseH9+RErKgQXjeKoWKjwtisC484wR+iyqWTZBMkDqmNjEBhZq+f6Y1mM6JB8uIHpAcokpbgoWgv0HOWh2yPMVIQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRo5XsEfN1VQlXiTrTNiHeWZtYDHocH1sMrHgVIVANY=;
 b=B5LPOJDW48/0WpSeDiBK0pd7CRQywVoaU7OHrm6cOT5Wv614D/CblRsD7JUjxyIW/MRk9Qs4oGwTx8WO4eOxcezYdy4X+EZqTgR1phbNU3kZHRVM39L2MJo99/dHR/E8YeWK/k7WXVv8uqnj2OHYZm5aYwzb/hVe0vy4q20zGbwGT/4HzPCsIP2N5+mBI0IjPHB/nXWDgrKLiQ4ghHLcAk0cVzF3W6qZ8rgHkhiK6m4vSe137x6qfcq/DY9bSbSlibjAQtpjXAe/QNowRnfaAG9XsYTHhXCDZYTWIUV2KfuaX+LbKWlpEFBR21CyDnJrUs5Hqf61xt8Ws44kk+RlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6640.namprd02.prod.outlook.com (2603:10b6:208:1d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Sat, 18 Apr
 2020 03:25:47 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2900.030; Sat, 18 Apr 2020
 03:25:47 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Laine Stump <laine@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAAB0KAgABZuwCAAFwZAA==
Date: Sat, 18 Apr 2020 03:25:46 +0000
Message-ID: <AFEDBC1F-8536-4354-9C5E-9829C258B6E3@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
 <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
In-Reply-To: <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [203.163.235.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bc9638a-0aa9-43bc-47ce-08d7e3482f94
x-ms-traffictypediagnostic: MN2PR02MB6640:
x-microsoft-antispam-prvs: <MN2PR02MB6640604998D37C168092B527F1D60@MN2PR02MB6640.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(6486002)(86362001)(5660300002)(6512007)(186003)(2906002)(36756003)(2616005)(66946007)(44832011)(66556008)(66476007)(66446008)(64756008)(76116006)(966005)(91956017)(478600001)(54906003)(71200400001)(4326008)(81156014)(8676002)(6916009)(8936002)(6506007)(26005)(53546011)(316002)(33656002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UrLnfnr7i0yRTYD3m6km1lxkI7qVsPAvIuf8+tbFX+g0kREUauPfG0qt7swibIMmiE7qArMLxrJq62QOlIp/VebKM7PVMDW+5d21TqHnagC5TlyYSorbN8cXFEKl7C4IjDSy2WaexbyQEdaDchWaf33Jh00Koyx/t50VCdFTWUYGPLEslJDcQrHCWcd0lMjaVO7kO4mCcUxqQqWLIRVd8XCHaacwG3iV743M+IRMqql8GJDSTcxblUOkWLBIU46cr4vFsqdp/q2ypFVH9Fg4Za+xOXimu3A72gGRVdEWIDHxbt1JPAhzOlo55Lkwv6DYjkJmhjnTnsdOwleT4HwxRk/brP1uQ9SKV9UqsVirh6RmTkn1aVLV2Daez39xP+KDVQ15YNytDxR4O5BmuNXYt5vg1FNxUvAA+OfIlII6H0ECyP5aBJfrunHQMgIPTgheuw7GASOIqoYq8KXQEOr2cySjMIMhP5o3Al7MIkhIQ0K8LuYHFpK9rUzJqlbXiSn8bcAX0M2/FiF4Rx7LdtaXuA==
x-ms-exchange-antispam-messagedata: fcUiY5Cm9eqHv7iL0KRRfDDoXE4mimfGgnoXRFayalib6LgEeTpqkM2BaWykLUY9MdfMaH9cnbK4H5LtZQMJrJA1fPhIzrm23Gv+2yLKLq4BoE78gf3G+5cvb49rYyG/uYiCFnqbZL1IfosiOi29AQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <559C8E5BF7EEE744A393AC9F5FD30764@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc9638a-0aa9-43bc-47ce-08d7e3482f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 03:25:46.9163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpIcRsu85nL0GSWTVTtX+3nu7PoTMrdYdSvr9ThwtdGCGi6StSgomZmAq7P7STKLCVB1Zfvc0xjNwPufpvl0lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-17_11:2020-04-17,
 2020-04-17 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Julia who implemented https://patchwork.kernel.org/patch/11388881/


> On Apr 18, 2020, at 3:26 AM, Laine Stump <laine@redhat.com> wrote:
>=20
> On 4/17/20 12:35 PM, Ani Sinha wrote:
>> +Laine
>>> On Apr 17, 2020, at 9:39 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>=20
>>> Problem is, I think this is not something we can support with pcie or s=
hpc.
>>> I'm reluctant to add features that only ACPI can support,
>>> we are trying to phase that out.
>> Hmm. I see. We use conventional PCI and hence was looking for providing =
this feature for conventional PCI only. Laine might be able to throw some l=
ights as to feasibility of the in PCIE world.
>=20
> Sorry, my knowledge doesn't go that low. If there's a qemu option I can e=
xpose it in libvirt, but am by no means an expert of qemu internals or the =
pci/pcie specs :-)
>=20
> (BTW, I think in the past people have prevented enabling hot-unplug by un=
privileged users in Windows with some sort of a "system policy" in Windows.=
 (whatever that is - I don't use Windows, and have just heard this from oth=
ers when discussing the problem).
>=20

My question to Julia is whether it is possible to disable just hot unplug b=
ut keep hot plugging for PCIE devices enabled using PCI_EXP_SLTCAP_HPC  or =
otherwise in Qemu?


