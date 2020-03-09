Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D922D2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2mpiECX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D922D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJkZ-00078O-2b
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBJhm-0003NN-De
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBJhj-0008Sk-9M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:48:30 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBJhj-0008SA-2e
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:48:27 -0400
Received: by mail-ot1-x341.google.com with SMTP id g15so3685798otr.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vl3ODH/+9cQlurQMjvMak6d1qO2peD3ZSVEKtUKOC/4=;
 b=l2mpiECXtvERk3d4kfZp8+e8wjepzK52nSmaEuY3R38pRch5TpUb3W2azKJ7yMhv1J
 uutDXaJJlmUhFXxPAuu1G6HXiv9f8mwVktZI13BeiBqeP9/2otMPKNRhws94EnEJonTW
 NekH5SQtqjsC2zPN32h27NLseQ4ip9bakSfvLUa2MshZ4Ty7q9w0aLZb8GTTKWxBk94g
 Vhl2JybeBn6TGQofXRWJNzJBcbjYOKbgaZ9MWcvg7bv8EeL97T5d6Ry1NoJk04HzUOyt
 wPNo75cNOELH95/aYrnNkbDmAYOF5LXUqbZTX/O1i/HrUUAtYR0gv7RsRXRG1RiKN8mQ
 7dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vl3ODH/+9cQlurQMjvMak6d1qO2peD3ZSVEKtUKOC/4=;
 b=U+UZHk3lk7vLTRN6b3Tdal0w4oRCAVFKDv1ZuCN/vwGLtKEuq/1KYwnjsrHvau/zXX
 LAJDL01Cu+PlTyMUeVhoF7SlQ7v6Il7CDtFrD5PlMWFFNtVYU80cV/+tqwd/3EzbAg4U
 rsUw9U7rX7f2IVGjVkBc7HiqVx16PwDjrdYNKcSSKYpHe4WsXoC5tWiXAZIO3T5d/SAo
 s4vTw0RnI/c2GEKRFkIU5EtbD2nzUClDDIG8hBfjdBPj/7zk8BNAjPId8JeuAtlzJE6Z
 IbQI83T5h9MaqbPoA8UtXS+kIyLjYmIQ3DpJDdaXGbCD7PpAYwlH7WObgaTzG8w8cPwg
 XLyQ==
X-Gm-Message-State: ANhLgQ2lDTjMYz3Jj+PqDPlt5Ol776nhVZ8eyi1sE6WdbY4lm+oer3qq
 A3bCm9fmJcNu07dMwfhdyLbO1CtXqITZkxVlBWYzvA==
X-Google-Smtp-Source: ADFU+vsrD5dQcey+NfLehLrTza6l1K6UF2qmk3HqY5VZroSH31EXZE/PgLK6sePkMVCVI9XkiAgZop8bwtdQuaiu9eI=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr13269048otl.135.1583765306061; 
 Mon, 09 Mar 2020 07:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200309144353.26457-1-philmd@redhat.com>
 <20200309144353.26457-3-philmd@redhat.com>
In-Reply-To: <20200309144353.26457-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 14:48:14 +0000
Message-ID: <CAFEAcA-4BmEvo73a-1pvQx5r+T0gXRa2GcqAmAdYxZBsfAJqFw@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/core/loader: Prohibit loading ROMs bigger than
 memory region
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 14:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> We must not write more data than the memory region size.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/core/loader.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index d1b78f60cd..c67c483936 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1136,7 +1136,10 @@ static void rom_reset(void *unused)
>              continue;
>          }
>          if (rom->mr) {
> -            void *host =3D memory_region_get_ram_ptr(rom->mr);
> +            void *host;
> +
> +            assert(memory_region_size(rom->mr) >=3D rom->datasize);
> +            host =3D memory_region_get_ram_ptr(rom->mr);
>              memcpy(host, rom->data, rom->datasize);

Does this really only happen if there's a QEMU bug,
or could a user trigger this assert by accidentally
passing an oversize file on the command line?

thanks
-- PMM

