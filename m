Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB55C2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C73216C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="m9djjnEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C73216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6GS-0000V6-M4
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 23:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kN6Fm-0008Mb-0s
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:24:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:45653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kN6Fh-0007gb-5j
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:24:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id x22so3141032pfo.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nven6VN6iAJYLf+Q6ct/3DtVEVRwJWGsmZwivX5VO2Y=;
 b=m9djjnEePz6WgDdT6C96Ra3pBE+ZKB7F7Gpl8EjtvpmULniA0ycelaPzT3XnRoKma/
 Q805qQzo7GiOYKcQM0F6Ap+YzjcJNGC0/FG06qCF0MvAjeKMDU0YY6wCyDEK8iHL38EZ
 PKCf1kn0gkrU0HeOsTe2bp+YzUSrJfBTnceVNndREjalykfQcV/UfQpFXiWJjnao7Klq
 z/TzketBY9/ORQMIKwQ1ia4/uuboVWj9v+tmUr0Phxr622Ruup7cBxWxr8eJz1WyBlgt
 tgqACObJuxgZWm4uEXvHu/3d7DyKuk2CCbjxJuuld6Yl3CndPuwqTagVyoJPcBq8KYE4
 tM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nven6VN6iAJYLf+Q6ct/3DtVEVRwJWGsmZwivX5VO2Y=;
 b=bGKd/+Bcv/lm37TG7LeooW1bbmlj1eDjIvMhRVGD8IrWTa++iXfQkMLpDEdnBL9z63
 a/3FOVm7tbTgqfLWkt0BjF/pqNgz+peOxERi7K6URZfQDB9H05l0PydtCJOJ2w7Bakmk
 6yV1EQUHA9pM51ARSDmnhvvLDpIb/dZTS7CQKNpgd9Be2iuuptHrbhYEAL5Ma7BtVca2
 KJjRyaTaxFjvDI+dzko2dD7xjOlDJ/hxWFWE0003oNXyeWh6bHxcjZVAarmSmGODtGE/
 wjeJ+FcDUtdPHJZ10oYR06L89fCW6/+xYPWJnnpAm1WsBpEb34iYtMGJx9Jbohk7w0ur
 FncQ==
X-Gm-Message-State: AOAM531LYw/SxYYG7Lef46DlwgT/Q+57RfrJF31aKR+eZXnQrFgM1GOG
 AdgIUHWZ295AucCVZc5NBDp7oXXTJCG2JhVL7PMadw==
X-Google-Smtp-Source: ABdhPJzox1awoXwDyYWTHRPgitnCj6y5lcNAJ9+Tw81pA6BOXpOr1vtIey/PSaj3GYEZf6NOPAw+l/LGk9xHyGNMIfQ=
X-Received: by 2002:a17:902:bc8a:b029:d2:2a0b:f09e with SMTP id
 bb10-20020a170902bc8ab02900d22a0bf09emr2538869plb.33.1601349865639; Mon, 28
 Sep 2020 20:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200824043121.13421-1-wanghonghao@bytedance.com>
 <20200824043121.13421-2-wanghonghao@bytedance.com>
 <20200825145250.GB7124@stefanha-x1.localdomain>
 <CADzM5uQnVRPaH6Xtef95BMJtLRCgNq2OcaMQi0xTG-dxUjJ1Fg@mail.gmail.com>
In-Reply-To: <CADzM5uQnVRPaH6Xtef95BMJtLRCgNq2OcaMQi0xTG-dxUjJ1Fg@mail.gmail.com>
From: =?UTF-8?B?546L5rSq5rWp?= <wanghonghao@bytedance.com>
Date: Tue, 29 Sep 2020 11:24:14 +0800
Message-ID: <CADzM5uRNSZurnZ-wm8-FG7H3y7_bg+V5oNo4AjNiFSWmMJcijA@mail.gmail.com>
Subject: PING: [PATCH 2/2] coroutine: take exactly one batch from global pool
 at a time
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I'd like to know if there are any other problems with this patch,
or if there is a better implement to improve coroutine pool.

