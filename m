Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58BC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1221A20714
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1221A20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22p9-00055K-8K
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 19:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j22oX-0004aQ-3y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j22oV-0001UF-DS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:57:08 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2054 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j22oV-0001RT-2u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:57:07 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 5B2D5ED2962676B84A3C;
 Thu, 13 Feb 2020 08:57:01 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Feb 2020 08:57:00 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 13 Feb 2020 08:57:00 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Thu, 13 Feb 2020 08:57:00 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: "Zhang, Chen" <chen.zhang@intel.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Daniel Cho <danielcho@qnap.com>
Subject: RE: The issues about architecture of the COLO checkpoint
Thread-Topic: The issues about architecture of the COLO checkpoint
Thread-Index: AQHV4KTfP+zQcjn0uEqzqV2FZVPRdagVv2IAgAEJtyD//76lgIABx2NA
Date: Thu, 13 Feb 2020 00:57:00 +0000
Message-ID: <dd65ec8a8b204e8aa4607025b37a3137@huawei.com>
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
 <20200211174756.GA2798@work-vm> <8737854e2826400fa4d14dc408cfd947@huawei.com>
 <2b09c8650b944c908c0c95fefe6d759f@intel.com>
In-Reply-To: <2b09c8650b944c908c0c95fefe6d759f@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.214.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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

Hi Zhang Chen,

> -----Original Message-----
> From: Zhang, Chen [mailto:chen.zhang@intel.com]
> Sent: Wednesday, February 12, 2020 1:45 PM
> To: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr. David Alan
> Gilbert <dgilbert@redhat.com>; Daniel Cho <danielcho@qnap.com>
> Cc: qemu-devel@nongnu.org
> Subject: RE: The issues about architecture of the COLO checkpoint
>=20
>=20
>=20
> > -----Original Message-----
> > From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Sent: Wednesday, February 12, 2020 11:18 AM
> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>; Daniel Cho
> > <danielcho@qnap.com>; Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel@nongnu.org
> > Subject: RE: The issues about architecture of the COLO checkpoint
> >
> > Hi,
> >
> > Thank you Dave,
> >
> > I'll reply here directly.
> >
> > -----Original Message-----
> > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> > Sent: Wednesday, February 12, 2020 1:48 AM
> > To: Daniel Cho <danielcho@qnap.com>; chen.zhang@intel.com;
> > Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Cc: qemu-devel@nongnu.org
> > Subject: Re: The issues about architecture of the COLO checkpoint
> >
> >
> > cc'ing in COLO people:
> >
> >
> > * Daniel Cho (danielcho@qnap.com) wrote:
> > > Hi everyone,
> > >      We have some issues about setting COLO feature. Hope somebody
> > > could give us some advice.
> > >
> > > Issue 1:
> > >      We dynamic to set COLO feature for PVM(2 core, 16G memory),
> > > but the Primary VM will pause a long time(based on memory size) for
> > > waiting SVM start. Does it have any idea to reduce the pause time?
> > >
> >
> > Yes, we do have some ideas to optimize this downtime.
> >
> > The main problem for current version is, for each checkpoint, we have
> > to send the whole PVM's pages To SVM, and then copy the whole VM's
> > state into SVM from ram cache, in this process, we need both of them
> > be paused.
> > Just as you said, the downtime is based on memory size.
> >
> > So firstly, we need to reduce the sending data while do checkpoint,
> > actually, we can migrate parts of PVM's dirty pages in background
> > While both of VMs are running. And then we load these pages into ram
> > cache (backup memory) in SVM temporarily. While do checkpoint, We just
> > send the last dirty pages of PVM to slave side and then copy the ram
> > cache into SVM. Further on, we don't have To send the whole PVM's
> > dirty pages, we can only send the pages that dirtied by PVM or SVM
> > during two checkpoints. (Because If one page is not dirtied by both
> > PVM and SVM, the data of this pages will keep same in SVM, PVM, backup
> > memory). This method can reduce the time that consumed in sending
> > data.
> >
> > For the second problem, we can reduce the memory copy by two methods,
> > first one, we don't have to copy the whole pages in ram cache, We can
> > only copy the pages that dirtied by PVM and SVM in last checkpoint.
> > Second, we can use userfault missing function to reduce the Time
> > consumed in memory copy. (For the second time, in theory, we can
> > reduce time consumed in memory into ms level).
> >
> > You can find the first optimization in attachment, it is based on an
> > old qemu version (qemu-2.6), it should not be difficult to rebase it
> > Into master or your version. And please feel free to send the new
> > version if you want into community ;)
> >
> >
>=20
> Thanks Hailiang!
> By the way, Do you have time to push the patches to upstream?
> I think this is a better and faster option.
>=20

Yes, I can do this, for the second optimization, we need time to realize an=
d test

Thanks

> Thanks
> Zhang Chen
>=20
> > >
> > > Issue 2:
> > >      In
> > > https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
> > > could we move start_vm() before Line 488? Because at first
> > > checkpoint PVM will wait for SVM's reply, it cause PVM stop for a whi=
le.
> > >
> >
> > No, that makes no sense, because if PVM runs firstly, it still need to
> > wait for The network packets from SVM to compare before send it to clie=
nt
> side.
> >
> >
> > Thanks,
> > Hailiang
> >
> > >      We set the COLO feature on running VM, so we hope the running
> > > VM could continuous service for users.
> > > Do you have any suggestions for those issues?
> > >
> > > Best regards,
> > > Daniel Cho
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


