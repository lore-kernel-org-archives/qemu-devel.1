Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027FEC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFA020714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFA020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1kqs-0006Hd-09
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 00:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1j1kpv-0005pT-5c
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 00:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1j1kps-00071x-VT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 00:45:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:41745)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1j1kps-0006wn-NW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 00:45:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 21:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="347449892"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2020 21:45:11 -0800
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 21:45:04 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Feb 2020 13:45:03 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 12 Feb 2020 13:45:03 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Daniel Cho <danielcho@qnap.com>
Subject: RE: The issues about architecture of the COLO checkpoint
Thread-Topic: The issues about architecture of the COLO checkpoint
Thread-Index: AQHV4KTcP1R3sKJVikmfjsOVjXKwRqgVv2IAgACfSoCAAKv5kA==
Date: Wed, 12 Feb 2020 05:45:03 +0000
Message-ID: <2b09c8650b944c908c0c95fefe6d759f@intel.com>
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
 <20200211174756.GA2798@work-vm> <8737854e2826400fa4d14dc408cfd947@huawei.com>
In-Reply-To: <8737854e2826400fa4d14dc408cfd947@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTRjZjgwZDYtNzAxYi00NGJkLTkwM2EtY2Q2ZDQ4NzBmOTdhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZDlPRlwvZXRjQ2NnQ1o4RjM5WnF0bDV4UDV1VHpTdHp4R0QxbVowWm1VV29DOGNUOGFcL243TXJVdVJndGROZHh5In0=
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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



> -----Original Message-----
> From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Sent: Wednesday, February 12, 2020 11:18 AM
> To: Dr. David Alan Gilbert <dgilbert@redhat.com>; Daniel Cho
> <danielcho@qnap.com>; Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-devel@nongnu.org
> Subject: RE: The issues about architecture of the COLO checkpoint
>=20
> Hi,
>=20
> Thank you Dave,
>=20
> I'll reply here directly.
>=20
> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Wednesday, February 12, 2020 1:48 AM
> To: Daniel Cho <danielcho@qnap.com>; chen.zhang@intel.com;
> Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Cc: qemu-devel@nongnu.org
> Subject: Re: The issues about architecture of the COLO checkpoint
>=20
>=20
> cc'ing in COLO people:
>=20
>=20
> * Daniel Cho (danielcho@qnap.com) wrote:
> > Hi everyone,
> >      We have some issues about setting COLO feature. Hope somebody
> > could give us some advice.
> >
> > Issue 1:
> >      We dynamic to set COLO feature for PVM(2 core, 16G memory),  but
> > the Primary VM will pause a long time(based on memory size) for
> > waiting SVM start. Does it have any idea to reduce the pause time?
> >
>=20
> Yes, we do have some ideas to optimize this downtime.
>=20
> The main problem for current version is, for each checkpoint, we have to
> send the whole PVM's pages
> To SVM, and then copy the whole VM's state into SVM from ram cache, in
> this process, we need both of them be paused.
> Just as you said, the downtime is based on memory size.
>=20
> So firstly, we need to reduce the sending data while do checkpoint, actua=
lly,
> we can migrate parts of PVM's dirty pages in background
> While both of VMs are running. And then we load these pages into ram
> cache (backup memory) in SVM temporarily. While do checkpoint,
> We just send the last dirty pages of PVM to slave side and then copy the =
ram
> cache into SVM. Further on, we don't have
> To send the whole PVM's dirty pages, we can only send the pages that
> dirtied by PVM or SVM during two checkpoints. (Because
> If one page is not dirtied by both PVM and SVM, the data of this pages wi=
ll
> keep same in SVM, PVM, backup memory). This method can reduce
> the time that consumed in sending data.
>=20
> For the second problem, we can reduce the memory copy by two methods,
> first one, we don't have to copy the whole pages in ram cache,
> We can only copy the pages that dirtied by PVM and SVM in last checkpoint=
.
> Second, we can use userfault missing function to reduce the
> Time consumed in memory copy. (For the second time, in theory, we can
> reduce time consumed in memory into ms level).
>=20
> You can find the first optimization in attachment, it is based on an old =
qemu
> version (qemu-2.6), it should not be difficult to rebase it
> Into master or your version. And please feel free to send the new version=
 if
> you want into community ;)
>=20
>=20

Thanks Hailiang!
By the way, Do you have time to push the patches to upstream?
I think this is a better and faster option.

Thanks
Zhang Chen

> >
> > Issue 2:
> >      In
> > https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
> > could we move start_vm() before Line 488? Because at first checkpoint
> > PVM will wait for SVM's reply, it cause PVM stop for a while.
> >
>=20
> No, that makes no sense, because if PVM runs firstly, it still need to wa=
it for
> The network packets from SVM to compare before send it to client side.
>=20
>=20
> Thanks,
> Hailiang
>=20
> >      We set the COLO feature on running VM, so we hope the running VM
> > could continuous service for users.
> > Do you have any suggestions for those issues?
> >
> > Best regards,
> > Daniel Cho
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


