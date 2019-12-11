Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFEEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AC420652
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7zlRNKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AC420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iexDn-0000K2-9Y
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 03:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iexDB-0008I5-Um
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iexDA-0003uJ-I0
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:19:09 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iexDA-0003rK-BE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:19:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id d73so2724653wmd.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 00:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IFBKvg4x/Gb5nHZhR+8JE6pBJzlV1KAuNoSP1Cze7x8=;
 b=p7zlRNKuOF06TOZ8bRoCtMQWGYMTEOpLn2xwxADS6LPxGtbcX8bXy4Ow6TfJaU2Ijr
 51wbUxFRevV2kdXx82NPzKaSOzEwKumo8eXUJhhVrwLB1uvCrGQErDLKeHE7YUj3bLRw
 q19D+ogNeYGRVKCg6AlRObhF+eI/GY8ERIHzVklaJkNNnAb2ABdJK67lRqteFtGt5W5T
 w7UKPsBVowg8l6Ok58A1nvHU6GjG2YZZCMN+mFy6QfnwLDz6sOUm9EpKSHwzirt3KoWJ
 BOZZ0UTE7f+PypCP/PxxlhnqG97AwAQq1GH0rxXhGd+wH9ihVmL0PzU1SGYWB0Jah4rK
 Uxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IFBKvg4x/Gb5nHZhR+8JE6pBJzlV1KAuNoSP1Cze7x8=;
 b=pxxgXuiYYEVIYGyj5r4xhjDKV4VTj9RWHOSa6sgyY+QVJndAFgDpStEVJvsdtc35Ay
 pCXvLVcA9kKDSLgB0HgP+KmWFXYlXt6zfcsEdO25pCS0UkMQyfP6DmpIy2cYfrRVBuRa
 CGLxUwKIQIlJX+LGR84xaMpnR0UT9pHKprB3VQZnddRg8F3+n/raHanPiKb9r3ZuwuDR
 bZTfef8oTS2r2u/ThratCCBv49K8+veFemfZLeduVpHq813Rk5f5t2iiED9dHSH5pfQ1
 QJ0JDnIHQqyAVUfsMYslKYKqy9b8Gwus8nSrYpWLLjpwsBE0YdYeBUBYCMCa44W6qB9l
 pfRw==
X-Gm-Message-State: APjAAAUBcwpO48VV+j0gtw1/UtUzW7jZpDobsSHqoODhH776N1fchoop
 hpRRzJ8X1dXjChg4I1YRzfX9e+egwPJaqdickdc=
X-Google-Smtp-Source: APXvYqwn412j6ft6IZGKvSprdqWXd26ZH32MM0PCha+IBqxYPA9Ubz88NPSW2WF/VgiZvTlEUIzSpA1v5/8oTvs3jg4=
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr2238760wme.42.1576052346595; 
 Wed, 11 Dec 2019 00:19:06 -0800 (PST)
MIME-Version: 1.0
References: <1576025722-41720-1-git-send-email-pannengyuan@huawei.com>
 <eb4d58d0-ac2e-e69d-0a04-87fd5fc14e6e@redhat.com>
In-Reply-To: <eb4d58d0-ac2e-e69d-0a04-87fd5fc14e6e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Dec 2019 12:18:54 +0400
Message-ID: <CAJ+F1CLFqpm8LRiJpQ6h1shW3_3UvV9yL6twDo7YAj=Ti1J8Vg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-test: fix a memory leak
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 pannengyuan@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Dec 11, 2019 at 11:57 AM Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi!
>
> On 11/12/2019 01.55, pannengyuan@huawei.com wrote:
> [...]
> > diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> > index 91ea373..54be931 100644
> > --- a/tests/vhost-user-test.c
> > +++ b/tests/vhost-user-test.c
> > @@ -717,6 +717,8 @@ static void test_migrate(void *obj, void *arg, QGue=
stAllocator *alloc)
> >      guint64 size;
> >
> >      if (!wait_for_fds(s)) {
> > +        g_free(uri);
> > +        test_server_free(dest);
> >          return;
> >      }
>
> Well spotted. But I'd prefer to rather move the allocation of these
> resources after the if-statement instead of doing the allocation at the
> declaration of the variables already. Or maybe use a "goto out" and jump
> to the end of the function instead? ... whatever you prefer, but
> duplicating the "free" functions sounds like a cumbersome solution to me.

g_auto (preferably) should work as well.


--=20
Marc-Andr=C3=A9 Lureau

