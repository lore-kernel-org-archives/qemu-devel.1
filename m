Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40583C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A8420729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="PeQN5t+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A8420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyD9k-0007b9-5W
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jyD92-0007B1-2o
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:42:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:30346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jyD8w-0002u4-DU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:42:43 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06MBbNM0025190; Wed, 22 Jul 2020 04:42:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=HUi45bxy4XQEELoefcjzksRjfq4SQqDoKzvZpI5iMjA=;
 b=PeQN5t+iKamvjAfb6tgQEptc8qoeZaUakmah6sY+HdU+DM9b1VPoJU3jol3w3FzMB2zx
 0n5Gn8gC6X1gweAG6/4A9QRhNPvaBwcBzexefRfBWiysOZx04GxAFVoufdza8blzgYW/
 OBx+v5ToxnybaONRcEJy3QY5fyAhANlL6aKOKKkttxhF0licK+9t2maV3KaNh71Xn02s
 FK9KbE+chdFSi2VPx8hyrt0hk2nfps6ZdNChwxDjPd8351rlRsFMz7WsCR/mBsqjR4Xi
 Y8KF33Imj9nlmhhXNNsNffoC7sXAFldEEXCIH3L6f6vQDIoz48d74IXrvnNL6s2/9wOP Ow== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-002c1b01.pphosted.com with ESMTP id 32dfjr4k4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 04:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKcdL9jExKavA4M1fpYyxm7gkQ8dI1faCunI+PSfTXpMthjVJOcF2ye/ItMEVPHHoYAzQSWsOaqRVvez7rbwNwWl6aMIf/jiuP+vmUM4/jRlVHe9LAsDD9tJP1m53/bQtdPgQryxxgFU8pst4cfTLtgR/Yesy0z6jYIxeOgZic2lRE6EOI6VlQYygicXDumzDOIJY3NFzUVnN4ELIxfzGZ19inFpNe94IsRJDS0wJloUNpMUKtblRUDJkHM7azSDCe4yYk5qF4P10LjH2w8fjJmQ5Znw2EID1VRdeoOXt11JQj8aa7rnf2zn6tT0+pD1KCAiVO2XrbT93qcV8l6xMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUi45bxy4XQEELoefcjzksRjfq4SQqDoKzvZpI5iMjA=;
 b=Uzsf/Cn15Eltm7b0ol5MMguFHSXllxq6ERb1fmmHHY2RreJB6Wm0RlfWdBM/QcE+Y+mVXDMKV+p8SMzb6tw6S93AjqJQkxf1wATAFqdBgrBIMQ243/hnbaR64W9OyFOFZPELufIvbkFO7Z6OIAIB/fJOnw1eIA3sEiBAlpv+cd0oaa/GnKmDVHnNLce9/hfEwsW2mgB9zTreGraN7ls861fskPM5IuyeJNxcOsopZLyHPXxZKlSGM2SiVjwNBe4opRZfw/5bYBuqiqB/D18B51Y0YR88XE6eL2lTt4t9msO1s3DYEidBSteawtaw1buh6Zgu/3FucUhNNMic6WMe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MWHPR02MB2607.namprd02.prod.outlook.com (2603:10b6:300:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 11:42:27 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::41c0:3347:6d78:a869]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::41c0:3347:6d78:a869%5]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 11:42:27 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: RE: [PATCH] introduce VFIO-over-socket protocol specificaion
Thread-Topic: [PATCH] introduce VFIO-over-socket protocol specificaion
Thread-Index: AQHWW4ZDdDAn+vuv6U+Nnck4fzWbQakLsYqAgAfRqKA=
Date: Wed, 22 Jul 2020 11:42:26 +0000
Message-ID: <MW2PR02MB372306D4995774D4E6D036AD8B790@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
 <20200717121753.GK128195@stefanha-x1.localdomain>
In-Reply-To: <20200717121753.GK128195@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db2886f3-68d7-49ca-8920-08d82e344f15
x-ms-traffictypediagnostic: MWHPR02MB2607:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB260782691201A20B8AF078B68B790@MWHPR02MB2607.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNl5aMvttfuqeOvuTjg8qmwX3GCqbsrwNGJyDrTt0AlL/K75kv/oCUyjpxpgCHc6xQhGqY5To+KmzHOlfO3CHRkKqKDjt+XocHf/H6jRbGTZu44R/8ZZf7HYCzwuMsQhNntLK28BpAjcn0luN9sIpkatJelWrIOnuv+RB6Our6VZMuvCqoeifqyNqRjnsBGfsFLCtE3sbzdljeiW/LJlzjv7zYenvXwLZovWUus5DvOT+pwTNNwLNcJ2amsIOhrV3cLAe0uR6UFXvu1dR9sw7xzVwha5uC0AGPdmLAqZuA8r701KrGNl7cnED3oF/5wBZ/WsgfU2vpUfoM6NNhWz1CampRaIbsiWQFKyQzD/yGQoAGY00lT+7kRwhAmNaUr6aMZTCVhoIGsYBJDIVL41Dg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(66946007)(76116006)(8936002)(52536014)(8676002)(2906002)(33656002)(6916009)(54906003)(5660300002)(4326008)(55016002)(316002)(86362001)(7416002)(9686003)(44832011)(6506007)(30864003)(26005)(7696005)(53546011)(83380400001)(966005)(71200400001)(66476007)(66446008)(64756008)(66556008)(478600001)(186003)(559001)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nXBlbCES9jfA1d+3LcFKkQN/pBSf/FCyjS7fPPh/10p/sTcaUFmK22qJmx66cDWA33hekJKYDVTFSFNNL/+kgfc+Lj1jNhZEFHLOhlLJV+co1DgT6yN9dxEVxS7fcdLY3nDCRUUTxDFEHWJbZn1zimmdRBO9WoszZ4cSLaBDc/OWGH4zpI7/Cb0lR8rlbAdM4WnFmhMyu/XtLVvXJRxifCUiZQFhA7SFCUeT3W0NpsrBjk2rWjJC+u8QIXwlvb6Q/vI1yEWCMqAFEnvQvm3eqXPkEUME0zSDa2ApiYLE4oNEKXGQv3RhiIWPL5czgmm4CV62ioMR34s1s1QOc9NMZfQ04rVODgNzN2z6XjuQwmnoFcFQftgb+np0Xg3il7A+zDkBR04IMBy+LOC/ruvSHRquijDnCdhqAKJJPgrlRk72QrVRoyxedbadD/BjYIVn1Dn0jXa3a2ptXid4Z8IH+n4jCw3UGD4mEnbZuoY35rQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3723.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2886f3-68d7-49ca-8920-08d82e344f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 11:42:27.1304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9bwGC7AsHTq8RaJccE7Y9+tk/x63hIyyucCHHQKvDds3ZOrSS4a46OhdtbXHr499Y1gowaAKL+OhMrYaz5bCfNdxOVnU4O6iT41SzShnOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2607
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_05:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 07:42:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
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
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: 17 July 2020 13:18
> To: Thanos Makatos <thanos.makatos@nutanix.com>
> Cc: qemu-devel@nongnu.org; alex.williamson@redhat.com;
> benjamin.walker@intel.com; elena.ufimtseva@oracle.com;
> jag.raman@oracle.com; Swapnil Ingle <swapnil.ingle@nutanix.com>;
> james.r.harris@intel.com; konrad.wilk@oracle.com; Raphael Norwitz
> <raphael.norwitz@nutanix.com>; marcandre.lureau@redhat.com;
> Kanth.Ghatraju@oracle.com; Felipe Franciosi <felipe@nutanix.com>;
> tina.zhang@intel.com; changpeng.liu@intel.com; dgilbert@redhat.com;
> tomassetti.andrea@gmail.com; yuvalkashtan@gmail.com;
> ismael@linux.com; John G Johnson <john.g.johnson@oracle.com>
> Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
>=20
> On Thu, Jul 16, 2020 at 08:31:43AM -0700, Thanos Makatos wrote:
> > This patch introduces the VFIO-over-socket protocol specification, whic=
h
> > is designed to allow devices to be emulated outside QEMU, in a separate
> > process. VFIO-over-socket reuses the existing VFIO defines, structs and
> > concepts.
> >
> > It has been earlier discussed as an RFC in:
> > "RFC: use VFIO over a UNIX domain socket to implement device offloading=
"
> >
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> > ---
> >  docs/devel/vfio-over-socket.rst | 1135
> +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 1135 insertions(+), 0 deletions(-)
> >  create mode 100644 docs/devel/vfio-over-socket.rst
>=20
> This is exciting! The spec is clear enough that I feel I could start
> writing a client/server. There is enough functionality here to implement
> real-world devices. Can you share links to client/server
> implementations?

