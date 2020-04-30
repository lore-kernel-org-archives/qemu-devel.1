Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474DFC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A702072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbIwaOX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A702072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFMZ-0004fZ-04
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 16:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jUFK0-0001ZG-J5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jUFI1-0001XC-I9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:58:12 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:35595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jUFGI-0006y1-Dc; Thu, 30 Apr 2020 15:54:22 -0400
Received: by mail-il1-x141.google.com with SMTP id b18so2577107ilf.2;
 Thu, 30 Apr 2020 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0rW6ZHBwhJGM7oUVbxpCTn1jvQK5R6MzduYksnD23GY=;
 b=kbIwaOX+Vs3yIDfGlj3k9ZPqbWUIQRykyaVd2jxq0jG/c0pvnZmOsVId+uB35Ekr40
 UrkEJe4kfxucKV1967A2nQZxlikEGNS1GNet1bHP2hLH8/nr6nrUG2VUnDTsF31qAtgi
 sVH7sJ80MfaekBcj7kYsKSnZHysztDrhefj2OvW+jdd/B8HCrmfY7HzNzF8fKQS2Hg10
 ryBtMM2iPypVYWBkerccG9g9Ex21LFcMicMZzHhRwc8nsdfnugnCLEEzw2roW2ABw+W+
 GfQIA7W/i5s+ZJtDx7E1XXrXy1aWuc6MjyClJ1ZcZ1hF7rvLlC1duUwoB2YVVsyrqrQt
 wKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0rW6ZHBwhJGM7oUVbxpCTn1jvQK5R6MzduYksnD23GY=;
 b=USAgGozRcDtPZLpfpu4kUX9JzCgYmh2bCKHsAGD2vaec0YhDAg1eFnlsJq0OA7q2vj
 mvPcIHZSNH9VJQ1xy8aGhVw98nFxufl+4StVIlHfdrmaBSmgtIFbVq1qHK+/vLtbWpP9
 jKm6SInX0S3PK6fhXn8BQhTV+T1b0qBadZLzR5Sosx1OhPtj8WbddEcpLUkwey5j/tPO
 rC87Syo0pduhNiSlOvbOucgSJzd4r5TVmBKWgYFmnJ9RzLA7PYY3EWV+QNDWZNMJuAn7
 4EhCZWwvzJgAOqQKkue21pV9NzpAB55/SlxedmiNSKWmgXOjxDLcDhz2GgL4/vH/fFdi
 PLmg==
X-Gm-Message-State: AGi0PuYv3UwQpMb6XQ3INkZPomlv8S2y9Rx+p4Vb22RlNL8WJRYCIEqT
 KoiRoJXtLozTURxtGYY9luP9qOEjOg2IlUphdGc=
X-Google-Smtp-Source: APiQypIvQVnoK5n1ojlg8TYH9fo7k6hkVT3pMgebeacyWC8YjkadFdjsO+Yfj1HlumTbgG6aQykAqZiKU6y2Gl/ZlAc=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr3809778ili.267.1588276459326; 
 Thu, 30 Apr 2020 12:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2LfTQZnor5haAgBg=h34qv50xf8Bs1bgSeGESfr-E2ng@mail.gmail.com>
In-Reply-To: <CAC41xo2LfTQZnor5haAgBg=h34qv50xf8Bs1bgSeGESfr-E2ng@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2020 12:45:45 -0700
Message-ID: <CAKmqyKNMiD6VJ1D-ty-q_HMyiZ7oj7F0XraKTaYy78-xjhAN4A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix check of guest pa top bits
To: Jose Martins <josemartins90@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 24, 2020 at 8:10 AM Jose Martins <josemartins90@gmail.com> wrote:
>
> The spec states that on sv39x4 guest physical  "address bits 63:41
> must all be zeros, or else a guest-page-fault exception occurs.".
> However, the check performed for these top bits of the virtual address
> on the second stage is the same as the one performed for virtual
> addresses on the first stage except with the 2-bit extension,
> effectively creating the same kind of "hole" in the guest's physical
> address space. I believe the following patch fixes this issue:
>
> Signed-off-by: Jose Martins <josemartins90@gmail.com>

Thanks for the patch.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

> ---
>  target/riscv/cpu_helper.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d3ba9efb02..da879f5656 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -421,15 +421,21 @@ static int get_physical_address(CPURISCVState
> *env, hwaddr *physical,

There seems to be a strange wrapping here, that corrupts the patch.
For future patches can you please check your git send-email setup?

Applied to the RISC-V tree with the above line fixed up.

Alistair

>      int va_bits = PGSHIFT + levels * ptidxbits + widened;
>      target_ulong mask, masked_msbs;
>
> -    if (TARGET_LONG_BITS > (va_bits - 1)) {
> -        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> +    if(!first_stage){
> +        if ((addr >> va_bits) != 0) {
> +            return TRANSLATE_FAIL;
> +        }
>      } else {
> -        mask = 0;
> -    }
> -    masked_msbs = (addr >> (va_bits - 1)) & mask;
> +        if (TARGET_LONG_BITS > (va_bits - 1)) {
> +            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> +        } else {
> +            mask = 0;
> +        }
> +        masked_msbs = (addr >> (va_bits - 1)) & mask;
>
> -    if (masked_msbs != 0 && masked_msbs != mask) {
> -        return TRANSLATE_FAIL;
> +        if (masked_msbs != 0 && masked_msbs != mask) {
> +            return TRANSLATE_FAIL;
> +        }
>      }
>
>      int ptshift = (levels - 1) * ptidxbits;
> --
> 2.17.1
>
> Jose
>

