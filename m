Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0906C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 21:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACDD2074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 21:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8s580cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACDD2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRjXL-0004w4-GW
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 17:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRjUn-0002nv-GK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRjUm-0000c4-T9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:34:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRjUm-0000ZC-DG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:34:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so8230310wmc.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ir+tYO9jr62x0YvQuNmRjMD1A+P5aEEDbS0NGpN3g8Y=;
 b=n8s580cT+sEpIHd+3yMQiAasB+ehtiWdZGzRdSahzxkKSrnalZGWbLV0nK1/CVbgLf
 qDXAyyPRnDvb/gOejJvPt5pBL+C7NJN9yDjGNjilvZS7SPgZ8kFNK/chs8lrQCBY6SAl
 m3UVqDf+IMdVR1gCEwog1u8t1gUMXbjvhQY1hGzK5YNOkAiumPBan4rxTzWY6QBaJeUY
 5AyTYx3fgUghTHrmMbLa1wfDROUMqHvLJOTjPzbLLKVTJBscYq6npI23YWY+HNazKpuq
 hMNqytrZ0aq8PXHSJTBzaMw/1mHIe8xQ+FHeEl1u6Sk8Ua1MQGGGBnTwyBO2VDhQCmf+
 MqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ir+tYO9jr62x0YvQuNmRjMD1A+P5aEEDbS0NGpN3g8Y=;
 b=LFien9lvX/J+30FsgQ37OKPhyxk/xDpfDbBqV6Mvb0xS2UhDIW8CIezABZYADSuaIe
 /lWIDuZ60C/h8MyGs4hkXgZ71Qj0OneO7nsKFaIIjdD7qn/oC+BtC5/3cXqsvdteSQl5
 pS1q9TbaXJs+VBlYF1yOnG4285ABI0aeHdUR8XdmZoiJsKgemYb5d84tMJTuOIZlj0TY
 a1mchNEYtyIK0Pv+TgJN/exVuBWbHrvdmceMBnMxFthbjoSAq4HNcoCJVsCz2MVMuDM0
 sWNHeOgvZOM+Ps5PpWN4/LJJi4wlqrzAsvNVYIB1w2RxVQbs2lEJXwCtN3G1RbKDabpF
 TsBg==
X-Gm-Message-State: AGi0Puaf8mS3R6pu3ZBgK7Wp9Vq5WN5XycE9OUL2to3iOcT8rnr2NmTa
 oN0bgHsVcQ9fhnBQ2Vz5d5wSVFHikI4+SNP85TzDY8lRG1c=
X-Google-Smtp-Source: APiQypLUmhJste/GdWv+UzJN0Yusb2WLz5GpCPlIU6gfUYu9DNCjyoO3tToszxCutDAYsiICu9TPdEQADCE4gAHJvz8=
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr6268167wmj.55.1587677694509; 
 Thu, 23 Apr 2020 14:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200423202112.644-1-philmd@redhat.com>
 <20200423202112.644-5-philmd@redhat.com>
In-Reply-To: <20200423202112.644-5-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 23:34:41 +0200
Message-ID: <CAJ+F1CLTXWrF5k9mw94CHvPB=qV_Cajh9h-G8FdUaSa8_y97jg@mail.gmail.com>
Subject: Re: [PATCH 4/7] chardev: Reduce "char-mux.h" scope,
 rename it "chardev-internal.h"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 10:24 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> No file out of chardev/ requires access to this header,
> restrict its scope.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/chardev/char-mux.h =3D> chardev/chardev-internal.h | 7 ++++---
>  chardev/char-fe.c                                        | 2 +-
>  chardev/char-mux.c                                       | 2 +-
>  chardev/char.c                                           | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
>  rename include/chardev/char-mux.h =3D> chardev/chardev-internal.h (96%)
>
> diff --git a/include/chardev/char-mux.h b/chardev/chardev-internal.h
> similarity index 96%
> rename from include/chardev/char-mux.h
> rename to chardev/chardev-internal.h
> index 417fe32eed..e0264ac349 100644
> --- a/include/chardev/char-mux.h
> +++ b/chardev/chardev-internal.h
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU System Emulator
> + * QEMU Character device internals
>   *
>   * Copyright (c) 2003-2008 Fabrice Bellard
>   *
> @@ -21,8 +21,8 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
>   * THE SOFTWARE.
>   */
> -#ifndef CHAR_MUX_H
> -#define CHAR_MUX_H
> +#ifndef CHARDEV_INTERNAL_H
> +#define CHARDEV_INTERNAL_H
>
>  #include "chardev/char.h"
>  #include "chardev/char-fe.h"
> @@ -30,6 +30,7 @@
>  #define MAX_MUX 4
>  #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
>  #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
> +
>  typedef struct MuxChardev {
>      Chardev parent;
>      CharBackend *backends[MAX_MUX];
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index f3530a90e6..474715c5a9 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -29,7 +29,7 @@
>
>  #include "chardev/char-fe.h"
>  #include "chardev/char-io.h"
> -#include "chardev/char-mux.h"
> +#include "chardev-internal.h"
>
>  int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
>  {
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 46c44af67c..6f980bb836 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -29,7 +29,7 @@
>  #include "chardev/char.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/sysemu.h"
> -#include "chardev/char-mux.h"
> +#include "chardev-internal.h"
>
>  /* MUX driver for serial I/O splitting */
>
> diff --git a/chardev/char.c b/chardev/char.c
> index e77564060d..b672a41150 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -39,7 +39,7 @@
>  #include "qemu/option.h"
>  #include "qemu/id.h"
>
> -#include "chardev/char-mux.h"
> +#include "chardev-internal.h"
>
>  /***********************************************************/
>  /* character device */
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

