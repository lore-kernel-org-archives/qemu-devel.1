Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375DFC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F20021D40
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HL1Rczfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F20021D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuwE-00023C-LE
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZuvG-0000h7-57
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:56:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZuvA-0008RI-RE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604404576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7I8gP+zdisi1KbMRrZsZBaiIgcHHpcETxHUPEMAGUAY=;
 b=HL1Rczfb7kVn9htg6qFCURksYRF7LhyADJlJow4xmGmvrW+y7UZf8sSW8OT0+IXRHgdFhX
 a3EbHpvMZ5oFMt0Iv66zFTn40Ttls6dCbJaWKwatT7gJzGtfv2bqNdXjD3rqhA9TgsW29+
 FaflcvNl396pxw6EOpu4oBRy9W9bMbY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-fbHIwcxPOgC6dR6MjbUKeA-1; Tue, 03 Nov 2020 06:56:14 -0500
X-MC-Unique: fbHIwcxPOgC6dR6MjbUKeA-1
Received: by mail-ej1-f70.google.com with SMTP id p18so5337048ejl.14
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7I8gP+zdisi1KbMRrZsZBaiIgcHHpcETxHUPEMAGUAY=;
 b=ihHRWvcPckEzfoy5T4nQvcwbbZIWdL49a0T5PTDbt6xeK2IPSCON1DfsruGcWRrwv+
 BPWgp24p6Cy8wcDBloxBwZGCBFH0gM467L77oZG7I8Jdr5n80ffqzYr31kuBPmCQcg5q
 NEWqUDBI7I15xrPmBY7drRloKXMIpWL37FyfAkSr0c67ijzgvomf++KD3fRZDnnkYOoO
 7samiDQKEkSAllq9JIItGcKT+wiHz8XglrNwtpXoJCL0WovOICUf6u1plcTP9GG2T8/n
 NaNmIQAo1aK1jkLwFP+8pkNXHfpnAPta7+tQj6Pl+Xop0SBATOw++cuMbjQVzAB9ynnm
 8rxQ==
X-Gm-Message-State: AOAM531J1i//JSIaqyG+x5cUuUrlIutsBxxXb4Ej70JLbC+MtQc7SI0b
 yW3fPG8RgjnoSSet9bfhM7CKWw0ZB+a9C7yspsVsdDB322PyjKvcyeugGquQWFO6AHWrXkgsyiO
 f9Hv/qJATwe56+DU=
X-Received: by 2002:a05:6402:84c:: with SMTP id
 b12mr1549289edz.122.1604404573114; 
 Tue, 03 Nov 2020 03:56:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMaIBUdtAdw5+PI5jbIZDIMIq81MA2GA1lyEwiC7nYXkPu9hU0k27AKtOjAr1v159kTzJDYg==
X-Received: by 2002:a05:6402:84c:: with SMTP id
 b12mr1549275edz.122.1604404572903; 
 Tue, 03 Nov 2020 03:56:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id nd5sm10482213ejb.37.2020.11.03.03.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 03:56:12 -0800 (PST)
Subject: Re: [PATCH] tests/qtest/libqtest.c: Check for setsockopt() failure
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201103115112.19211-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <945d6166-317e-46cb-d7db-a39f28e31d49@redhat.com>
Date: Tue, 3 Nov 2020 12:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103115112.19211-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 12:51, Peter Maydell wrote:
> In socket_accept() we use setsockopt() to set SO_RCVTIMEO,
> but we don't check the return value for failure. Do so.
> 
> Fixes: Coverity CID 1432321
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/libqtest.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 99deff47efc..be0fb430ddd 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -110,8 +110,13 @@ static int socket_accept(int sock)
>      struct timeval timeout = { .tv_sec = SOCKET_TIMEOUT,
>                                 .tv_usec = 0 };
>  
> -    setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (void *)&timeout,
> -               sizeof(timeout));
> +    if (qemu_setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO,
> +                        (void *)&timeout, sizeof(timeout))) {
> +        fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
> +                __func__, strerror(errno));
> +        close(sock);
> +        return -1;
> +    }
>  
>      do {
>          addrlen = sizeof(addr);
> 


Queued, thanks.

Paolo


