Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0AFFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7FD21848
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QjAtEk8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7FD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKinT-0000Pl-18
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1iKimY-0008P2-CY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1iKimX-0007yi-37
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:52:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:1810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1iKimW-0007yY-V2
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:52:01 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9GCo2nh024325
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:52:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=KoOGtT0KxkOpOjSZcsMCcRsr2oEb4X5YjIwg5UmHNnU=;
 b=QjAtEk8bl9DbZa9pJINA5CouOeQDl3iiSocJGnleBdUaJ2MvdGZZPtNBqVn9L0R3qbGo
 dz++Y7e468QX7EdS6TlcoqchZXxnwFtXv4Qev2CDii5UzVvHZG8xTpigHFQEBlyWpq9W
 KJHifkJn7pzQWftNf6zZZfcpMnfHKc8EQRcGlVqdnw+F1VzS+/cRDoLUs2wj51EnAFj5
 NxF9PDtHEaMJAquUf0Kv1ZZqlvTMlXOkQdrHPlYWDIS8AsgVGFRB84Cc8yubTCHPIwav
 e6ervGD0/DetO9Ie0oUoQAdKaBWBX3CaLEWalzSFYQ+/DPtjSGcQNvp+JXDBAtODRm2h DQ== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2vkcc90d2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNfB3BkxyDKvJaDWVPqvLCkxrp5wvQnKntK+hBh0hlgFiyypmAx7EQxIqCiBUDHKYqIecVaqnARYNqkKW4yyxUK//u8OpvacIMp3kUVyTEPykTmQYSNPtBBNOLkQqP1zutS6sKDOiLSoZqqPfXDnZhbCYldOpAFircFBHTJr2cjtzh/+auw/cRIb6Ud3rWfxfjneOObGXHEJ5eau9Fs2xXS3zEnvnU86ajoPHaRAoGZWpPsDCgIpaLPrKFTiyP2n/jcqApRDz9MGn6Gwv0IMOzgLJ222GX+m3+Vl7n57n/Umw10c5H+XjxP4fOBn69vMXmu+ihhVCU5lxGmldUIRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoOGtT0KxkOpOjSZcsMCcRsr2oEb4X5YjIwg5UmHNnU=;
 b=TAsNrVhV7dFJb6qPQJ2uEd9SJN+y5SJNS1Rnhdp2DXHRr/GGhMOP1450xViwpmYhR8PL5vC51HiT5rklJUo2eCaVVHg+F48dh05fQmC8BPhE8oI2ipR577GNbi8ldZE6qSUYCeQMwUsdxZSKRyFWpzVy3k6TIckUw6tjm589EhqS717cSbcT4TXOeyOQ7B5VFGTIwo7gtwZ8dY/Xh2SfFDxK936lWHnYcNCpwowQNqPbVOIWs8zZu11J3elkdvdhAWQ4+G283lwvrYvD4Z9tkPsxpxRm+Z5ZBTre+cpHsokzwKl+aAZcbQgx4Qxl63rilgvt7HkF4QIlK96FeY/rhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB5135.namprd02.prod.outlook.com (52.135.99.152) by
 SN6PR02MB4191.namprd02.prod.outlook.com (52.135.70.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 12:51:58 +0000
Received: from SN6PR02MB5135.namprd02.prod.outlook.com
 ([fe80::3522:65f0:16b:52ba]) by SN6PR02MB5135.namprd02.prod.outlook.com
 ([fe80::3522:65f0:16b:52ba%2]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 12:51:58 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Qemu-Devel <qemu-devel@nongnu.org>
Subject: TOPOEXT and CentOs 7 guests
Thread-Topic: TOPOEXT and CentOs 7 guests
Thread-Index: AQHVhCBpN90m/YAKD0uECqPPoY9rEA==
Date: Wed, 16 Oct 2019 12:51:58 +0000
Message-ID: <SN6PR02MB513583C0D0C43777B47910D1F1920@SN6PR02MB5135.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [103.68.105.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93bee125-4994-435d-a11e-08d75237a186
x-ms-traffictypediagnostic: SN6PR02MB4191:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR02MB4191A9C97F8319E750BA5F75F1920@SN6PR02MB4191.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(44832011)(71200400001)(71190400001)(476003)(66066001)(66476007)(66446008)(64756008)(66556008)(76116006)(91956017)(66946007)(486006)(81156014)(478600001)(14454004)(316002)(26005)(25786009)(186003)(966005)(256004)(81166006)(7696005)(6506007)(8676002)(86362001)(6916009)(6436002)(8936002)(5660300002)(74316002)(7736002)(102836004)(6116002)(9686003)(6306002)(305945005)(2906002)(3846002)(33656002)(99286004)(52536014)(55016002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR02MB4191;
 H:SN6PR02MB5135.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0WkUfhZNTexo/A0wPmGKTTx5HQ2GIksXGeB1YDjCCBj4r1eGbqiVsK0by3rRWUDfVXOrqizgYrJJUHrBjvd0C8uIuoqGeCX+baOx5qGNMQTxuaZq67q+L/95XpdFtagUyOiPwqGgsVJHhB6gffiBGyVdthvPbpwa9NIP/2F5n2UTwOzUmVTKfywvFxJh+IZMQWXa6SaKGgYlFPRjLus/JJdLU36mgIiBu33xMGbddRHm0iDzsKfClMlVpnqDz6viWoTjtDOPeKbxlL72ixCmw29ozOK1T0dVOVEgiaq5YMJm0vDXgQT+Ch/jQEP/w/dCzZHpOH6uGnDGkFbdeMbRvJNriUb5SXldr/pDWlt9F1JG4QonrgFrDzHDnNwSoTtrJvpOc7JhWlxFktzWcXbp3l75M2vbRy4QuT8jsCJJuR8TL6ZiASlW7BT9okUuIMY0nEblzkihFD7xTrYG6aRLA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bee125-4994-435d-a11e-08d75237a186
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 12:51:58.1366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmasN9k01lEvX2lqCTLn6Nra2Ly6X+CZAsXEPJ43iCcVEmWd6i0caBRfHBtZOy0Z9yvvlgKilOFKi/3N6HLsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4191
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi :=0A=
=0A=
I am looking at a patch where we disable TOPOEXT when -cpu host or -cpu max=
 is passed to qemu :=0A=
=0A=
if (cpu->max_features) {=0A=
=A0 =A0for (w =3D 0; w < FEATURE_WORDS; w++) {=0A=
=A0 =A0 =A0/* Override only features that weren't set explicitly=0A=
=A0 =A0 =A0 * by the user.=0A=
=A0 =A0 =A0 */=0A=
=A0 =A0 =A0 env->features[w] |=3D=0A=
=A0 =A0 =A0 x86_cpu_get_supported_feature_word(w, cpu->migratable) &=0A=
=A0 =A0 =A0 =A0 =A0~env->user_features[w] & \=0A=
=A0 =A0 =A0 =A0 =A0~feature_word_info[w].no_autoenable_flags;=0A=
=A0 =A0 }=0A=
}=0A=
=0A=
https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01641.html=0A=
=0A=
We are using a setup where we pass =93kvm64=94 as the cpu model along with =
other hypervisor CPIUD capabilities as detected by libvirt to a centOS 7.7 =
guest and the guest is unable to boot. We are using a AMD EPYC platform and=
 we have traced it down to TOPOEXT flag being the offending CPUID from the =
host CPU which is causing the issue. Does it makes sense to not enable this=
 flag by default on all other guest CPU models as well except for EPYC and =
EPTC-IBPB?=0A=
=0A=
Just looking at the code very recently and thought I=92d get an opinion fro=
m the wiser qemu community.=0A=
=0A=
Thanks=0A=
Ani=