Strictly speaking there's no client/server implementation yet as we're wait=
ing
until the protocol is finalized.

The closest server implementation we have is an NVMe controller implemented=
 in
SPDK with MUSER:
(https://github.com/tmakatos/spdk/tree/rfc-vfio-over-socket and
https://github.com/tmakatos/muser/tree/vfio-over-socket).

The closest client implementation we have is libvfio in the VFIO-over-socke=
t
PoC.

Neither of these implementation use the new protocol, but they're similar i=
n
spirit.

John is working on the VFIO changes, the only thing left to do is the DMA/I=
OMMU
changes we made in the last review round, they'll be on their GitHub site s=
oon.


>=20
> launching, and controlling device emulation processes. That doesn't need
> It would be useful to introduce a standard way of enumerating,
> to be part of this specification document though. In vhost-user there
> are conventions for command-line parameters, process lifecycle, etc that
> make it easier for management tools to run device processes (the
> "Backend program conventions" section in vhost-user.rst).

Sure, we'll come up with something similar based on those.

>=20
> > diff --git a/docs/devel/vfio-over-socket.rst b/docs/devel/vfio-over-
> socket.rst
> > new file mode 100644
> > index 0000000..723b944
> > --- /dev/null
> > +++ b/docs/devel/vfio-over-socket.rst
> > @@ -0,0 +1,1135 @@
> > +***************************************
> > +VFIO-over-socket Protocol Specification
> > +***************************************
> > +
> > +Version 0.1
>=20
> Please include a reference to the section below explaining how
> versioning works.

I'm not sure I understand, do you mean we should add something like the
following (right below "Version 0.1"):

"Refer to section 1.2.3 on how versioning works."

?

>=20
> Also, are there rules about noting versions when updating the spec? For
> example:
>=20
>   When making a change to this specification, the protocol version
>   number must be included:
>=20
>     The `foo` field contains ... Added in version 1.3.

OK, we'll add the rule as per your recommendation.

>=20
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +VFIO-over-socket, also known as vfio-user, is a protocol that allows a
> device
>=20
> vfio-user is shorted. Now is the best time to start consistently using
> "vfio-user" as the name for this protocol. Want to drop the name
> VFIO-over-socket?

"vfio-user" it is.

>=20
> > +to be virtualized in a separate process outside of QEMU. VFIO-over-
> socket
>=20
> Is there anything QEMU-specific about this protocol?
>=20
> I think the scope of this protocol is more general and it could be
> described as:
>=20
>   allows device emulation in a separate process outside of a Virtual
>   Machine Monitor (VMM).
>=20
> (Or "emulator" instead of VMM, if you prefer.)
>=20
> > +devices consist of a generic VFIO device type, living inside QEMU, whi=
ch
> we
>=20
> s/QEMU/the VMM/

Correct, QEMU is simply our main use case but the protocol is agnostic to t=
hat.
We'll drop QEMU and rephrase based on your suggestion.

>=20
> > +call the client, and the core device implementation, living outside QE=
MU,
> which
> > +we call the server. VFIO-over-socket can be the main transport
> mechanism for
> > +multi-process QEMU, however it can be used by other applications
> offering
> > +device virtualization. Explaining the advantages of a
> > +disaggregated/multi-process QEMU, and device virtualization outside
> QEMU in
> > +general, is beyond the scope of this document.
> > +
> > +This document focuses on specifying the VFIO-over-socket protocol. VFI=
O
> has
> > +been chosen for the following reasons:
>=20
> It's a little subtle here that "VFIO" means the Linux VFIO ioctl
> interface. Expanding it a bit makes the rest of the text clearer:
>=20
>   The `Linux VFIO ioctl
>   interface
>   <https://www.kernel.org/doc/html/latest/driver-api/vfio.html>`_ has
>   been chosen as the base for this protocol for the following reasons:

OK.

>=20
> > +
> > +1) It is a mature and stable API, backed by an extensively used
> framework.
> > +2) The existing VFIO client implementation (qemu/hw/vfio/) can be
> largely
> > +   reused.
> > +
> > +In a proof of concept implementation it has been demonstrated that
> using VFIO
> > +over a UNIX domain socket is a viable option. VFIO-over-socket is
> designed with
> > +QEMU in mind, however it could be used by other client applications. T=
he
> > +VFIO-over-socket protocol does not require that QEMU's VFIO client
> > +implementation is used in QEMU. None of the VFIO kernel modules are
> required
> > +for supporting the protocol, neither in the client nor the server, onl=
y the
> > +source header files are used.
>=20
> In the long run only the last sentence in this paragraph needs to be in
> the specification.

