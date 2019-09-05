Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B04C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FD520828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7uGR0hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FD520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tpJ-0008Qo-Ee
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5tmY-0005GI-HY
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5tmW-0002yj-Vc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:34:46 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:37489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5tmW-0002ye-Qx
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:34:44 -0400
Received: by mail-ot1-x330.google.com with SMTP id s28so2624245otd.4
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kKy6cTzrgfJjw0zn/w6ZwpLB7QRHrP04QVzvDKXt5TA=;
 b=D7uGR0hYw3gY6y0Da0bxU9dwsUiGJumfAKNUbr7j+68x30XPYMUOez/RAbxu1ZMex5
 x9CBNpiLfYMhKUfqw3ZQt4UtnjwCp7knjdP3wQgvXy3B5vY60xpj7V7BAg83Vl9Oft7T
 Ym7BO2jwBXxskiY/ZGHivSgOnvfLSbBezBdtPLC5w/geh+xauNJJvkVLk6Cf5tOPoaA8
 NFyX5CJ4cinRdWW4rA+EGJJAuYSxCkE62KwA8nP/0ZjHKz3yV1sgcIbXsWq/35odc/V/
 O3G4KgSMNcNQgmtfGLt9iP/2CqtMiRV/xNyWg1cUB4ordn1fyVf/aOZa2PJJWfD1/A40
 Hixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kKy6cTzrgfJjw0zn/w6ZwpLB7QRHrP04QVzvDKXt5TA=;
 b=o8m4/WB6DraHmZKA8XH2NvSaM/DlX2x0tz/lhpYEpMaEqGl7r6YQCvy1kEDN+HBBeX
 YNc+qRO/vl7U8PEGqEO6ceZcJR0YExt927PncfcY8d09/L/u7RTvvrKBXxPlmk6Lpw/O
 rd1+YVWltPvHeNsc4uYKQtAmkadgoGFJUW3Xx8C/Gn3LL990UC1J4yKxFqm+qlQiVISa
 Zf2pP7KMzkaoCw4MpyvHkmB+udROMbqT7m8Kiu1gGGE7X6atpsshF95XIsqRc2niUSWe
 f97eHuoRWQ2oaCR3eHOYfO4beMr0wOMh9VJszdDRxjarLjTOcTiwefiK5OERLR8J3TQg
 tUvg==
X-Gm-Message-State: APjAAAU/31PPWmipB+GWbqAIz6/9WHL5q8pEeka7G7HdHBlbwvj3Bdck
 ngSV6dhJRpN71YtGLzy8jsfGub/b/hATgQK4YW+hPg==
X-Google-Smtp-Source: APXvYqzo0Vsk0kkDKyDqAyJ8dnrPMEw7GvB5I1xW+97PQgA5BgIc8r0Y64bwynhC45dHDY2GNhL1IHMh5Tsv+5a3An4=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr3007088otk.221.1567697683963; 
 Thu, 05 Sep 2019 08:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190905134526.32146-1-berrange@redhat.com>
In-Reply-To: <20190905134526.32146-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2019 16:34:33 +0100
Message-ID: <CAFEAcA8-C4V6EQBZDvLUaL+WoLfnr4wB6tiQNAtH1wN1kRQN3Q@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL 0/4] Docs patches
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Sep 2019 at 14:45, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit 500efcfcf0fe2e0dae1d25637a13435ce7b6e4=
21:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-or1k-20190904' into=
 staging (2019-09-05 09:33:01 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/docs-pull-request
>
> for you to fetch changes up to 9f8efa74d3f1cb9ceeee957ee382c2b4feb2ae30:
>
>   docs: split the CODING_STYLE doc into distinct groups (2019-09-05 14:41=
:00 +0100)
>
> ----------------------------------------------------------------
>
> * Merges HACKING into CODING_STYLE
> * Converts README and CODING_STYLE docs into RST syntax
> * Documents use of auto cleanup functions
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (4):
>   docs: convert README, CODING_STYLE and HACKING to RST syntax
>   docs: merge HACKING.rst contents into CODING_STYLE.rst
>   docs: document use of automatic cleanup functions in glib
>   docs: split the CODING_STYLE doc into distinct groups
>
>  CODING_STYLE          | 216 --------------
>  CODING_STYLE.rst      | 641 ++++++++++++++++++++++++++++++++++++++++++
>  HACKING               | 257 -----------------
>  README =3D> README.rst  |  47 ++--
>  scripts/checkpatch.pl |   2 +-

I'm going to apply this, but something I thought of looking at
the diffstat: should some or all of this be in the docs/devel
manual rather than free-floating rst files in the root directory?

thanks
-- PMM

