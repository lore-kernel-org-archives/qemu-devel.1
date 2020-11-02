Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F755C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E3622226
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGuEMyGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E3622226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXHq-0000JG-BS
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZXGu-00085Y-BL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZXGo-0000Ds-Hv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604313661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/sqx7lW/UDP1CI19rRScHegJiO+UxKtZEMKJob9xww=;
 b=LGuEMyGlEsErN+c2B8DdQLpUrDdHJesjHmUVwpdnNdxHTCuq4+JoZX/9nE4XYLNwEHIpFz
 6vYdq5HjIfBZfgZ8qLGuTBN6HtWoCgiMTFaVeAJoQeMMSpTKmqrSjvPc3LkNe7Q7ptvxBr
 sv1i8mKWSz6+KD4wBkri7q2upsazbVE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-M1w6b8v_Ozqrk0QeSC_aPA-1; Mon, 02 Nov 2020 05:41:00 -0500
X-MC-Unique: M1w6b8v_Ozqrk0QeSC_aPA-1
Received: by mail-wm1-f69.google.com with SMTP id c10so2336282wmh.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B/sqx7lW/UDP1CI19rRScHegJiO+UxKtZEMKJob9xww=;
 b=i0eMppl/SS4N0IYIKpRXxAwHWsU03UXhlM5HSOMdmMzl7YJVOAkicqZkHLv8VT5q0I
 Kb1G6dKjVlVg6xwZ8FCPPfTnbYaAqUKtl5XWm7TQX96PsMq2IkJg65QYqytrjrOn7Dsp
 i6QIkDkckKnfNdxyPy/kYm1Pjbd+Ig/mD+ivxTHHf+DzdZ6pvWA9mEK6ME8ygjuqnLwo
 C7Rj/Ig7pwWtOiydl6chC5oLMXOcsFghGmgSKFtmy+yj4OLDnH3bP3CaPflj4FqkUc40
 97XXGmhzF5sEeO5sZ3aDYAFwUssLKlXQnHehO5l9NNm0lKGN51dQoDEtgS4t/o2GbpAd
 Y+4Q==
X-Gm-Message-State: AOAM530HNsHhnN5s5EUrowGPm+sW3SpFwv7A/Jh78q5HtQdwMf5/Iw8k
 PJkxOuMNaccdgj3gzgdE5wTxrmD9g68Mi4KH6oCdPspclW4Bu9X1cGdI9dVM7UkzvrMbOXzeYCT
 IV4OrtLK+thTfLi0=
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr17126450wmf.111.1604313659133; 
 Mon, 02 Nov 2020 02:40:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5vC5Yh/HCRlKP9SHBZB1XK2ta5k7VOTxNStpfxWTdPNOq7YBakNauvgll8Vob9YuHkjf10w==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr17126431wmf.111.1604313658960; 
 Mon, 02 Nov 2020 02:40:58 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e20sm14442072wme.35.2020.11.02.02.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 02:40:58 -0800 (PST)
Subject: Re: [PATCH v2] pc: comment style fixup
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20201102102815.1102222-1-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d863e674-6ca0-3801-def2-924d13d2fe58@redhat.com>
Date: Mon, 2 Nov 2020 11:40:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102102815.1102222-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 11:28 AM, Michael S. Tsirkin wrote:
> Fix up checkpatch comment style warnings.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes from v1:
>     address philippe's comments
> :w
> 
>  hw/i386/pc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