OK.

>=20
> The proof of concept and QEMU-specific info is good to know for the
> discussion right now, but I don't think this needs to be in the
> specification.

OK.

>=20
> > +
> > +The main idea is to allow a virtual device to function in a separate p=
rocess
> in
> > +the same host over a UNIX domain socket. A UNIX domain socket
> (AF_UNIX) is
> > +chosen because we can trivially send file descriptors over it, which i=
n turn
> > +allows:
> > +
> > +* Sharing of guest memory for DMA with the virtual device process.
>=20
> Should the spec start consistently using "server" instead of various
> terms like "virtual device process"?

Indeed, that would be better.

>=20
> > +* Sharing of virtual device memory with the guest for fast MMIO.
>=20
> The VIRTIO spec restricts itself to the terms "device" and "driver" so
> that the scope isn't too specific to virtualization of software devices.
> I think the same might be good here because who knows how
> VFIO-over-socket will be used in the future. Maybe it will be used
> outside the context of traditional guests. For example, it's a great
> interface for writing device emulation tests and fuzzers!
>=20
> I suggest consistently using "client" (for the guest) and "server" (for
> the device emulation process). That way the spec isn't focussed on a
> specific use case.

OK.

>=20
> > +* Efficient sharing of eventfd's for triggering interrupts.
> > +
> > +However, other socket types could be used which allows the virtual
> device
> > +process to run in a separate guest in the same host (AF_VSOCK) or
> remotely
> > +(AF_INET). Theoretically the underlying transport doesn't necessarily =
have
> to
> > +be a socket, however we don't examine such alternatives. In this
> document we
> > +focus on using a UNIX domain socket and introduce basic support for th=
e
> other
> > +two types of sockets without considering performance implications.
>=20
> This is a good place to be explicit about the protocol requirements:
>=20
> Is file-descriptor passing necessary?
>=20
> Is shared-memory necessary?
>=20
> Is there always an in-band message-passing fallback for any operation
> that can be optimized via fd passing?
>=20
> By stating something about this in the spec it's easier to ensure that
> the protocol continues to follow these design parameters in the future
> when other people make modifications.

Passing of file descriptors isn't necessary. We explain that later in
"Guest Memory Configuration" and we'll also state it here for clarity.

>=20
> > +This document does not yet describe any internal details of the server=
-
> side
> > +implementation, however QEMU's VFIO client implementation will have
> to be
> > +adapted according to this protocol in order to support VFIO-over-socke=
t
> virtual
> > +devices.
>=20
> This paragraph about the QEMU implementation status can be dropped from
> the specification.

OK.

>=20
> > +
> > +VFIO
> > +=3D=3D=3D=3D
> > +VFIO is a framework that allows a physical device to be securely passe=
d
> through
> > +to a user space process; the kernel does not drive the device at all.
> > +Typically, the user space process is a VM and the device is passed thr=
ough
> to
> > +it in order to achieve high performance. VFIO provides an API and the
> required
> > +functionality in the kernel. QEMU has adopted VFIO to allow a guest
> virtual
> > +machine to directly access physical devices, instead of emulating them=
 in
> > +software
>=20
> s/software/software./

OK.

>=20
> > +
> > +VFIO-over-socket reuses the core VFIO concepts defined in its API, but
> > +implements them as messages to be sent over a UNIX-domain socket. It
> does not
>=20
> Can "UNIX-domain" be dropped here? If the protocol design is intended to
> support other transports then it helps to avoid mentioning a specific
> transport even if only AF_UNIX will be implemented in the beginning.

OK.

>=20
> > +change the kernel-based VFIO in any way, in fact none of the VFIO kern=
el
> > +modules need to be loaded to use VFIO-over-socket. It is also possible=
 for
> QEMU
> > +to concurrently use the current kernel-based VFIO for one guest device=
,
> and use
> > +VFIO-over-socket for another device in the same guest.
> > +
> > +VFIO Device Model
> > +-----------------
> > +A device under VFIO presents a standard VFIO model to the user process=
.
> Many
>=20
> I'm not sure what the meaning of the first sentence is.
>=20
> s/standard VFIO model/standard interface/ ?

OK.

>=20
> > +of the VFIO operations in the existing kernel model use the ioctl() sy=
stem
> > +call, and references to the existing model are called the ioctl()
> > +implementation in this document.
> > +
> > +The following sections describe the set of messages that implement the
> VFIO
> > +device model over a UNIX domain socket. In many cases, the messages
> are direct
> > +translations of data structures used in the ioctl() implementation.
> Messages
> > +derived from ioctl()s will have a name derived from the ioctl() comman=
d
> name.
> > +E.g., the VFIO_GET_INFO ioctl() command becomes a
> VFIO_USER_GET_INFO message.
> > +The purpose for this reuse is to share as much code as feasible with t=
he
> > +ioctl() implementation.
> > +
> > +Client and Server
> > +^^^^^^^^^^^^^^^^^
> > +The socket connects two processes together: a client process and a ser=
ver
> > +process. In the context of this document, the client process is the pr=
ocess
> > +emulating a guest virtual machine, such as QEMU. The server process is=
 a
> > +process that provides device emulation.
> > +
> > +Connection Initiation
> > +^^^^^^^^^^^^^^^^^^^^^
> > +After the client connects to the server, the initial server message is
> > +VFIO_USER_VERSION to propose a protocol version and set of capabilitie=
s
> to
> > +apply to the session. The client replies with a compatible version and=
 set
