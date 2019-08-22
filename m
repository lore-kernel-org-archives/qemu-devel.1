Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E43C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A95322CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8QnwI7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A95322CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0n0m-0007m2-8Y
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 09:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0mxI-0005pO-Fr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0mxH-0008It-2L
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:16:44 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:45392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0mxG-0008IU-QB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:16:42 -0400
Received: by mail-ot1-x329.google.com with SMTP id m24so5356656otp.12
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ehz3md5fEQQONS866XzVW/EBdKEq+9laLlbcN52qzBU=;
 b=t8QnwI7Rf8/XXbNdUAw3d5qe3A6V1MlBiG0TR5V1u3aQ5gr8Cd4vuBbUL+DM2LZaeX
 mT3Hbdacb8yAorBYagMT4qZakqL+nh7gw1qY/igWTOSdkbAYM00faonv911WSiYUHc8I
 Tx5m9wPecOqV3aFVWCbI3CBMpzKs5BQmET+2EuRS4aJOr5kNd/VqVVpj08BDtcFGiYpR
 Cio4zvzCCiMoL2zBwGB5Za5XRbW6dKoQyNkH71stqVQOrRVilhoVg95BiGfW27d+k9i9
 Az2GIlOtbJVe2C4tkT+F648CF1O5IeB9zo5b2Lsz1TgZwjDHbCCrTKPKNdOJ+4RTAh2i
 L4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ehz3md5fEQQONS866XzVW/EBdKEq+9laLlbcN52qzBU=;
 b=qzxQNZB/wB4z+7kGGpIhP32twykN10i8YPCyt/dZYVSmE//1lC/Nc0IkfIrNd1rU9V
 DXWlk4enEvVQwbpJ0Dm2wVKb8UqZnEgecOeZSd7mS9nDggvfWCWH+rVGDu9dVmKwGJ2Z
 uNr+wtQOz5WDepkjku22huVAar/8XeVoB3ly1EhbNpGEBRH6QN23o/F5ChbXCyiwGdbF
 dFsi9BGcsZPu6WS0l+JkiP1MgnwudVwGxh/ICz44KKEcaIZm76ELD/wEyfgM9jvgNUAs
 QeMz+xMZNbLbsL/JRcTHXcAu7XwedZ0dAQ5WwF0Bw4eQX0E5TQSxKhG3qPkp3gXqC9oR
 hosg==
X-Gm-Message-State: APjAAAWFA0nd1WQwLLNP+uUSLEEW/dYgOe30QRo9qf5lIrqnjEu7SWfl
 AxHnnQVIsMbfpI8Rzr0RFlxuru0Y+81oMJ1/u/v0vw==
X-Google-Smtp-Source: APXvYqwgha7v5rsagdxlzwdXzX+cqHCmPm93or5su1N3IDj77MZGi2/u+hh6f1I9EO8IN64vaq0FKKDK9F7+n02HDPE=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr7785317otq.221.1566479801887; 
 Thu, 22 Aug 2019 06:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 14:16:30 +0100
Message-ID: <CAFEAcA8HuH5ff+jZvAzGvaHvRQ9H3JQM7Y64CrmCGfp+LTQZeA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PULL 00/13] Misc patches for 2019-08-21
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 18:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e65472c7bc413d79faa61eb1d05c540b039458=
94:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20190821=
' into staging (2019-08-21 14:04:17 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 78d01598aea85841f0e4f8baf62c42b76230a81c:
>
>   char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout() (=
2019-08-21 16:31:59 +0200)
>
> ----------------------------------------------------------------
> * Longstanding chardev race condition fix (Berto)
> * Cleanups and tests from the Meson POC (Marc-Andr=C3=A9, myself)
> * Coalesced range cleanup (Peter)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

