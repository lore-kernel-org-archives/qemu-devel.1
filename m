Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00813C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7434206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2JGRbrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7434206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrQ3-0002vn-TO
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kDrOK-0000lN-CO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:43:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kDrOI-0002vA-AP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599147789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tnEwLqH8x0/EokZdPkG1renPCJr01LJODqzCvmqzLc=;
 b=i2JGRbrAO/APSRqtzsyGHgHJxc/ZfBWYwykNRQyW1XIM/AsrfU1vgboDd9jkT0iFhF947D
 oJzuUa0AgUrlLsw6rLaPvGh4bYvR4hZBv//OzpIa5LOtgpwRqOgknjhCSwmNxNgqpPYZNv
 ynJ3VeLRB+cbsICRu5TvEqf5nepe3PE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-xSnw9O2POgCFfwsOZCF-0g-1; Thu, 03 Sep 2020 11:43:07 -0400
X-MC-Unique: xSnw9O2POgCFfwsOZCF-0g-1
Received: by mail-io1-f69.google.com with SMTP id i1so2344673iom.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1tnEwLqH8x0/EokZdPkG1renPCJr01LJODqzCvmqzLc=;
 b=YBmuEA9sZ1eEyNFOJv+WS2I0TN5TkOYY2seZVSiyICbdBDHIlYcvCUhshZoVyq5gMl
 QG+VUXp2++FepAbKjKwY5VS+oX9WWpIDtfGUdc5p6Ok5PPOim2kzaqI215SO2ny+Ejh4
 jD2d0AP8gpBjBreGTMU2iAG770Kd9Ay5tMYexSBP04KOB7veYcxS5ba4eJ27i89g7Ga9
 4qSIUi3w5RW3qs3KvfPqEFKAznqAvGzNWAysE/EmckqDJ9YUS47/73EBItqA4/7/414Z
 ZpkfIVKWPKlgyMCgfRxBwDJ7e7QzEK1yzfzzH2kYoupuN6sjbPV7CYLvx6GEVmGZVBtd
 8sDA==
X-Gm-Message-State: AOAM532H9wR6dTv4hz1z+3r1TRS7iew87fzPxRVaEthvKIG9epNqvCCi
 CqvnUyjp8XmG8N9Xq21ApFSxhfjMK/2nXGzr3kkYhTi3S61C4uY8SpWU8sOZfoioo8aUdCAwxUr
 A/s+V5OgHuufJyYVJANchgAjK2eRGusk=
X-Received: by 2002:a92:4f:: with SMTP id 76mr3635254ila.11.1599147787137;
 Thu, 03 Sep 2020 08:43:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0T0AljdESFoHIzNioJ02UQj4OfKtn7rL/Ydei1WtqdD4s/3tsWUQljZOYpp/XlQP0P0oQArHu+dHvXc3HG5E=
X-Received: by 2002:a92:4f:: with SMTP id 76mr3635240ila.11.1599147786907;
 Thu, 03 Sep 2020 08:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200903153524.98168-1-brogers@suse.com>
In-Reply-To: <20200903153524.98168-1-brogers@suse.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 3 Sep 2020 19:42:55 +0400
Message-ID: <CAMxuvayzXH33FQ=Rf5+LNv5F-pTHvMUCA8M-E_7-5nOTLC97Cg@mail.gmail.com>
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
To: Bruce Rogers <brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Sep 3, 2020 at 7:35 PM Bruce Rogers <brogers@suse.com> wrote:
>
> Turn on the meson install flag for these executables
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>

I am not sure we want to install binaries that don't even have
maintainers (or am I wrong?).

> ---
>  contrib/ivshmem-client/meson.build | 2 +-
>  contrib/ivshmem-server/meson.build | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
> index 1b171efb4f..83a559117f 100644
> --- a/contrib/ivshmem-client/meson.build
> +++ b/contrib/ivshmem-client/meson.build
> @@ -1,4 +1,4 @@
>  executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
>             dependencies: glib,
>             build_by_default: targetos == 'linux',
> -           install: false)
> +           install: true)
> diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
> index 3a53942201..a1c39aa3b3 100644
> --- a/contrib/ivshmem-server/meson.build
> +++ b/contrib/ivshmem-server/meson.build
> @@ -1,4 +1,4 @@
>  executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
>             dependencies: [qemuutil, rt],
>             build_by_default: targetos == 'linux',
> -           install: false)
> +           install: true)
> --
> 2.28.0
>


