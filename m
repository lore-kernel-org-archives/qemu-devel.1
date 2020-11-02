Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F148AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1FE22275
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="W6nMaKmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1FE22275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZY2l-0001Q7-5L
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kZY1q-0000xG-Q7
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:29:38 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:28514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kZY1n-0001QO-JV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:29:37 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0A2BIPK8013987; Mon, 2 Nov 2020 03:29:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=AjDtG+qQvQRhLnx/EYEQCdhvwLgcXsCzqVnRqQC27GY=;
 b=W6nMaKmnAlBHtzNrnjvA8s1S3WWjsV0Jd5udZx+kdjQ9vBYIyF7fR8e0Xiwg7ECAbJUf
 5dvKWcy8nXdet8WGXd8dSTDE4At9VBjIh1J2mGBO9wuuUmwVWJxxjRrhzefuEJ8m3jJr
 w5bgUf2JOEj8xNu616eAiqD97x+kS/LtP0EiBPv+NY/jedv1m63M+W+4BbPSYLYjfMQe
 oQhfEhfhWey8GK5ec4pI0zi8o79ufLM6P0qjtAKmXmOhzG3rSLkU5zJweKxEHAZIi5A9
 dLNUaK2+6bmXon3xGsb2piTX89b6bdk1qO4esacgkqkHk0pFRKAzCByGCC7gvgJTGByf xQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx0b-002c1b01.pphosted.com with ESMTP id 34h61hk68n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2020 03:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm6971exsWZMheis3YQLM/PzSf7FJSE2wWeklDz20sQTluqYuSt33pbNYXcvSar3KDfrE4J5mEGK+hklj/JTJlfdPztyKfvvwyqK5KxtUGW3cE/8dikrKdMO4FKedTEZvio39mUvGXaDYOZfgsNhKFN2LcriDjgDfQ8CdKRZ2WV7wyLJzQWizReHF9uxsUZiF4vbRLpgh4Qvu180MBTdTxHC4KqS/xi4oPB2879kSPEKeLZESmy5WlRY+HYkLNqfbufTMZGW3tL2pfPoYI80cwF+FLQC2gfeDNyHiaWGi8nZi0hcD6im8EHkHFR+2cVxt0slAKq4s/H2MSXUWQDkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjDtG+qQvQRhLnx/EYEQCdhvwLgcXsCzqVnRqQC27GY=;
 b=SbrO/HYosa0E7W07998APcSuvNoixfp3e52zWsYnHSMw5qyRk5iD/2VfVAZpftmawhoOqryxmj8bdgTjV7GhinsEW4VKXmFJLKZ/IL8B0MNLFVUqTsVTLPo2Ci6jxsk34mRQQrftjYYnb7ujvdCkWVh0YqQbC0XN3oU2SdGxJfsDll4avD3vFpW/b9tABTGEfCEAMHGv6THWJQiZ/okxZHHdbqbRaqmpaDQaVfgJQlNjyGeCataC0poFLl8QrATglVb3YsbR/ynCeEwlbHO0BlyU3fFruo1rQa6cz3fkuHwPDwxp9Z3tCkYhL7mTywSe9qTOXVjvh62egt6RUEW3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by CO6PR02MB7747.namprd02.prod.outlook.com (2603:10b6:303:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 11:29:24 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0%5]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 11:29:24 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: John Levon <levon@movementarian.org>
Subject: RE: [PATCH v5] introduce vfio-user protocol specification
Thread-Topic: [PATCH v5] introduce vfio-user protocol specification
Thread-Index: AQHWrUTVjUvP5pU8VEG/kGG39PR4hqmtNlfQgAMsMQCABFmqAA==
Date: Mon, 2 Nov 2020 11:29:23 +0000
Message-ID: <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
 <20201030170306.GA2544852@li1368-133.members.linode.com>
In-Reply-To: <20201030170306.GA2544852@li1368-133.members.linode.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: movementarian.org; dkim=none (message not signed)
 header.d=none;movementarian.org; dmarc=none action=none
 header.from=nutanix.com;
