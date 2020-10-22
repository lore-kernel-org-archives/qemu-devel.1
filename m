Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96BA2463F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="CbFaYc8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96BA2463F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdUh-0004Zb-Fo
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kVdTh-0003eA-Op; Thu, 22 Oct 2020 12:30:14 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kVdTb-0005Cs-9q; Thu, 22 Oct 2020 12:30:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603384168; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=RCN4Xanhj8vDR0aZ+rTYW+5VhYTfmE24d7DPAHNOkG+VM6qtyiLuwduPLr3xNqte8sBn8pGCdDkCctlQ4UjTLIHF4z1p7qA5aao0xkylJyfI8AAiXOYicoquHkGlkv7ItmHXOFU0h5yqOujMYG90BZFJITpRI+s7cnrEQyCPVhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1603384168;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=RG+FbTMfDpaCfZcPPooQEK1P+aL1uknjYMe2yMz6ZWE=; 
 b=C+OyI3wE+EEzfQOpNZsiICMBn4felzclTWbz4AHWhs0BCBjiOCcmEl/zlGafOTXfpM3bv24DugmkuClNTICx4JhvI5pWh2SDYuDc7fxeZUxp2VINRzpOmWrfnRnuhVfSIh3VeEXrJghRbvT1PefR0yW5Uug6IHLfPDGrA/DQxes=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603384168; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
 bh=RG+FbTMfDpaCfZcPPooQEK1P+aL1uknjYMe2yMz6ZWE=;
 b=CbFaYc8cSMUija8M7HerpXpWvDd5/GnnzDY4DChwn5RWbigDiFXW/SwgsllD4l+y
 k1acK2TsTFFa5uaJhIkDnVQih2qJ92HS0Cs/yGrgLa2Pn+Zy47s7GI1uasxKFkdkTrW
 TFjLY8A9q3WxQ/8SQpya5e65yklKd2vkbg6S6iMY=
Received: from freeip.amazon.com (54.239.6.187 [54.239.6.187]) by
 mx.zoho.com.cn with SMTPS id 1603384165830491.83193300631535;
 Fri, 23 Oct 2020 00:29:25 +0800 (CST)
Message-ID: <ab245c4580cd5aecc8c5d338fd0e2802cac029d5.camel@euphon.net>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
From: Fam Zheng <fam@euphon.net>
To: Zhenyu Ye <yezhenyu2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 22 Oct 2020 17:29:16 +0100
In-Reply-To: <4eb92c5e-fa2f-50a5-a0f7-5cabe6e15bb4@huawei.com>
References: <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
 <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
 <20200918140628.GA2509473@dev>
 <1ba06b0d-3fcf-3676-f9e0-52875851ff19@huawei.com>
 <20200921111435.GA2524022@dev>
 <20201013100033.GB164611@stefanha-x1.localdomain>
 <f70dc6ce-385b-a4f9-04a0-244018f3ddbb@huawei.com>
 <6fd02e2b-50fa-b667-efc6-47d1765bdd8c@redhat.com>
 <4eb92c5e-fa2f-50a5-a0f7-5cabe6e15bb4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 12:29:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 armbru@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-10-20 at 09:34 +0800, Zhenyu Ye wrote:
> On 2020/10/19 21:25, Paolo Bonzini wrote:
> > On 19/10/20 14:40, Zhenyu Ye wrote:
> > > The kernel backtrace for io_submit in GUEST is:
> > >=20
> > > 	guest# ./offcputime -K -p `pgrep -nx fio`
> > > 	    b'finish_task_switch'
> > > 	    b'__schedule'
> > > 	    b'schedule'
> > > 	    b'io_schedule'
> > > 	    b'blk_mq_get_tag'
> > > 	    b'blk_mq_get_request'
> > > 	    b'blk_mq_make_request'
> > > 	    b'generic_make_request'
> > > 	    b'submit_bio'
> > > 	    b'blkdev_direct_IO'
> > > 	    b'generic_file_read_iter'
> > > 	    b'aio_read'
> > > 	    b'io_submit_one'
> > > 	    b'__x64_sys_io_submit'
> > > 	    b'do_syscall_64'
> > > 	    b'entry_SYSCALL_64_after_hwframe'
> > > 	    -                fio (1464)
> > > 		40031912
> > >=20
> > > And Linux io_uring can avoid the latency problem.

Thanks for the info. What this tells us is basically the inflight
requests are high. It's sad that the linux-aio is in practice
implemented as a blocking API.

Host side backtrace will be of more help. Can you get that too?

Fam

> >=20
> > What filesystem are you using?
> >=20
>=20
> On host, the VM image and disk images are based on ext4 filesystem.
> In guest, the '/' uses xfs filesystem, and the disks are raw devices.
>=20
> guest# df -hT
> Filesystem              Type      Size  Used Avail Use% Mounted on
> devtmpfs                devtmpfs   16G     0   16G   0% /dev
> tmpfs                   tmpfs      16G     0   16G   0% /dev/shm
> tmpfs                   tmpfs      16G  976K   16G   1% /run
> /dev/mapper/fedora-root xfs       8.0G  3.2G  4.9G  40% /
> tmpfs                   tmpfs      16G     0   16G   0% /tmp
> /dev/sda1               xfs      1014M  181M  834M  18% /boot
> tmpfs                   tmpfs     3.2G     0  3.2G   0% /run/user/0
>=20
> guest# lsblk
> NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
> sda               8:0    0  10G  0 disk
> =E2=94=9C=E2=94=80sda1            8:1    0   1G  0 part /boot
> =E2=94=94=E2=94=80sda2            8:2    0   9G  0 part
>   =E2=94=9C=E2=94=80fedora-root 253:0    0   8G  0 lvm  /
>   =E2=94=94=E2=94=80fedora-swap 253:1    0   1G  0 lvm  [SWAP]
> vda             252:0    0  10G  0 disk
> vdb             252:16   0  10G  0 disk
> vdc             252:32   0  10G  0 disk
> vdd             252:48   0  10G  0 disk
>=20
> Thanks,
> Zhenyu
>=20