> of
> > +capabilities it will support, or closes the connection if it cannot su=
pport the
> > +advertised version.
> > +
> > +Guest Memory Configuration
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +The client uses VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP
> messages to inform
> > +the server of the valid guest DMA ranges that the server can access on
> behalf
> > +of a device. Guest memory may be accessed by the server via
> VFIO_USER_DMA_READ
> > +and VFIO_USER_DMA_WRITE messages over the socket.
>=20
> "Guest" is a virtualization term. "DMA Memory Configuration" and "DMA
> memory may be accessed ..." would be more general.

OK.

>=20
> > +
> > +An optimization for server access to guest memory is for the client to
> provide
> > +file descriptors the server can mmap() to directly access guest memory=
.
> Note
> > +that mmap() privileges cannot be revoked by the client, therefore file
> > +descriptors should only be exported in environments where the client
> trusts the
> > +server not to corrupt guest memory.
> > +
> > +Device Information
> > +^^^^^^^^^^^^^^^^^^
> > +The client uses a VFIO_USER_DEVICE_GET_INFO message to query the
> server for
> > +information about the device. This information includes:
> > +
> > +* The device type and capabilities,
> > +* the number of memory regions, and
>=20
> VFIO calls them "device regions", which is clearer:
> 1. It cannot be confused with "DMA Memory Regions"
> 2. It allows for I/O space in additional to Memory space
>=20
> I suggest using "device regions" consistently.

OK.

>=20
> > +* the device presents to the guest the number of interrupt types the
> device
> > +  supports.
> > +
> > +Region Information
> > +^^^^^^^^^^^^^^^^^^
> > +The client uses VFIO_USER_DEVICE_GET_REGION_INFO messages to
> query the server
> > +for information about the device's memory regions. This information
> describes:
> > +
> > +* Read and write permissions, whether it can be memory mapped, and
> whether it
> > +  supports additional capabilities.
> > +* Region index, size, and offset.
> > +
> > +When a region can be mapped by the client, the server provides a file
> > +descriptor which the client can mmap(). The server is responsible for
> polling
> > +for client updates to memory mapped regions.
> > +
> > +Region Capabilities
> > +"""""""""""""""""""
> > +Some regions have additional capabilities that cannot be described
> adequately
> > +by the region info data structure. These capabilities are returned in =
the
> > +region info reply in a list similar to PCI capabilities in a PCI devic=
e's
> > +configuration space.
> > +
> > +Sparse Regions
> > +""""""""""""""
> > +A region can be memory-mappable in whole or in part. When only a
> subset of a
> > +region can be mapped by the client, a
> VFIO_REGION_INFO_CAP_SPARSE_MMAP
> > +capability is included in the region info reply. This capability descr=
ibes
> > +which portions can be mapped by the client.
> > +
> > +For example, in a virtual NVMe controller, sparse regions can be used =
so
> that
> > +accesses to the NVMe registers (found in the beginning of BAR0) are
> trapped (an
> > +infrequent an event), while allowing direct access to the doorbells (a=
n
> > +extremely frequent event as every I/O submission requires a write to
> BAR0),
> > +found right after the NVMe registers in BAR0.
> > +
> > +Interrupts
> > +^^^^^^^^^^
> > +The client uses VFIO_USER_DEVICE_GET_IRQ_INFO messages to query
> the server for
> > +the device's interrupt types. The interrupt types are specific to the =
bus
> the
> > +device is attached to, and the client is expected to know the capabili=
ties of
> > +each interrupt type. The server can signal an interrupt either with
> > +VFIO_USER_VM_INTERRUPT messages over the socket, or can directly
> inject
> > +interrupts into the guest via an event file descriptor. The client con=
figures
> > +how the server signals an interrupt with VFIO_USER_SET_IRQS messages.
> > +
> > +Device Read and Write
> > +^^^^^^^^^^^^^^^^^^^^^
> > +When the guest executes load or store operations to device memory, the
> client
> > +forwards these operations to the server with VFIO_USER_REGION_READ
> or
> > +VFIO_USER_REGION_WRITE messages. The server will reply with data
> from the
> > +device on read operations or an acknowledgement on write operations.
> > +
> > +DMA
> > +^^^
> > +When a device performs DMA accesses to guest memory, the server will
> forward
> > +them to the client with VFIO_USER_DMA_READ and
> VFIO_USER_DMA_WRITE messages.
> > +These messages can only be used to access guest memory the client has
> > +configured into the server.
> > +
> > +Protocol Specification
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +To distinguish from the base VFIO symbols, all VFIO-over-socket symbol=
s
> are
> > +prefixed with vfio_user or VFIO_USER. In revision 0.1, all data is in =
the
> > +little-endian format, although this may be relaxed in future revision =
in
> cases
> > +where the client and server are both big-endian. The messages are
> formatted
> > +for seamless reuse of the native VFIO structs. A server can serve:
> > +
> > +1) multiple clients, and/or
> > +2) multiple virtual devices, belonging to one or more clients.
> > +
> > +Therefore each message requires a header that uniquely identifies the
> virtual
> > +device. It is a server-side implementation detail whether a single ser=
ver
> > +handles multiple virtual devices from the same or multiple guests.
> > +
> > +Socket
> > +------
> > +A single UNIX domain socket is assumed to be used for each device. The
> location
> > +of the socket is implementation-specific. Multiplexing clients, device=
s, and
> > +servers over the same socket is not supported in this version of the
> protocol,
> > +but a device ID field exists in the message header so that a future su=
pport
> can
> > +be added without a major version change.
>=20
> There is a version negotiation mechanism for making protocol changes.
> I'm not sure there is any advantage to including the multiplexing header
> now? I suggest keeping it simple and dropping the unused header.

OK.

>=20
> > +
> > +Authentication
> > +--------------
> > +For AF_UNIX, we rely on OS mandatory access controls on the socket
> files,
> > +therefore it is up to the management layer to set up the socket as
> required.
> > +Socket types than span guests or hosts will require a proper
> authentication
> > +mechanism. Defining that mechanism is deferred to a future version of
> the
> > +protocol.
> > +
> > +Request Concurrency
> > +-------------------
> > +There can be multiple outstanding requests per virtual device, e.g. a
> > +frame buffer where the guest does multiple stores to the virtual devic=
e.
> The
> > +server can execute and reorder non-conflicting requests in parallel,
> depending
> > +on the device semantics.
>=20
> The word "request" has not been used up to this point in the spec. What
> does "request" mean here?
>=20
> I'm not sure if this section is talking about vfio-user protocol message
> exchanges (e.g. a client->server message followed by a server->client
> message) or something else?

