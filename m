Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67782C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334B520787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ncv1uoIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334B520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYLQ-0007ut-ED
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYKE-0006uW-KJ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:04:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYKC-0007Hw-SI
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590494692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bdsl3NHXctqdkc68LnHcrft3I3CyU8ErIcZ5xrnaZWM=;
 b=Ncv1uoITCRYr2uBoaW5qSj9V3ycgZen9+oTKb0lp1GzYVKPE9AK6bFMRUJYNGi1f1B8vwr
 Dm3twsR4ynix349hyBobu9PmQ2iAawzSvjIZyTzezxB2xpsoBRO4P36B0UqgYmYWREDFSY
 beq8hOGknEadP9X0rAIS3yGQFXEL0Dc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-Xgw5-CuWO8CENVJetEDy1w-1; Tue, 26 May 2020 08:04:50 -0400
X-MC-Unique: Xgw5-CuWO8CENVJetEDy1w-1
Received: by mail-ed1-f71.google.com with SMTP id k17so8857264edo.20
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 05:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Bdsl3NHXctqdkc68LnHcrft3I3CyU8ErIcZ5xrnaZWM=;
 b=KKqb6Zv6jQJQimpyuPiWCByc14kO6/rV41krBjgTMVgt++tKuboaFuRL6LcYymSK04
 fTAPRJJpBD2+m/mLAGGQPzVpjgPQ/vWEj1tBXMITTSN61c/3NOaFoiesy+1v13LZrHJC
 6TlijAn6xqwmsfe/0BbcPV64P99AZxPonh/EmdoXp4mjMgnJxSVNwbJQt9DbCAg09+KY
 ns5HayH6i7/RNnE1WOhQN4i2PyKVCaPc6zp8enkE8FSptwchV07RmrOXoyWh8XlHtX/u
 GxIPwml1RnqtUSt7jJY1/MPpwIkOWL9QdDCflt9tN0AEI+DE1Vy7X1+tq3U8YZPRSSCk
 5ssQ==
X-Gm-Message-State: AOAM530U2Ck2kkPdfAm1uy76RBpaLiwrujYe4yRQs7m845H6AL982ElT
 5MtYrBJm7Fz70iVIFFyoW4+2XExYMJBFjUgBi1hLBboGMlNeiWGTRfXsXGBN6QLd02HLxGXa9JT
 mzK+GoTvfzZHuaXA=
X-Received: by 2002:a17:906:94d5:: with SMTP id
 d21mr780734ejy.342.1590494689428; 
 Tue, 26 May 2020 05:04:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzO0ld/wnpfREFzKyIW7cVh105UXDM4kN4b6vZkz7Kb+qBfHPyULPdEjhq54MUVr6OCJFCNw==
X-Received: by 2002:a17:906:94d5:: with SMTP id
 d21mr780716ejy.342.1590494689212; 
 Tue, 26 May 2020 05:04:49 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b62sm18825750edf.28.2020.05.26.05.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 05:04:48 -0700 (PDT)
Subject: Re: [PATCH 5/7] block/nvme: clarify that free_req_queue is protected
 by q->lock
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-6-stefanha@redhat.com>
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
Message-ID: <bfa19a0d-8e78-ffa4-0146-932923162e79@redhat.com>
Date: Tue, 26 May 2020 14:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-6-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 00:48:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 7:11 PM, Stefan Hajnoczi wrote:
> Existing users access free_req_queue under q->lock. Document this.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 3ad4f27e1c..e32bff26ff 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -57,7 +57,6 @@ typedef struct {
>  } NVMeRequest;
>  
>  typedef struct {
> -    CoQueue     free_req_queue;
>      QemuMutex   lock;
>  
>      /* Fields protected by BQL */
> @@ -65,6 +64,7 @@ typedef struct {
>      uint8_t     *prp_list_pages;
>  
>      /* Fields protected by @lock */
> +    CoQueue     free_req_queue;
>      NVMeQueue   sq, cq;
>      int         cq_phase;
>      int         free_req_head;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