=E7=8E=8B=E6=B4=AA=E6=B5=A9 <wanghonghao@bytedance.com> =E4=BA=8E2020=E5=B9=
=B48=E6=9C=8826=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:06=E5=86=99=
=E9=81=93=EF=BC=9A

>
> The purpose of this patch is to improve performance without increasing
> memory consumption.
>
> My test case:
> QEMU command line arguments
> -drive file=3D/dev/nvme2n1p1,format=3Draw,if=3Dnone,id=3Dlocal0,cache=3Dn=
one,aio=3Dnative \
>     -device virtio-blk,id=3Dblk0,drive=3Dlocal0,iothread=3Diothread0,num-=
queues=3D4 \
> -drive file=3D/dev/nvme3n1p1,format=3Draw,if=3Dnone,id=3Dlocal1,cache=3Dn=
one,aio=3Dnative \
>     -device virtio-blk,id=3Dblk1,drive=3Dlocal1,iothread=3Diothread1,num-=
queues=3D4 \
>
> run these two fio jobs at the same time
> [job-vda]
> filename=3D/dev/vda
> iodepth=3D64
> ioengine=3Dlibaio
> rw=3Drandrw
> bs=3D4k
> size=3D300G
> rwmixread=3D80
> direct=3D1
> numjobs=3D2
> runtime=3D60
>
> [job-vdb]
> filename=3D/dev/vdb
> iodepth=3D64
> ioengine=3Dlibaio
> rw=3Drandrw
> bs=3D4k
> size=3D300G
> rwmixread=3D90
> direct=3D1
> numjobs=3D2
> loops=3D1
> runtime=3D60
>
> without this patch, test 3 times:
> total iops: 278548.1, 312374.1, 276638.2
> with this patch, test 3 times:
> total iops: 368370.9, 335693.2, 327693.1
>
> 18.9% improvement in average.
>
> In addition, we are also using a distributed block storage, of which
> the io latency is much more than local nvme devices because of the
> network overhead. So it needs higher iodepth(>=3D256) to reach its max
> throughput.
> Without this patch, it has more than 5% chance of calling
> `qemu_coroutine_new` and the iops is less than 100K, while the iops is
> about 260K with this patch.
>
> On the other hand, there's a simpler way to reduce or eliminate the
> cost of `qemu_coroutine_new` is to increase POOL_BATCH_SIZE. But it
> will also bring much more memory consumption which we don't expect.
> So it's the purpose of this patch.
>
> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:52=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Mon, Aug 24, 2020 at 12:31:21PM +0800, wanghonghao wrote:
> > > This patch replace the global coroutine queue with a lock-free stack =
of which
> > > the elements are coroutine queues. Threads can put coroutine queues i=
nto the
> > > stack or take queues from it and each coroutine queue has exactly
> > > POOL_BATCH_SIZE coroutines. Note that the stack is not strictly LIFO,=
 but it's
> > > enough for buffer pool.
> > >
> > > Coroutines will be put into thread-local pools first while release. N=
ow the
> > > fast pathes of both allocation and release are atomic-free, and there=
 won't
> > > be too many coroutines remain in a single thread since POOL_BATCH_SIZ=
E has been
> > > reduced to 16.
> > >
> > > In practice, I've run a VM with two block devices binding to two diff=
erent
> > > iothreads, and run fio with iodepth 128 on each device. It maintains =
around
> > > 400 coroutines and has about 1% chance of calling to `qemu_coroutine_=
new`
> > > without this patch. And with this patch, it maintains no more than 27=
3
> > > coroutines and doesn't call `qemu_coroutine_new` after initial alloca=
tions.
> >
> > Does throughput or IOPS change?
> >
> > Is the main purpose of this patch to reduce memory consumption?
> >
> > Stefan

