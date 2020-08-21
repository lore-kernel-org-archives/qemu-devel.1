Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6028FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3119B20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Seb+7YB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3119B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BIY-00083i-ET
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9BHQ-0005vs-Iz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9BHO-00051o-Fk
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598032601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+9Se6hxBLJ7lRfgMnKAHVexggB4fM10BtGsA9g4RXNY=;
 b=Seb+7YB0HTbf47IQqf5jhsY+0oRF5DRwtbeGSgwt0GqjCtZ1zh93awfChlJm/0IxHrp4aQ
 G7z5jBJd8f4szFV0hFwBPElu2GRj4GNDF99WDgnBPwzzgFWk98k9e1bICBomXwNqKEg0Gk
 ZAqA7qhHLKrC4H7OUeEV2yrNilA7v24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-sFvClEtJMUGFqj-l85cpEg-1; Fri, 21 Aug 2020 13:56:39 -0400
X-MC-Unique: sFvClEtJMUGFqj-l85cpEg-1
Received: by mail-wr1-f71.google.com with SMTP id m7so788938wrb.20
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+9Se6hxBLJ7lRfgMnKAHVexggB4fM10BtGsA9g4RXNY=;
 b=KHw0LZM5W/cZ1/VwwwyDPhUU+WIOMvonIEBFmnEBFOWLfTz7jzYLhuU/7ktmEJOa5W
 4t9QMnbi2/BvHvrYrufdbM0Uw2ZItrnhsr5SxiOS2E9zhCGa3j5kNOIz5SoXoCF/5XNO
 YrPMO2nGDgWjKwQCoF3mFfqBrtku4VybRl8LN5/I0S2F45uzxQWIAWo9REGjh9kd+nH4
 0GO3mnlVsQYJyxffUlCa1rnPbSPPZSLdFMyJGJU3P/7tAVr2E2ztP1w790BQjkQwO9Lt
 9GSmlZ1gkSCk3AXZ295ywI5mcTXOmXULe17CJ4+/llgsL+hjj4ztz87AYLUc6qkQlSCL
 307w==
X-Gm-Message-State: AOAM533Wz097pVxtAghoe8Ut4kKinab2uC0L60Ofj51HIp+r8iAOuV+l
 E7I+/xHNFahn8IZhEm1KMiOHIoFG9GoBbnknfby4W5xIVfPF0dkxzoc0qgGONgTAvoI9GafHwe8
 f4FcUUew8vBojPF0=
X-Received: by 2002:adf:e550:: with SMTP id z16mr2565089wrm.360.1598032598329; 
 Fri, 21 Aug 2020 10:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKi+mxXRdO4x6+N0qWhIRGwos5imRz4x/Tq7YtRbCy9/S8/3RQf0ZK0j1Wkp9jiWVSIqoP8Q==
X-Received: by 2002:adf:e550:: with SMTP id z16mr2565071wrm.360.1598032598063; 
 Fri, 21 Aug 2020 10:56:38 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w132sm7303888wma.32.2020.08.21.10.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 10:56:37 -0700 (PDT)
Subject: Re: [PATCH] keymaps: update
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200821161415.25341-1-pbonzini@redhat.com>
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
Message-ID: <8ed9a66b-c868-42bc-7d97-14e52ae60088@redhat.com>
Date: Fri, 21 Aug 2020 19:56:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821161415.25341-1-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 6:14 PM, Paolo Bonzini wrote:
> Looks like update-keymaps has not been run in a while.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  pc-bios/keymaps/ar    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/bepo  | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/cz    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/da    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/de    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/de-ch | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/en-gb | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/en-us | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/es    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/et    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/fi    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/fo    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/fr    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/fr-be | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/fr-ca | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/fr-ch | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/hr    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/hu    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/is    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/it    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/ja    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/lt    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/lv    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/mk    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/nl    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/no    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/pl    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/pt    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/pt-br | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/ru    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/th    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  pc-bios/keymaps/tr    | 242 +++++++++++++++++++++++++++++++++++++++++-
>  32 files changed, 7680 insertions(+), 64 deletions(-)

Typical pre-release CI job.


