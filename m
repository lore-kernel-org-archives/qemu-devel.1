Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1C7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0B82076D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgyLSzUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0B82076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1GE-0004gv-S6
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT18f-0001CC-SQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT18b-0005Ye-KF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602760175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWdD/fy1kJlA/xHpjqMh0Qz8/90w6OVAkY6x3PSbdGA=;
 b=YgyLSzUTx6spijLUo4cX+GQJ2TKrhLOF0P+Apwdu9+JDCbjtvbh6EjAx9OIz7zXNovrltq
 isCCCzmChM58xdz8YXDQyqIt1zWbDLI/Dl7D3RffaFPCZK2Xo1MHyGWhrVB/KYLcvpotid
 YF8nau+5L/6Vn5GHyQJN383pEAQc8W8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-yZpUNMpaOmywoELKvbwIgg-1; Thu, 15 Oct 2020 07:09:31 -0400
X-MC-Unique: yZpUNMpaOmywoELKvbwIgg-1
Received: by mail-wm1-f72.google.com with SMTP id p17so1572699wmi.7
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 04:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kWdD/fy1kJlA/xHpjqMh0Qz8/90w6OVAkY6x3PSbdGA=;
 b=JoVDinQW7y27meFzY1jYv4S/OAQSNxz7Kjwyjtavgpy4X3q7U9JarcoXPWturwlUkk
 qqa+Qdn6E6GfSUoHF30HAA/0HK9vKjl/MlgtBDZh7QNLrJBJrVKRD+mj4LXX48QQfNO0
 kZvHSHyXmYHphRP7pmn7lvyeBdyTzvfMg7ORKJ9IhiAT3WrSr1iPZrVIrnLedxbRU0Ed
 25hSzjcE1FjsWNhaFrICO4vVy1U5p8ZXhawmBdxjwcKoPnyPZLWHhQ8z8TVHcfqboUK1
 Tl8LpV/WSChCSM+WXCFJMax49u6tQyKq/ByPo7NLfdCvtW1TXMkT0Ry6RBZTtzPNxbBA
 X80g==
X-Gm-Message-State: AOAM532J/uhlvwZgH7GvywgXRyIPJl8Ag+/1WRcKMnyL8E2o61HkPWrN
 gf28TjFaMz1CLiO0SQ6V2+TwYDB6A2EshAzEC4xBcTg7hmvLI4tFwATKkuD+C9RMJysnfkYuJKu
 e7fyd92rw+Um3WF0=
X-Received: by 2002:a05:6000:10c6:: with SMTP id
 b6mr3837012wrx.10.1602760170439; 
 Thu, 15 Oct 2020 04:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxz4HkHLD5/EJIJ02Rg8KZA8QjhWpGkRnP8HOJjyE8nnbmf+qDeNRxqX9lrS/63fi9vDDAcA==
X-Received: by 2002:a05:6000:10c6:: with SMTP id
 b6mr3836984wrx.10.1602760170145; 
 Thu, 15 Oct 2020 04:09:30 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t5sm4377253wrb.21.2020.10.15.04.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 04:09:29 -0700 (PDT)
Subject: Re: [PATCH 05/10] colo-compare: fix missing compare_seq initialization
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <20201014072555.12515-6-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1591a864-b038-6366-b5db-cef9fce36d34@redhat.com>
Date: Thu, 15 Oct 2020 13:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014072555.12515-6-chen.zhang@intel.com>
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
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:25 AM, Zhang Chen wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> 

Please include:

Fixes: f449c9e549c ("colo: compare the packet based on the tcp sequence 
number")
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/colo.c b/net/colo.c
> index a6c66d829a..ef00609848 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -133,14 +133,11 @@ void reverse_connection_key(ConnectionKey *key)
>   
>   Connection *connection_new(ConnectionKey *key)
>   {
> -    Connection *conn = g_slice_new(Connection);
> +    Connection *conn = g_slice_new0(Connection);
>   
>       conn->ip_proto = key->ip_proto;
>       conn->processing = false;
> -    conn->offset = 0;
>       conn->tcp_state = TCPS_CLOSED;
> -    conn->pack = 0;
> -    conn->sack = 0;
>       g_queue_init(&conn->primary_list);
>       g_queue_init(&conn->secondary_list);
>   
> 


