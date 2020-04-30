Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1FC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F67320774
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ClNBzBWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F67320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7La-0001da-Ak
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jU7IH-0005y1-Dm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jU7IA-0003QG-BV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:23:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:22434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jU7I9-0003Q5-Lj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:23:46 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03UBMqSG002904; Thu, 30 Apr 2020 04:23:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=oixrk1TaMqYsGftluZDu/Ai1AhbkUComWWhGHuFdkcQ=;
 b=ClNBzBWqhWG8AtaQHOVPmTtW6h0aKf68xQO8RHJ91ivSTwj6/iUZOpBJW7RiGKQ8sfuq
 UleravvgqQ7vEpRZi5M2weHsuK3cvX7jyHD0R+0efzCHGDnShxrRCa8KA7rDzsuQugoV
 bRPhOgWdgZhH0wxjhftqyarOYIvSIshHj47wYJ9b1Dca0mcriwlPu9HYn4PJLSoTaGM+
 iUxXxslxsdJuKcUBS1DNsmko00MhB66BZWA2jaiJMu+LdrKu/zKa6JxhodZFOjdxgxlT
 c4JuKmlaTW8k1rAFqdLui2yGvC/OJLon4fRIo78l263R1DPHIVoaIPoyWT7VxEzDjjUz Ag== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30mmryu908-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2020 04:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNDZj/DIR1iuxEjz5AQ3WCm6Xu2hkeBI7dcW/Hv/ZA6zsq1uk6GiDJajX/LyftUikoljjhz86PenWhaypvDkN3LwLYEL/1OM/YYOx0FCswuGPt5IrnjL9d+cG0OgP2a63SkNh0gjrV5CtqVZ0Qs8fNz97GAqQpyp4zS0L5++lvwHZlvsduB//Px36OJZYOErM147y/lBBIshyUNmkV9WZwV9mjg1lRBX4qQAfd7axRke7hglmSYAYI0+Dh0PG4OA2bryxpDNslhdCgsEkxU590zerf20sooJ38tbMZu8BdpkyD5WdWjsvuWAroRI/a35YihQPoKJE/SJllB7MuNohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oixrk1TaMqYsGftluZDu/Ai1AhbkUComWWhGHuFdkcQ=;
 b=MhXiorxkiBmzwHnhcjJuIDLJ46KAejEF9bNO8HzfE3qQZFnQVbvnNKl2JwN0KOcifEC3tqwBYmGLM2MgHOGnB/fntW6syYTr0L3gQAcIcQaZYQz+DsDut0OZAyk0dJneAifq/0J5bYqOWtcya6M68rlWL0vhCiwf70oGyiPdZh1zldi6hb+e9FVNGYlYdyiEGmJvC4cBc+BmesbBeJCdP8dmy0UbGmyoy5KFI4nfmVpv6AJwkZ98bZEeswzCsScrCmYEKA7SMjzVrplfi3zCe4ODaaQ0e6qG7qB0QGmykBI8ug5d68392MsU9ayw9gn1c/VfEiB80w7Xy5awNAgsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MW2PR02MB3787.namprd02.prod.outlook.com (2603:10b6:907:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 11:23:35 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e%5]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:23:35 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>, Stefan Hajnoczi
 <stefanha@gmail.com>, John G Johnson <john.g.johnson@oracle.com>