x-originating-ip: [78.149.9.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28faa1fa-6682-47a6-6cc5-08d87f228ce9
x-ms-traffictypediagnostic: CO6PR02MB7747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR02MB77476A6379A82F68BDF7C7038B100@CO6PR02MB7747.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HEKRwTOUuqiljX66qsguk5HexweWIeYLB4XA6XSbs29MX6KsiMKG+C5NqdLtBv/HWPsagM9rTDBuDl+PhbAvxIdWHGLQ83U0rg422YFpQeLXSINKapveLFZyaXy97X5kw0jJo+YZ35ocIMf1HEyDl2FCJvAy9jBjqoYnFWGunLKPKWzUpNniHRoBKJm6SPkGahxVy/Q+e4/ZbmM0lDC9z2HH8eHQHLtzCCltT4YlmPdofiGsJ3EmiD36rCVWFC7T2pCxfJ543WpOyzdfpvGTSd9Oitkwxv/Dn4jZVU4exrf8luQjNxgn9aXEXzVrv5UAdSK8ZN9aoSAw3gfkvJ0QRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(136003)(39860400002)(346002)(396003)(76116006)(4326008)(66476007)(8936002)(64756008)(66556008)(66446008)(54906003)(66946007)(86362001)(55236004)(186003)(7416002)(316002)(6506007)(53546011)(71200400001)(5660300002)(55016002)(7696005)(2906002)(33656002)(52536014)(6916009)(83380400001)(44832011)(478600001)(8676002)(9686003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: QlprI5/EjLBDeY5ufMKUK4pXjMcSQjQ5bqqfR14CLwoXulOoycwH0daUFjrKtKg9EmRy6VxZtw0jcNRf3Gu3IlCIP8sYqR8g4OtlRpyu+fPiGcJ+YDcow2N79G8qP3MW6ArYJz6WTB/YCYCtrrS6zcnyaKcTW36fMj0lDr0tbP9yvdHGApaft9XlaIdvZhNVTfn6WRsrrOovbG0L6g0ntJpKkzA2YWJgT1pBvtbo5O5WL09xdPIKx1nQQIyS1hIkeyIKqIbRoMIzVyrPIn0LRCjdBH0+DXIYeqGoh8Zms5HYaW5hpkSQl80pvVrv9PLkznZg4QvJs0zQECL//xUo7Wu+CJ+udZd/8USMAs7Vb2qY+beELG2zA6/1U4KE8h4A7xU78FKYto1j01Bnm7j0wGmfQE3vLo0OlB4CFfXI1YRSOLxnw/1qzC5DA6F/7wYWGa/aHbSW+u1NzP64tO1SiglYQMQe/tRrmu0j5Ua47iCxr1s8QhDoRGKpEZAM9WJB9hKbI+B12ZajgEp1MnqwtxdBe2x6oBo2uf1Z9DgBtW3rukMHe3Qewps8mu6HVz18ioa1IVvKgb+fACEFVyJn249nqGDThSmssbAPYXp1qUQjhTxKMCG+B743PZO4erWfpT4bEerBUBj/2BJMuX1K+w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3723.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28faa1fa-6682-47a6-6cc5-08d87f228ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 11:29:24.0250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geLzFEuf4rRnmp9anFSn1p3nz7LG3vdBdJcBqu6GT54PVDUyv5s7C9C4nsC6f2yi33Jh/9kRsWvay0Fqh61c0Ctk0bFJ3gJhN+qx2BGMOaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7747
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-02_03:2020-11-02,
 2020-11-02 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 06:29:32
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: John Levon <levon@movementarian.org>
> Sent: 30 October 2020 17:03
> To: Thanos Makatos <thanos.makatos@nutanix.com>
> Cc: qemu-devel@nongnu.org; benjamin.walker@intel.com; Elena Ufimtseva
> <elena.ufimtseva@oracle.com>; tomassetti.andrea@gmail.com;
> john.g.johnson@oracle.com; jag.raman@oracle.com; Swapnil Ingle
> <swapnil.ingle@nutanix.com>; james.r.harris@intel.com;
> konrad.wilk@oracle.com; yuvalkashtan@gmail.com; dgilbert@redhat.com;
> Raphael Norwitz <raphael.norwitz@nutanix.com>; ismael@linux.com;
> alex.williamson@redhat.com; Kanth.Ghatraju@oracle.com; Stefan Hajnoczi
> <stefanha@redhat.com>; Felipe Franciosi <felipe@nutanix.com>;
> xiuchun.lu@intel.com; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; tina.zhang@intel.com;
> changpeng.liu@intel.com
> Subject: Re: [PATCH v5] introduce vfio-user protocol specification
>=20
> On Wed, Oct 28, 2020 at 04:41:31PM +0000, Thanos Makatos wrote:
>=20
> > FYI here's v5 of the vfio-user protocol, my --cc in git send-email got =
messed
> up somehow
>=20
> Hi Thanos, this looks great, I just had some minor questions below.
>=20
> > Command Concurrency
> > -------------------
> > A client may pipeline multiple commands without waiting for previous
> command
> > replies.  The server will process commands in the order they are receiv=
ed.
> > A consequence of this is if a client issues a command with the *No_repl=
y*
> bit,
> > then subseqently issues a command without *No_reply*, the older
> command will
> > have been processed before the reply to the younger command is sent by
> the
> > server.  The client must be aware of the device's capability to process
> concurrent
> > commands if pipelining is used.  For example, pipelining allows multipl=
e
> client
> > threads to concurently access device memory; the client must ensure
> these acceses
> > obey device semantics.
> >
> > An example is a frame buffer device, where the device may allow
> concurrent access
> > to different areas of video memory, but may have indeterminate behavior
> if concurrent
> > acceses are performed to command or status registers.
>=20
> Is it valid for an unrelated server->client message to appear in between =
a
> client->server request/reply, or not? And vice versa? Either way, seems
> useful
> for the spec to say.

Yes, it's valid. I don't see a reason why it shouldn't. I'll update the tex=
t to
make it explicit.

>=20
> > |                | +-----+------------+ |
> > |                | | Bit | Definition | |
> > |                | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+ |
> > |                | | 0-3 | Type       | |
> > |                | +-----+------------+ |
> > |                | | 4   | No_reply   | |
> > |                | +-----+------------+ |
> > |                | | 5   | Error      | |
> > |                | +-----+------------+ |
> > +----------------+--------+-------------+
> > | Error          | 12     | 4           |
> > +----------------+--------+-------------+
> >
> > * *Message ID* identifies the message, and is echoed in the command's
> reply message.
>=20
> Is it valid to re-use an ID? When/when not?

Yes, it's valid to re-use an ID. I suppose it's also valid, though should b=
e
discouraged, to have multiple outstanding requests with the same ID, even t=
hough
that probably doesn't make much sense and will most likely break things. Th=
e ID
belongs purely to whomever sends the request, the receiver simply echoes it
back in the response and must make no assumptions about its uniqueness. I t=
hink
it's simpler to have it this way, otherwise implementations might start abu=
sing
it or rely on it too much. If there's no objection to these semantics I'll
update the text to clarify.


>=20
> >   * *Error* in a reply message indicates the command being acknowledged
> had
> >     an error. In this case, the *Error* field will be valid.
> >
> > * *Error* in a reply message is a UNIX errno value. It is reserved in a
> command message.
>=20
> I'm not quite following why we need a bit flag and an error field. Do you
> anticipate a failure, but with errno=3D=3D0?

Indeed, the Error bit seems redundant. John, is there a reason why we need =
the
error bit?

>=20
> > VFIO_USER_VERSION
> > -----------------
> >
> > +--------------+------------------------+
> > | Message size | 16 + version length    |
>=20
> Terminating NUL included?

Good point, in the current libmuser implementation we do include the termin=
ating
NUL, however it's not necessary. I don't have a strong opinion on this one,=
 I'll
update the text to include the terminating NUL just to be correct for now,
however if there's a good argument for/against it we should definitely cons=
ider
it.

>=20
> > +--------------+--------+----------------------------------------------=
-----+
> > | Name         | Type   | Description                                  =
     |
> >
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > | version      | object | ``{"major": <number>, "minor": <number>}``   =
     |
> > |              |        |                                              =
     |
> > |              |        | Version supported by the sender, e.g. "0.1". =
     |
>=20
> It seems quite unlikely but this should specify it's strings not floating=
 point
> values maybe?
>=20
> Definitely applies to max_fds too.


major and minor are JSON numbers and specifically integers. The rationale
behind this is to simplify parsing. Is specifying that major/minor/max_fds
should be an interger sufficient to clear any vagueness here?


>=20
> > Common capabilities:
> >
> > +---------------+------------------------------------------------------=
------+
> > | Name          | Description                                          =
      |
> >
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > | ``max_fds``   | Maximum number of file descriptors that can be receiv=
ed
> by |
> > |               | the sender. Optional.                                =
      |
>=20
> Could specify the meaning when absent?

Good point. I suppose the receiver must assume max_fds=3D1 if it's missing.

>=20
> By array I presume you mean associative array i.e. an Object. Does the wh=
ole
> thing look like this:
>=20
>  {
>    "major": ..
>    "minor": ..
>    "capabilities": {
>       "max_fds": ..,
>       "migration
>    }
>  }
>=20
> or something else?

Yes, it's an associative array, and you're correct in your example. I'll up=
date
the text.

>=20
> > Versioning and Feature Support
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Upon accepting a connection, the server must send a VFIO_USER_VERSION
> message
> > proposing a protocol version and a set of capabilities. The client comp=
ares
> > these with the versions and capabilities it supports and sends a
> > VFIO_USER_VERSION reply according to the following rules.
>=20
> I'm curious if there was a specific reason it's this way around, when it =
seems
> more natural for the client to propose first, and the server to reply?

I'm not aware of any specific reason.

>=20
> > VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP
> > -----------------------------------------
>=20
> Huge nit, but why are these DMA_*MAP when vfio uses *MAP_DMA ?

We discussed this with John privately but I don't have the details, John do
you remember why we decided to name it like that?

>=20
> > VFIO bitmap format
> > * *size* the size for the bitmap, in bytes.
>=20
> Should this clarify it does *not* include the bitmap header in its size, =
unlike
> other size fields?

Yes, definitely, I'll update the text.

>=20
> > VFIO_USER_DMA_MAP
> > """""""""""""""""
> > If a DMA region being added can be directly mapped by the server, an ar=
ray
> of
> > file descriptors must be sent as part of the message meta-data. Each re=
gion
> > entry must have a corresponding file descriptor.
>=20
> "Each mappable region entry" ?

OK.

>=20
> > descriptors must be passed as SCM_RIGHTS type ancillary data. Otherwise=
,
> if a
> > DMA region cannot be directly mapped by the server, it can be accessed =
by
> the
> > server using VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE
> messages, explained in
> > `Read and Write Operations`_. A command to map over an existing region
> must be
> > failed by the server with ``EEXIST`` set in error field in the reply.
> >
> > VFIO_USER_DMA_UNMAP
> > """""""""""""""""""
> > Upon receiving a VFIO_USER_DMA_UNMAP command, if the file
> descriptor is mapped
> > then the server must release all references to that DMA region before
> replying,
> > which includes potentially in flight DMA transactions. Removing a porti=
on of
> a
> > DMA region is possible. If the
> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP bit is set
> > in the request, the server must append to the header the ``struct
> vfio_bitmap``
> > received in the command, followed by the bitmap. Thus, the message size
> the
> > client should is expect is the size of the header plus the size of
> > ``struct vfio_bitmap`` plus ``vfio_bitmap.size`` bytes. Each bit in the=
 bitmap
> > represents one page of size ``vfio_bitmap.pgsize``.
>=20
> I'm finding this makes the sizing a bit confusing between map and unmap,
> could
> we may be separate them out, and always define a vfio_bitmap slot for
> unmap?

We can separate them.

Regarding always defining a vfio_bitmap slot for unmap, we need to consider=
 the
case when a vIOMMU is used, where map/unmap messages will be extremely freq=
uent.
If VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is not used then the vfio_bitmap sl=
ot
will be unused, so some bytes will be wasted. If this doesn't really affect
performance then I suppose we can always including it.
=20
>=20
> Also, shouldn't the client expect sizeof (header) +
> (nr_table_entries_in_request
> * (each vfio_bitmap's size))  in the server's response?
>=20
> Does the reply header size field reflect this?

Correct, I'll update the text.


>=20
> > VFIO_USER_DMA_WRITE
> > -------------------
> >
> > This command message is sent from the server to the client to write to
> server
> > memory.
>=20
> "write to client memory"?
>=20
> > VFIO_USER_DIRY_PAGES
>=20
> Nit, "DIRTY"

Correct in both cases, I'll update the text.

>=20
> thanks
> john

