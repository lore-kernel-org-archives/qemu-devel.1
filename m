Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBFDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2AB206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW6+wW3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2AB206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHf6-0007T8-LK
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 01:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbHeD-0006FR-Hn
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:52:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbHeB-0007qo-Gl
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589953926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stVJCL2v9dEuUavWEFv857UyjH8yD/Z8mGawkl1/4uc=;
 b=bW6+wW3VLJKRWpxiv99coOT5rs4h5C0D9b/U8EUHUA2lpPQeVQGB8VOyTjdIQnxRPbM2G7
 H2MHFF6XZ3XVRRByDYrTGHYkxHEfTtgXEDsjT8OzagrrTWv4n5TJWXUVTM+jSXO18KrTSE
 Yfm6ftkI4DaxXJQ8o186bbBOrwLJbog=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-UJKkW2NVPiOVA9gZ2oiKgA-1; Wed, 20 May 2020 01:52:04 -0400
X-MC-Unique: UJKkW2NVPiOVA9gZ2oiKgA-1
Received: by mail-wr1-f70.google.com with SMTP id p13so925483wrt.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=stVJCL2v9dEuUavWEFv857UyjH8yD/Z8mGawkl1/4uc=;
 b=haJqVdZaEqAHiY7Xe2u8n/W0p8UFkPwB9OMSGPpMPUWMNcHwGpGSd1WzlZqmOsN7VJ
 UEjEiFUzhMxzetpWnCsqLIZkyZ9L40A/XDYY1f0vgCXQWRmImTDUa7wgb6lA2F3ANV46
 39BzXf/q26QoPXsR0z16E+CmiP9K0w4xeXeZgwJHxhMEQ0NOCpC3i9t+Fh5ccBtZiiVh
 S1bVsuc29at0yhXBj8BT9xOZOurwX0ME3kPRJApFSm7yQA0geYHP4HgEZPgZw/MZyTY+
 rmECeDcna6zHrBENdP3Gdg8PPqkPKIYmRaBwD7RL5jGVzuCIJ8jQ32pxFtlq3hNxcBRg
 d1LQ==
X-Gm-Message-State: AOAM533kOlBWENDTgQ6DjorbAhB1cX+X0kUMXcHLfUBcqvriOsGatlOv
 QbP8YZ4U9NziYFZrLq+OQvw3ZRmS0AxiIf6FiPakK8OQnvRL9rRq7pyEm85i0jAfutl3Gjbazh4
 zvf547d8bh+WRY6g=
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr3060524wmt.28.1589953923562; 
 Tue, 19 May 2020 22:52:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVDt+mNUzNQBAoU9/olR3xsdIKq/6UQAhgZcCCugOMsr4I/FTJb0I56xqAjk0CDtgJbsRVtg==
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr3060508wmt.28.1589953923341; 
 Tue, 19 May 2020 22:52:03 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s67sm2012308wmf.3.2020.05.19.22.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 22:52:02 -0700 (PDT)
Subject: Re: [PATCH 1/7] colo-compare: Fix memory leak in packet_enqueue()
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>
References: <20200519200207.17773-1-chen.zhang@intel.com>
 <20200519200207.17773-2-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <437267be-2ddc-afaa-c563-b392f7dd254f@redhat.com>
Date: Wed, 20 May 2020 07:52:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519200207.17773-2-chen.zhang@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Derek Su <dereksu@qnap.com>, qemu-dev <qemu-devel@nongnu.org>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 10:02 PM, Zhang Chen wrote:
> From: Derek Su <dereksu@qnap.com>
> 
> The patch is to fix the "pkt" memory leak in packet_enqueue().
> The allocated "pkt" needs to be freed if the colo compare
> primary or secondary queue is too big.
> 
> Replace the error_report of full queue with a trace event.
> 
> Signed-off-by: Derek Su <dereksu@qnap.com>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo-compare.c | 23 +++++++++++++++--------
>   net/trace-events   |  1 +
>   2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index c07e7c1c09..56d8976537 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -122,6 +122,10 @@ enum {
>       SECONDARY_IN,
>   };
>   
> +static const char *colo_mode[] = {
> +    [PRIMARY_IN] = "primary",
> +    [SECONDARY_IN] = "secondary",
> +};
>   
>   static int compare_chr_send(CompareState *s,
>                               const uint8_t *buf,
> @@ -217,6 +221,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
>       ConnectionKey key;
>       Packet *pkt = NULL;
>       Connection *conn;
> +    int ret;
>   
>       if (mode == PRIMARY_IN) {
>           pkt = packet_new(s->pri_rs.buf,
> @@ -245,16 +250,18 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
>       }
>   
>       if (mode == PRIMARY_IN) {
> -        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
> -            error_report("colo compare primary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret = colo_insert_packet(&conn->primary_list, pkt, &conn->pack);
>       } else {
> -        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)) {
> -            error_report("colo compare secondary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret = colo_insert_packet(&conn->secondary_list, pkt, &conn->sack);
>       }
> +
> +    if (!ret) {
> +        trace_colo_compare_drop_packet(colo_mode[mode],
> +            "queue size too big, drop packet");
> +        packet_destroy(pkt, NULL);
> +        pkt = NULL;
> +    }
> +
>       *con = conn;
>   
>       return 0;
> diff --git a/net/trace-events b/net/trace-events
> index 02c13fd0ba..fa49c71533 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -12,6 +12,7 @@ colo_proxy_main(const char *chr) ": %s"
>   
>   # colo-compare.c
>   colo_compare_main(const char *chr) ": %s"
> +colo_compare_drop_packet(const char *queue, const char *chr) ": %s: %s"
>   colo_compare_udp_miscompare(const char *sta, int size) ": %s = %d"
>   colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
>   colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


