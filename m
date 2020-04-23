Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74AEC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7021B20767
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYdyQLhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7021B20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRirj-00083B-Is
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRipT-0004sR-0K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRipS-0004DG-Gt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:52:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRipS-00045k-3m
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:52:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id s10so8300585wrr.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CRlpL+X7G1JQjETZfk+jaD5KsaIpRIoUjlQnXUV98TU=;
 b=PYdyQLhySUR1/uJhzhxX0aRV5UxRjcyO6OjO1gZJnW5VghzaZZysWtzzIxtZf1Vpp+
 RtYhzUdixiCSWfPVuEEv93BUBJ94Jm02VLljpbozIVn5/vApnTiRXH9cIGepmk8V2str
 zFJ7DEH/8NVcKhFKyHxgdnD0w2iiMP0JxXMgE2gHEMgeQnP3KmejoajbMXS8nXZBHXuv
 DxJjzklSOe1T0i0/iugnlT0iO7BG4K7R9NxAdR9wrsx+nd9gJdITLGOoJmKv+SqoOrXh
 3ycTTOOv/LwhhubdB1P0rUiJ5K652GXAv8vY0JKk8d7ZLEt8PmNAr7Il+Q89Mk5HiqpM
 zBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CRlpL+X7G1JQjETZfk+jaD5KsaIpRIoUjlQnXUV98TU=;
 b=it+iPgEAputVfTfx4JCf/L5tN8Nw/qA8ReSTD81s+3J1cUVM+re4hfR/TKToniX1ac
 mH7xP3F6ff8ALaPhkeBG6V/M5AFXzEUsqFUiIBSweTF5954NwnDCaPzvRPzFSs5lChPM
 W2W+hrB/SxY6XrobR4rSXLmapIujbfxyF15F6JfWvx/jBXVZ76nAkEF53Y6xpCIdCYqJ
 C0KIljAPVV9zHoGnDW3s0q5+JKZ2ZK5lqIsti4dz79PW9r6tM3TYjhGG8tegG3WofTf7
 5jbX7IYx6YcJLp5ZT7slG1p4Rct0PYfGTEAo2qHtfd1e6L+GQQkg+eKj9wj66XpHl9tl
 gbeA==
X-Gm-Message-State: AGi0Pub7Sa/H9kcS8IuQ8n9/jGM13816N6rznAwykqYyeNRpZfMrEp90
 +1AJnxGncGR9VFGx3qKI/KMDu+lj9agcfJQOHmA=
X-Google-Smtp-Source: APiQypIDD1ezVZ+G70F7wgKR3hQlFokOcMV8xNFT8jGfqN6aOe5IziGT/Ga53b/lfgDocdJqfZMXS/HMhlauPyua6G8=
X-Received: by 2002:adf:ff82:: with SMTP id j2mr7203379wrr.96.1587675131736;
 Thu, 23 Apr 2020 13:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200423202112.644-1-philmd@redhat.com>
 <20200423202112.644-3-philmd@redhat.com>
In-Reply-To: <20200423202112.644-3-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 22:51:58 +0200
Message-ID: <CAJ+F1C+mfwWv=LJNtKugaXZ41Ah4wnNG4iLveme31onuU2sB0w@mail.gmail.com>
Subject: Re: [PATCH 2/7] tests/test-char: Remove unused "chardev/char-mux.h"
 include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 10:22 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> This test never required "chardev/char-mux.h", remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-char.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 3afc9b1b8d..f08a39790e 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -6,7 +6,6 @@
>  #include "qemu/option.h"
>  #include "qemu/sockets.h"
>  #include "chardev/char-fe.h"
> -#include "chardev/char-mux.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-char.h"
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

