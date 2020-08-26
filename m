Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C0A206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="IM+kEfvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C0A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAoaU-0006to-Va
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 02:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kAoZy-0006TE-On
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 02:06:38 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kAoZu-00077g-3L
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 02:06:36 -0400
Received: by mail-pj1-x1043.google.com with SMTP id nv17so388274pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 23:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hTYlHJ143WkiPjrmc+Yyb3SEQvoS3KTQBedP5iaAS3I=;
 b=IM+kEfvgPjl8pYjifhCRdGjJTcRTEErFdgw0WTHIwYB4X4SXp2AyH5IZhWwU4ALY4g
 0nJ1OQN5IM4A0XtUqkdqZapUXbRGnvYFoBhLA+JuML17+AkxJ5Ax7pJPHSQL6vW8BPLZ
 sGq798eKOoKpTdCDnQIdeQX0q7KWHWqBKlxUFICgPrKHur0ChTDo6Mx3l3JhzESznXx9
 iGmcJ5qLsu+CxuFIgWBMKgoQrb0SL4MK8/du+ZAqYffZ4Y/oU5bIVCBtJ2HCcNgnL2IW
 oYUdkNXON0X3LlQH6aDCWIiJ7n1T525+kzqD7Te4jKskUrv6j9+ggGwG0bwhB0U+exb9
 H4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hTYlHJ143WkiPjrmc+Yyb3SEQvoS3KTQBedP5iaAS3I=;
 b=jo+vmQplOV7F18vh+bf/xUwF8LT4cwhDLoUSXXtNc2nhjwoDrDXCa05j1dFAZXkIjq
 byV3AQ+lzKhEV64g/+QB/QetNxBVJeECKxfFNj8P9V618tYiPdS9EoLeUZ9CwJ4W9xE4
 fIvv1NM9eKnh0d+WnXAZqlmFASzTANqHxic9rDQ8GxRrPf06NV793I9W+kuG1X+Hyy1H
 SWgJgH1SMek/bjJ7Q5wvL+/UAi7bb0SOvUYOe3cG4V9D9Lm/KS26OtlzENUd/cWVY5DL
 6SYV3W34XqX4Zywpjyl9VA0g3MhhxEYUd2CtuZJQ03PWeAfSOe9KjJJKjs/QmcdLQ7fy
 d1sw==
X-Gm-Message-State: AOAM530QgzwKgBH2aKl+R1+OxE48/3MXgCaHmSxULjpjQPmPzOctpi7e
 ALHny2jj8V79avq4uFjPZo3aMzP5jd4hoKtP83E/dg==
X-Google-Smtp-Source: ABdhPJyTI4YoCRSQTfvh9t4c+RMLRnLn0fXFwak1CeWJye0hCLXbGlyV/UVe1j6LHgG41i3uSkUdqpD/0oLNPqxM5KA=
X-Received: by 2002:a17:90a:e00e:: with SMTP id
 u14mr4821502pjy.51.1598421990842; 
 Tue, 25 Aug 2020 23:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200824043121.13421-1-wanghonghao@bytedance.com>
 <20200824043121.13421-2-wanghonghao@bytedance.com>
 <20200825145250.GB7124@stefanha-x1.localdomain>
In-Reply-To: <20200825145250.GB7124@stefanha-x1.localdomain>
From: =?UTF-8?B?546L5rSq5rWp?= <wanghonghao@bytedance.com>
Date: Wed, 26 Aug 2020 14:06:19 +0800
Message-ID: <CADzM5uQnVRPaH6Xtef95BMJtLRCgNq2OcaMQi0xTG-dxUjJ1Fg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/2] coroutine: take exactly one batch from
 global pool at a time
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pj1-x1043.google.com
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

The purpose of this patch is to improve performance without increasing
memory consumption.

My test case:
QEMU command line arguments
-drive file=3D/dev/nvme2n1p1,format=3Draw,if=3Dnone,id=3Dlocal0,cache=3Dnon=
e,aio=3Dnative \
    -device virtio-blk,id=3Dblk0,drive=3Dlocal0,iothread=3Diothread0,num-qu=
eues=3D4 \
-drive file=3D/dev/nvme3n1p1,format=3Draw,if=3Dnone,id=3Dlocal1,cache=3Dnon=
e,aio=3Dnative \
    -device virtio-blk,id=3Dblk1,drive=3Dlocal1,iothread=3Diothread1,num-qu=
eues=3D4 \

run these two fio jobs at the same time
[job-vda]
filename=3D/dev/vda
iodepth=3D64
ioengine=3Dlibaio
rw=3Drandrw
bs=3D4k
size=3D300G
rwmixread=3D80
direct=3D1
numjobs=3D2
runtime=3D60

[job-vdb]
filename=3D/dev/vdb
iodepth=3D64
ioengine=3Dlibaio
rw=3Drandrw
bs=3D4k
size=3D300G
rwmixread=3D90
direct=3D1
numjobs=3D2
loops=3D1
runtime=3D60

without this patch, test 3 times:
total iops: 278548.1, 312374.1, 276638.2
with this patch, test 3 times:
total iops: 368370.9, 335693.2, 327693.1

18.9% improvement in average.

In addition, we are also using a distributed block storage, of which
the io latency is much more than local nvme devices because of the
network overhead. So it needs higher iodepth(>=3D256) to reach its max
throughput.
Without this patch, it has more than 5% chance of calling
`qemu_coroutine_new` and the iops is less than 100K, while the iops is
about 260K with this patch.

On the other hand, there's a simpler way to reduce or eliminate the
cost of `qemu_coroutine_new` is to increase POOL_BATCH_SIZE. But it
will also bring much more memory consumption which we don't expect.
So it's the purpose of this patch.

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 24, 2020 at 12:31:21PM +0800, wanghonghao wrote:
> > This patch replace the global coroutine queue with a lock-free stack of=
 which
> > the elements are coroutine queues. Threads can put coroutine queues int=
o the
> > stack or take queues from it and each coroutine queue has exactly
> > POOL_BATCH_SIZE coroutines. Note that the stack is not strictly LIFO, b=
ut it's
> > enough for buffer pool.
> >
> > Coroutines will be put into thread-local pools first while release. Now=
 the
> > fast pathes of both allocation and release are atomic-free, and there w=
on't
> > be too many coroutines remain in a single thread since POOL_BATCH_SIZE =
has been
> > reduced to 16.
> >
> > In practice, I've run a VM with two block devices binding to two differ=
ent
> > iothreads, and run fio with iodepth 128 on each device. It maintains ar=
ound
> > 400 coroutines and has about 1% chance of calling to `qemu_coroutine_ne=
w`
> > without this patch. And with this patch, it maintains no more than 273
> > coroutines and doesn't call `qemu_coroutine_new` after initial allocati=
ons.
>
> Does throughput or IOPS change?
>
> Is the main purpose of this patch to reduce memory consumption?
>
> Stefan

