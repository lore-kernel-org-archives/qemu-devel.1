Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26832C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26CE2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLKYKpDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26CE2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Pvq-00033x-4C
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4Pux-00029C-K2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4Puv-00014N-Ka
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:01:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4Puv-00013s-Gr
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582120892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qvcVIGaoNADNnRTSnUwr7JP3cEtgVmrAX3wk0w7/3E=;
 b=cLKYKpDElsElii5cJ8YhSodHVxD9d2Z2jj7xnBfRfRBllm29YMgsuMalvMdy+6+jkYXcXN
 sfoyiRJ+lgbGPs5yPjaABmXdZ4ljGHZ482VhOjrr5Sxk/pIAcE2Rtq22vqIZKjOyiGgFn1
 gG+ICIBWRK/Cg3mC547yiaRYey6XRTU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-Euhlhyo_OwGmchcE4zvwFw-1; Wed, 19 Feb 2020 09:01:30 -0500
Received: by mail-wr1-f72.google.com with SMTP id o9so89731wrw.14
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 06:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0qvcVIGaoNADNnRTSnUwr7JP3cEtgVmrAX3wk0w7/3E=;
 b=ID+WH8oqVYm5OVmciwIsEhtLp7VgLCcx02LxtDCrX0uDhCS0W2VfYSV6yCRePkvTLq
 hIobQSrVoO4SiJ0oqu2vbR8tVS/pXOCJaRAv2r4k0xBY/+VQ9fiAGe/sCMndjPNMCAjC
 s4gNsTsFnHcny20CQjkLMB+hl5EqO/hyOfChE0XnEua7NbOaMI1H6R62JiSKUvJb7OPz
 8OsGjxIZbd9BiPNNt+7pKp5hRFQkok2BKY1MvFBLnPlAzuwuOWQlzqG21oSjnrGwf6Ji
 NZPZOs2tZwxcXS4S0PixiiGBZJxoZrfOj59FW98NVD7NC9dcxNXhHXCoWmUg4T9SmS/Z
 QywQ==
X-Gm-Message-State: APjAAAUUtq1e7OFQxJ9+bFEgmWOY+Vc0nem+Ckol3ONKkhOvKf1sUbfY
 m+Vmu+VgxfF3EFm7gAqGdRhimdvmzWw0q8ReeDu8jljCN+v6pn2kLCy7QwVxe5cIFbWKzX54gUz
 Cc7C6dZz1iROanE4=
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr8543139wru.332.1582120889051; 
 Wed, 19 Feb 2020 06:01:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwj7yanPo/0pNbdx+uqQMfbRfD38Kjvca+ipTGmZH/aPn7fGko011ioB6Ad8wy8iRc41NA/fg==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr8543096wru.332.1582120888524; 
 Wed, 19 Feb 2020 06:01:28 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b13sm3261102wrq.48.2020.02.19.06.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 06:01:27 -0800 (PST)
Subject: Re: [PATCH 2/2] block/curl: HTTP header field names are case
 insensitive
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200219132745.315381-1-david.edmondson@oracle.com>
 <20200219132745.315381-3-david.edmondson@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b0b900f0-e879-727d-e88b-5ddb3ffe8fc1@redhat.com>
Date: Wed, 19 Feb 2020 15:01:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219132745.315381-3-david.edmondson@oracle.com>
Content-Language: en-US
X-MC-Unique: Euhlhyo_OwGmchcE4zvwFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 2/19/20 2:27 PM, David Edmondson wrote:
> RFC 7230 section 3.2 indicates that HTTP header field names are case
> insensitive.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   block/curl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 0cf99a4b31b8..4256659cd85b 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -216,11 +216,11 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>       size_t realsize = size * nmemb;
>       const char *header = (char *)ptr;
>       const char *end = header + realsize;
> -    const char *accept_ranges = "Accept-Ranges:";
> +    const char *accept_ranges = "accept-ranges:";
>       const char *bytes = "bytes";
>   
>       if (realsize >= strlen(accept_ranges)
> -        && strncmp(header, accept_ranges, strlen(accept_ranges)) == 0) {
> +        && strncasecmp(header, accept_ranges, strlen(accept_ranges)) == 0) {

Can you use g_ascii_strncasecmp() instead?

>   
>           char *p = strchr(header, ':') + 1;
>   
> 


