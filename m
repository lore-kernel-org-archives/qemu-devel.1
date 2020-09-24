Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1038B2220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLyB0Md3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1038B2220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSRC-00085k-Uz
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLSPk-0007Pu-P6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLSPj-0005eE-3z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600958402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KMh+fXHgVCObOJBJYTlBrjZ6/sWqsQ7dlxi04LnfftA=;
 b=hLyB0Md3OXAjDVrauEigNCJ+YVdcWMxKonZCamiXSZL8h58LjDlPz8PVwbddBO1JME6rAD
 T38PLM9vbSs/pOscTkyxBiWwDTRybkFn2fx6lYILdYemXJeYvzD3Ckogpev0Tr9mgJF405
 YA9BJ0NEVrAczFj6LhGYWW13UOHCds8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-0-oAEtBIPv6puHbn3SwQ9g-1; Thu, 24 Sep 2020 10:40:00 -0400
X-MC-Unique: 0-oAEtBIPv6puHbn3SwQ9g-1
Received: by mail-wr1-f72.google.com with SMTP id v12so1324177wrm.9
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 07:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KMh+fXHgVCObOJBJYTlBrjZ6/sWqsQ7dlxi04LnfftA=;
 b=OXIlUClH3NLkP/NM0ocjSYhJf1qkGy8zbUHisT8h3za56U8GGcdFqcBbMqXmI7ULKN
 Y4trvizhYbj7cyEXAgaXtIKQ4Lgf8eIORpckv+3K94fFzLWsgZLHfqbDhy/aszzcVIq8
 wubnfBvLLQvhHHPHliwomxkhBGa+ZXa9UZJfBtQOiSSf9aiKDSThbq9Y28DPglcIzETh
 mN3DArjTuiRX/SCj0VjGhQA83+cFWgPBMWycmmbyqJ8HYMzEGAvT2Q8DvO4pMXH2pP44
 cRc0j1Uzfv724Af4UwZSZef6j5Wr6d+8UawdJlaZ3iBGyLoOVb3Kb2m3vLVcYfT50tJz
 6pFw==
X-Gm-Message-State: AOAM530NUnnChEkqmN3r2mly0HjTif4dCS0ZyczppfayOH8YiRQVKMxC
 QNc/swQ0k78tiYZKOTMIQ2z5VThMm3gPj93Kh71e1jbJtrjwb9juZ1EcIdIY/cTjLE7gK4iBWve
 HIQKg4HBQ8kWhiDA=
X-Received: by 2002:a5d:5106:: with SMTP id s6mr129322wrt.166.1600958399119;
 Thu, 24 Sep 2020 07:39:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3ktiGMFmqB7wGmrGM9qfpgRvtxBIzUjVb0a9ShRVA9F12lkow5rJ6uf0dUMvlDWI8/snQ3w==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr129302wrt.166.1600958398940;
 Thu, 24 Sep 2020 07:39:58 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id k6sm3595907wmi.1.2020.09.24.07.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 07:39:58 -0700 (PDT)
Subject: Re: [PATCH] hw/scsi/lsi53c895a: Sanitize some trace events format
To: qemu-devel@nongnu.org
References: <20200915174639.1366226-1-philmd@redhat.com>
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
Message-ID: <07e2eda6-c384-7b21-628e-577c327401e0@redhat.com>
Date: Thu, 24 Sep 2020 16:39:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915174639.1366226-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 9/15/20 7:46 PM, Philippe Mathieu-Daudé wrote:
> Make some lsi53c895a trace events more understandable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/scsi/trace-events | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
> index 9a4a60ca635..ac4209f361e 100644
> --- a/hw/scsi/trace-events
> +++ b/hw/scsi/trace-events
> @@ -234,9 +234,9 @@ spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
>  
>  # lsi53c895a.c
>  lsi_reset(void) "Reset"
> -lsi_update_irq(int level, uint8_t dstat, uint8_t sist1, uint8_t sist0) "Update IRQ level %d dstat 0x%02x sist 0x%02x0x%02x"
> +lsi_update_irq(int level, uint8_t dstat, uint8_t sist1, uint8_t sist0) "Update IRQ level %d dstat 0x%02x sist 1:0x%02x 0:0x%02x"
>  lsi_update_irq_disconnected(void) "Handled IRQs & disconnected, looking for pending processes"
> -lsi_script_scsi_interrupt(uint8_t stat1, uint8_t stat0, uint8_t sist1, uint8_t sist0) "SCSI Interrupt 0x%02x0x%02x prev 0x%02x0x%02x"
> +lsi_script_scsi_interrupt(uint8_t stat1, uint8_t stat0, uint8_t sist1, uint8_t sist0) "SCSI Interrupt stat 1:0x%02x 0:0x%02x sist 1:0x%02x 0:0x%02x"
>  lsi_script_dma_interrupt(uint8_t stat, uint8_t dstat) "DMA Interrupt 0x%x prev 0x%x"
>  lsi_bad_phase_jump(uint32_t dsp) "Data phase mismatch jump to 0x%"PRIX32
>  lsi_bad_phase_interrupt(void) "Phase mismatch interrupt"
> 


