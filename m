Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D27EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3162070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVTGRH/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3162070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUJk-0003YI-Ah
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdUJ6-0002rA-OD
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:47:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdUJ5-0000iZ-Ub
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+d6nr6kYvA286kxry/vXk1/Cx3ZVfvfylmDRqkywnuc=;
 b=cVTGRH/jkjmybcSzufZXQQF2cvWaBDmbp2dOqQnmq00luFEPW431a/YEsyItEPKr9KA5jg
 YS4u703mqLADDsakHvpc0akbjo7UAXXLvGXt3XoWyLM5kuyMLWNHNsapLRSlRRquLIXGKO
 4mfVx25qB8cyBlC4ggiigYzp4D6Rkbw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-pdMp_mP9M0ivEbEemqrRiw-1; Tue, 26 May 2020 03:47:23 -0400
X-MC-Unique: pdMp_mP9M0ivEbEemqrRiw-1
Received: by mail-wr1-f69.google.com with SMTP id s7so2907226wrm.16
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+d6nr6kYvA286kxry/vXk1/Cx3ZVfvfylmDRqkywnuc=;
 b=mLjQ/27a3waRTK5pGI6RBk6dXK8XWPaEMvnOsTjHzS578OPf6eO6eD3tdtuythrl1o
 wgy1T5n2WN7aYR86GNV9gC10uLnrhyLxh5ip7Ws5bT2u3wV78zYub7mMwW67NCmWk3y5
 GPOX1FQPYpb9GwzYkD2icl4TR/sxCj7Cx1wHjGnEASjbkgvUhYLueZhG/o7h41j5JFQr
 xeGsfHB+oxxg9q16D1YARkAD0O/S8XZI/VqXDrL7VEqGsHoCDclzyU2lfoRucZCZuQVF
 DzDJewZ76XktkDgi98CaqHpT6bi60IOQx9yDiWo7CDzHqk47sb5XlBTBdng63Imh6H1F
 1kyA==
X-Gm-Message-State: AOAM533R1ugxvfGtqjwAhCcNNbgTYTgBImurNiDGiFWW8A2ToUhqp4TM
 u2sQZ7NYZyc/TTvL/AGJCSUf2ItltRHBrcnlhy+eJC26PebMccUMgt4Nd0RHE8XM5IYuHroELL6
 ife4mboW8urhyZmA=
X-Received: by 2002:adf:ed01:: with SMTP id a1mr11671851wro.271.1590479242755; 
 Tue, 26 May 2020 00:47:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGf/TXwdMBsGbYAmJH5iOTTuqmrJFFFumYbmerBr959hUtk9mBktuZIf8yfGIUBGevkg3FRQ==
X-Received: by 2002:adf:ed01:: with SMTP id a1mr11671825wro.271.1590479242566; 
 Tue, 26 May 2020 00:47:22 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p4sm20873062wrq.31.2020.05.26.00.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:47:21 -0700 (PDT)
Subject: Re: [PATCH 00/12] hw/mips/fuloong2e: PoC to fix hang after reboot
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200510210128.18343-1-f4bug@amsat.org>
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
Message-ID: <2d2d03c8-d881-2fe1-b7d6-ed539273012b@redhat.com>
Date: Tue, 26 May 2020 09:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/20 11:01 PM, Philippe Mathieu-Daudé wrote:
> The PMON firmware behave differently regarding it is run
> after a cold/warm reset. A simple bit flip fix the issue,
> however we need to know the type of reset to set it.
> Currently QEMU only supports COLD reset.
> 
> This series contains various of my current Fuloong queue,
> - Welcome Huacai Chen as co-maintainer,
> - Fix typo in machine name,
> - Few cleanups in Bonito64,
> - Report various Bonito64 accesses as UNIMP,
> - Proof-of-concept fix for the reset bit.
> 
> The last patch is not for merging, but is included to see
> if the Multi-phase reset mechanism can fix the problem.
> 
> Regards,
> 
> Phil.
> 
> Huacai Chen (1):
>   MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
> 
> Philippe Mathieu-Daudé (11):
>   hw/mips/fuloong2e: Rename PMON BIOS name
>   hw/mips/fuloong2e: Move code and update a comment
>   hw/mips/fuloong2e: Fix typo in Fuloong machine name
>   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
>   hw/pci-host/bonito: Fix DPRINTF() format strings
>   hw/pci-host/bonito: Map peripheral using physical address
>   hw/pci-host/bonito: Map all the Bonito64 I/O range
>   hw/pci-host/bonito: Map the different PCI ranges more detailled
>   hw/pci-host/bonito: Better describe the I/O CS regions
>   hw/pci-host/bonito: Set the Config register reset value with
>     FIELD_DP32
>   POC hw/pci-host/bonito: Fix BONGENCFG value after a warm-reset

Thanks, patches 1, 3-11 queued to mips-next after addressing Aleksandar
comments.


