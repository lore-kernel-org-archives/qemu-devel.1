Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D447C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D502073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcqOmvFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D502073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR06-00036u-G6
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlQz9-0001sL-Bl
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:51:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlQz7-0004O6-N3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:51:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id f185so622507wmf.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 22:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jxlSALHKim3gBbTJh91hfmw7yNYDqTGX6WVT3cFQzfc=;
 b=XcqOmvFn7shqprerfoWUZKc2VNMEJIzOo4ZYoivA/hR6nBR0J9bj8e9u6bZ+2Z5EQn
 DpUfXvwDDe2Lm56Slav8NhKbrtAeYIUEqSa008FPE+LR7Z79fNMNJEFzRVa20Jwfo2IN
 spdKG7F2utl9L0mFnovUm1N9GoBObKgWTW59H/hDqKZaXwl2LaZfysdqO53Il1h/m0EW
 68u9nIkVnXN4QNBRPchYm+kFbYkTd6qVGBOqYGE7/lQvm2VZIopa2YVlYKVQISsifiKr
 iTTfIzd+pAqy1lWA8FA7fb5l3eAno5zbgyBjlMG7SX1he4N0I/KAAARkeyfpVfQLtWRF
 dTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jxlSALHKim3gBbTJh91hfmw7yNYDqTGX6WVT3cFQzfc=;
 b=ZqeF9t4W29RZpyzEFsPx0x+b1oSmr9486c4Ek6CemuOZn1ygaqh98N7aVa2uceS8Wq
 V1K2iE2ES0j/cH7VzDD1GRKp3NadP8yDUSQUoexgyZaZ4HxBCHMkH06aztcOis2FYkPG
 g+lPvEiD9C4NSEoyjHCTBsXUTSUTbI9am6XM0daYx3XWzVxry9vn8ke+vSM309WIAHfi
 neF8OYBxlBVUbWXzGWBxU9kkKtIRfGZz+749oTpVhq5oWO5KlnASmVcDxRAqyBTAbuQw
 prJ4UlDDyapIW3pVBgGj+O5dGYQQV2Si7VtEynScz5lI30Dont3yG0sLy0o8diieSyPV
 +j/Q==
X-Gm-Message-State: AOAM532igXB+PXH09NiKOMhvRfK0s0nd6yc+zZQV6IdFszPOtd3loHfb
 I/EN/RpinKK4APQWOGBUBY+v0XnLsB15WtLcSX8=
X-Google-Smtp-Source: ABdhPJwDbkSuzSDddWgcVf8ommYr8b35fE3gf84VnlJ7PA92wk8IkZ4H7Bgu4sfVrPSaiuvY9a9du+fmiin4/2sAXqw=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr6367153wmf.129.1592373100142; 
 Tue, 16 Jun 2020 22:51:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Tue, 16 Jun 2020 22:51:39 -0700 (PDT)
In-Reply-To: <20200616231204.8850-2-ahmedkhaledkaraman@gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 17 Jun 2020 07:51:39 +0200
Message-ID: <CAHiYmc7b6rK8mej0vMs29iVbyzNOf4bvaPUuKPapWY6bos=m=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Add 'Miscellaneous' section
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000fbe80d05a84140b5"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fbe80d05a84140b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> This new section includes the 'Performance Tools and Tests' subsection
> which will contain the the performance scripts and benchmarks written
> as a part of the 'TCG Continuous Benchmarking' project.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---


I also think that the title of the patch should be 'Add 'Performance Tools
and Tests' subsection', since this is the core purpose of the patch - new
section 'Miscellaneous' is just a mean to achieve this.

Thanks,
Aleksandar




>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 955cc8dd5c..68f668ae2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2974,3 +2974,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: docs/conf.py
>  F: docs/*/conf.py
> +
> +Miscellaneous
> +-------------
> +Performance Tools and Tests
> +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +S: Maintained
> +F: scripts/performance/
> \ No newline at end of file
> --
> 2.17.1
>
>

--000000000000fbe80d05a84140b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This new section includ=
es the &#39;Performance Tools and Tests&#39; subsection<br>
which will contain the the performance scripts and benchmarks written<br>
as a part of the &#39;TCG Continuous Benchmarking&#39; project.<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>I also think that the title of the patc=
h should be &#39;Add &#39;Performance Tools and Tests&#39; subsection&#39;,=
 since this is the core purpose of the patch - new section &#39;Miscellaneo=
us&#39; is just a mean to achieve this.</div><div><br></div><div>Thanks,</d=
iv><div>Aleksandar</div><div><br></div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
=C2=A0MAINTAINERS | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 955cc8dd5c..68f668ae2a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2974,3 +2974,10 @@ M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell=
@linaro.org">peter.maydell@linaro.org</a>&gt;<br>
=C2=A0S: Maintained<br>
=C2=A0F: docs/conf.py<br>
=C2=A0F: docs/*/conf.py<br>
+<br>
+Miscellaneous<br>
+-------------<br>
+Performance Tools and Tests<br>
+M: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmed=
khaledkaraman@gmail.com</a>&gt;<br>
+S: Maintained<br>
+F: scripts/performance/<br>
\ No newline at end of file<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000fbe80d05a84140b5--

