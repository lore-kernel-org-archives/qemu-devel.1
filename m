Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FB3C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99E4246A7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="T+7sxXHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99E4246A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXiNY-0006L3-P9
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kXiMv-0005vW-KW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:07:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:50820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kXiMr-0008An-HX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:07:48 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09S9vqgv029015; Wed, 28 Oct 2020 03:07:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=crJcYz8adUqu00EbYlmfbHIWAUaeD4MaTxdD+A9BXaM=;
 b=T+7sxXHVi29HwN9ijjM/7qpNvrd2zZjfOFVzESYLo5rrDkPYJF6+TNyx94WLrfA5Ycwy
 Kjpm2rOw8sHwtKen05v+ulDR9ohMcnW5IMKF438G4VlJFecfV9KpEtrA5myjhfg5+DrF
 RsKFWH5qqfs0RU3xWD0MJNaJIMgN/iOY8bPXuw0rFQnJ6+E6JF1p0iiF5sS/toTrv3+j
 NObbStXv0i9yELmhDvL3PhHqsgLAFbn7TntL+1i6gwWA3MBnT42fOmV9Yz/DraW8varU
 y6EMhutdQVt+xRTVt6gSAbyRliAXTCzXJrMA1POJQyQObBDznwBOD4tt0xhbwquHsWx1 mQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-002c1b01.pphosted.com with ESMTP id 34cg678ar3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 03:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRc53z5NPTvpb5lxFxiXUzWs20j8YwXWgyzlOmGIkCJ/qZd3Y0HVMcw2phcmMKyGI+Gl7+HeK7RTSD7UQtayYziGcMku2bXAkjImSEHqnrYuKysUnWOtY+nJ39Jrmal3VS5TNsSnOon6m6kegf9JywORQHNr7BH1dzQdknSnqVkMiJ8MUBu6w8OIl1bHghqVDo+TtguV63OlRp+SceIzTbeb5UPSs85VSM5SERLxLonOL5G66EPrjTsTUjJOd8f9aFBEC0kLYkeLWzU+BVN6WlxewBIqb7Bosu//b4DqYfrsOAMBJQaq0kvXJIA9Q6HkV/6nVvjTuRCHcZe+Sc7LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crJcYz8adUqu00EbYlmfbHIWAUaeD4MaTxdD+A9BXaM=;
 b=EatODBesuT2vRRldORrJC/FfWddtYEYvaWrX8peSheINWJIjSIF/XbDhvgcnN1KRmbkSlAdyzbraX9MGVRfi+AmiRZGRrsM7gwYm0gDkOCimkuEnQJrEGWXgrh5Pb63j+8Mg3EJfIWyWXboKvpRqzNoNnMX1KVi6MUG59KW7YLOAD5GfA1knYSaL3c5G5rjgr7wqerQ6K/hDN/ZW5FhLanSSAiejTJxiIzLJNcBcK1a6TbFQihbjH1MP3oMCTjsnLzxy6CtJb94KnGMB9dBZQVnom8EbEdSPrgOyKVle1IAIPJ29AEtquLTPZA9uy97tRUQ6TdVC85hpwX1P3cAFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 28 Oct
 2020 10:07:30 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 10:07:30 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: Out-of-Process Device Emulation session at KVM Forum 2020
