Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 19:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0E52065F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 19:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmOt6wH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0E52065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvnXf-0007GI-W1
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 15:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jvnX5-0006pH-Rt
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 15:57:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58734
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jvnX2-0002NQ-Su
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 15:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594843049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMYeVpzZujOS4X+0l6Lfg6+KSd7X84nrQM0K1wWhVcY=;
 b=SmOt6wH/caPStynbTZxs7jE4+ztVqnGz5r2KqRZMA6Q/KpOMqQONMy3A5AT+/2iKP8oI0x
 84VN56laV126Oq2+3yAEOz2iUnlnrpoHBbWZ5onXnJCOtogOUSsvFQhpxGGXJH9gn+z+/6
 R5BdH2eueh8CXeGKx1Q6y09WS/1s134=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-10q5ZkL0MxyP9DDs7ghsLA-1; Wed, 15 Jul 2020 15:57:26 -0400
X-MC-Unique: 10q5ZkL0MxyP9DDs7ghsLA-1
Received: by mail-io1-f72.google.com with SMTP id b133so2089141iof.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 12:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iMYeVpzZujOS4X+0l6Lfg6+KSd7X84nrQM0K1wWhVcY=;
 b=nUSdvtaT2eFX5aYnfKhqonllleIEBU2EIUCxF3Ikuy17rlfihgLS9UJO3nMRE1oI4K
 Qg85M35+mRmjpVgc4Z4SYQ/eBeoJGusdBDZCV2TmWyUScoTVVOjZle3m3HM1cBvVNmDx
 kpgxtSq+SqovfGV11ZDotdr/hEwc8sekntUfkLaRqcnsp3orjs90G6O22yQp9aRg9O6+
 inRq4jP+vqav7PwC5Ai4KuP2y0k9qKJq3FghexUUKwdGUddBjE+S4GGE3c8WtTy7Bfcu
 +1CmS1KhEqVhyKizTNvdeWPhxBt18JnAK9oNBQ+zCNtwJkPCDWRVDr3wtTdoTHYV54kQ
 RU1g==
X-Gm-Message-State: AOAM5335gILTF0IB+sNiALcHRpfATAUfNWbmGspYyRlFpYwEXuij5xUL
 eORoBuztQYcMNulb4EFp4bY4eUn50eI/GGjOJMpMD1ZynF+ClJ1Mp1DArgAi9hmCQSuIbUJQR+1
 eJJwypCSxjUq1QbMJKrd6T1XqLrUjuIE=
X-Received: by 2002:a92:c0c9:: with SMTP id t9mr1249320ilf.82.1594843045485;
 Wed, 15 Jul 2020 12:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhtSP0yq4ayKML9DGmfzV2RBSC6N7Yiq3xuEyq3Ff5BwrL4yV/0lR0ZrN3sFOpgH1/a2Yw5ktAnKBXhJNVRoo=
X-Received: by 2002:a92:c0c9:: with SMTP id t9mr1249299ilf.82.1594843045186;
 Wed, 15 Jul 2020 12:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
 <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
 <CAFEAcA8BtVkBbHtLt-kB-AcZnN9YWtBahKTQ0wSvHWojF9CinQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8BtVkBbHtLt-kB-AcZnN9YWtBahKTQ0wSvHWojF9CinQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Jul 2020 23:57:14 +0400
Message-ID: <CAMxuvaxUqrq77_io9j6k7EU91vm7iEEBaTwLNsKd9YJ9NVR7rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: Peter Maydell <peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joe Slater <joe.slater@windriver.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "MacLeod,
 Randy" <randy.macleod@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jul 15, 2020 at 11:37 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 16 Jun 2020 at 10:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 16 Jun 2020 at 00:00, Joe Slater <joe.slater@windriver.com> wrote:
> > >
> > > Always look for ../share/qemu then ../pc-bios when looking for datadir.
> >
> > Could you provide some more context, please? Why is this
> > change useful; presumably we broke some setup in 5.0, but
> > what exactly ?
> >
> > I'm guessing this might be a regression introduced by commit
> > 6dd2dacedd83d12328 so I'm ccing the relevant people.
>
> Marco, Paolo: ping? Another user has just asked me the status
> of this as they also ran into this regression in what directories
> we search...

Thanks for the heads-up, I didn't see that bug/mail. Indeed, that
commit assumed that either we run from a build directory or from an
installed qemu. It seems this is hybrid approach, which I didn't know
we supported. I'll check it.

cheers

>
> thanks
> -- PMM
>
>
> > > Signed-off-by: Joe Slater <joe.slater@windriver.com>
> > > ---
> > >  os-posix.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/os-posix.c b/os-posix.c
> > > index 3cd52e1e70..f77da94bf6 100644
> > > --- a/os-posix.c
> > > +++ b/os-posix.c
> > > @@ -82,8 +82,9 @@ void os_setup_signal_handling(void)
> > >
> > >  /*
> > >   * Find a likely location for support files using the location of the binary.
> > > + * Typically, this would be "$bindir/../share/qemu".
> > >   * When running from the build tree this will be "$bindir/../pc-bios".
> > > - * Otherwise, this is CONFIG_QEMU_DATADIR.
> > > + * Otherwise, this is CONFIG_QEMU_DATADIR as constructed by configure.
> > >   */
> > >  char *os_find_datadir(void)
> > >  {
> > > @@ -93,6 +94,12 @@ char *os_find_datadir(void)
> > >      exec_dir = qemu_get_exec_dir();
> > >      g_return_val_if_fail(exec_dir != NULL, NULL);
> > >
> > > +    dir = g_build_filename(exec_dir, "..", "share", "qemu", NULL);
> > > +    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> > > +        return g_steal_pointer(&dir);
> > > +    }
> > > +    g_free(dir);  /* no autofree this time */
> > > +
> > >      dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
> > >      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> > >          return g_steal_pointer(&dir);
> > > --
> > > 2.17.1
>


