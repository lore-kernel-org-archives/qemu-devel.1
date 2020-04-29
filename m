Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCBDC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083DB206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Fp9SmWge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083DB206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfmf-00013z-7R
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTfld-0008Gj-H1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTflc-0007Ud-CW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:00:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:13436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTflb-0007JV-MB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:00:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T5w1SL017590; Tue, 28 Apr 2020 23:00:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Vp4/WjGwt0SIJavZveBE8GLr0nMFwIBmGTmPkahIPbc=;
 b=Fp9SmWgey0SXGCtbRQ6l79126+GQq7Paq3sIL/YopGLyqQzJM6jQP36rwErTZi/PA8Bw
 HksTZuayYedOXSs5emBUxVz5Bb3pL9gl7+EIVT4bLzwwskJjocRM4JcNEpMGeHFyVKAC
 B0A91Me5lYJMnmX7VqAdiEkBKLBBb9FuBvlLxCn1DZHpZRoLs3GQkThR/8BddibycHVS
 ZTp3ALabNY86W30t7rQKz5RB+R3kPC/FfUcWkShXwuwT3ah6CHwPQsHqjWtTz1f5NuE4
 w3FB/NVTljSbnDuKQul+ABpKkq8V3jGUcpATapFzgNJalCJ/LbbKrxLrOb+GNN8jZsW8 Vw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30nhn9nuew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2020 23:00:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwON5aj8lI5YSSPyUOj5w80fleXmVwFiFJwcION0F12nMrl5L0YNBi3qQZqJPm14Tfnhcmzx28LSy+yaappKriON3BX+qkRMIOpVlSAd7bODRWTXGJJgcyaITpyBKefnYf5nbO7j6d/i1Jcbl38PCIn0i3gqWTyP0N/imVzcupPHJhV65UVdayZUFs+4iTYbeTFesAg1XO78P/xZWKdQtAwqb/v0P0vUbYYoTgxaOHC9n2a2+DfTRescppSFi4ZuNgkQfCGGfoqacX+B7VpfNcknIhN6M5T3GM7LPra+Rk8+Kxk+vh2sWmWpgSoQUDhpzP8t1mZ1QWh8QO7hciQqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp4/WjGwt0SIJavZveBE8GLr0nMFwIBmGTmPkahIPbc=;
 b=OI5+hOZgaX9kTq5q5m5qYjt0u0Aywl1uuaBOBC55SKvnqVjGwR2icxd9FSCKxZbAftqHW4EL86l08vJl2wGL/5tcQc4pFFFOLeni//Op5FtA1tO524vBLt78iPD5Mwr7Ep3pD4X+bg3yfT0ojlsMe+aUfyWA71khNk8GTxRsa516x8rFzQRVPKdMw94QIfDNfm3Cf0cCkarewvINeqyoj4i4hh7W+SDmfROnL4fCglzb1Z5iP3/VdKIsTEwnqzEvql8KEY8a3gLCfkODHBucfjFD9RfGjDS1v/8l/I2ykjLZnb/39hdEO0N+otTE+/MFCij+Fpvdidj4hTvCWxYQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6365.namprd02.prod.outlook.com (2603:10b6:208:1bf::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 06:00:00 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 05:59:59 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAI5YA=