Indeed, this is confusing, we use the term "command" earlier in the
"VFIO Device Model" section, we'll replace the term "request"
with "command" throughout the specification.

>=20
> What about the ordering semantics at the vfio-user protocol level? For
> example, if a client sends multiple VFIO_USER_DMA_MAP/UNMAP
> messages
> then the order matters. What are the rules? I wonder if maybe
> concurrency is a special case and really only applies to a subset of
> protocol commands?

All commands are executed in the order they were sent, regardless of whethe=
r a
reply is needed.

>=20
> I'm not sure how a client would exploit parallelism in this protocol.
> Can you give an example of a case where there would be multiple commands
> pending on a single device?

For instance, a client can issue the following operations back to back with=
out
waiting for the first two to complete:
1. map a DMA region=20
2. trigger some device-specific operation that results in data being read i=
nto
   that DMA region, and
3. unmap the DMA region

>=20
> > +
> > +Socket Disconnection Behavior
> > +-----------------------------
> > +The server and the client can disconnect from each other, either
> intentionally
> > +or unexpectedly. Both the client and the server need to know how to
> handle such
> > +events.
> > +
> > +Server Disconnection
> > +^^^^^^^^^^^^^^^^^^^^
> > +A server disconnecting from the client may indicate that:
> > +
> > +1) A virtual device has been restarted, either intentionally (e.g. bec=
ause of
> a
> > +device update) or unintentionally (e.g. because of a crash). In any ca=
se,
> the
> > +virtual device will come back so the client should not do anything (e.=
g.
> simply
> > +reconnect and retry failed operations).
> > +
> > +2) A virtual device has been shut down with no intention to be restart=
ed.
> > +
> > +It is impossible for the client to know whether or not a failure is
> > +intermittent or innocuous and should be retried, therefore the client
> should
> > +attempt to reconnect to the socket. Since an intentional server restar=
t
> (e.g.
> > +due to an upgrade) might take some time, a reasonable timeout should
> be used.
> > +In cases where the disconnection is expected (e.g. the guest shutting
> down), no
> > +new requests will be sent anyway so this situation doesn't pose a
> problem. The
> > +control stack will clean up accordingly.
> > +
> > +Parametrizing this behaviour by having the virtual device advertise a
>=20
> s/Parametrizing/Parameterizing/

OK.

>=20
> > +reasonable reconnect is deferred to a future version of the protocol.
>=20
> No mention is made of recovering state or how disconnect maps to VFIO
> device types (PCI, etc.). Does a disconnect mean that the device has
> been reset?

Regarding recovering state, I believe that since all the building blocks ar=
e
there and the client is pretty much the master in the vfio-user model, it's=
 up
to the client how to deal with exceptional situations. For recovery to work=
, the
client will have to reconfigure IRQs, DMAs, etc., and the server will have =
to
persistently store device state.

Regarding how disconnect maps to VFIO device types, it depends on whether o=
r not
the client/server can recover from it and continue operating. If this doesn=
't
happen (e.g. the server hasn't restarted, the client doesn't support
recovering), then the device cannot continue being operational, which I sup=
pose
is an implementation detail of the client.

Do we need something more specific at this stage?

>=20
> > +
> > +Client Disconnection
> > +^^^^^^^^^^^^^^^^^^^^
> > +The client disconnecting from the server primarily means that the QEMU
> process
> > +has exited. Currently this means that the guest is shut down so the de=
vice
> is
> > +no longer needed therefore the server can automatically exit. However,
> there
> > +can be cases where a client disconnect should not result in a server e=
xit:
> > +
> > +1) A single server serving multiple clients.
> > +2) A multi-process QEMU upgrading itself step by step, which isn't yet
> > +   implemented.
> > +
> > +Therefore in order for the protocol to be forward compatible the serve=
r
> should
> > +take no action when the client disconnects. If anything happens to the
> client
> > +process the control stack will know about it and can clean up resource=
s
> > +accordingly.
> > +
> > +Request Retry and Response Timeout
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +QEMU's VFIO retries certain operations if they fail. While this makes =
sense
> for
> > +real HW, we don't know for sure whether it makes sense for virtual
> devices. A
> > +failed request is a request that has been successfully sent and has be=
en
> > +responded to with an error code. Failure to send the request in the fi=
rst
> place
> > +(e.g. because the socket is disconnected) is a different type of error
> examined
> > +earlier in the disconnect section.
> > +
> > +Defining a retry and timeout scheme if deferred to a future version of=
 the
> > +protocol.
> > +
> > +Commands
> > +--------
> > +The following table lists the VFIO message command IDs, and whether
> the
> > +message request is sent from the client or the server.
> > +
> > ++----------------------------------+---------+-------------------+
> > +| Name                             | Command | Request Direction |
> >
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D+
> > +| VFIO_USER_VERSION                | 1       | server ???????? client =
  |
>=20
> Unicode issues? I see "????????" instead of the characters that were
> supposed to be here.

My bad, I selected UTF-8 when I ran git send-email, it's supposed to be "->=
".

>=20
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DMA_MAP                | 2       | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DMA_UNMAP              | 3       | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DEVICE_GET_INFO        | 4       | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DEVICE_GET_REGION_INFO | 5       | client ???????? server
> |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DEVICE_GET_IRQ_INFO    | 6       | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DEVICE_SET_IRQS        | 7       | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_REGION_READ            | 8       | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_REGION_WRITE           | 9       | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DMA_READ               | 10      | server ???????? client =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_DMA_READ               | 11      | server ???????? client =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_USER_VM_INTERRUPT           | 12      | server ???????? client =
  |
> > ++----------------------------------+---------+-------------------+
> > +| VFIO_DEVICE_RESET                | 13      | client ???????? server =
  |
> > ++----------------------------------+---------+-------------------+
>=20
> Why is this command named VFIO_DEVICE_RESET and not
> VFIO_USER_DEVICE_RESET?

That's a mistake, it should be VFIO_USER_DEVICE_RESET.

