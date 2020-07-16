Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B82FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C85206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibFiya5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C85206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvyQx-0006GA-J5
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 03:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvyOT-0003vQ-4R
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:33:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvyOQ-0008LT-De
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594884800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQapggv2ZpDbOuefqhJPUM9GuRgISpJ2vvuWQpgvqfI=;
 b=ibFiya5Be/nr/uarEbetlBF7l8MweUw5xvCHNgaBa57/OLXXwazhPVj0T2LZcxPCxs8hkY
 7+IIx6sFrRSiiNSk0aqhNRQs3OQx+IW/61olLaz2XGFC54PpnjcFjY+QRo60lolB+2XGPa
 Ky0uddqafZojdbxlxiIxUi4TdFane3w=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-pVzpEz9mM1u4yIVdFkcOPw-1; Thu, 16 Jul 2020 03:33:19 -0400
X-MC-Unique: pVzpEz9mM1u4yIVdFkcOPw-1
Received: by mail-ot1-f70.google.com with SMTP id e48so2288599ote.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 00:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hQapggv2ZpDbOuefqhJPUM9GuRgISpJ2vvuWQpgvqfI=;
 b=j+Y2FtNbz5B+bhbHPtWW4NzDVNtEm/xspxsgFRfb6SndytRhs3zDlvNbAZl8gGtbJh
 Gw7JesK7b/cxFmErK6YYGaK6kn1namrOs5A62ORtAm28qr0LKr2K0lc5TfWzZzWYeEmA
 ym+0+MGAXvSNoTa7a/JfYUFcns8qyj1aFSPicVeKxEz9/x65SfvIQcITrWxl3udVyKrb
 XJgeDMLNPNi8m+JsyjxpK/kh7aYzH6oxLVP7jxBnjWwrvv2PeBP6f3Ri0gvvYyAT485A
 PS4KW207hKCFEI/JlUhfB2v5vNOCxCwepcjB9GuGygt+PZ5zopAYkhxuc+6YlBUhC3Sq
 I9yA==
X-Gm-Message-State: AOAM5335UCj4Y35ztVrmELBRefbzCZnkSWcbsAcNs+cfLYrRzZKBb6+v
 ecZtWbnfZyRqi0oHsyIje3uFbZ4heYDmEOtXpQ+ZWZfEKJYAFdVmJberLpMA8fG/HizXHjHyutm
 fKr6PaQOeFuhhpZfm9WEaVC/a4360xDc=
X-Received: by 2002:a9d:12f7:: with SMTP id g110mr3359921otg.79.1594884798345; 
 Thu, 16 Jul 2020 00:33:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUj2qKc/xiSXiAiUwxgVOgCf8L6ZkT/2GClY5rkaPDAo9ZsPdU2Ge5PvPsEW7r9yV1tLM0bLMsVjO4K5puCwE=
X-Received: by 2002:a9d:12f7:: with SMTP id g110mr3359901otg.79.1594884798071; 
 Thu, 16 Jul 2020 00:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200716055655.24507-1-thuth@redhat.com>
 <ec2ae831-d666-3d0c-a8f3-0e16e2ffd3d1@amsat.org>
In-Reply-To: <ec2ae831-d666-3d0c-a8f3-0e16e2ffd3d1@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 16 Jul 2020 09:33:07 +0200
Message-ID: <CAP+75-U-wp3zyLqyWh8xTd-No1gMMqLW8sSgAibYpNWWSC293g@mail.gmail.com>
Subject: Re: [PATCH] configure: Fix for running with --enable-werror on macOS
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 9:32 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/16/20 7:56 AM, Thomas Huth wrote:
> > The configure script currently refuses to succeed when run on macOS
> > with --enable-werror:
> >
> >  ERROR: configure test passed without -Werror but failed with -Werror.
> >
> > The information in config.log indicates:
> >
> >  config-temp/qemu-conf.c:3:55: error: control reaches end of non-void
> >  function [-Werror,-Wreturn-type]
> >  static void *f(void *p) { pthread_setname_np("QEMU"); }
> >                                                       ^
> > And indeed, the return statement is missing here.
>
> I have a similar commit dated "2019-07-13 17:13:51" that fixes that too,
> because I had problem with a CI (cirrus?). I remember there was a
> discussion about it, as I can't find on the list, I suppose it was
> discussed on IRC.
> I don't remember the outcome, it was negative or the patch was
> incomplete. I'm happy if it get fixed, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Oops the other one:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>
> >
> > Fixes: 479a57475e ("util: Implement debug-threads for macOS")
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  Note: There is another issue with --enable-werror on macOS, with the
> >        atomic64, which I haven't quite figured out yet, so compiling
> >        with --enable-werror is still not working there.
> >
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index b751c853f5..e93836aaae 100755
> > --- a/configure
> > +++ b/configure
> > @@ -4198,7 +4198,7 @@ pthread_setname_np_wo_tid=3Dno
> >  cat > $TMPC << EOF
> >  #include <pthread.h>
> >
> > -static void *f(void *p) { pthread_setname_np("QEMU"); }
> > +static void *f(void *p) { pthread_setname_np("QEMU"); return NULL; }
> >  int main(void)
> >  {
> >      pthread_t thread;
> >
>
>


