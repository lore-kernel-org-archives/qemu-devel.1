Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24644C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AEC204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWeXYVa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AEC204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7z5i-000771-88
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7z4w-0006dI-1t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7z4t-0003Pf-8W
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597747370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KPu+AuK5ZRBc8jdxch2qQ8wi7UI7VVpX0TW1w+06LXw=;
 b=GWeXYVa48QYDi7uWIJXKKNwovXVMGvyUOIux4GTF5DWE6CeQCY5qgbCoaPlcH5t1d2IWsl
 EwJ6BZEEuuE7SGBfWjGIjmEQKRwt83RW85UzgbOYvlTFyZAYRvhAStQhe5D/JZzQAIAUnZ
 cJlQzs0BCw9usSejCh+RlzMAp7hSzWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-C0jmf-ynMuGSetflDM0Yjw-1; Tue, 18 Aug 2020 06:42:48 -0400
X-MC-Unique: C0jmf-ynMuGSetflDM0Yjw-1
Received: by mail-wr1-f71.google.com with SMTP id 5so8041269wrc.17
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KPu+AuK5ZRBc8jdxch2qQ8wi7UI7VVpX0TW1w+06LXw=;
 b=klZmaXGBpExRRPCE0TU3K7SrWC9HToz+HsaKyGfIXfWY5NnVcpMxzte3SrVhHA64vK
 g37InH8ZecOgVbijzrFMQgd8oJrawEsgQGdLDQf6m7oQgWvF7iWGVV3tjd8boaS/PdNY
 QZPDYoCFG5eFkgZ4/Yvw7wrAtG1b4McV1OqRb39//Nk+CUq9XWAhFWxOnNk8S0OkHwPv
 ay1q/MZumGF23mtf72QmsY4quCc2EHrFjO2C4Fkpl6gAaMLWAJpWMCrvkCwfXel45AHD
 qzdjDHz4JudOc3MhlZ1N7WKOydYHPiGl6gE8UzHePtK3I9CuaaqRVnuc6Y9dMEu2pKjV
 l01Q==
X-Gm-Message-State: AOAM532FgOSUydRBlG66K5Wy/aN+1jFsP/CuIm5UzvX9kaTrq/YO/q0L
 2RU2+z0GREuP/8JGvkUIG1V8M0paV94JIcpdReqOnFZ+nSKc85+4f77aUgmhiYACysK8PYSfTZh
 F9y29hW1idjNMelE=
X-Received: by 2002:a5d:4701:: with SMTP id y1mr20367739wrq.416.1597747364463; 
 Tue, 18 Aug 2020 03:42:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1tPpQ5W9kS7YTbAKHUjrKR9AR8WVMjx0M6wppCsKbfGb5YEfGdA8wTCIzDZ449to7N3wanQ==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr20367733wrq.416.1597747364257; 
 Tue, 18 Aug 2020 03:42:44 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e5sm36413256wrc.37.2020.08.18.03.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:42:43 -0700 (PDT)
Subject: Re: [PATCH 087/150] meson: convert hw/nubus
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817143723.343284-88-pbonzini@redhat.com>
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
Message-ID: <e3752aaf-0a09-3061-be12-1c3d86fd2e82@redhat.com>
Date: Tue, 18 Aug 2020 12:42:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817143723.343284-88-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 4:36 PM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs       | 1 -
>  hw/meson.build         | 1 +
>  hw/nubus/Makefile.objs | 4 ----
>  hw/nubus/meson.build   | 7 +++++++
>  4 files changed, 8 insertions(+), 5 deletions(-)
>  delete mode 100644 hw/nubus/Makefile.objs
>  create mode 100644 hw/nubus/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