>=20
> > +
> > +Header
> > +------
> > +All messages are preceded by a 16 byte header that contains basic
> information
>=20
> I suggest dropping "16 byte" here because the table already shows this
> and it is easy to forget to update the text when changing the table.

OK.

>=20
> > +about the message. The header is followed by message-specific data
> described
> > +in the sections below.
> > +
> > ++----------------+--------+-------------+
> > +| Name           | Offset | Size        |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID      | 0      | 2           |
> > ++----------------+--------+-------------+
> > +| Message ID     | 2      | 2           |
> > ++----------------+--------+-------------+
> > +| Command        | 4      | 4           |
> > ++----------------+--------+-------------+
> > +| Message size   | 8      | 4           |
> > ++----------------+--------+-------------+
> > +| Flags          | 12     | 4           |
> > ++----------------+--------+-------------+
> > +|                | +-----+------------+ |
> > +|                | | Bit | Definition | |
> > +|                | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+ |
> > +|                | | 0   | Reply      | |
> > +|                | +-----+------------+ |
> > +|                | | 1   | No_reply   | |
> > +|                | +-----+------------+ |
> > ++----------------+--------+-------------+
> > +| <message data> | 16     | variable    |
> > ++----------------+--------+-------------+
> > +
> > +* Device ID identifies the destination device of the message. This fie=
ld is
> > +  reserved when the server only supports one device per socket.
>=20
> Clearer:
> s/is reserved/must be 0/

OK.

>=20
> > +* Message ID identifies the message, and is used in the message
> acknowledgement.
>=20
> Are Message IDs global or per-device?

We're dropping the device ID field in the header therefore it's global.

>=20
> > +* Command specifies the command to be executed, listed in the
> Command Table.
> > +* Message size contains the size of the entire message, including the
> header.
> > +* Flags contains attributes of the message:
> > +
> > +  * The reply bit differentiates request messages from reply messages.=
 A
> reply
> > +    message acknowledges a previous request with the same message ID.
> > +  * No_reply indicates that no reply is needed for this request. This =
is
> > +    commonly used when multiple requests are sent, and only the last
> needs
> > +    acknowledgement.
>=20
> Is_Reply and Dont_Reply are more self-explanatory to me, but this is
> probably subjective.
>=20
> > +
> > +VFIO_USER_VERSION
> > +-----------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+------------------------+
> > +| Name         | Value                  |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | 0                      |
> > ++--------------+------------------------+
>=20
> The Device ID is always 0 and this message is sent just once regardless
> of the number of devices? Please describe this explicitly so it's clear
> that this message is per-session and not per-device.

We're dropping the device ID from the header.

>=20
> There could also be a special NO_DEVICE (0xff) value but I don't think
> it matters.
>=20
> > +| Message ID   | <ID>                   |
> > ++--------------+------------------------+
> > +| Command      | 1                      |
> > ++--------------+------------------------+
> > +| Message size | 16 + version length    |
> > ++--------------+------------------------+
> > +| Flags        | Reply bit set in reply |
> > ++--------------+------------------------+
> > +| Version      | JSON byte array        |
> > ++--------------+------------------------+
> > +
> > +This is the initial message sent by the server after the socket connec=
tion is
> > +established. The version is in JSON format, and the following objects =
must
> be
> > +included:
> > +
> > ++--------------+--------+---------------------------------------------=
------+
> > +| Name         | Type   | Description                                 =
      |
> >
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| version      | object | {???????major????????: <number>,
> ???????minor????????: <number>}            |
>=20
> More Unicode issues.
>=20
> > +|              |        | Version supported by the sender, e.g.
> ???????0.1????????.      |
> > ++--------------+--------+---------------------------------------------=
------+
> > +| type         | string | Fixed to ???????vfio-user????????.          =
                   |
> > ++--------------+--------+---------------------------------------------=
------+
> > +| capabilities | array  | Reserved. Can be omitted for v0.1, otherwise=
 must
> |
> > +|              |        | be empty.                                   =
      |
> > ++--------------+--------+---------------------------------------------=
------+
>=20
> s/array/array of strings/ ?

No, it's array were each element can be any object in JSON.

>=20
> > +
> > +Versioning and Feature Support
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +Upon accepting a connection, the server must send a
> VFIO_USER_VERSION message
> > +proposing a protocol version and a set of capabilities. The client com=
pares
> > +these with the versions and capabilities it supports and sends a
> > +VFIO_USER_VERSION reply according to the following rules.
> > +
> > +* The major version in the reply must be the same as proposed. If the
> client
> > +  does not support the proposed major, it closes the connection.
> > +* The minor version in the reply must be equal to or less than the min=
or
> > +  version proposed.
> > +* The capability list must be a subset of those proposed. If the clien=
t
> > +  requires a capability the server did not include, it closes the conn=
ection.
> > +* If type is not ???????vfio-user????????, the client closes the
> connection.
>=20
> Is there a rationale for this field? In order to get to the point where
> this JSON is parsed we must already implement the vfio-user protocol
> (e.g. parse the header).

It was suggested to include it as a sanity check, we'll drop it.

>=20
> > +
> > +The protocol major version will only change when incompatible protocol
> changes
> > +are made, such as changing the message format. The minor version may
> change
> > +when compatible changes are made, such as adding new messages or
> capabilities,
> > +Both the client and server must support all minor versions less than t=
he
> > +maximum minor version it supports. E.g., an implementation that
> supports
> > +version 1.3 must also support 1.0 through 1.2.
> > +
> > +VFIO_USER_DMA_MAP
> > +-----------------
> > +
> > +VFIO_USER_DMA_UNMAP
> > +-------------------
> > +
> > +Message Format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+------------------------+
> > +| Name         | Value                  |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | 0                      |
> > ++--------------+------------------------+
>=20
> Is this message per-session instead of per-device?
>=20
> This has implications on IOMMU semantics. Two different devices sharing
> a connection have access to the same DMA memory?

Good point, it is per-session since we're dropping the device ID from the
header. I suppose this means that if in a future version we want to support
devices sharing the same connection the header will have to be extended to
include the device ID.

