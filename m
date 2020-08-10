Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C073C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 07:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF382073A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 07:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Sa4y/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF382073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k52Hb-0002gp-5j
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 03:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k52Gx-0002HP-Ju
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 03:31:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k52Gs-00030W-T6
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 03:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597044661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yx/8qsA5k+d+vGx60dwL8ZRTQ1PJGd7Gw0jOR5jgoOo=;
 b=V4Sa4y/7UZMX5ExxsrIz6OBB4fHjCd2QX4L9HzJThnemowOB5+Y8mO+ZTIritOzORVw3xW
 jjw4EBwt+WKvHCWeIK+dl67lu38WghC7zn2GrSNSZ5XHLkxstchtuRHvnKSaGneKxjzKjT
 mfi1xLHx3dgKG10cL8tVk0DYnFZBmKs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-ICCr7dt1MrquFgMI4n76BA-1; Mon, 10 Aug 2020 03:29:21 -0400
X-MC-Unique: ICCr7dt1MrquFgMI4n76BA-1
Received: by mail-io1-f72.google.com with SMTP id p12so1679903iom.18
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 00:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yx/8qsA5k+d+vGx60dwL8ZRTQ1PJGd7Gw0jOR5jgoOo=;
 b=W2SF8L6AyPrS+qojSoFciVoHwQPxzuhwDiwNMhslFmlQiIuOEZs4huicnqxB03imWO
 IPReBCBxpR2DTcTD1GOrJ8qtM5lxJJ4/6FT4jv7W6wyFxATQPPU4ei6ejutZMM4h/EMY
 uUE+X2js1l9Akqg/UQrXG/mrDoO/yuglX6PXBpl0FZJ23LD26jh6Wt+ZGVV6KF2vwX5d
 blhKmpdGNt0g9CMtfCz0kKOf/lfsUCre9aDw6IvpOpOZenPg5ww2XLcKE4kjLpgaGIuD
 GQ+7QLgY2SX3vRNunVCDkXryzFAcXwNsKUNC3gFh7IHRJK8Duqz5y2RxEyegWpdTv1CJ
 +9hg==
X-Gm-Message-State: AOAM533CJyxtHDP9wtq0wK2dqQlGXxurpE2bReZQDlIvT8n+7P5tOD6L
 rY6QT3oVPxmgrMRdGF16cjW50AJBiWyPCbZkRavgKJo0uQY2VjRJg1oJ02eiyNJfIeSI+Ce07z0
 kFLNNAB8oZeduyc7DdHbt2c1zrMiOKKk=
X-Received: by 2002:a6b:e211:: with SMTP id z17mr16059774ioc.82.1597044560579; 
 Mon, 10 Aug 2020 00:29:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFrS5OXp5QlL3vwwz0vmcN/1T0fL5GUQuS/skuNglwOB0xMYhik0b/YzpZw/IIpZalahWZsw8Z+GkS6Z7Dx5Q=
X-Received: by 2002:a6b:e211:: with SMTP id z17mr16059759ioc.82.1597044560365; 
 Mon, 10 Aug 2020 00:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
 <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
 <CAFEAcA8BtVkBbHtLt-kB-AcZnN9YWtBahKTQ0wSvHWojF9CinQ@mail.gmail.com>
 <CAMxuvaxUqrq77_io9j6k7EU91vm7iEEBaTwLNsKd9YJ9NVR7rw@mail.gmail.com>
 <20200808013531.GA166030@google.com>
 <CAFEAcA__4GwKKe9rY4ut41f-S-u_AnSkdwHvSX0YoaPwjO3ARw@mail.gmail.com>
In-Reply-To: <CAFEAcA__4GwKKe9rY4ut41f-S-u_AnSkdwHvSX0YoaPwjO3ARw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 10 Aug 2020 11:29:08 +0400
Message-ID: <CAMxuvaw1Rpah2ErvGQWdD+K+KU=PFpfyNnM-95s5UUSXY6zj6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joe Slater <joe.slater@windriver.com>,
 Brian Norris <briannorris@chromium.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "MacLeod,
 Randy" <randy.macleod@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sat, Aug 8, 2020 at 7:34 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Sat, 8 Aug 2020 at 02:35, Brian Norris <briannorris@chromium.org> wrot=
e:
> >
> > Hello!
> >
> > On Wed, Jul 15, 2020 at 11:57:14PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi
> > >
> > > On Wed, Jul 15, 2020 at 11:37 PM Peter Maydell <peter.maydell@linaro.=
org> wrote:
> > > >
> > > > On Tue, 16 Jun 2020 at 10:19, Peter Maydell <peter.maydell@linaro.o=
rg> wrote:
> > > > >
> > > > > On Tue, 16 Jun 2020 at 00:00, Joe Slater <joe.slater@windriver.co=
m> wrote:
> > > > > >
> > > > > > Always look for ../share/qemu then ../pc-bios when looking for =
datadir.
> > > > >
> > > > > Could you provide some more context, please? Why is this
> > > > > change useful; presumably we broke some setup in 5.0, but
> > > > > what exactly ?
> > > > >
> > > > > I'm guessing this might be a regression introduced by commit
> > > > > 6dd2dacedd83d12328 so I'm ccing the relevant people.
> > > >
> > > > Marco, Paolo: ping? Another user has just asked me the status
> > > > of this as they also ran into this regression in what directories
> > > > we search...
> > >
> > > Thanks for the heads-up, I didn't see that bug/mail. Indeed, that
> > > commit assumed that either we run from a build directory or from an
> > > installed qemu. It seems this is hybrid approach, which I didn't know
> > > we supported. I'll check it.
> >
> > Add one more to the pile! Chrome OS noticed this when upgrading to
> > 5.0.0:
> >
> > https://bugs.chromium.org/p/chromium/issues/detail?id=3D1114204#c8
> >
> > I'd love to see this applied to a release.
>
> It's just missed 5.1, unfortunately :-(
>
> Marc-Andr=C3=A9, did you want to review it ?

I tried an alternative approach, and ack his version instead:

https://patchew.org/QEMU/20200716141100.398296-1-marcandre.lureau@redhat.co=
m/

(I am going to do this in this thread instead)