Subject: RE: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9QEsuagAA77zu+AAbiuPAADxCFGgAJikHLA=
Date: Thu, 30 Apr 2020 11:23:34 +0000
Message-ID: <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
In-Reply-To: <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bab32d3d-0a8f-4a7f-fbcd-08d7ecf8ebfd
x-ms-traffictypediagnostic: MW2PR02MB3787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR02MB3787C72DED215E9AFD70F2818BAA0@MW2PR02MB3787.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(71200400001)(316002)(52536014)(8936002)(478600001)(7416002)(8676002)(186003)(7696005)(66946007)(64756008)(9686003)(66556008)(55016002)(66476007)(6506007)(110136005)(26005)(66446008)(76116006)(44832011)(2906002)(4326008)(54906003)(5660300002)(86362001)(966005)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6LRTt581LDBmR4rWUe5VmtLC6PBC9+oUwUlm9wqZ5g/Q+GUVYWSx2nCXXMzASerHLR3iijIqPKlkSrU26kV5VXQ+HEgQ8aXbamNtKZLFDz4/k92buXVuYz+iP+dNgc8TEm2rPXFOBc5XwLMZkzMc/tELs4Gk0bi4cynrHWW28k48IrlSrSaan697S0uDXuf1kFSibNv4yDd3aksKsiic21j1FvF+bg5Zqu4nCrECnDejYnZ6LdD0Ukd2toQXqvv3vgjtA0bHRqrDUneFhCE+PuIlET6T7E1/OE6Tet2kbHwY5fdJyphEvcsXaCdIgvJ8GVVMUQ3Gd8O6qB9yspzfqmwGNO59hQ5HpdYhOVgUy5NSyilJF4JBqqePAZWhvfsBoGMJL7WFAIGgGXgfiSnxsRNZuO/daZnbauc7oZStT7DqjekMkPJbhJjSHRqEPqM1A9taheG2BaceTHRPXFnew+OQKi6xOZSoQauqQCLa+PFH8BUdh7qv6SkyGETIrzXtYuymtgyP/4UQVDeOqxqaQ==
x-ms-exchange-antispam-messagedata: C1NN6XrrmIaWDgBp0Dq/aEIw0gAmw7rRP0PPdFMMfXw3dPDwxOxc+lP2ljETe9dagPVmHbOaWqT1zhmrhjQIW+quE2IsCla3RhxKN6tCdylB/pR9RKg251YW1P2ZVNN3NfpnXt6MyfLXUSE6iH2F58qE5s3GzOetKMiQWcDCbFBnzezFKQssjzURip5qLsubm0ea7FK1EyfKMzJm6jd0LYymnmMM6nEbabO/k608lEwMuEljtVK6GtcBnYxlIycVRS6jIii544ni88eH0CV0HmJtHPWSaV6nEc3qOxS0Q9Pf+SFGr8GC015kNPJUGkS76RT+dDmPxXggVz8qq0TKUYDpGjL5TcnAkrVO/lbBTPQEwE2gbvEZsbmdoaVUT3aOrAKARGYHIVShdGQZVcdVfoKuRZ7OIGxl2LxVdKxOh7Im8f4YV/wsOaug0UMk7zscSQvoeC6VQKT6c1o3wGG7exxRlSF+0gkPcAyTnocmgdYHxvBWR+C3KXpD//G0gkIF69Nk7cONJ7Rrc4ovUM/QwmPInjzMcxfSNX/3Bo35yQlunbl33QnSjq3RCH6JV/Bgic0kVJMIBil8goU69E0KitsFneeFZ2WExqTE0gE91ftW4+BKrm3aruUdlYkxF8+WLJrMe2Y7YuG444GxmS1i9GD6eruRZsY5QwFE0GJ4IDLJ+n0Om1lLAVp8BfC8sq0kycgvi77mutWuwVzd0oKxrW+ghyFuTj0bBcwO2m4cvbmEeYLlvr4Y7hyV7lcmynO6qb79xgPXDvtcRc9WshaXTwg23R+Syii/umXN2seahYA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab32d3d-0a8f-4a7f-fbcd-08d7ecf8ebfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 11:23:34.7971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQ4GIvHxdu0OhU/YAYyLT/Zj/yu9AQJWyCJL/8PP68l6bGqATaxbB5yENpvtBVJfAWEqE0eV3Lua9yD+pIifSEMJct6my7GSnQXTDkU0nck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-30_07:2020-04-30,
 2020-04-30 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:23:39
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > I've just shared with you the Google doc we've working on with John
> > where we've
> > > been drafting the protocol specification, we think it's time for some=
 first
