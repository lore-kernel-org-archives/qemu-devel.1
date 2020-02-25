Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969FEC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB4D21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="wbRnbXOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB4D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WM3-0002zI-JX
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1j6WL8-0001wC-Oo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1j6WL5-0003w5-Vv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:17:17 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:59768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1j6WL5-0003vD-Cj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:17:15 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01P9Alcd020434; Tue, 25 Feb 2020 01:16:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=n1JH8WoNJkF85mn6v+ZeTrc0nHlW4HQWDybksjAMlAk=;
 b=wbRnbXOoJfQr0SwlPLpllWEUZOqvBo9Hzvd/sZXTPuLgtQIPNIXm+nbV0FlpvacbwQgW
 DbwN+TxSdHX7PKktOOB3+eV/QiKKdWyokOb6LzrCM7ZfnM1DlMy05FUptYHEXuMPg3Pa
 8QcM2Vl0XXmk/Qk5Y4eO+/W1noGvJq1I60u1VDeDSVk8ajVc0ByMBXrhNhQq6TmFWdvY
 bbXAjocjzacwBPaXoynxXi7kSyLeXDXzDFhTJlJh8w8E4DDrKtNobj9Tw6av8AqjnuSp
 IdMevmtpGgSTagcMIKGVdFcpm1+fQmhzYPdF3SaxxjSWDDby1eM8Fw12dIL+/IJHBphN fQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2yb2qedvgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2020 01:16:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU8pK3hIiLirLiaJ3PCiSpGrhExJLy1rbT3zG/9FX/D4fz1XI1wL7gZA7bAMfOqx/THIGpB4FdT+SCjiDZi+MNYO7Ps+rijWRQ5nOoCKAHOWKNEU31qIlBt6IoQ5DonG5Ky1jg93RzbE2fGC7Rk/XtzjoS+1roqWo47Dyu9W2ILHSCqNqizMEw+1Xc8vDeLSelAbahvv31MfjyPHZXGbtBr2ArHl/Vx5JsumheUbtzalZW2oPYrYBAHfnHVm+IPZam7wiqXa2IeDFBvBFmBxczOQB/wm/rwyI2pS9UythrftObcwvZsUAtVxhBKeXLqVDKECiTiJrnNbDOCHIT18aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1JH8WoNJkF85mn6v+ZeTrc0nHlW4HQWDybksjAMlAk=;
 b=izbbo/+yS7YoWAsRJcY9wbOSN/9907145d3Nz61eJTjOgipzbznLz+v4SjK20YpI6CD6h/YfdtEICKu+NjivjSr750a+DilMaOU6V/xyJrGmoNTrjYRX1JAP85twuplrxS7/7NWgG48cA686Tg7rgFLiNYH7Xb6WAtuqCzaUwFdh90S3Z17cqQaZyUqFijEcuGXkJ8vjO1NxqIEsJ9K+Cl9CK9GWHqxKn8XXqfIWUn5vYqFASo/hGWTQWwpBieUPnFoO+sg/9PZKMDX3aqORmlqdrCcLOu+JRZ8wFZ0iK129QeRA3Ey7Hoea4d+O++Mw7RHJSO5+IWK2/hJArH2AXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (2603:10b6:208:1bf::17)
 by MN2PR02MB6366.namprd02.prod.outlook.com (2603:10b6:208:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 09:16:46 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 09:16:45 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Alex Williamson <alex.williamson@redhat.com>, Felipe Franciosi
 <felipe@nutanix.com>
Subject: RE: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Topic: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Index: AQHVryXIg/uKp1+E6Uq+iMIQmMM9NKe35WUAgAVPdACAAAL2AIABWUMAgABrS4CAAmvVgIAACnqAgAAGGACAAV3YAIAAAQkAgABJqYCAABPwAIBo5G+w
Date: Tue, 25 Feb 2020 09:16:44 +0000
Message-ID: <MN2PR02MB62051138ADD8C35156229EAC8BED0@MN2PR02MB6205.namprd02.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 5e014110-580c-4031-4af6-08d7b9d36f83
x-ms-traffictypediagnostic: MN2PR02MB6366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6366FE6AA2DCAA8667E8A4D68BED0@MN2PR02MB6366.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(39860400002)(346002)(396003)(189003)(199004)(316002)(66446008)(33656002)(86362001)(4326008)(66476007)(66946007)(54906003)(110136005)(64756008)(2906002)(66556008)(76116006)(71200400001)(478600001)(7416002)(26005)(9686003)(7696005)(44832011)(81156014)(8936002)(55016002)(8676002)(52536014)(4744005)(6506007)(186003)(81166006)(5660300002)(6636002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6366;
 H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tWduPH0J+gR93P8NbVNHRJ7Iy7jPQMC9XkBxIie6wASacCzw1x/nYdOsOaG8dPaxHNpVI3mOwxb9lKsxixsLOLALzINafmmb4dinkg89YAUeipHBdkNF8kq1VprrVfgFyk3qLmdboDMYkJ+GwOcSotXt/aC+x1S/1hh8fHhlT9CMW1JPv/l2xJ7kvE2dayDmKhPt+RCceLcrKvLz464CS2gRySlmLgCp4Z2v29ixhiPVh3FTkbKH11Ybbvap+3HWZs6C4YTF+K0cxA8RQwcy05TaDDfFxcXfTWKP6ZEfIu9WbgTrj2dZPRQJQ5oj3em4ZvtkedRfBYQyT3JEvtfdyDz+dQnvkALzfTpHONmoDrOxj8ec51IRXq4NzX8mfu+0p5ohiqBAIitB/GQvCrHqFSiOiwYYyw5hICzHYLFLsh2TmvOXUru9VRALNiebaisn5fwysJJGj9m6jPotiT4k4w2VTO8N7vLVDlEkVqGIwkKfzVbO8ptBRKiKwn06NzMrF69YO/CfU5yg0HCtiALwQ==
x-ms-exchange-antispam-messagedata: Rm/n9jwUFy87OAz2LDRS8zfICr6xdcw4ryfBjmnVsWZXhGwAemu0bK2AuXh7/he/xlYh+cB5MqpuW91R/fDE5CIlv7UUdBX4l6L++PuJB/IFKdNTr+qQJjUE+RZ/JgXpWxrq3dRiSBUJ62llLTGH4g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e014110-580c-4031-4af6-08d7b9d36f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 09:16:45.3109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 228Y7l+Xomni/jHbBQ8afQBW3LK79dfgQjYBhO0k8bT1HAY2VUNxLEJWUr+9YNFfa0uZGnyIUohuJGXY2D+QI95vM7IaALF0LCYoTXRKsO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_02:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > 3) Muser.ko pins the pages (in get_dma_map(), called from below)
> > (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_nutanix_muser_blob_master_kmod_muser.c-
> 23L711&d=3DDwICAg&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6ogtt
> i46atk736SI4vgsJiUKIyDE&m=3DC8rTp4SZoy4YNcZWntiROp3otxCyKbLoQXBw8O
> SB0TM&s=3DG2JfW1GcVNc_iph7C4hE285sTZM8JrR4dYXgmcyAZPE&e=3D )
>=20
> Yikes, it pins every page??  vfio_pin_pages() intends for the vendor
> driver to be much smarter than this :-\  Thanks,

We no longer have to pin pages at all. Instead we grab the fd backing the V=
MA
and inject it in libmuser, and then request it to mmap that file. This also
solves a few other problems and is far simpler to implement.