>=20
> > +| Message ID   | <ID>                   |
> > ++--------------+------------------------+
> > +| Command      | MAP=3D2, UNMAP=3D3         |
> > ++--------------+------------------------+
> > +| Message size | 16 + table size        |
> > ++--------------+------------------------+
> > +| Flags        | Reply bit set in reply |
> > ++--------------+------------------------+
> > +| Table        | array of table entries |
> > ++--------------+------------------------+
> > +
> > +This message is sent by the client to the server to inform it of the g=
uest
> > +memory regions the device can access. It must be sent before the devic=
e
> can
> > +perform any DMA to the guest. It is normally sent directly after the
> version
> > +handshake is completed, but may also occur when memory is added or
> subtracted
> > +in the guest.
> > +
> > +The table is an array of the following structure. This structure is 32=
 bytes
> > +in size, so the message size will be 16 + (# of table entries * 32). I=
f a
> > +region being added can be directly mapped by the server, an array of f=
ile
> > +descriptors will be sent as part of the message meta-data. Each region
> entry
> > +will have a corresponding file descriptor. On AF_UNIX sockets, the fil=
e
> > +descriptors will be passed as SCM_RIGHTS type ancillary data.
> > +
> > +Table entry format
> > +^^^^^^^^^^^^^^^^^^
> > +
> > ++-------------+--------+-------------+
> > +| Name        | Offset | Size        |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Address     | 0      | 8           |
> > ++-------------+--------+-------------+
> > +| Size        | 8      | 8           |
> > ++-------------+--------+-------------+
> > +| Offset      | 16     | 8           |
> > ++-------------+--------+-------------+
> > +| Protections | 24     | 4           |
> > ++-------------+--------+-------------+
> > +| Flags       | 28     | 4           |
> > ++-------------+--------+-------------+
> > +|             | +-----+------------+ |
> > +|             | | Bit | Definition | |
> > +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
 |
> > +|             | | 0   | Mappable   | |
> > +|             | +-----+------------+ |
> > ++-------------+--------+-------------+
> > +
> > +* Address is the base DMA address of the region.
> > +* Size is the size of the region.
> > +* Offset is the file offset of the region with respect to the associat=
ed file
> > +  descriptor.
> > +* Protections are the region's protection attributes as encoded in
> > +  ``<sys/mman.h>``.
> > +* Flags contain the following region attributes:
> > +
> > +  * Mappable indicate the region can be mapped via the mmap() system
> call using
> > +    the file descriptor provided in the message meta-data.
>=20
> What are the semantics of map/unmap with respect to mapping over
> existing regions, unmapping a subset of an existing region, etc?

The VFIO kernel driver returns EEXIST if mapping over an existing area
and allows unmapping a subset. I'd think we should follow their example.

>=20
> What are the concerns for MAP/UNMAP while the device is operational and
> may be performing DMA? Should this command be combined into a single
> VFIO_USER_SET_DMA_REGIONS command with Flags Bit 1 indicating
> Add/Delete
> so that a single message can atomically add and delete DMA regions?

Regarding receiving a DMA unmap request while there is an ongoing DMA
transaction, once the server ACK's the DMA unmap then it must not touch tha=
t DMA
region. It is an implementation detail whether the server waits for the DMA=
 to
finish or kills the DMA operation, which might not be possible at all (e.g =
part
of that region has been submitted for I/O to a physical device).

>=20
> What is the format of the reply to this message?

It's just the header explained in the "Header" section, no additional data =
are
sent by the server, it simply ACK's the command.

>=20
> > +
> > +VFIO_USER_DEVICE_GET_INFO
> > +-------------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+----------------------------+
> > +| Name         | Value                      |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | <ID>                       |
> > ++--------------+----------------------------+
> > +| Message ID   | <ID>                       |
> > ++--------------+----------------------------+
> > +| Command      | 4                          |
> > ++--------------+----------------------------+
> > +| Message size | 16 in request, 32 in reply |
> > ++--------------+----------------------------+
> > +| Flags        | Reply bit set in reply     |
> > ++--------------+----------------------------+
> > +| Device info  | VFIO device info           |
> > ++--------------+----------------------------+
> > +
> > +This message is sent by the client to the server to query for basic
> information
> > +about the device. Only the message header is needed in the request
> message.
> > +The VFIO device info structure is defined in ``<sys/vfio.h>`` (``struc=
t
> > +vfio_device_info``).
> > +
> > +VFIO device info format
> > +^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > ++-------------+--------+--------------------------+
> > +| Name        | Offset | Size                     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
> > +| argsz       | 16     | 4                        |
> > ++-------------+--------+--------------------------+
> > +| flags       | 20     | 4                        |
> > ++-------------+--------+--------------------------+
> > +|             | +-----+-------------------------+ |
> > +|             | | Bit | Definition              | |
> > +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> > +|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
> > +|             | +-----+-------------------------+ |
> > +|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
> > +|             | +-----+-------------------------+ |
> > ++-------------+--------+--------------------------+
> > +| num_regions | 24     | 4                        |
> > ++-------------+--------+--------------------------+
> > +| num_irqs    | 28     | 4                        |
> > ++-------------+--------+--------------------------+
> > +
> > +* argz is reserved in vfio-user, it is only used in the ioctl() VFIO
> > +  implementation.
> > +* flags contains the following device attributes.
> > +
> > +  * VFIO_DEVICE_FLAGS_RESET indicates the device supports the
> > +    VFIO_USER_DEVICE_RESET message.
>=20
> Why is VFIO_USER_DEVICE_RESET support optional?

Because it is optional in VFIO, too.

>=20
> > +  * VFIO_DEVICE_FLAGS_PCI indicates the device is a PCI device.
> > +
> > +* num_regions is the number of memory regions the device exposes.
> > +* num_irqs is the number of distinct interrupt types the device suppor=
ts.
> > +
> > +This version of the protocol only supports PCI devices. Additional dev=
ices
> may
> > +be supported in future versions.
> > +
> > +VFIO_USER_DEVICE_GET_REGION_INFO
> > +--------------------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+------------------+
> > +| Name         | Value            |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | <ID>             |
> > ++--------------+------------------+
> > +| Message ID   | <ID>             |
> > ++--------------+------------------+
> > +| Command      | 5                |
> > ++--------------+------------------+
> > +| Message size | 48 + any caps    |
> > ++--------------+------------------+
>=20
> The client does not know how much space capabilities need when sending
> the request. Should the client send a 48-byte request and expect the
> server to reply with a 48+ byte response?

Correct.

>=20
> > +DMA Read/Write Data
> > +^^^^^^^^^^^^^^^^^^^
> > +
> > ++---------+--------+----------+
> > +| Name    | Offset | Size     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> > +| Address | 16     | 8        |
> > ++---------+--------+----------+
> > +| Count   | 24     | 4        |
> > ++---------+--------+----------+
> > +| Data    | 28     | variable |
> > ++---------+--------+----------+
> > +
> > +* Address is the area of guest memory being accessed. This address mus=
t
> have
> > +  been exported to the server with a VFIO_USER_DMA_MAP message.
> > +* Count is the size of the data to be transferred.
> > +* Data is the data to be read or written.
> > +
> > +Address and count can also be accessed as ``struct iovec`` from
> ``<sys/uio.h>``.
>=20
> This seems to be incorrect since the count field is 4 bytes but struct
> iovec::iov_len is size_t (64-bit on 64-bit hosts).

Indeed, I forgot about padding. We can remove the reference to struct iovec=
 or
make count 8 bytes?

>=20
> > +
> > +VFIO_USER_REGION_READ
> > +---------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+------------------------+
> > +| Name         | Value                  |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | <ID>                   |
> > ++--------------+------------------------+
> > +| Message ID   | <ID>                   |
> > ++--------------+------------------------+
> > +| Command      | 8                      |
> > ++--------------+------------------------+
> > +| Message size | 32 + data size         |
> > ++--------------+------------------------+
> > +| Flags Reply  | bit set in reply       |
> > ++--------------+------------------------+
> > +| Read info    | REGION read/write data |
> > ++--------------+------------------------+
> > +
> > +This request is sent from the client to the server to read from device
> memory.
> > +In the request messages, there will be no data, and the count field wi=
ll be
> the
> > +amount of data to be read. The reply will include the data read, and i=
ts
> count
> > +field will be the amount of data read.
> > +
> > +VFIO_USER_REGION_WRITE
> > +----------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+------------------------+
> > +| Name         | Value                  |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | <ID>                   |
> > ++--------------+------------------------+
> > +| Message ID   | <ID>                   |
> > ++--------------+------------------------+
> > +| Command      | 9                      |
> > ++--------------+------------------------+
> > +| Message size | 32 + data size         |
> > ++--------------+------------------------+
> > +| Flags        | Reply bit set in reply |
> > ++--------------+------------------------+
> > +| Write info   | REGION read write data |
> > ++--------------+------------------------+
> > +
> > +This request is sent from the client to the server to write to device
> memory.
> > +The request message will contain the data to be written, and its count
> field
> > +will contain the amount of write data. The count field in the reply wi=
ll be
> > +zero.
> > +
> > +VFIO_USER_DMA_READ
> > +------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+---------------------+
> > +| Name         | Value               |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | <ID>                |
> > ++--------------+---------------------+
> > +| Message ID   | <ID>                |
> > ++--------------+---------------------+
> > +| Command      | 10                  |
> > ++--------------+---------------------+
> > +| Message size | 28 + data size      |
> > ++--------------+---------------------+
> > +| Flags Reply  | bit set in reply    |
> > ++--------------+---------------------+
> > +| DMA info     | DMA read/write data |
> > ++--------------+---------------------+
> > +
> > +This request is sent from the server to the client to read from guest
> memory.
> > +In the request messages, there will be no data, and the count field wi=
ll be
> the
> > +amount of data to be read. The reply will include the data read, and i=
ts
> count
> > +field will be the amount of data read.
> > +
> > +VFIO_USER_DMA_WRITE
> > +-------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+------------------------+
> > +| Name         | Value                  |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | <ID>                   |
> > ++--------------+------------------------+
> > +| Message ID   | <ID>                   |
> > ++--------------+------------------------+
> > +| Command      | 11                     |
> > ++--------------+------------------------+
> > +| Message size | 28 + data size         |
> > ++--------------+------------------------+
> > +| Flags        | Reply bit set in reply |
> > ++--------------+------------------------+
> > +| DMA info     | DMA read/write data    |
> > ++--------------+------------------------+
> > +
> > +This request is sent from the server to the client to write to guest
> memory.
> > +The request message will contain the data to be written, and its count
> field
> > +will contain the amount of write data. The count field in the reply wi=
ll be
> > +zero.
> > +
> > +VFIO_USER_VM_INTERRUPT
> > +----------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++----------------+------------------------+
> > +| Name           | Value                  |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID      | <ID>                   |
> > ++----------------+------------------------+
> > +| Message ID     | <ID>                   |
> > ++----------------+------------------------+
> > +| Command        | 12                     |
> > ++----------------+------------------------+
> > +| Message size   | 24                     |
> > ++----------------+------------------------+
> > +| Flags          | Reply bit set in reply |
> > ++----------------+------------------------+
> > +| Interrupt info | <interrupt>            |
> > ++----------------+------------------------+
> > +
> > +This request is sent from the server to the client to signal the devic=
e has
> > +raised an interrupt.
> > +
> > +Interrupt info format
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > ++----------+--------+------+
> > +| Name     | Offset | Size |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D+
> > +| Index    | 16     | 4    |
> > ++----------+--------+------+
> > +| Subindex | 20     | 4    |
> > ++----------+--------+------+
> > +
> > +* Index is the interrupt index; it is the same value used in
> VFIO_USER_SET_IRQS.
> > +* Subindex is relative to the index, e.g., the vector number used in P=
CI
> MSI/X
> > +  type interrupts.
> > +
> > +VFIO_USER_DEVICE_RESET
> > +----------------------
> > +
> > +Message format
> > +^^^^^^^^^^^^^^
> > +
> > ++--------------+------------------------+
> > +| Name         | Value                  |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| Device ID    | <ID>                   |
> > ++--------------+------------------------+
> > +| Message ID   | <ID>                   |
> > ++--------------+------------------------+
> > +| Command      | 13                     |
> > ++--------------+------------------------+
> > +| Message size | 16                     |
> > ++--------------+------------------------+
> > +| Flags        | Reply bit set in reply |
> > ++--------------+------------------------+
> > +
> > +This request is sent from the client to the server to reset the device=
.
>=20
> How are errors treated in any of these commands? For example, if memory
> addresses are out-of-bounds?

We'll add an error flag in the header and an error field to store a UNIX er=
rno.
It will be unused in the command.


John and Thanos

