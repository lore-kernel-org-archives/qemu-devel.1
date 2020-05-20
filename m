Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B75C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61682075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIX/wky/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61682075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHOA-0006VJ-Nv
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 01:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbHNY-0005sB-82
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:34:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbHNU-0005Cg-Cm
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589952891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/yYznJjjbKntahD85eM3G3iBzc/4A4M0fpH6H+uGs8=;
 b=MIX/wky/k6HWQfVxHG3fZfd5TdDKlRHtm0DcZGYj2l4X0WmVlZYPLgJwf8OsDZniK+ph2j
 KSn/GSPNplS6fqt+t4+cW5rVPWohLNDR/mqrNyLIdZlNZ/OcfAog6tNK/II2pywCMrwOpv
 ksW4+Z+HFqWXGy//JmzsIYxo1OX9IW4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-dZlPq8FtM6KZqXL8Yjiuxg-1; Wed, 20 May 2020 01:34:49 -0400
X-MC-Unique: dZlPq8FtM6KZqXL8Yjiuxg-1
Received: by mail-wm1-f71.google.com with SMTP id t23so472359wmi.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D/yYznJjjbKntahD85eM3G3iBzc/4A4M0fpH6H+uGs8=;
 b=EcGsGXAk9rfcj/JfITZPxGYG0ztvRRbrP75LsRHNuwjLnveuJajfOPLvEnlooVg78S
 Zwls6H1BnhN3ZvtWF5RZJHM/VPunBbVsh6zNbDVvZ8bODUkvRaOUeoIabSsHVAV+LlcP
 B9x36E55lbRudosVlybNS8d7l7nQdD3soWz/qo5hwevsKc1mV6euELLdDXsNQKnrWmIE
 i8XeTiC32/LVj3eyKxuM7oVUHSp81O51ksSvjxw2wL4S54v18aSIOqsw3Y1Kxt5qNFny
 nE4d7ERDl4NfNIvYv4MqQtAnfCx4IbziHcNfDRH5mZXUuP5He+Ei8n4FhpiMLKN/iV5D
 Z3zA==
X-Gm-Message-State: AOAM530QsGBPKn+HV3jvaxwaRkGBf6F7F+ZlEsP5JXui3luAGMS2O+44
 EcSSWAjcV0vQGOo99zYYTa80AIyXwp7s9CxuSaWO6iu+4eWaWAYasIo7GxqjBex4XTE0y4wU1a6
 18xGSpA4hOYyaQJI=
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr2740590wmd.109.1589952887965; 
 Tue, 19 May 2020 22:34:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+SOI1Gmyov1lTPJzY3jQUMg10BGC+7T14icI66hcTHgN45PaD+092ApR1AQR1o9aTNpPEXQ==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr2740572wmd.109.1589952887716; 
 Tue, 19 May 2020 22:34:47 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w82sm1910070wmg.28.2020.05.19.22.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 22:34:47 -0700 (PDT)
Subject: Re: [PATCH 3/7] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>
References: <20200519200207.17773-1-chen.zhang@intel.com>
 <20200519200207.17773-4-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02f98f09-5e41-601f-4a40-9ce6236994ad@redhat.com>
Date: Wed, 20 May 2020 07:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519200207.17773-4-chen.zhang@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-dev <qemu-devel@nongnu.org>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 10:02 PM, Zhang Chen wrote:
> From: Lukas Straub <lukasstraub2@web.de>
> 
> This will be needed in the next patch.

Can you reword to something clearer, maybe:

"To be able to convert compare_chr_send to a coroutine in the
next commit, use qemu_co_sleep_ns if in coroutine."

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   chardev/char.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 0196e2887b..4c58ea1836 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -38,6 +38,7 @@
>   #include "qemu/module.h"
>   #include "qemu/option.h"
>   #include "qemu/id.h"
> +#include "qemu/coroutine.h"
>   
>   #include "chardev/char-mux.h"
>   
> @@ -119,7 +120,11 @@ static int qemu_chr_write_buffer(Chardev *s,
>       retry:
>           res = cc->chr_write(s, buf + *offset, len - *offset);
>           if (res < 0 && errno == EAGAIN && write_all) {
> -            g_usleep(100);
> +            if (qemu_in_coroutine()) {
> +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
> +            } else {
> +                g_usleep(100);
> +            }
>               goto retry;
>           }
>   
> 


