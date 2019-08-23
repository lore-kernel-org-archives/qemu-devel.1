Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654C1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF952173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZqTJkgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF952173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1AR0-0004nm-7n
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1AKO-0007wA-Vs
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1AKN-0005aI-AL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:14:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1AKN-0005Zt-47
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:14:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id v12so7086890oic.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VZV4PSNWC1AgmJZyK/nkJbWzJ2/YUDtvq2HoFDjulv0=;
 b=EZqTJkgUt49DtsPZNj0llsQFWsRsv4DnjJ5Lgl0zUlucW/nVwcCwSWz1RzrWw5EjRV
 wybn0P8zUYltf2vMrALEEEtAi+nvjXv6fwylJJUv8k2j4+/Qk6+aMJhy6/+RI9eT/VKB
 ioKJBsgWWyiIWU7v0Iw00nTPI7837le9e4KVpBMV0e8KqdjLLJxBqyFIjV9M3o9ouKxq
 FhrhY2G5csY+XvRBa/+VX4YWEW77l20URWW5DsqF2yXA3mPLQeSoOUzIl1/7fa42WTF4
 TcZPZ0M24ujeEaaw0GAPGIsSA7OKSxm20/VKNLdvtFOsSiYxXqOtjYGrhPu9jy5RJX5b
 jHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VZV4PSNWC1AgmJZyK/nkJbWzJ2/YUDtvq2HoFDjulv0=;
 b=f+pH/yjMwLWOcl5moWFRFp95YLicF/qdk2ln0U63w/P6DdkL5KlyccXyXwMEmicUaV
 MSAGZVUaNxtPq/JTLFnW/tNyRnHSTsV9fBZnwhzLPiCJmL+hf0wczkEwJ8KBtVIAV5P2
 2sfc796GnkAZhf1I+EgSLet+RDWhNosN4c00PZrKJF6S5U7SpQ+Wh+jhWuBVRaIyqKjh
 fV+n25Ii9GT5k7sDtgmx0fgJuUdz7kQaF1lsqybqO3hTDK7xC0hLPVuRgbdzKynIVgWQ
 RHdxfLymy8zCf210ZHdhBp/EBu3n9+XhwF9jPDFfoGINyWsnA5j36BoQd13CBj+lNlBr
 V6PA==
X-Gm-Message-State: APjAAAVBXjArj8+X5ZhyiOf2W+z6TQZnseUxojsK8g03P5/PXgeMNg1J
 vuvyCO7c5ApUiUiUvu5ZoqGGx0cpBCklOxVGA9tSIA==
X-Google-Smtp-Source: APXvYqxk/n6c/8zVBOlD7/HlMQYehUuw4cT4qFlds6eN8B1yBRnpvNF69w4BnitSiPNWf9uH9tzNB84kO81N0vKDZvA=
X-Received: by 2002:aca:4b86:: with SMTP id y128mr3270961oia.163.1566569646391; 
 Fri, 23 Aug 2019 07:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 15:13:55 +0100
Message-ID: <CAFEAcA_4nW5CZJbVzzOpXd0uKWbKByQMYOPeUi0km5oj=FnYQA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 18:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/modules-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/modules-test.c b/tests/modules-test.c
> index 3aef0e5..a8118e9 100644
> --- a/tests/modules-test.c
> +++ b/tests/modules-test.c
> @@ -4,7 +4,7 @@
>  static void test_modules_load(const void *data)
>  {
>      QTestState *qts;
> -    const char **args = data;
> +    const char **args = (const char **)data;
>
>      qts = qtest_init(NULL);
>      qtest_module_load(qts, args[0], args[1]);
> --
> 1.8.3.1

Applied to master as a build fix, thanks.

-- PMM

