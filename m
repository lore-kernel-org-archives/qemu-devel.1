Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC91C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB062076D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR82TBZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB062076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1I8-0006br-CM
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT1Ak-0001w4-RB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT1Aj-0006Aw-3Q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602760306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDmWnrlKKHfBZ6olpkMo2Yl2ziMS5ygf4QWhtHU2UlU=;
 b=GR82TBZ7/ujQp5VKe4RNzfL0Lj0far8mi0JC3oo8txiZ0LN5OKJLQUzlpXurSDWluMSd7c
 T6NQtsqLFQGUt3EIENmdn8LKt+e7knK1ftVdCpAoYvgrgsWGsqz5z/jyjRmkbedO2/Yc1Q
 cF06Wer7YohBBc1T8iMu5T0C/bUgyB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-O5jfwUyoPL6txjX5PiJvEg-1; Thu, 15 Oct 2020 07:11:45 -0400
X-MC-Unique: O5jfwUyoPL6txjX5PiJvEg-1
Received: by mail-wm1-f70.google.com with SMTP id f26so1044544wml.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 04:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GDmWnrlKKHfBZ6olpkMo2Yl2ziMS5ygf4QWhtHU2UlU=;
 b=ULGTGxFMQwT4CvHHUvh2WlVl8Rc/AF8flRxwXwbPsWOAPOTUZRe/TAQtSBDjV6LTf8
 mWQ65M4U8FVAzYDvxK9+1MQI2gDNQH57UNCRM+IkQIlxXsAAsnzN6EzAhVM8xfTfruRO
 eylUYd/yzg7713lMMaVto9RZ/BPHh41aZ76t2Kj/fnT1BoOBkWZe6H2gW23gHM+mRTfF
 6KDe6JvF+n0aUykQxbF5ejt6y3/sWO+Hs/da911DBsCuDW4cwDlIOVwmx7hDZ1UiEd7b
 WYTHkScRaIx6nJlhKRN36C6f891GWNo//+2cFQHmR4mFbdwCetxU4/ywqZqCkjCYxszx
 emSg==
X-Gm-Message-State: AOAM532mB/Z4ttvuDFajA+TKSwvck3Myfcv01BksfQRote4ObWePJ7OB
 iOrOgKNofkpLdyF9nBaJoqgtQ1QWJ2EafSV2GhDIJ0XQv20z6ZKtPKtIFIf5faK3g/DjAk2SXAV
 xAyYu1YmSxH0uIKQ=
X-Received: by 2002:a05:6000:1110:: with SMTP id
 z16mr3986022wrw.71.1602760304083; 
 Thu, 15 Oct 2020 04:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJV2OYzlRbjH78GFwZIVgJCqpblYJqHkUJ6JNGcfjXf52LIT/jMwpn/koPERgk+eiMTVSebQ==
X-Received: by 2002:a05:6000:1110:: with SMTP id
 z16mr3985999wrw.71.1602760303886; 
 Thu, 15 Oct 2020 04:11:43 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x65sm4174070wmg.1.2020.10.15.04.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 04:11:43 -0700 (PDT)
Subject: Re: [PATCH 07/10] net/colo-compare.c: Fix compare_timeout format issue
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <20201014072555.12515-8-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <938e4d0b-7820-cecc-d4d2-cce591dd4810@redhat.com>
Date: Thu, 15 Oct 2020 13:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014072555.12515-8-chen.zhang@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:25 AM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> This parameter need compare with the return of qemu_clock_get_ms(),
> it is uinit64_t. So we need fix this issue here.

Typo "uint64_t"

Please add:

Fixes: 9cc43c94b31 ("net/colo-compare.c: Expose "compare_timeout" to users")
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Reported-by: Derek Su <dereksu@qnap.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 24c366eec0..f4814c5f09 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -120,7 +120,7 @@ struct CompareState {
>       SendCo out_sendco;
>       SendCo notify_sendco;
>       bool vnet_hdr;
> -    uint32_t compare_timeout;
> +    uint64_t compare_timeout;
>       uint32_t expired_scan_cycle;
>   
>       /*
> @@ -1075,9 +1075,9 @@ static void compare_get_timeout(Object *obj, Visitor *v,
>                                   Error **errp)
>   {
>       CompareState *s = COLO_COMPARE(obj);
> -    uint32_t value = s->compare_timeout;
> +    uint64_t value = s->compare_timeout;
>   
> -    visit_type_uint32(v, name, &value, errp);
> +    visit_type_uint64(v, name, &value, errp);
>   }
>   
>   static void compare_set_timeout(Object *obj, Visitor *v,
> @@ -1140,9 +1140,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
>                                  Error **errp)
>   {
>       Error *local_err = NULL;
> -    uint32_t value;
> +    uint64_t value;
>   
> -    visit_type_uint32(v, name, &value, &local_err);
> +    visit_type_uint64(v, name, &value, &local_err);
>       if (local_err) {
>           goto out;
>       }
> @@ -1390,7 +1390,7 @@ static void colo_compare_init(Object *obj)
>       object_property_add_str(obj, "notify_dev",
>                               compare_get_notify_dev, compare_set_notify_dev);
>   
> -    object_property_add(obj, "compare_timeout", "uint32",
> +    object_property_add(obj, "compare_timeout", "uint64",
>                           compare_get_timeout,
>                           compare_set_timeout, NULL, NULL);
>   
> 