> > > comments. Please feel free to comment/edit and suggest more people
> to
> > be on the
> > > reviewers list.
> > >
> > > You can also find the Google doc here:
> > >
> > >
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__docs.google.com_document_d_1FspkL0hVEnZqHbdoqGLUpyC38rSk-
> 5F&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6ogtti46a
> tk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJW7NMg
> Rg&s=3DRyyhgVrLX2bBTqpXZnBmllqkCg_wyalxwZKkfcYt50c&e=3D
> > 7HhY471TsVwyK8/edit?usp=3Dsharing
> > >
> > > If a Google doc doesn't work for you we're open to suggestions.
> >
> > I can't add comments to the document so I've inlined them here:
> >
> > The spec assumes the reader is already familiar with VFIO and does not
> > explain concepts like the device lifecycle, regions, interrupts, etc.
> > We don't need to duplicate detailed VFIO information, but I think the
> > device model should be explained so that anyone can start from the
> > VFIO-user spec and begin working on an implementation.  Right now I
> > think they would have to do some serious investigation of VFIO first in
> > order to be able to write code.
>=20
> I've added a high-level overview of how VFIO is used in this context.
>=20
> > "only the source header files are used"
> > I notice the current <linux/vfio.h> header is licensed "GPL-2.0 WITH
> > Linux-syscall-note".  I'm not a lawyer but I guess this means there are
> > some restrictions on using this header file.  The <linux/virtio*.h>
> > header files were explicitly licensed under the BSD license to make it
> > easy to use the non __KERNEL__ parts.
>=20
> My impression is that this note actually relaxes the licensing requiremen=
ts, so
> that proprietary software can use the system call headers and run on Linu=
x
> without being considered derived work. In any case I'll double check with=
 our
> legal team.
>=20
> > VFIO-user Command Types: please indicate for each request type whether
> > it is client->server, server->client, or both.  Also is it a "command"
> > or "request"?
>=20
> Will do. It's a command.
>=20
>=20
> > vfio_user_req_type <-- is this an extension on top of <linux/vfio.h>?
> > Please make it clear what is part of the base <linux/vfio.h> protocol
> > and what is specific to vfio-user.
>=20
> Correct, it's an extension over <linux/vfio.h>. I've clarified the two sy=
mbol
> namespaces.
>=20
>=20
> > VFIO_USER_READ/WRITE serve completely different purposes depending
> on
> > whether they are sent client->server or server->client.  I suggest
> > defining separate request type constants instead of overloading them.
>=20
> Fixed.
>=20
> > What is the difference between VFIO_USER_MAP_DMA and
> > VFIO_USER_REG_MEM?
> > They both seem to be client->server messages for setting up memory but
> > I'm not sure why two request types are needed.
>=20
> John will provide more information on this.
>=20
> > struct vfio_user_req->data.  Is this really a union so that every
> > message has the same size, regardless of how many parameters are
> passed
> > in the data field?
>=20
> Correct, it's a union so that every message has the same length.
>=20
> > "a framebuffer where the guest does multiple stores to the virtual
> > device."  Do you mean in SMP guests?  Or even in a single CPU guest?
>=20
> @John
>=20
> > Also, is there any concurrency requirement on the client and server
> > side?  Can I implement a client/server that processes requests
> > sequentially and completes them before moving on to the next request or
> > would that deadlock for certain message types?
>=20
> I believe that this might also depend on the device semantics, will need =
to
> think about it in greater detail.

I've looked at this but can't provide a definitive answer yet. I believe th=
e
safest thing to do is for the server to process requests in order.

> More importantly, considering:
> a) Marc-Andr=E9's comments about data alignment etc., and
> b) the possibility to run the server on another guest or host,
> we won't be able to use native VFIO types. If we do want to support that
> then
> we'll have to redefine all data formats, similar to
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_qemu_qemu_blob_master_docs_interop_vhost-
> 2Duser.rst&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6
> ogtti46atk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJ
> W7NMgRg&s=3D1d_kB7VWQ-8d4t6Ikga5KSVwws4vwiVMvTyWVaS6PRU&e=3D .
>=20
> So the protocol will be more like an enhanced version of the Vhost-user
> protocol
> than VFIO. I'm fine with either direction (VFIO vs. enhanced Vhost-user),
> so we need to decide before proceeding as the request format is
> substantially
> different.

Regarding the ability to use the protocol on non-AF_UNIX sockets, we can=20
support this future use case without unnecessarily complicating the protoco=
l by
defining the C structs and stating that data alignment and endianness for t=
he=20
non AF_UNIX case must be the one used by GCC on a x86_64 bit machine, or ca=
n=20
be overridden as required.

We've polished the document a bit more with the help of Marc-Andr=E9,
Raphael, and Swapnil.

The major outstanding issue is agreeing on the having a pair of commands fo=
r
registering/unregistering guest memory and another pair of commands to map/=
unmap
DMA regions, similar to QEMU.