Date: Wed, 29 Apr 2020 05:59:59 +0000
Message-ID: <5AD9B19D-EACA-4111-BB5B-78F8378AE93D@nutanix.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429011228-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa3bdc85-7e93-4fa9-e1fb-08d7ec028d39
x-ms-traffictypediagnostic: MN2PR02MB6365:
x-microsoft-antispam-prvs: <MN2PR02MB636598A5D35AA0F28ABCBC18F1AD0@MN2PR02MB6365.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 03883BD916
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1T77ZrywZq0jidUEUf1fr2LgFIruBnvnbJFAPbGMU5nvqUKFKRO2mcmpPijYFAo+iU7oaoixm9ITA0HBpghj3CZOnCppFlf6O4iXZxTUiybQ5mNudzRsn9vr0hO02RHo8mcB4KqlAKNAazxbFqW3wV03GZ9DGlXxVIA1wdT+NmRG8iKpAY82x+9GB4/alH1/gzgazgCElzu2RUtG0duGKxQLUfkNa7YY9T30ylFgkTWGYhb69Ea6x3bJCCQYMwxhbTc1Af0ohAkRaQVGJ78bvEXE8VmehcAZ6TU515z0lv1Hp8x/8GDVsaDFsgfv1r1EVFEmRZq/Lk6MAoDiMeKImyMYf7jsmufSn3MreceUbbKGcO7ihKc6NzQVJpFydWJV6XKKedQL31/BnSHv8IJtpJP05H70rQSof9db2HFX5Nk8/1e/tdlc8a+aSX5Ohjo4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39840400004)(396003)(376002)(136003)(366004)(346002)(76116006)(8936002)(91956017)(66946007)(5660300002)(36756003)(6916009)(2906002)(478600001)(8676002)(33656002)(86362001)(6512007)(6486002)(7416002)(4326008)(71200400001)(186003)(26005)(53546011)(6506007)(44832011)(66446008)(316002)(64756008)(54906003)(2616005)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4rMmzbEGF1JwrmlvqHv6c4i30YofPP2LV6ncqQFUn/rxlC1DZEL8T+RUPXFISTgS6FdpWpO9mKg0ZzdKR+lTof5N1yND8hM+Jv5/QC9i+3196acLfaFb3eOJUU1ysdwdW5UkHpeM6wYciZhZ+fOrXliLBXDmUmT6UQufAmZ7cH5E2X9UBEXu8puHcbx9SWiXjgNsPSoJt2mnsZ1i5PqSuUS+uLEH5BwW7fTZZvKspdGNgQBsl7ymJmibU0Mb2+OwFtwMBkBibQK/MRcEZ76tcqEQ0cTfBSe+o+aVidWCVZFiJIQUjy8V7MpV4XAzPrl1fjb+BKZZafQXxbx5rgUjTd9wG/ZYOgunMF+uDOXuaMWAJCc6HPceyKL8WCs/NhYeGJTQpZJxqnkcO22M6fBroDvArsaZbQy7Cmk+8GqrwVdB6cWDIvxl4IoTM4bKXiOXXzn3vylkOuFWBLSxgEhi8L5p08ttNrzf7GkOY6vsW2sGvtFEKGI/OM+Ybn/wqggE5NIFKLczlQ/mtAYNRkdKNyL415QBPPWBbADjtzA+qDW9jhHykQx9GhPeL9CNnhGzfSK5Ec1qju9n+ISN+YARvPBvdccARFKVM2pugk4/tcKKFQXGC2a4+njagNvvsIVUgUMtnmFJdq2e0s3yC/qHuw5ZFfDk0d59BOJT/BUYKf8YTEWqisCqprLGd/85+Uv1aQtisu1hesfuyPSSs/KtxcWI7yGRjOejhDh9UwqPthYPcNwF0JQWXsZTx622vO5I72y6TLBhNDhdO5yqRMH51+TKFafzt3Vwb0N0kWA2ms8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B0EB26D19D2D6647A37B3EB0944EC978@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3bdc85-7e93-4fa9-e1fb-08d7ec028d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 05:59:59.8835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YR+vrX8OpoYIEVaTr+JXcAYiRrggud7do2o/n8y869OX462o6TRQw0+NZpbyofANNriBRWvPngHbT0i25C3/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6365
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_01:2020-04-28,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:00:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> For example, how about hot-plugging a bridge which doesn't
> support hotplug itself?

So now for every device we want to hot plug, we will add a new bridge? Soun=
ds not a scalable and elegant idea.

> Would that happen to make windows
> do what you want, for both PCI and PCIE? We don't support
> hotplugging bridges with devices behind them ATM, but
> that sounds like a useful option.
>=20
>=20
> Also, pcie root ports recently gained ability to disable hotplug, see
> 	commit 530a0963184e57e71a5b538e9161f115df533e96
> 	Author: Julia Suvorova <jusual@redhat.com>
> 	Date:   Wed Feb 26 18:46:07 2020 +0100
>=20
> 	    pcie_root_port: Add hotplug disabling option
>=20
> adding this to pci and pcie bridges sounds very reasonable.

This patch uses PCIE native hot plug capability to turn on or turn off per =
slot hot plug option. This does not enable hot unplugging while allowing de=
vices to be hot plugged on a PCIE port. Besides, PCI-PCI bridges already ha=
ve an option to disable hot plug capability for all the slots of that bridg=
e. My patch follows that approach.


