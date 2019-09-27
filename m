Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C9BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F731217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n95unHRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F731217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDlGo-0005pf-Ad
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 04:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iDl84-0006mL-Rg
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iDl83-0001Uf-Jc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:28 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:37588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iDl83-0001UT-Fl; Fri, 27 Sep 2019 03:57:27 -0400
Received: by mail-yw1-xc41.google.com with SMTP id u65so612176ywe.4;
 Fri, 27 Sep 2019 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1ulQVMgYqQD3VaW5xilM4PVnmRiBHUelaeuS5oMSLX0=;
 b=n95unHRPEwRZt18MgpwZS9rBRyukXnIsMRVVPreEB5lRwXWguv6DmC3exeFBOYHkZq
 JO/zqkjaAms+gbXiKJJWlIPq8aq+OXhqk+ECEq5LLn4H48j0/MtGTkq9nGhzxjY+bB+U
 JP79GIRLiCw/Rlg47R7WQ2ni8IqIm2/BMmZFMR+NETpdznRcC7EIp9xbhKPiDk2aSWty
 2Kpbi8fU7AqAMtafiFw7RbqIHfyw+V8yNFqGkUXURGcurJ7w/C0f1+xoE+X4PK6KosK+
 PVOSTJDhyQP0EikymqSP1zXuqLS0scoGHF53HXG7Q/J+bp3lg3fAUSteT66aNsA7qheF
 UN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1ulQVMgYqQD3VaW5xilM4PVnmRiBHUelaeuS5oMSLX0=;
 b=nAcm4SQ8ql1LwhAJHc+xWEnTrc80b8+Bi7LJIG3MCxoGVOIX1PjrtaJvxnrLvgaWjF
 EKuYmkKQTJu0Qa8TVL6DKoriCDHzQBIetoth5ghu2432ZEAL+vPaK6tw7XnZdKNXZ79y
 eYaEfP30+dh6Fc8F9SYDj3DtSnu0SoD1lAVNlw9iN+lp8CNI354Ww+VuzXv9hoQwNwQ5
 IKg5LVzqv8a4hKOpHmuSqaYQx5ZrpV66ApfSilsVk08qGIaLKcJQYrib078I4sEglI9h
 vL6JDtUyJC73wNke09Tt94DS8KheumMqv130FQ5JBmeQxYGMJYgpUQSgEZWFNm1bFxxD
 enYA==
X-Gm-Message-State: APjAAAUAv8OQDQfjtJ4d5NA57iAnn1EpMQGrh7/zHxUbstxWZRXYQ2vt
 niwAiwYkvuVnrF5SVF5sekMyBab7/eCt6OHqEOq7eQ==
X-Google-Smtp-Source: APXvYqzyfhzOfFZYeZFjY1S93cvU4SlqKwxdIAeJh4d8ZQdziO53ND99dxIv+Kblp5owksWhmH97+lG74yAufyWiraw=
X-Received: by 2002:a81:a401:: with SMTP id b1mr1605778ywh.280.1569571047134; 
 Fri, 27 Sep 2019 00:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569545046.git.alistair.francis@wdc.com>
 <c02135a1838ad7b289774b03989424a7a40b38d3.1569545046.git.alistair.francis@wdc.com>
In-Reply-To: <c02135a1838ad7b289774b03989424a7a40b38d3.1569545046.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 27 Sep 2019 15:57:14 +0800
Message-ID: <CAEUhbmUjgw-n6TiUR=P=2Af7rphLiB87yw_vEPs_Oto6Mi9-yg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] riscv/virt: Jump to pflash if specified
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 8:57 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> If the user supplied pflash to QEMU then change the reset code to jump
> to the pflash base address instead of the DRAM base address.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/riscv/virt.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

Tested-by: Bin Meng <bmeng.cn@gmail.com>

