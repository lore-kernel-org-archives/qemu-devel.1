Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B017DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA06207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQlqCcB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA06207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzYc-0000IE-Kw
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqzVj-0004Sv-DS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:44:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqzVg-0005XP-1c
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593697454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DYXFNSP5QGhfFw1WXax8fa+wTwSWIKF/Vs6yd2PpBrg=;
 b=jQlqCcB7aQPyIR5AvRAVRKeaIrn8j2HnAn7Z0ZLwqNKdUIeUvTAhSx59KMG0+OSKtR54JV
 hygJ94IP+KXLFaHsXlEtCDrrw4L78CIAaKtOHYlyFWH54rEK7xxlZ4e7GiFyYCqO3plGFx
 nK6tf503sUqieEBpbw+15s/VW8s7Hpo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-eqagqzvnOzOv-7E-goDsjw-1; Thu, 02 Jul 2020 09:44:11 -0400
X-MC-Unique: eqagqzvnOzOv-7E-goDsjw-1
Received: by mail-wr1-f69.google.com with SMTP id j16so20612118wrw.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 06:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DYXFNSP5QGhfFw1WXax8fa+wTwSWIKF/Vs6yd2PpBrg=;
 b=KIShkwbAL8BmUb7Q1PiYUcSGVzQ6JvuKlOjspGkbcQbMsNLpYfwyZGVBrVLjKIZ89i
 cFX2Z2JaH63OQW/nbA/cJmbUxIBs4hkbaU0X1F1APJPZpgL9jizTwNO6Ecx7iqcWKGyP
 URf7mY2shRVgz0D4/CI1FrkrmaElFaAPmMLtAKo2iD5oCPwF5r1PKbYZ8JlI5JRDERdH
 KdadcubMsdJOExfMgwsulomqviK9K/ueUCyL9j/C8G2c8GfriF8/csEjH7J7d+3z/LrE
 X/iqlncVL7kcnIcAcs2QboifijvC7NRPKVNE0XHuOjuKGjj+i/Phea0K1EohfajF9ZEO
 xJxg==
X-Gm-Message-State: AOAM532FTE8poppB/mUj/+HUrHmco3jraqQnQbc5JnN+LHmXiXcnnBYu
 Wyie2hl1a3QG0SM1Tsq/wBBOeiAISARKn3REGKCAgSqf8pJg2oaYNvzhq/oE4kQKwpedWHBTSaC
 TkZHL2ZkY9IYh3p0=
X-Received: by 2002:a5d:664a:: with SMTP id f10mr31538783wrw.300.1593697450643; 
 Thu, 02 Jul 2020 06:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNIxB/EWiH83yJ1K+bjY6SRMOCxAX/g2uSyfxCEslM4TgXgOiKwT6B/rPXa4q0C1GZfJTFdQ==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr31538761wrw.300.1593697450424; 
 Thu, 02 Jul 2020 06:44:10 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 33sm11462260wri.16.2020.07.02.06.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 06:44:09 -0700 (PDT)
Subject: Re: [PATCH v5 11/20] pc_basic_device_init: pass PCMachineState
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200702132525.6849-1-kraxel@redhat.com>
 <20200702132525.6849-12-kraxel@redhat.com>
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
Message-ID: <6e2ece1b-f411-9982-bac0-4650a24634d3@redhat.com>
Date: Thu, 2 Jul 2020 15:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702132525.6849-12-kraxel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 3:25 PM, Gerd Hoffmann wrote:
> Need access to pcms for pcspk initialization.
> Just preparation, no functional change.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/pc.h | 3 ++-
>  hw/i386/pc.c         | 3 ++-
>  hw/i386/pc_piix.c    | 2 +-
>  hw/i386/pc_q35.c     | 2 +-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index dce1273c7dad..3a601dbe71da 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -160,7 +160,8 @@ void pc_memory_init(PCMachineState *pcms,
>                      MemoryRegion **ram_memory);
>  uint64_t pc_pci_hole64_start(void);
>  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
> -void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
> +void pc_basic_device_init(struct PCMachineState *pcms,

[Not this patch problem, simply thinking loudly]

What we should pass is a PCMachineClass pointer.

I don't understand why PIT is a runtime changeable property.

> +                          ISABus *isa_bus, qemu_irq *gsi,
>                            ISADevice **rtc_state,
>                            bool create_fdctrl,
>                            bool no_vmport,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4af9679d039b..d89e577f6fa1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1155,7 +1155,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
>      g_free(a20_line);
>  }
>  
> -void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
> +void pc_basic_device_init(struct PCMachineState *pcms,
> +                          ISABus *isa_bus, qemu_irq *gsi,
>                            ISADevice **rtc_state,
>                            bool create_fdctrl,
>                            bool no_vmport,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 1d832b2878b1..a3b416507286 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -235,7 +235,7 @@ static void pc_init1(MachineState *machine,
>      }
>  
>      /* init basic PC hardware */
> -    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, true,
> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, true,
>                           (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
>                           0x4);
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 047ea8db28ea..b16e22c6cccd 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -275,7 +275,7 @@ static void pc_q35_init(MachineState *machine)
>      }
>  
>      /* init basic PC hardware */
> -    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, !mc->no_floppy,
> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, !mc->no_floppy,
>                           (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
>                           0xff0104);
>  
> 


