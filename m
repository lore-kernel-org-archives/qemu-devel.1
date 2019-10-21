Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C061CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309E920640
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309E920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSvn-0008Cf-9k
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changpeng.liu@intel.com>) id 1iMSv9-0007g1-Ui
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changpeng.liu@intel.com>) id 1iMSv8-00015Z-2I
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:20:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:3199)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
 id 1iMSv7-00014R-QP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:20:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Oct 2019 01:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; d="scan'208";a="209397386"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2019 01:20:01 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 01:20:01 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 01:20:01 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.165]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.96]) with mapi id 14.03.0439.000;
 Mon, 21 Oct 2019 16:19:59 +0800
From: "Liu, Changpeng" <changpeng.liu@intel.com>
To: Felipe Franciosi <felipe@nutanix.com>, Yongji Xie <elohimes@gmail.com>
Subject: RE: [PATCH] vhost-user-scsi: implement handle_output
Thread-Topic: [PATCH] vhost-user-scsi: implement handle_output
Thread-Index: AQHVhQl71p+KRszYckq7k3pyTpDK5adftgOAgACKQACABD4KgIAAQsUAgAADQWA=
Date: Mon, 21 Oct 2019 08:19:59 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B873307@SHSMSX103.ccr.corp.intel.com>
References: <20191017163859.23184-1-felipe@nutanix.com>
 <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
 <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
 <CAONzpcYDDUde0PLVtGYuwGm79RvU-VubXqDs=4F_8yp+-pz-Zg@mail.gmail.com>
 <B53729BD-5A55-4D27-88BE-F8ED2A39D41F@nutanix.com>
In-Reply-To: <B53729BD-5A55-4D27-88BE-F8ED2A39D41F@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzFjOGYwMmYtMWM3Ny00Y2NiLTllYjQtODdiNzQ5NjQ4NGFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUE5VZHR6bzVac1RDdHJURElQd3JQbENEQ1JBNjRrdmF3TUFxaWozQUs1dzJ4SUxWeVl0aVo2akJUWVBiMkZHbCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is some logic in vhost_user_blk_handle_output() for now, it's not emp=
ty as vhost-user-scsi.
There should be other issue if it can't start from SeaBIOS.

> -----Original Message-----
> From: Felipe Franciosi [mailto:felipe@nutanix.com]
> Sent: Monday, October 21, 2019 4:00 PM
> To: Yongji Xie <elohimes@gmail.com>; Liu, Changpeng
> <changpeng.liu@intel.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>; Alex Williamson
> <alex.williamson@redhat.com>; Dr . David Alan Gilbert <dgilbert@redhat.co=
m>;
> qemu-devel@nongnu.org
> Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
>=20
>=20
>=20
> > On Oct 21, 2019, at 5:01 AM, Yongji Xie <elohimes@gmail.com> wrote:
> >
> > On Fri, 18 Oct 2019 at 19:14, Felipe Franciosi <felipe@nutanix.com> wro=
te:
> >>
> >>
> >>
> >>> On Oct 18, 2019, at 3:59 AM, Yongji Xie <elohimes@gmail.com> wrote:
> >>>
> >>> On Fri, 18 Oct 2019 at 01:17, Felipe Franciosi <felipe@nutanix.com> w=
rote:
> >>>>
> >>>> Originally, vhost-user-scsi did not implement a handle_output callba=
ck
> >>>> as that didn't seem necessary. Turns out it is.
> >>>>
> >>>> Depending on which other devices are presented to a VM, SeaBIOS may
> >>>> decide to map vhost-user-scsi devices on the 64-bit range of the add=
ress
> >>>> space. As a result, SeaBIOS will kick VQs via the config space. Thos=
e
> >>>> land on Qemu (not the vhost backend) and are missed, causing the VM =
not
> >>>> to boot. This fixes the issue by getting Qemu to post the notificati=
on.
> >>>>
> >>> Should we fix this in vhost-user-blk too?
> >>
> >> I'm not sure vhost-user-blk suffers from the same problem. Certainly
> >
> > Actually I found vhost-user-blk has the same problem in a mutilple
> > GPUs passthough environment.
>=20
> Let's Cc Changpeng for comments. I'm not familiar with that code.
>=20
> In any case, I still think we should merge this and fix other
> implementations separately. That allows us to revert patches
> individually if anything else breaks.
>=20
> F.
>=20
> >
> > Thanks,
> > Yongji


