Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304C32076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="GKGcA+YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304C32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTglK-0004Uf-AM
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:04:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTgkQ-00042m-Uu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTgkP-0007WF-Ls
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:03:10 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:42916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTgkP-0007MD-65
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:03:09 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T701W6019242; Wed, 29 Apr 2020 00:02:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=CvUEBn5ISVGju8MsFmT8r76HnMK7Oe6++ryRgkCEkxc=;
 b=GKGcA+YTJFu+4Y0leqqkWIKyaVV9Z3WQeq3qMpGR7WgNXY+yI/YtuzIjfviJKVaaimue
 lIZOY7PHPcSlEbMaW0//z9DkQ0WOrKjdzpAfqgxFsirNlf9+3itXgHrc1VYUDEmfO+mV
 QlOt7oPJQk7hVY3ljralX9uM2AKbqz0Lg5b4cTP4mdusurzwUbuhrqO7k9ER5DQRGrih
 LqgJGC3HdaQvSi8w5K1NZ8GEbnetj/P5YsqNJh9WvgeyZs093EvVclgiGbjGhlXg6RcT
 7eLsRNruRtHYzGaZr2qjI3sysLjy4HUSzPz66m2qcqCtcgEt2eL39A7hrcPGvCSi4IqU JA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mjr9g6aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 00:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpQf3cFz45o0gaxTYZoWVQHiRGbw3vpHoH4uPnhuItOcgGwE2Lfo1Q4G+Pl6ZRVatQsvnSrTEds80FF1yAej8K6Ig1fvqfRRbyIQn2vmctwExB4AQeP5xhLErvv6ZHq6H7UFvdeWweVzTpEH8+m8bPABNQt3Bsk/Pk2FGHOhDI3HTFTTYAf5+fzxv7oypTMCAMbdDhJCxTT+Ux8oDG7atrdMs2aisbJl7smPgITExAlFTc6jSaboWoJWeRhmDjgDqtgTGwsaL25P3D3cnvrzTlpEwsA+LHqu3i4urmWG7FbBfsEIrIKtc2rft/OuTSlkOG9J/jtynji76GHcBhbBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvUEBn5ISVGju8MsFmT8r76HnMK7Oe6++ryRgkCEkxc=;
 b=EOySSijIzIHrcmNQBw98BBFGf0qvtGu+Fv8wbrlyHmBzbUE/OKfoDBep4q+iEuvoUv5N9UhuehFyUgl8PLxCt7LZXsLPiGeTUE8tAf7xBJd1GJhC9pQlyzBP8latDNkBIHxEdsS+3bzrpDzgYu8uUzLQewW8r2TfBpdZeb2VAaFIsZE/LUNbeMA31VQFWZzMjbRRr8hvfE8dT0Bs3uuyGHiyQrkq2LfFqDfhL+k40dDJmgDmhZwBX3tsoGYpO9PnJW3VOAhEKfPyUkUB4MVaoU5W7NLD0/aLBXNLvzu6fQZwRN+flsobJkrO7JW6X7HXgKq/hhn0NC8lzW/cpqh11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (20.179.85.91) by
 MN2PR02MB5967.namprd02.prod.outlook.com (20.179.98.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Wed, 29 Apr 2020 07:02:57 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 07:02:57 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgAgAAAq4CAAAGWAA==
Date: Wed, 29 Apr 2020 07:02:56 +0000
Message-ID: <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
References: <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429025535-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bd5fc06-d8c2-4ee5-a962-08d7ec0b5883
x-ms-traffictypediagnostic: MN2PR02MB5967:
x-microsoft-antispam-prvs: <MN2PR02MB596725AE5C0B5442457C6032F1AD0@MN2PR02MB5967.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(346002)(376002)(39850400004)(366004)(91956017)(2906002)(33656002)(2616005)(8676002)(6916009)(186003)(86362001)(6512007)(4326008)(8936002)(6486002)(66946007)(66476007)(64756008)(316002)(478600001)(54906003)(66556008)(66446008)(76116006)(53546011)(6506007)(71200400001)(26005)(36756003)(5660300002)(7416002)(44832011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5h4b35n8lsBVbWhZvNq7d1aVA8uDNwkddUtLDr7qg5oFVdOPHC+HFOXRStWUdbZbT/Uf6W9BAIdc36ogyl2z1jcc6HYbCEUjES9TwT4+4CSvx7pfuzE2FDP+bXJhZMNDGciX+pzjCVE/4dFegohj0Oj74sjQ8gFp4RMl67EWZODU0L/+mgSTjltHXL6qNcZfuQ6vkOIhu2yNW+JzcgJh0t0amdnO8LMutb5n3Y2GLqbALjeyJj1catFRMF1f1a4dfBufvX/VxCtgyNIxo7W51BDooY9iB7W41tv4xyiaPChlsA1+LKD//IfoFnBeDgfoSZGgLZBJFJzNXiPj4gZH/07Aotr7XW/rG5Ye5JpQbJR7TnMKcc6lj0a7Or3DtD1/8+2JSyal5pZfETuJX6dud8Wi5RnIO04PxdW9boHuRBUJHoGHYdeOB5CwTBW++FBH
x-ms-exchange-antispam-messagedata: 7asblq4qfQsDAshYNgpCFQec4B0ZqXdk5vzQQAF/RCtIHkr2GV0vIcaXskBbVrZhHuP7ddqR10MbqQ/Sjxpc7SggsBDlGzw8OsryzEfgLtQctSl8Ow0jlB30I+CA+rPIrAUAme6sTk4lVISWnIfMoZr7E7KRNQLHgXBnbxQfMddzL8BxD2U49WBWkSwQut1zE1p0z0P0/ADYUrgj/w35xqnH44V8GWqJxp1eSFgUSlopjKQYx0wVdyGCF0gHDeWuZyx5jy6W1aVrYei+ABzdRLJc4CXXXvc9sEkbk+vwPQ5j3MG8PYcyZ6scP1AsXOz+/O0XZ8ZgOtnSGskYGoxYAW8N+TIsbOyUiEAygVSw2pa1Qmd5En3AJeCSbjZoal3XbhnlsKRp6Sdpm0RMyZt9t3wUuZ6Y7W1uyUIebJSWyGinURwsGVWqZKyL7Z5PWQW2AQYx6pBHbwkRikA3Nq1eAB9c9fUL70+AnYBJShqDs0RNR0R/1l8rVL3iHUgpUmzopmtaJm/QiwV210YPPIL6D3oiF2VPedRBgbnzQfAD8Vq/w2LqIBGkXFJUXq66lyrCL6dPmlLVutkvtxObG874e3y1w0ztiVS50Cl5v65bz3pZf7qfdQ/C6M0DKJiBPuD37qfF+4Ytp3YwGiQsgFweV741GZhbHLpnrKp73ezNypzNNG7Kl4E8dLMPQW5XosXlmBBd/pmPh6QhAQ+KQ6ck0MBAwquDBeziYsWXVYjo0HtkSzYGAlwpnJIIGtashwOVIsZ7P9IwIvMNbB7nYYBOTPL5tK3uqtvPJ87ko6owKsU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <99414B97D1967841B3370C88C95E0903@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd5fc06-d8c2-4ee5-a962-08d7ec0b5883
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 07:02:56.8954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYuOu2bHE3IH+2kX/rh+njzdMqZyXw6G4+hmJbe85UpD7mX9kHYjJY7ofC6oMrNEdN0HgDLbxoKC5f5fIh6dHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5967
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_02:2020-04-28,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 29, 2020, at 12:27 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Apr 29, 2020 at 06:54:52AM +0000, Ani Sinha wrote:
>>=20
>>=20
>>> On Apr 29, 2020, at 12:22 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
>>>=20
>>> On Wed, Apr 29, 2020 at 06:11:20AM +0000, Ani Sinha wrote:
>>>>=20
>>>>=20
>>>>> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
>>>>>=20
>>>>> o if there's a need to disable
>>>>> just one of these, commit log needs to do a better job documenting th=
e
>>>>> usecase.
>>>>=20
>>>> The use case is simple. With this feature admins will be able to do wh=
at they were forced to do from Windows driver level but now at the bus leve=
l. Hence,=20
>>>> (a) They need not have access to the guest VM to change or update wind=
ows driver registry settings. They can enable the same setting from admin m=
anagement console without any access to VM.
>>>> (b) It is more robust. No need to mess with driver settings. Incorrect=
 settings can brick guest OS. Also no guest specific knowhow required.
>>>> (c) It is more scalable since a single cluster wide setting can be use=
d for all VM power ons and the management plane can take care of the rest a=
utomatically. No need to access individual VMs to enforce this.
>>>> (d) I am told that the driver level solution does not persist across a=
 reboot.=20
>>>>=20
>>>> Ani
>>>=20
>>> Looks like disabling both plug and unplug would also address these need=
s.
>>=20
>> No the driver level solution does not prevent hot plugging of devices bu=
t blocks just hot unplugging. The solution I am proposing tries to do the s=
ame but from the bus/hypervisor level.
>=20
> Why does the driver level solution need to prevent just hot unplugging?

Because it not fair to prevent end users from hot plugging new devices when=
 it is the (accidental?) hot unplugging of existing devices which causes is=
sues.
=20
>=20
>=20
>>=20
>>> --=20
>>> MST


