Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3C3C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20BF2071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUlHs4qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20BF2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQ7e-0005JT-5O
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDQ75-0004sx-N2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:35:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDQ73-0005KW-VM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599042932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q036AVIjrZTNxrqIevLqZFQ+UdM4P52TkqjIBqmZfeI=;
 b=UUlHs4qF5meyaR5x9TZI7gu0Bk2ZQlQwGJA2H5RHoVTzNNz6Npkku0r/8dyO0ezUPVMzcv
 G1M7Kq+B2S74kSW6SXv19BCkedeaDz87l1mbh3QCUmnUaeQpHkLEr0Xgqf9CuJBS8umzd5
 Fsrpc5En3tCqXOfICjMe6Pf98NSWC4Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-6QeQXMbfPmu2eQygSoyXDA-1; Wed, 02 Sep 2020 06:35:31 -0400
X-MC-Unique: 6QeQXMbfPmu2eQygSoyXDA-1
Received: by mail-wm1-f72.google.com with SMTP id d5so1474965wmb.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 03:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Q036AVIjrZTNxrqIevLqZFQ+UdM4P52TkqjIBqmZfeI=;
 b=Tv281p1xTQ0BJxRh5CG50gTOeMuyeAxCCKskUYAE4/Hb+wyawTWUgk0elEO3hor3wW
 QRpdi7/KMZ/u9dK74oYPqTdwnl+tl6TrgrhdAmHmSxPA6xXjXIT8iOxzkXI5KJQSmEjG
 MjHSRc5OLNlDscQ8MGxpm6nfTg0DU48HgIXQwPgDgBbBm8NCACxkHkwmh8fgctXSOi05
 CV5fE3LYhX5FVfGAcmyoU1XCMHFXGrPBc5eTja+FlBx6tMMLRN3M+DoMiOHqFOsVUyvW
 YsSuSlNURO31qvfRlameM7rV1ss+cqjVDQEPbSZnQD9q0HRAPHEJY4C9j2XMtEIxYjvk
 84kQ==
X-Gm-Message-State: AOAM530B+ksB9ZeX7O6ysQ6GN45gSF4LRFVt0DKUL1OVhEMFC42Fgx0O
 qtd3Pdr4PNjVGNsnG2B7mytDxRbjRnT7AR73RNvLjuVhTLHZsfU1mKC4x1T7tRcxTMd6mkw/qdR
 FPPSiEqjJzNGO0MY=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr871wmj.132.1599042929833;
 Wed, 02 Sep 2020 03:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwZ6fznKf1n3NxSnK6/nZjCQGRJ5pWxPW9fikpGbbmlcKP3nR/ZeSO5jGaKytnbO37egFjTg==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr844wmj.132.1599042929606;
 Wed, 02 Sep 2020 03:35:29 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id p16sm6530156wro.71.2020.09.02.03.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 03:35:29 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 1/2] hw/mips/mipssim: Use MMIO serial device on
 fake ISA I/O
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200730165900.7030-1-philmd@redhat.com>
 <20200730165900.7030-2-philmd@redhat.com>
 <CAJ+F1C+LGO-nCEo7ELs4j07-cAahXmrbn=NWDX31=gpMP7OKLA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <b6c19e0c-6c2c-4536-b5fd-0b613b0122b5@redhat.com>
Date: Wed, 2 Sep 2020 12:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+LGO-nCEo7ELs4j07-cAahXmrbn=NWDX31=gpMP7OKLA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 7:20 PM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jul 30, 2020 at 9:04 PM Philippe Mathieu-Daudé
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> 
>     The 'mipssim' is not a real hardware, it is a simulator.
> 
>     There is an ISA MMIO space mapped at 0x1fd00000, however
>     this is not a real ISA bus (no ISA IRQ). So can not use
>     the TYPE_ISA_SERIAL device...
>     Instead we have been using a plain MMIO device, but named
>     it IO.
> 
>     TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, using
>     regshift=0 and endianness=DEVICE_LITTLE_ENDIAN.
> 
>     Directly use the TYPE_SERIAL_MM device, enforcing the
>     regshift/endianness values. 'regshift' default is already
>     '0'. 'endianness' is meaningless for 8-bit accesses.
> 
>     Note, there is no migration problem, because TYPE_SERIAL_IO
>     was not migrated.
> 
> 
> I am not so sure about that. It has:
>     /* No dc->vmsd: class has no migratable state */
> 
> but that doesn't mean it's not migratable I think.

Can you be more verbose... I don't understand what I should do.
Reword the patch description or modify the patch?
Thanks.

> 
> 
>     Suggested-by: Peter Maydell <peter.maydell@linaro.org
>     <mailto:peter.maydell@linaro.org>>
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      hw/mips/mipssim.c | 4 +++-
>      1 file changed, 3 insertions(+), 1 deletion(-)
> 
>     diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
>     index 1b3b762203..853bbaca58 100644
>     --- a/hw/mips/mipssim.c
>     +++ b/hw/mips/mipssim.c
>     @@ -216,9 +216,11 @@ mips_mipssim_init(MachineState *machine)
>           * MIPS CPU INT2, which is interrupt 4.
>           */
>          if (serial_hd(0)) {
>     -        DeviceState *dev = qdev_new(TYPE_SERIAL_IO);
>     +        DeviceState *dev = qdev_new(TYPE_SERIAL_MM);
> 
>              qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>     +        qdev_prop_set_uint8(dev, "regshift", 0);
>     +        qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
>              qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>              sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>              sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
>     -- 
>     2.21.3
> 
> 
> 
> 
> -- 
> Marc-André Lureau


