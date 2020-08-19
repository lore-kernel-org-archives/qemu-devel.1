Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB84C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0342067C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPrqoKXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0342067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SIW-0008BE-2w
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 13:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k8SHk-0006k1-D0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:54:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k8SHj-0005ah-05
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597859638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3IN7qKQY0CuWK/Sl2ONNUWcdZTo9bruxn5iAEAKvGCs=;
 b=ZPrqoKXecMCrQL/4IIC/TDC8Tu09ROLFepPIXY6D02Xu2pEZehxxFp8M9wLHEZiFwy5oOg
 u5FDuFU+ZUGwQcLAlK3OjbjFAvHAjzzaDUtojVxs8awtxwuB3VePLtYcD9LXxBQ45SPjTf
 gyVAZjD+akRNeS59BpQWCmWWjD/MqTI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-IZjlFTM6Ob2DSu_xAuMlqw-1; Wed, 19 Aug 2020 13:53:53 -0400
X-MC-Unique: IZjlFTM6Ob2DSu_xAuMlqw-1
Received: by mail-qv1-f69.google.com with SMTP id z10so16202128qvm.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 10:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3IN7qKQY0CuWK/Sl2ONNUWcdZTo9bruxn5iAEAKvGCs=;
 b=ZsKnO1/Fjt7WTaTVvBENrTR4UlWSkzxbFZwx2KmMguK7YNqVlw1q/t2b7agG4pnrRd
 V1P+t3MG5vFtKWtl+VWJ+jHohA9J+203ceL4xMZzhmeTcPcE89cOFUrb7vIFtzpR/HhU
 8jtnYYItvtTqo0z/L9zgCKSigGk3paOvRq7x/0mYentqS1L2BxGWR+djTQMJ16daVLNm
 Ya12Fwo7e7+hZykfBWrtjcHlJrCddBh0JrxacpMNqzI5T4j45IiwMBFm8NHBJf6vmnRR
 EKAk4yRssDa4PB+OWBJZEBKVJtyIu5SWHWTGedel7VzWpekAKkRnzhF0hTlUFzj4nIrC
 cwKQ==
X-Gm-Message-State: AOAM532RJkWRX6nPdv2YuL3ML8ix3svJ9oKXS0kmqOgMUeroj+z2CzXv
 NWOomCk6M77lGL06+5H0qNx32K6wQnVws7Xufs7CzXupyNH5GM7ZYVnZsO7lmBFEZc2Th2XeYTa
 Kejrq/zZADsCgTU+gQT0nxZrCm8Cp9NI=
X-Received: by 2002:ac8:4f4b:: with SMTP id i11mr22884999qtw.379.1597859633237; 
 Wed, 19 Aug 2020 10:53:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO0xDeTXmwUA506c3vcAlVWcTiXbSImEJscpTYLGKhz/y8mdOLZfAN3f0m8u2M627SHHR9G6rxSYUhfZeEAcE=
X-Received: by 2002:ac8:4f4b:: with SMTP id i11mr22884978qtw.379.1597859633038; 
 Wed, 19 Aug 2020 10:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200818130151.31678-1-eperezma@redhat.com>
 <20200818130151.31678-3-eperezma@redhat.com>
 <20200819164002.GB305409@xz-x1>
 <CAJaqyWfazchLdyeRrr6yn9SMyY7tkYoEwadQ=u2DUq39tjv07w@mail.gmail.com>
In-Reply-To: <CAJaqyWfazchLdyeRrr6yn9SMyY7tkYoEwadQ=u2DUq39tjv07w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Aug 2020 19:53:16 +0200
Message-ID: <CAJaqyWcaCT2=kRbog-b620s-kTvnRWFgeynGdC+HVmRBjekzqg@mail.gmail.com>
Subject: Re: [RFC v4 2/2] memory: Skip bad range assertion if notifier is
 DEVIOTLB type
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 7:47 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Aug 19, 2020 at 6:40 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 03:01:51PM +0200, Eugenio P=C3=A9rez wrote:
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > The changes on the callers of memory_region_notify_one_iommu() seems to=
 be
> > still missing (and, to embed the type into the notification process)..
> >
>
> Hi Peter.
>
> I thought that these were left for a future patch series (the main

s/that these were left/that we were going to left them/

> motivation was to avoid for guest code to hit the assertion).
>
> Do you want me to put them in this series?
>
> Thanks!
>
> > --
> > Peter Xu
> >


