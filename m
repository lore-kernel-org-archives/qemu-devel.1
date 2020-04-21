Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58990C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269502075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNL+1P5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269502075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQq3i-0006uu-7a
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jQq2m-0006C9-BM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jQq2l-0002rq-3L
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:22:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jQq2k-0002qU-Ld
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:22:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id z6so3057894wml.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4cQqO6E8Og1xwYBrubCAay+Q2ib6q0EYIgpBDWHI1ug=;
 b=KNL+1P5DvJua2J4AeHjJNOzi+MsW+7PqiEQR2UPpx/3Ljf6ySKu4cU5DOsd8XuKTgh
 eixJYYa0w1Pxc47drn1q3u2eOT40XxoOLw6ADc/fp5PKCFcVzKzA/UWzWHTFbVBB34kT
 hmYCl0JVfWUK+Xl7qu2KfzUE3cuwUnhDJi/ZYSsRWt26h89G0ZStQW75f9EZGwmCEXh0
 g8thouSa42LCBr68X/jVroExl4lKpbYTdk2axjMid1K07yZNak2YZ9C1yrKuuQDxnCHq
 OyCL53N5ry2eAGw0ni3k9Qz/kOoxkoJcApWOibbCabboynXv30L95czCIeJC3DXNnFrl
 tRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4cQqO6E8Og1xwYBrubCAay+Q2ib6q0EYIgpBDWHI1ug=;
 b=Af5qLHgItXHbLwg2zeGoBVdGqvQLkJz+QFSAerdVK7lzSJw599lUu0n9Z9oLrMUWGW
 fhCd0keDG4R3Gs6vVbSy1PtD6v2sqBkRxBsvks0y2DWa99OgqaEe1j8MjukiK/NCF7va
 Z/3xLz9vR2wYl382akZ9+vMhT9ZSnTbwS6qa4zAiE2ttSblKRK+MLBboRUqcYHxhg4TJ
 7Wk0oVMvqncSVghFica7RKO1552T/yOlmL4A44Z/lW/vztbd1ZxreoXG6DYs22icZ0FM
 Mxw/wta37vLnUkGzvLr2me9kzocXB7tWa5OZ1RijJhdWAmPsj6WIKj9/G2xP6gsHVDkN
 ocxg==
X-Gm-Message-State: AGi0PuZZrbt++ClBVuF+9Lv719L8J315tL3ehJrgxBSxSACZ/Eo65vAY
 R7udiKJtO3v03ZQOwxzjHKoZSqtOBvUjttMz38A=
X-Google-Smtp-Source: APiQypJIffWRcDwkr/NMjHAYqvMm8WyBNqjUH4DGJUpeJ6/FZJgyriXwSZkpSnudObzUeEnxMzQxCpTcG0TRW0QxBnM=
X-Received: by 2002:a1c:e284:: with SMTP id z126mr4416265wmg.32.1587464537039; 
 Tue, 21 Apr 2020 03:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+75-UisNwFqedDPfuGt=HFEEnPSO7sNq9JxpUuLPVdYDryuw@mail.gmail.com>
In-Reply-To: <CAP+75-UisNwFqedDPfuGt=HFEEnPSO7sNq9JxpUuLPVdYDryuw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Apr 2020 12:22:05 +0200
Message-ID: <CAJ+F1C+YnbgCkYN1+7zpq0XvZYb2LWL6kbQXRSybJew1JnBgQQ@mail.gmail.com>
Subject: Re: SLiRP: use-afte-free in ip_reass() [CVE-2020-1983]
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::330
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Apr 21, 2020 at 11:18 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Samuel and Marc-Andr=C3=A9,
>
> Peter is going to tag 5.0-rc4 (final before release) today.
> Do you have plans to send a last minute pull-request to fix CVE-2020-1983=
?
>
> https://gitlab.freedesktop.org/slirp/libslirp/-/commit/9ac0371bb

libslirp is not following qemu release schedule. The master branch has
a few changes that shouldn't be added to the release. We could create
version/stable/qemu branches, but then between each version, we would
end up with the submodule jumping between branches (with a non-linear
history). Is that the only option?

--=20
Marc-Andr=C3=A9 Lureau

