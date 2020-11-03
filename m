Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49103C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81C52067C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUrWNghp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81C52067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZm2t-0000DS-Sj
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZluP-0001am-NW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:18:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZltt-0004of-7O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESQS/9ZpN8f5wR/Ua+oxoReioLgsWM4Nnz/LVkHEDRc=;
 b=BUrWNghpzcyB5TdlsDcL83BK9QPEn8wK7bIEVPKXALDD/SJmdft3ITaP9FaX2+YmOFWZN/
 Qn/U2QXVASWakoAsCrWLIfmQ1OsFhn9QqfmOOz18jlcQw+uXMyye73IuuDSidTNzklebwI
 XzHhzPorlWDh+DsorDb7lu212EWHhBA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-59xl_8iFMZy809v1Vu3FEw-1; Mon, 02 Nov 2020 21:18:16 -0500
X-MC-Unique: 59xl_8iFMZy809v1Vu3FEw-1
Received: by mail-wr1-f69.google.com with SMTP id b6so7158017wrn.17
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ESQS/9ZpN8f5wR/Ua+oxoReioLgsWM4Nnz/LVkHEDRc=;
 b=oDYosUU1ypAqzo2ZFjNQUHF48YC4Ec3L42QfBnWa6OQEB8cDkamG/1hyAHNSVqPzg5
 xYbEQHjVWJoHQXVoTBoOth6NoXPTh3bElKc6z6gJ3+O3bKkFlRrAkDJq1nlo0aPMGa50
 6up2VIUzKEbEMRl8g4u5A+xDrUm991iVA8YhLeosghSMcdt9QdwONwxfqeR0YfU7Fn8F
 YsvAxInhbTE2bDjyacdsky2j0Uo3WbrI9PGi+ZELEeUiy6JzxvRmP23WuB3g59+1DF6f
 b/qLU3HL1i2oyk/ROef9qoDnmjcNUfN1zWP4o12Wz3tI0ZG1FpUPxghxGIkaIqc1Miw0
 e9Uw==
X-Gm-Message-State: AOAM5326Z0ojlmHknVz4uA2Ef/ox6VvJjtTi2jL3UzVfj3G+7S1PStsl
 rALfwJuJ8+bQxOAX4zL0oYNoqp7XnLK0FasXrB4nTSXgyneGR0Iz0quNCP1cV18ZlAxxReq/3hz
 rIQQPs9nT4daou5M=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr984867wms.77.1604369895701; 
 Mon, 02 Nov 2020 18:18:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhFPuiT+gVFPGa9j4dfWHFSgwNyIcohjaiyosSRuwjfQIy8LUY3Of1VcNoTrNXDTCIIiY/Pw==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr984855wms.77.1604369895545; 
 Mon, 02 Nov 2020 18:18:15 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t1sm23552014wrs.48.2020.11.02.18.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 18:18:14 -0800 (PST)
Subject: Re: [PATCH 5/6] plugins/loader: fix uninitialized variable warning in
 plugin_reset_uninstall()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-6-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b069ab47-8f3d-b4e9-77f6-567b1dcbd296@redhat.com>
Date: Tue, 3 Nov 2020 03:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103015228.2250547-6-kuhn.chenqun@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:36
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 2:52 AM, Chen Qun wrote:
> After the WITH_QEMU_LOCK_GUARD macro is added, the compiler cannot identify
>  that the statements in the macro must be executed. As a result, some variables
>  assignment statements in the macro may be considered as unexecuted by the compiler.
> 
> The compiler showed warning:
> plugins/loader.c: In function ‘plugin_reset_uninstall’:
> plugins/loader.c:382:15: warning: ‘ctx’ may be used uninitialized in this function [-Wmaybe-uninitialized]

This shouldn't happen as the function returns before
(else there is a NULL deref).

>  382 |     data->ctx = ctx;
>      |     ~~~~~~~~~~^~~~~
> 
> Add a default value for 'expire_time' to prevented the warning.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> ---
>  plugins/loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/loader.c b/plugins/loader.c
> index 8ac5dbc20f..88593fe138 100644
> --- a/plugins/loader.c
> +++ b/plugins/loader.c
> @@ -367,7 +367,7 @@ void plugin_reset_uninstall(qemu_plugin_id_t id,
>                              bool reset)
>  {
>      struct qemu_plugin_reset_data *data;
> -    struct qemu_plugin_ctx *ctx;
> +    struct qemu_plugin_ctx *ctx = NULL;
>  
>      WITH_QEMU_LOCK_GUARD(&plugin.lock) {
>          ctx = plugin_id_to_ctx_locked(id);
> 


