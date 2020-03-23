Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D5AC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBA32076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwECtmxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBA32076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLaw-0005KU-9U
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jGLa2-0004ua-C4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jGLa1-0005L3-9x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:49:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jGLa1-0005Ki-4N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:49:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id b12so1298504wmj.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6ugVyVHamM0S6zQ0REmf8yJDkXLxnl3i0L0vqbG9BsE=;
 b=QwECtmxszVvGx+VNrp0krL/7dETiKdCX9HjiDjy9VRB/T9M3jicSux7LiTPhB3+m10
 DM2rYgP0T49HFNK/1XX3b1nF8cn3WP1XeJQHCIauzrhfRn6QELdqwroYPMn8K9S8Jvoy
 zQfZIomuET8TzcMjtqqIRsDe2XxmA/wUkGbSlV6sS40XNR/tm5JWTrmQY/VPKoiaAfd6
 Sb40R6cIEMNkwOYUUc/ZvOhmkvCmZM/kpn2VjkDogvmyhNIym3Fwr2wlVU+MSVWOAG+P
 OgsAVtPbEK4G0wyxIZySGnVzKeyoYWO0cqKMg0YAUcbvcCgLfSdgIqtnQMQfhLJ/dvN+
 xBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6ugVyVHamM0S6zQ0REmf8yJDkXLxnl3i0L0vqbG9BsE=;
 b=C0eAJ1CIkgH+X6cFwTs7AZAbSwKbP++3EIBMHFR+8sz3bHOSVe1vqwBPXCXmMBGkKb
 gc/6sEUwrevuAoZ/1iKTgc2kZVY3Nx3ToryEWhV6AsbmhF9yxPnk5U2NqtSazSd7+pNm
 X7bakVGRxAUJEdxVwdKwOjlpGfqUi/5Ed6cPhNkKytmj3uXzHoVT8uhYsia6/PgIQ6Io
 QHwGRL8wmpSYGN1jTV4Cn49oyFVPcBv5f3IFQRkz/43Jwtrtzxb1C8PXMTCDoMOZcNTn
 IER4rJFZXM4OndHTWrYATm/h+b3mpkJYP36msseZCE5hu6MXnSy9TcIyRShUQjthTxxX
 nkBA==
X-Gm-Message-State: ANhLgQ3Rstk/eeazMG+dFy1JjZjAVBRjW/0mHTWBZz96w8GKSMNNgap0
 jH3ObeoFkuhkOeqLbzlHmcxDUHpzUReOYBhV7Gg=
X-Google-Smtp-Source: ADFU+vuRpTuMpkqpEhwYtbEc/YFMVoG81HQTJcEBWEbcB0nQKvXO5qqXjM22FDjjf7BlMtAzxi5T5riLd62GekeF73U=
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr13320221wmd.26.1584964155984; 
 Mon, 23 Mar 2020 04:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200322171635.678219-1-marcandre.lureau@redhat.com>
 <20200322171635.678219-2-marcandre.lureau@redhat.com>
 <87h7yfb8qs.fsf@linaro.org>
In-Reply-To: <87h7yfb8qs.fsf@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 23 Mar 2020 12:49:04 +0100
Message-ID: <CAJ+F1CL1dRGRb0Yobk4H1Kyqrf0owB9HT7ZgHWus+1V4LVo+HQ@mail.gmail.com>
Subject: Re: [PULL v3 1/1] slirp: update submodule to v4.2.0+
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Mar 23, 2020 at 12:40 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > git shortlog
> > 126c04acbabd7ad32c2b018fe10dfac2a3bc1210..55ab21c9a36852915b81f1b41ebaf=
3b6509dd8ba
> >
> <snip>
> >       build-sys: make libslirp-version.h depend on Makefile
>
> FWIW I ran into a build error when I updated to the latest tree. It was
> failing while building version.o. In the end I tracked it down to a
> duplicate of slirp/src/libslirp-version.h (one in the build tree and one
> in the src tree). I didn't spot it for a while because git was telling
> me the tree was clean because of .gitignore:
>
>   /src/libslirp-version.h
>
> Is this stale now? Is slirp always built out of tree?
>

The rule to build libslirp-version.h hasn't changed much:
https://gitlab.freedesktop.org/slirp/libslirp/-/blob/master/Makefile#L26

I think this means that at some point, you built qemu/slirp in tree,
and /src/libslirp-version.h was left, conflicting with out-of-tree
version.



--=20
Marc-Andr=C3=A9 Lureau