Thread-Topic: Out-of-Process Device Emulation session at KVM Forum 2020
Thread-Index: AQHWrHPc6iSycZlvN0m0r0GCbG+HcamsvrSQgAAMavA=
Date: Wed, 28 Oct 2020 10:07:29 +0000
Message-ID: <MW2PR02MB37236F19438C743E4BC63A8B8B170@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <MW2PR02MB3723F97DA47F8747CB92E4418B170@MW2PR02MB3723.namprd02.prod.outlook.com>
In-Reply-To: <MW2PR02MB3723F97DA47F8747CB92E4418B170@MW2PR02MB3723.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [78.149.9.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d09dabf3-73f3-4762-0bce-08d87b2947cc
x-ms-traffictypediagnostic: MW2PR02MB3723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR02MB372353545000F7D4927B9C368B170@MW2PR02MB3723.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAnA4eCDgfMVSHgxXAbfNl12K0r6+E96PA8r0Rcwymzt1IK8E6DGG6+MDVQlFgUt7mksiAKAiBbOR/tRQ7ogkya5UN+cTm95iT7WhMOr7urSutD+slmo5Evs9lQ0xqr2NzAULE5kzDT3o/0GRDzgTo8qSJTta+TT9p9nP47Tc2bWMWWf2y0j8RU7m5NBlQGWGGzBsqw3NjEwvqQngi3l/o0l+dKkvdROZ7OO331SWQk6UNIX4eHcvH7QcO/zqo7BL6VYPu2zyJVjxx0m+Sm0L3N++dYgTBjgF91jtGjdeEjYrBwdBxVygXeTOkzqFsRYo/EvPY6DlHZ24ejfSM9fbaw9YL12kvp2tEQ1nCc4UKNaKFgReJJ+Kc8nxcExVl0llDFhHUAqhv01vyqOIrvgjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(346002)(39860400002)(396003)(376002)(64756008)(4326008)(44832011)(66556008)(2940100002)(2906002)(86362001)(6506007)(26005)(55236004)(53546011)(7696005)(76116006)(66476007)(5660300002)(7416002)(186003)(9686003)(83380400001)(478600001)(52536014)(316002)(71200400001)(33656002)(66946007)(8676002)(55016002)(54906003)(110136005)(19627235002)(66446008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8/y0PYR5/ympsR36MWdLHupQNSTqKXQiO8JqGcHPzDBAWhaqJS0lLILTe8UEu60IqAqqoXZH9O5Q6yGBRp7UDj7WyDGLhUlhtiGI9bSy0UzVZP22D8UU+fiH6L+wTF0RJpAaE93zoTslKLlxLJkrnwoA0cdhnR+/OIIqWt1TXOOQZCBkhudaydZ0kd+MhCgd8MCfr6qxY5RBfmAdWPteBUwocpvjJ/dUl7oTDHLAKEu6vKhz8QaiHbrINGxw9HINgiFHznTggqkwBHehqeRSDuKUDV9xzFWZBau/m6UN6p8Kl6y3RMzItElhEcg20rakCt8xeCPzgXlBlHsPRVf8ntPjwCBZDLhFupUWP8dD9EJ3mUagI7K4K9igmbPNpBm6M4gIV6ZwybkY4lT29ROl8fN9nsPwp6JuylryH4sjM14EQ5aiC5ODwy+2nx8txjaypyoXuOvyxSpwIfZ8Sl4+ujxTX85ZCmvPL0CpNGX8E1ml70ckRGI1hRZgYtTNlTPVFLELi7CCLabNrDZ4591J7L6KT+qQjjYIhy86o7feKeYHeKuoH7OwcItxLgsSYmKl6D+6OgBuImsQC5ulQL/Ftegq6j5NLpZmEVzukpcoMvzBxWmU3PFPAD0XsKqwyqaClPAoUyL3OQ2Dt2fX7SAl6Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3723.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09dabf3-73f3-4762-0bce-08d87b2947cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 10:07:30.0116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZX88lNvMqRj4fr9TM8CGuFJZOW+/DxojkkNMg66C5Soey8cxMVwgKW2RfOr3MHeW/d90AiDORGT4FhP/TCe+Q8l+rX8GzeQwDhsQlzd6mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3723
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-28_04:2020-10-26,
 2020-10-28 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 06:07:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "slp@redhat.com" <slp@redhat.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+thanos.makatos=3Dnutanix.com@nongnu.org> On Behalf Of Thanos
> Makatos
> Sent: 28 October 2020 09:32
> To: Stefan Hajnoczi <stefanha@redhat.com>; qemu-devel@nongnu.org
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>;
> john.g.johnson@oracle.com; mst@redhat.com <mtsirkin@redhat.com>;
> jag.raman@oracle.com; slp@redhat.com; kraxel@redhat.com; Felipe
> Franciosi <felipe@nutanix.com>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Alex Benn=E9e <alex.bennee@linaro.org>;
> David Gibson <david@gibson.dropbear.id.au>
> Subject: RE: Out-of-Process Device Emulation session at KVM Forum 2020
>=20
> > -----Original Message-----
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: 27 October 2020 15:14
> > To: qemu-devel@nongnu.org
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>; mst@redhat.com
> > <mtsirkin@redhat.com>; john.g.johnson@oracle.com; Elena Ufimtseva
> > <elena.ufimtseva@oracle.com>; kraxel@redhat.com;
> > jag.raman@oracle.com; Thanos Makatos <thanos.makatos@nutanix.com>;
> > Felipe Franciosi <felipe@nutanix.com>; Marc-Andr=E9 Lureau
> > <marcandre.lureau@redhat.com>; slp@redhat.com; David Gibson
> > <david@gibson.dropbear.id.au>
> > Subject: Out-of-Process Device Emulation session at KVM Forum 2020
> >
> > There will be a birds-of-a-feather session at KVM Forum, a chance for
> > us to get together and discuss Out-of-Process Device Emulation.
> >
> > Please send suggestions for the agenda!
> >
> > These sessions are a good opportunity to reach agreement on topics that
> > are hard to discuss via mailing lists.
> >
> > Ideas:
> >  * How will we decide that the protocol is stable? Can third-party
> >    applications like DPDK/SPDK use the protocol in the meantime?
> >  * QEMU build system requirements: how to configure and build device
> >    emulator binaries?
> >  * Common sandboxing solution shared between C and Rust-based
> binaries?
> >    minijail (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_google_minijail-29-
> 3F&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6ogtti46a
> tk736SI4vgsJiUKIyDE&m=3DhPc4ln1oFnCIYCRna-
> C027BO06__al6zPJhAs0_KcP8&s=3DdqqLRGO3GvV4gAEqkMXzbhm5TtOHqLGQ
> d_0SBlzubp0&e=3D  bubblewrap
> >    (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_containers_bubblewrap-29-
> 3F&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6ogtti46a
> tk736SI4vgsJiUKIyDE&m=3DhPc4ln1oFnCIYCRna-
> C027BO06__al6zPJhAs0_KcP8&s=3DRnd-
> 6YVz2xrg0Vrm6ukannwt3kmbQ8L7upVLrEc227g&e=3D  systemd-run?
> >
> > Stefan
>=20
> Here are a couple of issues we'd also like to talk about:
>=20
> Fast switching from polling to interrupt-based notifications: when a sing=
le
> process is emulating multiple devices then it might be more efficient to =
poll
> instead of relying on interrupts for notifications. However, during perio=
ds
> when
> the guests are mostly idle, polling might unnecessary, so we'd like to be=
 able
> switch to interrupt-based notifications at a low cost.

Correction: there are no interrupts involved here, just guest to device not=
ifications.

>=20
> Device throttling during live migration: a device can easily dirty huge a=
mounts
> of guest RAM which results in live migration taking too long or making it=
 hard
> to estimate progress. Ideally, we'd like to be able to instruct an out-of=
-
> process
> device emulator to make sure it won't dirty too many guest pages during a
> specified window of time.


