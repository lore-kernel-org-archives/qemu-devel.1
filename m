Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D0EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 21:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DA72070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 21:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZimwDUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DA72070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6LkF-00059u-EL
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 17:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i6LjL-0004Nk-F7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 17:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i6LjK-0002ux-8N
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 17:25:19 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i6LjJ-0002sS-Tf; Fri, 06 Sep 2019 17:25:18 -0400
Received: by mail-lf1-x143.google.com with SMTP id l11so6177362lfk.6;
 Fri, 06 Sep 2019 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=41vitPaR9QJU0hyMIKTOsEnYo8xWm+xShqZjqioEH/s=;
 b=hZimwDULM8L2NvaeATEUnPYm+zjrG7nQD2lh7Hwt7PBkDM6POfUCw8RujxyGdR1cII
 7Mcd0ffQcjXkKZpjr+uiba+bwjFQ531O1JSC8F1Qwy6/ijUB9GchWr5jdRpkX5IoNRJ2
 BoGV0gUQmCLQBAkLYestpSK9U6ZvcUez+GH9C7R/PKkt8/pOZwmy9yn5M9q/UYkrKjEs
 Dm4a4REV20pohS2s76DIz8jXSeVCWUOdTk4Raqhb6wCez1TT/gQvwM4ATL12AXWuS8vu
 8W2zX7G0rP8hp9wN6WkDPy4kKpULVmtaCKU9luli2XzViUCAgUtkE1kEmzhAcRO9llRL
 8bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=41vitPaR9QJU0hyMIKTOsEnYo8xWm+xShqZjqioEH/s=;
 b=V9iB8qH1wFGShojqO9joZM8H8DD/ZKWeovKHToZcY4Gb0Cl52Cb1YB/Jb1jS1p4Ren
 64QSDdk3OshmMKBsCtlXiO1r6I5Y71MWuGLW7hKzRhlLyyDffJku0lRWEA8HnH4JNuyJ
 Vu4VBNKBITXo6K1DUR9Xs3yiL+AxJfG3cEN/AXxBufzfP73/bVwKNk0qrPdXq8wtfa5+
 maL+KMc7kQgvDgA8yWVjtR69plgvDkcH74YQ2VqxDarp64SSoH6dp+U7IAjPX/vUXH2I
 deR/v/pCXTgHeNotjvUzJhX8XUo7EgOcybUC5AnFkJjoqus7JwfprGBPUJdh2DqwK7AM
 VA3Q==
X-Gm-Message-State: APjAAAWEimWtzgfeFg6+GVCdCYgDFFqZB3N1SBF6Pg22Bj/nlr4zycuY
 jJsTZ0Jp4D8CxuFT1NlH6XeGddl1dDsBTvxN2c8=
X-Google-Smtp-Source: APXvYqzuM1C0sxWAwZn0iI6hvWtphG1gWjhalo7iSuEn9PwyX54TqXKz3QcKNYRyzZ9TrRthq4lD+sVnHgEdmv62/68=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr7631834lfh.44.1567805116003; 
 Fri, 06 Sep 2019 14:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
 <1567786819-22142-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1567786819-22142-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2019 14:20:56 -0700
Message-ID: <CAKmqyKP9G5kHhMGPjXpHVNj4S5io5xtbLU4=QiNzCx9cgn9Npw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v8 01/32] riscv: hw: Remove duplicated
 "hw/hw.h" inclusion
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 6, 2019 at 9:20 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Commit a27bd6c779ba ("Include hw/qdev-properties.h less") wrongly
> added "hw/hw.h" to sifive_prci.c and sifive_test.c.
>
> Another inclusion of "hw/hw.h" was later added via
> commit 650d103d3ea9 ("Include hw/hw.h exactly where needed"), that
> resulted in duplicated inclusion of "hw/hw.h".
>
> Fixes: a27bd6c779ba ("Include hw/qdev-properties.h less")
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v8:
> - newly included in v8 to ease patch inter dependencies
>
>  hw/riscv/sifive_prci.c | 1 -
>  hw/riscv/sifive_test.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
> index 9837b61..562bc3d 100644
> --- a/hw/riscv/sifive_prci.c
> +++ b/hw/riscv/sifive_prci.c
> @@ -19,7 +19,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "target/riscv/cpu.h"
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> index afbb3aa..3a14f9f 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/riscv/sifive_test.c
> @@ -19,7 +19,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "target/riscv/cpu.h"
> --
> 2.7.4
>
>

