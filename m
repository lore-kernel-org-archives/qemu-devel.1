Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78754CA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4726720679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgu+TC/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4726720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpwZ-00061V-Ha
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iMpvo-0005AA-Cv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iMpvn-0006vS-8N
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:54:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iMpvn-0006v3-2T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:54:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id s1so8314711wro.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=V4VhBihoolZqFYIN54r9nmx9vYW/oQSJU4NMMDQk7As=;
 b=Dgu+TC/pYPvxFl322P5ZQxatcCTlZr9/Na3bgs3e7uOoeVESu2uvhuRLFlA7Vx7/JT
 /eva777fMJ8YfTgOGc73Mx0YxP01s6+hevrbvcCTqdpw/rTSEltteQbcZoXK4PmPIUBm
 cl1ypCckqOcn43h6toBhuentFcrt9KGnXUPqpaFPa4bW3E56B+6i3Tx8qAHh1iiETUX3
 dGqXsu8Ew2uALCJSx4VFErFJJJcuSnDcWNuVe97h231nTAgZjz2TP8/8KWalCN6fqC//
 yNJAMz15ra9LHEt59Z0uirpJUswkt76MyYPG+hYLPwDY8SCBSYcr4fVQzU3aNLfA4uei
 GoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=V4VhBihoolZqFYIN54r9nmx9vYW/oQSJU4NMMDQk7As=;
 b=jchSzmO0xAlxcHp5n7+amjlAyIFcYgRZXiyptNoJZd4WnbmiTk+MqtPaMi6bYycvq5
 9iVTqYXmHYv2utSR3kG/CAtbrona5uBRACCDiEAUbJoeCyWhUUExb9kp4eSRvoq3hw6y
 Sr7dhqwj6VzqTxSFyev7Xm4bxrpmuD0aLs8C7Ilgb1MLx/pzojkhrZsGLGZl0Y2wsMw3
 uoXtnJuy2sdYqTudmByXOM4jJD3X53lJ3QRaC9gV8qTGIP8mveqGPR47RXCnesQ90ZqG
 UDIBna5vcJFs4a5wITjTc3rM7WT8DOwx1zZN2wIPVbr3LAF2n5B+A+AGuseE/hurPw0K
 0IMA==
X-Gm-Message-State: APjAAAUGbjjgGz1arpoDoGEHPof0fTsYilpzaijpMns7NQqN0+BUMWxi
 hd9oZrukynUu1WUqKyYBefE=
X-Google-Smtp-Source: APXvYqz8BBP5wYK70GC9RnObS4GNK085VbmK6595Ok53rEH80UBeoYuODXHUVHqO1KEoZ2xkh46u7g==
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr2269042wrw.32.1571734457519; 
 Tue, 22 Oct 2019 01:54:17 -0700 (PDT)
Received: from ?IPv6:2a01:c23:604c:2a00:af2b:2e92:39f9:c05b?
 ([2a01:c23:604c:2a00:af2b:2e92:39f9:c05b])
 by smtp.gmail.com with ESMTPSA id p21sm8365131wmc.25.2019.10.22.01.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 01:54:17 -0700 (PDT)
Message-ID: <80119c423b25ff027844fd04a4e57e5fcb7dfbb9.camel@gmail.com>
Subject: Re: [PATCH v2 04/20] Revert "irq: introduce qemu_irq_proxy()"
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org
Date: Tue, 22 Oct 2019 10:50:46 +0200
In-Reply-To: <20191018134754.16362-5-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-5-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daudé escribió:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> This function isn't used anymore.
> 
> This reverts commit 22ec3283efba9ba0792790da786d6776d83f2a92.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/core/irq.c    | 14 --------------
>  include/hw/irq.h |  5 -----
>  2 files changed, 19 deletions(-)
> 
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 7cc0295d0e..fb3045b912 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -120,20 +120,6 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq
> irq2)
>      return qemu_allocate_irq(qemu_splitirq, s, 0);
>  }
>  
> -static void proxy_irq_handler(void *opaque, int n, int level)
> -{
> -    qemu_irq **target = opaque;
> -
> -    if (*target) {
> -        qemu_set_irq((*target)[n], level);
> -    }
> -}
> -
> -qemu_irq *qemu_irq_proxy(qemu_irq **target, int n)
> -{
> -    return qemu_allocate_irqs(proxy_irq_handler, target, n);
> -}
> -
>  void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler
> handler, int n)
>  {
>      int i;
> diff --git a/include/hw/irq.h b/include/hw/irq.h
> index fe527f6f51..24ba0ece11 100644
> --- a/include/hw/irq.h
> +++ b/include/hw/irq.h
> @@ -51,11 +51,6 @@ qemu_irq qemu_irq_invert(qemu_irq irq);
>   */
>  qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
>  
> -/* Returns a new IRQ set which connects 1:1 to another IRQ set,
> which
> - * may be set later.
> - */
> -qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
> -
>  /* For internal use in qtest.  Similar to qemu_irq_split, but
> operating
>     on an existing vector of qemu_irq.  */
>  void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler
> handler, int n);
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


