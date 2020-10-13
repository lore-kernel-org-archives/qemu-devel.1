Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC47C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0556F20878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hxu1984y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0556F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHf8-00025K-RS
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHdd-0001Pv-5t
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHda-0003kq-5c
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602585272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoguNjI7oBCF4ito9ca0lw6czC+f+FC3PWqdy4LBhOk=;
 b=Hxu1984y0DUREdigJPb6qDJWNKQQGyEffDzsCwZFlSvwvf+LvLInEw4JUUyXkF3psh7Zh0
 5zff5D0VzCLWVJH3wdoE34lvsAwRyPlgeuTrJo3xla838+rk4U0Ooiz66M3Z+XXD9CSysF
 aZwMxWJFBVxZlav728ibs4JujYOMW1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-XwtVShsFPYSHmwElDXzlXQ-1; Tue, 13 Oct 2020 06:34:30 -0400
X-MC-Unique: XwtVShsFPYSHmwElDXzlXQ-1
Received: by mail-wm1-f72.google.com with SMTP id d197so5793751wmd.4
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VoguNjI7oBCF4ito9ca0lw6czC+f+FC3PWqdy4LBhOk=;
 b=V0MsZY+CFdnYc3aPb40uUbeM6oPyUAV8Z+6iLQJuitcyC9FyF542aQhgdvZqmpl101
 JjamPUWzdnppbJrybGp/6B9smDCYMosmBkyxqt0P3f4dGRb6Nw9/4QJZ1m67Jg/TnyEk
 TmPfSjrGlnp+lWoZyj70KKvcFv50G1YRJbFrh+xEMe2A22YvigLdT99sYR5Qlnk8O3Ks
 MVP/YxUgCcknqXK9up+r88IrovAJATM9e9XMql2Wr/qukh65Q2WTlbbUZQCqY/EpYvdu
 XohsqkXaBS06lc44qoshXzwBZ55D6oyRDYmSP5bq5pZnMoKoY2Mze1YrdGd6VK9An3G7
 MtFA==
X-Gm-Message-State: AOAM533JV7KFWuENgmvFrhCHuUEGw1ZogU6+Ky1/4zt+wSz8mj41f5NQ
 xwTxfG78urb0j4PuhoCSzUJUVV/ysG4o1nOli8yQYwkXjXrNVX5l5QFcpEDZB3wWAUzDsjKOXnh
 SZpJmrVJsLovmgo8=
X-Received: by 2002:a1c:bd43:: with SMTP id n64mr14194480wmf.113.1602585268717; 
 Tue, 13 Oct 2020 03:34:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXxAhYHpQXHMAHqMNLnEgFO7iGslPWdKPALdTKqMPOCyGzdTryyT9Cc7ETObocvJFFMa7KbQ==
X-Received: by 2002:a1c:bd43:: with SMTP id n64mr14194463wmf.113.1602585268523; 
 Tue, 13 Oct 2020 03:34:28 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p4sm22652218wrf.67.2020.10.13.03.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 03:34:27 -0700 (PDT)
Subject: Re: [PATCH v3] hw/core/qdev-properties-system: Fix pci bus range in
 set_pci_host_devaddr()
To: Klaus Herman <kherman@inbox.lv>, qemu-devel@nongnu.org
References: <20201013092014.34059-1-kherman@inbox.lv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f1303e7-90f4-aeb4-a7e9-0088b9f3c741@redhat.com>
Date: Tue, 13 Oct 2020 12:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013092014.34059-1-kherman@inbox.lv>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 11:20 AM, Klaus Herman wrote:
> Fixes: bccb20c49df ("hw/core/qdev-properties: Use qemu_strtoul() in set_pci_host_devaddr()")
> Signed-off-by: Klaus Herman <kherman@inbox.lv>
> ---
>   hw/core/qdev-properties-system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 49bdd12..e3dca56 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -903,7 +903,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>       bus = val;
>   
>       p = (char *)e + 1;
> -    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
> +    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xff || e == p) {

As this is used to check both bus/slot range, I sent a different
approach to fix this issue:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03604.html

>           goto inval;
>       }
>       if (*e == ':') {
> 


