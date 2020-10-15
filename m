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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C30C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375162072D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6711OUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375162072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT17R-0000MB-R7
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT164-0008CF-Nf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT161-0005GI-Md
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602760017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WxCGUkaUvxz3tEFWXzQIa6mdAQonjiYg2m+ZHYCN8LI=;
 b=V6711OUMAcDRN9ibA9I9+aBHzVGQNsZxdAg9273BnwhlbsdtPL2i9USvExE4K2VFG0Au8v
 48sZDOsDjgkPxiUFmxHp9ts9KDtgDVoEU/TP/7UlATaQsxFQH9RO+BaKm2by2ImxXR52pC
 O8AeMORUoYxbTi5YxPhgJmQjU03A7Xg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-aNIuKSvfNVq4VLo0rbga3A-1; Thu, 15 Oct 2020 07:06:55 -0400
X-MC-Unique: aNIuKSvfNVq4VLo0rbga3A-1
Received: by mail-wr1-f70.google.com with SMTP id j15so1639381wrd.16
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 04:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WxCGUkaUvxz3tEFWXzQIa6mdAQonjiYg2m+ZHYCN8LI=;
 b=HrrWok6kp8xbsMg6/2OR28ftDTlFt/rmbMMdn3Tgfsr1MVKVQSYjSsbJoHBvuYJ/Vr
 CpwldicBb3H0Wp6LHPsMnMbmMY/NUboLMONIFn4XqRNfyBkmv4orAIMEhypco8EF3OQA
 G0wFiTf7iE3gC7vIwVsh2EYmActSydHh+KGKpx+09O8GM7J2I5l4jDJ96swDO5pESbno
 oPMeNYXMPBVd2hmFG7cIGBqXbKjgsmQlSp8HrWX2Pd1vOwh4yGj6dseXJa9lpGGQJwNS
 WeXblsoIrbPiqZZoo1LZtDE40vnU4YYHV4KdWHCvoROfikScbfU86sJ/I/YdxU5B9IDl
 qMnQ==
X-Gm-Message-State: AOAM533u7kNf53iDxw7YnDZ0N5HIqxp7DaKdYkY8mPJ5tHIbSZAyX4e9
 8zmhnhzBc6c8N8xp+Dn+kt5/Tgrd8Yhops/nN07EL0zIFgpkzpupPCRZMTfgE52yNcL40xlYXe/
 icnWdiwiNYNtXtfc=
X-Received: by 2002:a7b:c112:: with SMTP id w18mr3602291wmi.66.1602760014236; 
 Thu, 15 Oct 2020 04:06:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw51lKnIw40/ctieZ1uEWu160zVg1pzgu0T7XmD7UnHLXwlY68AgFo9wnJAQxS8sVJVBSgI/w==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr3602262wmi.66.1602760014027; 
 Thu, 15 Oct 2020 04:06:54 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c130sm3906478wma.17.2020.10.15.04.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 04:06:53 -0700 (PDT)
Subject: Re: [PATCH 02/10] Optimize seq_sorter function for colo-compare
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <20201014072555.12515-3-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dac21b2c-ee3f-fd12-9cec-9f7c03b5e6d8@redhat.com>
Date: Thu, 15 Oct 2020 13:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014072555.12515-3-chen.zhang@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: "Rao, Lei" <lei.rao@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:25 AM, Zhang Chen wrote:
> From: "Rao, Lei" <lei.rao@intel.com>
> 
> The seq of tcp has been filled in fill_pkt_tcp_info, it
> can be used directly here.
> 
> Signed-off-by: leirao <lei.rao@intel.com>

"Signed-off-by: Lei Rao <lei.rao@intel.com>"?

> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo-compare.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 3a45d64175..86980cef5e 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -196,11 +196,7 @@ static void colo_compare_inconsistency_notify(CompareState *s)
>   

Maybe add a comment /* Use restricted to colo_insert_packet() */

Because if someone use it elsewhere it will now be buggy.

>   static gint seq_sorter(Packet *a, Packet *b, gpointer data)
>   {
> -    struct tcp_hdr *atcp, *btcp;
> -
> -    atcp = (struct tcp_hdr *)(a->transport_header);
> -    btcp = (struct tcp_hdr *)(b->transport_header);
> -    return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
> +    return a->tcp_seq - b->tcp_seq;
>   }
>   
>   static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
> 


