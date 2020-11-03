Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DB2C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537BA2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSwxztDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537BA2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZm60-0002mb-AX
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlxh-0004qq-Cp
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlxf-0005LP-N5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604370134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWiw7zaw2eb0SGYngU9UL3pFUdknkWkNFfZqseY3VAA=;
 b=RSwxztDNojzubskDYsk2PGXRZwjADZUx4L4xwWBbn3f/5at5On114CCM4MSxJtaIw0j0Mo
 2LGNOswsRh+1wsovUd3TQgHRAkCYad2rex7GQaZtOtyHoT2KHhmFLOKKas2hWBCPPOM7LG
 vbfWLTgrZiw5BtEvAEdo405B3mMJLsY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-vrhsfugyMQyl-UjOc_k3xA-1; Mon, 02 Nov 2020 21:22:12 -0500
X-MC-Unique: vrhsfugyMQyl-UjOc_k3xA-1
Received: by mail-wm1-f71.google.com with SMTP id z62so4826960wmb.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SWiw7zaw2eb0SGYngU9UL3pFUdknkWkNFfZqseY3VAA=;
 b=ZO95jT/OyycMaRQHK/2PEwS8tyTaLi+T4vMJolteEcCaBrsZiZ4iiWUvpSsWwrgIK3
 fhsjpYi0rUhFZCAxUV2X/esEu6/gHuc0FthpSMP1q7YSknQuNIO258f57bPyd6ysBSp6
 Pt5cYEj3VZBwjHyR8Q17XkIlF+oRDTzZCzBLc1QnoL0nMZrZ8DYIGgr4v8GGf/xz0EHo
 MTLF7jRbnnxaW6byz4J51MrluGl+0sKh/l056h5L8Tfn1XeZcE55aUG0iBG0VlfUdRYl
 ftS2/2peC2BRGCwG9Yy2kaceH41p818HQSuILytKQrlztx7isHQ59jH8JgQgfIZ2+zMO
 rp+Q==
X-Gm-Message-State: AOAM531o0OYzt6X1jzyDaMCqVhwJxTia4xjH6OmerGSUsVj79b10myt6
 Eoq3HCX4iMw+ntZjZA3I2TItbJI6ChRAxQSl0sfW1ivMUKRZwrCj+2bcqSaW/Dw/2nKOhz+SB8k
 gixUekrCxQMQUgi8=
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr17683773wrn.248.1604370131514; 
 Mon, 02 Nov 2020 18:22:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8nNIS66EHHhMzL0zz/1hBcWF+KW/wzA6xHjs1l9F+6WbagkdH0r7nPhO8grMZA0ZqZPePfQ==
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr17683755wrn.248.1604370131291; 
 Mon, 02 Nov 2020 18:22:11 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o3sm23512461wru.15.2020.11.02.18.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 18:22:10 -0800 (PST)
Subject: Re: [PATCH 6/6] migration: fix uninitialized variable warning in
 migrate_send_rp_req_pages()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-7-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e259270f-14c6-7033-faad-6406e5de930c@redhat.com>
Date: Tue, 3 Nov 2020 03:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103015228.2250547-7-kuhn.chenqun@huawei.com>
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
Cc: ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>,
 zhang.zhanghailiang@huawei.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 2:52 AM, Chen Qun wrote:
> After the WITH_QEMU_LOCK_GUARD macro is added, the compiler cannot identify
>  that the statements in the macro must be executed. As a result, some variables
>  assignment statements in the macro may be considered as unexecuted by the compiler.
> 
> The compiler showed warning:
> migration/migration.c: In function ‘migrate_send_rp_req_pages’:
> migration/migration.c:384:8: warning: ‘received’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  384 |     if (received) {
>      |        ^
> 
> Add a default value for 'received' to prevented the warning.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9bb4fee5ac..de90486a61 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -361,7 +361,7 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
>                                RAMBlock *rb, ram_addr_t start, uint64_t haddr)
>  {
>      void *aligned = (void *)(uintptr_t)(haddr & (-qemu_ram_pagesize(rb)));
> -    bool received;
> +    bool received = false;
>  
>      WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
>          received = ramblock_recv_bitmap_test_byte_offset(rb, start);
> 

Since this helps static analyzer:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


