Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9A2C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F80120776
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="v3mjll7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F80120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPT1L-0004Hy-53
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPSzt-00039c-5K
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPSzo-0007dk-Rw
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:33:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:16998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1jPSzo-0007d5-C0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:33:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03HFK7Kw029574; Fri, 17 Apr 2020 08:33:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=9I6416fYOxVxKmbTGEOi655KWiJlAkeHY0XiFShHqhk=;
 b=v3mjll7brXpqlvmXBDqHP3EglUngFuD9HBJqgDYLrQXkR2iAd4dn5q2Z/zpWTly5jl5z
 mNCkMx8iC1eB715umWnSN/1r4DG2UVOigT3/TbYCRvQLPJorkcTpx25FRDfm9i8mFhRg
 M5NLUGnF5RdvmIaebsyyFP+DyBDd41fU+E65YkD7CVHCF1ztCQplhrzLgxbCuqsSzTX8
 b/EctJ0xubOA/Ys9MVmQNzR7A+vlzw1585dYjTfWXBAROAlUf78W5uU50zF4AEgfkEGR
 1yFJNzJ42IrTCVsnb77sTqqrqMM+W8qWa1N9Furg9pjdGseGbmUCj31l8OpzUcuiActn yw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30dn9yq83g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2020 08:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf2ij9dxVSMPgCNySG6C/ooRlB+wpKNeA8+UGZjpeSUz9OF0X4hjILgB3xfJT2N0ptixSSa8apzLSuVGqwqZMq1tM1zDVLCBluP7RFFBu3awzFqRaq4EM6jLHtYzqxanvFswKIAM3ZNLHElGtm9coDdsv7DYCWjtPzXvjIdDY96b+ygDJjU3RYJ5TiVvOK2aVVB0CFQIcuL74ciOX9r1OnqQzDhT50tUK08Pkfr3nQQXQbDN+dZMsha8/6I7ln5Brjvu0c35GiWVSxbuFJUGbvlB3kDaZ1iVKUNLH/NAUmEy3o/MInMKQYorq0oH7f9gFRuWYH5p0IJ37G8WXU88iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I6416fYOxVxKmbTGEOi655KWiJlAkeHY0XiFShHqhk=;
 b=GHlWj2BqV2A8/BN65eUNwwwnBSJD9+W7b+GUsWehor2FOglZZMt2HbLltXvPPADS/bMAyc74L0MLGa/RjRHt8JTJtO2heZpVklTfddv/TkACfAo/ztxkESdKMFgW9VaKaj6na0p3i6M3+fN6UmPSzdnwH1nZ3Q6f0daD3FZ9Orxaq+ybUq3qL6Tykw0byG4iK+IirsQOeE4iSFFWUPMs61esX9Wht6mb4d7leYmRpU7ZM8fpTQA5olDGwJsjXUPle4Pkv9LLJysvZvGu6Y7MiSG33gPqSiqkLSIHgvgWRY4Wky1megD6YWaB1j4fxdkg59dUs6ON2tIYSrJ9GJ3f5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6894.namprd02.prod.outlook.com (2603:10b6:208:202::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 15:33:32 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2900.030; Fri, 17 Apr 2020
 15:33:32 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: Hot unplug disabling on pci-pci bridge
Thread-Topic: Hot unplug disabling on pci-pci bridge
Thread-Index: AQHWAcPYtZw/rt1SL0WZPWjOTF64NqhXl/WAgAAk5wCAAA1iAIAlzVEA
Date: Fri, 17 Apr 2020 15:33:32 +0000
Message-ID: <FAAF4C21-44D1-40AB-BDFE-2BCA81412227@nutanix.com>
References: <BF9E6F48-E047-4D1B-BEF1-A58024DE0C6E@nutanix.com>
 <20200324121703.472b034b@redhat.com>
 <90435944-E1E5-49AB-A039-ADBEC58EFB0B@nutanix.com>
 <20200324151702.4c2eb79e@redhat.com>
In-Reply-To: <20200324151702.4c2eb79e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c8da454-7c7a-4be4-ec3c-08d7e2e4afbf
x-ms-traffictypediagnostic: MN2PR02MB6894:
x-microsoft-antispam-prvs: <MN2PR02MB6894EF332281F12920485FF4F1D90@MN2PR02MB6894.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(346002)(39860400002)(396003)(366004)(376002)(6486002)(966005)(6512007)(36756003)(76116006)(316002)(186003)(6916009)(86362001)(66446008)(66476007)(4326008)(91956017)(66946007)(64756008)(66556008)(2616005)(44832011)(6506007)(53546011)(2906002)(478600001)(33656002)(5660300002)(8936002)(26005)(4744005)(8676002)(81156014)(71200400001);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVF5juiviRVMhLo3253v8e8Tv41uLspmEVzv6fF4oSHGv7shQ6sK8S3Ne4TP+OvhF+Tbr7mwm8ak/qTcxCfhq6ErOQ9IqK1WFo4zkQkb/HFizjkndvsT/UcpyluGfwZb8/CTHvqsDPvKisPF/gi2e/YQtWHD3wiRf6Co+sFn9K9+vMCnTb0a4jgcFrtMKbq3koAdwByBTfdrSI4VaeOW/eSNTyiUweP2InAMiHFDPWtWFOs/Q0MmCuDKIZvhuWoaIp9YKk/7EBbbwetusI29SWLmyba3ye+0DAPrboANVs8F3bRLarf83ptAGXpPfyW1Jk9UCQYZU1JATRMmwf8+76MX2ng1HB/A8zzlM74KLeLjYmOM5lVIddLKowhg73IYKhTGqkJylVRXzWdnjyAi7NdKGAXBPn5ow3IEfWwfAKKYFE2lttV2999joZAnYn/Csqmq8MYED++OBV1YY9AclnV/q2D8riwfeIbKeXxTT6BPed/zx/UaHLOOokfDoshU+Lgs6P1SoZFXTMQjjwbqSw==
x-ms-exchange-antispam-messagedata: EBrsx7+n5CEN+AvmWhN3kCjnR4anjXsb+pk2m+DDW6S7AnAMrRExGhHdL2XGfIwqShTPtTT2wU9aywizAHS9TndMprOgEYG5kzUGJPLwMJwZPVoe70aq77eOcj0r5+VVV+NgrTL0otAVPVr+MMuUFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B463D3E97916F428EFF38510D80F204@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8da454-7c7a-4be4-ec3c-08d7e2e4afbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 15:33:32.4436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0seigzK3NipbxUQ+sYqnVHC7JY0uEWcrpIZWUmb8LIdX71txTPx6n8IQq308r2p6jv7B26A1ARld5MxeKnHzsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6894
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-17_06:2020-04-17,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor:

> On Mar 24, 2020, at 7:47 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> if you are interested in hacking ACPI PCI hotplug more, look at how build=
_append_pci_bus_devices() works

I am trying to disable hot unplug of a device on PCI-PCI bridge without rem=
oving the capability to hot plug. Will it be enough to disable the followin=
g lines of code?

+                    method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
+                    aml_append(method,
+                               aml_call2("PCEJ", aml_name("BSEL"),
+                                         aml_name("_SUN"))
+                        );
+                    aml_append(dev, method);

I have sent a patch. Please provide comments.

https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg02773.html

Thanks
Ani


