Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB02C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 03:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55091216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 03:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hyper-sh.20150623.gappssmtp.com header.i=@hyper-sh.20150623.gappssmtp.com header.b="FCTNARzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55091216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hyper.sh
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzvEB-0006fk-En
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 23:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xu@hyper.sh>) id 1hztpW-0002gc-Jr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 22:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xu@hyper.sh>) id 1hztpU-0007aL-Sm
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 22:25:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:37495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <xu@hyper.sh>) id 1hztpT-0007S2-9d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 22:25:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 129so2359947pfa.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hyper-sh.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=BOrCHPbDmj29GjvyK+AXUXnogCx8AnGY5D7ncKnRZe0=;
 b=FCTNARznRU0/LMEaWtcLVI4mQrmxjHaWwJr1Y5h8C5A1XrDEyA9pBmNVWsrV48Q0Ja
 Lumz6bnXjmzfgQniEKu4tY/zlnfAc50VOhlcVa7zanAE6B/x1BLYZEsttJHWuZTdTmUJ
 I4sdihEvnZn8Cq2Q96Qe1l1D+J5t6Bg65Jb+dsF31c7ujiuD85tGi2W01ICBcFyFI/4H
 fsEkvjZIf/GaVfzLvYKFL4SUMK/rbZ+jRd4/C/Mrrb/a9Xd3+JgiIP7Xl8Wqr6nt+9Pi
 COd6/iY7ve1yFChEWrhnA5gXyL6iK153YZnsc4WkowmDYC9cyh4QxHb3I3XifhdbQMrr
 Zs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=BOrCHPbDmj29GjvyK+AXUXnogCx8AnGY5D7ncKnRZe0=;
 b=cxBcQZvCZ3vrTTmmJfSVfyXLRuPDhQsi7myAsxY/NWGfz09OCWl8QCh6geb7l8bj85
 HDynlxjxwSC1NCY7fsEOpgT+qg9XSbgWX7I+mYpjAx4oBKo6PZ7Xn1wFyPwouVUIZRUm
 ZU8+jeB20BT9qMIXCmLmKpnldmIDA9Zol1MfClzkbVswG4DRHfSO3ljKSTd1XKqZQ/ze
 XZevowMc9Pjrv+vSfAXlzIxPZWM57ryL90kwjhNg7XNIiNMNQwQeFi+Ga6XAikxtNSnW
 n/wIgaS0RL4r+B/scoUEH73ivcedQMIS6eD2ntfg4R50cnWEMyPtqCtN2HIFfByfep1R
 1AQg==
X-Gm-Message-State: APjAAAWlInVy6ShrYM76fbhiqJJWVbAxhui5CyFEN/ueSaXzrf7Fl9d+
 p1LKTr4RO0fMVeVoi7i896lNxQ==
X-Google-Smtp-Source: APXvYqz2qXEiSgUqoduH1/12N70qmcE0mEiteLrlux7Ymx8d1nAlo+O58FQroQlNvRYNY3317XjoZQ==
X-Received: by 2002:a63:2148:: with SMTP id s8mr22201245pgm.336.1566267895646; 
 Mon, 19 Aug 2019 19:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([47.88.5.130])
 by smtp.gmail.com with ESMTPSA id s11sm15279001pgv.13.2019.08.19.19.24.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Aug 2019 19:24:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Xu Wang <xu@hyper.sh>
In-Reply-To: <20190819160426.GB2625@stefanha-x1.localdomain>
Date: Tue, 20 Aug 2019 10:24:48 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C829E80-50E4-496D-82AF-FCA46C5DEE3D@hyper.sh>
References: <20190819160426.GB2625@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
X-Mailman-Approved-At: Mon, 19 Aug 2019 23:53:52 -0400
Subject: Re: [Qemu-devel] [kata-dev] [ANNOUNCE] virtio-fs v0.3 release
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks all the contributors, looking forward to having a product =
virtio-fs deployment shortly.

> On Aug 20, 2019, at 12:04 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> I am delighted to announce the release of virtio-fs v0.3, a shared =
file
> system that lets virtual machines access a directory tree on the host.
> This release is based on QEMU 4.1.0 and Linux 5.3-rc3.
>=20
> For more information about virtio-fs: https://virtio-fs.gitlab.io/
>=20
> This is a development release aimed at early adopters of virtio-fs.  =
Work is
> being done to upstream the code into Linux and QEMU.  We expect to =
stop
> publishing virtio-fs releases once the code has been merged by these =
upstream
> projects.
>=20
> Where to get it:
>=20
>  https://gitlab.com/virtio-fs/linux/-/tags/virtio-fs-v0.3
>  https://gitlab.com/virtio-fs/qemu/-/tags/virtio-fs-v0.3
>=20
> Changes:
>=20
> * Please note that the mount syntax has changed to:
>=20
>     # mount -t virtio_fs myfs /mnt -o ...
>=20
>   The old syntax was "mount -t virtio_fs none /mnt -o tag=3Dmyfs,...".
>=20
> * virtiofsd --fd=3DFDNUM takes a listen socket file descriptor number. =
 File
>   descriptor passing is an alternative way to manage the vhost-user =
UNIX
>   domain socket.  The parent process no longer needs to wait for =
virtiofsd to
>   create the listen socket before spawning the VM.
>=20
> * virtiofsd --syslog logs to syslog(2) instead of stderr.  Useful for =
unifying
>   logging and when the virtiofsd process is not being supervised.
>=20
> * virtiofsd --thread-pool-size=3DNUM sets the maximum number of worker =
threads
>   for FUSE request processing.  This can be used to control the host =
queue
>   depth.  The default is 64.
>=20
> * Performance improvements and bug fixes.
>=20
> Note for Kata Containers: the new kernel is not compatible with =
existing
> Kata Containers releases due to the mount syntax change.  To try it =
out,
> please apply the following kata-runtime patch:
>=20
>  =
https://gitlab.com/virtio-fs/runtime/commit/a2e44de817e438c02a495cf2580397=
74527e3178
>=20
> Kata Containers patches for virtio-fs v0.3 are under development and =
will be
> submitted to Kata soon.
>=20
> Thanks to the following people for contributing code and to many more
> for helping the virtio-fs effort:
>=20
> Dr. David Alan Gilbert <dgilbert@redhat.com>
> Eric Ren <renzhen@linux.alibaba.com>
> Eryu Guan <eguan@linux.alibaba.com>
> Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
> Jiufei Xue <jiufei.xue@linux.alibaba.com>
> Liu Bo <bo.liu@linux.alibaba.com>
> Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Miklos Szeredi <mszeredi@redhat.com>
> Peng Tao <tao.peng@linux.alibaba.com>
> piaojun <piaojun@huawei.com>
> Sebastien Boeuf <sebastien.boeuf@intel.com>
> Stefan Hajnoczi <stefanha@redhat.com>
> Vivek Goyal <vgoyal@redhat.com>
> Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> _______________________________________________
> kata-dev mailing list
> kata-dev@lists.katacontainers.io
> http://lists.katacontainers.io/cgi-bin/mailman/listinfo/kata-dev


