Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C984CC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905512073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVq6n8aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905512073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRioN-0003RV-O6
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRigQ-0007LW-PV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRigQ-0003C9-6e
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:42:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRigO-0003A3-NH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:42:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id t14so8226061wrw.12
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dCr1y9kRSOin6F/un++8dIrT/khXQbChVWwnhIrn63k=;
 b=kVq6n8aJ0uUvO5lPJ43Hv3pbQsPFJcIGKW+PNmBUVIPFrO4Gu3nqjzX/afAp8YjqJF
 bvU2kzdatOPdRpbdlNqUGqKin4AHVjX6C9Jum8cifQeRyQYGHjlDaWYIC4ax352DiGxb
 hB5g+l4qf8F03lXmpmr/AnRZlYp39mvInrbC/BnpdzpcqEj4AzXSgMq7t/QwYOEYYnP+
 DPlyXdTg8AvWwpthWmIiZAWBtHAyp8ZRITrXbQ7ozKDleTTzNbblmSzDiUhlcdFUCytw
 klZEzRWhI6Z6alivvs9uLmfVfgRyhdNcK6w7tZuTfJERng2QpLUnauvjnPSZgU8oZ0jh
 pAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dCr1y9kRSOin6F/un++8dIrT/khXQbChVWwnhIrn63k=;
 b=UVYB/dtJNcNNVw4agcL+UtTItQNda7bmV25MWjt4yrNaV2r9aYihkMLs0jra2UR3yJ
 0nxsvQzAwv0ypkEIbR5DINFTe27z3kjaVAKJXThdwOPeRSM7I+8OvE2WolVD2H6pq7g1
 dhJ+CPkSXxw9scDRWuYTa2aN98f6i6BJH297G8xBljfSv0sOA23qGp3C1Gia/PUbDNhC
 bEn1Jxa4hoOjS7AzuxCjFXhOtVhbQx8viYW2StNS2J9OUiTmQtCwjQ4WkAR7NCAOyCmu
 OZOBuF3/mnmAylu1bpAxIL+dogapLbY+5Z+Gs7/HIyCJr0pecbGtAuXu5flzJZMxvyLu
 Lh6Q==
X-Gm-Message-State: AGi0PuYA+PmJ/teYlFUwVRMtOj6Q1jVydgfavyz1fHPuPwh/zo9MVNe6
 yHYjIlmcKWeZIzQDRmddfZ9j+EpRiq4/gyzOoik=
X-Google-Smtp-Source: APiQypLACacL4apR38qdxwAL8Wh9D6+oE1usKg/wnMVsEUAIzWPaJX1g6wKuJ2IOE5p0GEN0hV+Fo7OesAufwNKH/UA=
X-Received: by 2002:adf:ed07:: with SMTP id a7mr7241336wro.2.1587674570560;
 Thu, 23 Apr 2020 13:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200423202112.644-1-philmd@redhat.com>
 <20200423202112.644-2-philmd@redhat.com>
In-Reply-To: <20200423202112.644-2-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 22:42:37 +0200
Message-ID: <CAJ+F1C+Rp-Pmu7TCsMGDaQP-Xigm2nAYEie2pjE8am2v-AUCRQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] monitor/misc: Remove unused "chardev/char-mux.h"
 include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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

On Thu, Apr 23, 2020 at 10:23 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> monitor/misc.c never required "chardev/char-mux.h", remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  monitor/misc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 6c45fa490f..5d68026a7f 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -33,7 +33,6 @@
>  #include "exec/gdbstub.h"
>  #include "net/net.h"
>  #include "net/slirp.h"
> -#include "chardev/char-mux.h"
>  #include "ui/qemu-spice.h"
>  #include "qemu/config-file.h"
>  #include "qemu/ctype.h"
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

