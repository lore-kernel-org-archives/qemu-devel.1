Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAAD212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc3KF5cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAAD212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT0xU-0004eb-AU
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 06:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT0wl-000476-SZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT0wk-0003xD-7D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602759441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQhMBWckJ1wDypTpkcDXY1fnxGItvH3KMoQpV05XNz4=;
 b=Sc3KF5cQKrOWTE09YOI59M7PDrsOj+ErO+aESRw+UKgR0jRdrxZzeuLC7m4OKjbgUgZhlu
 teUNgTpVWQnUNc6tSoRDGHCPWxfmeXBYD4bVkBVFplrQAsFKVKiQNnJwes1avwft0HQZXX
 WmAHpFLLhs4wWxxuW/ZPEGQZGSE4v8o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-wtDeNO89PO-91QcpWEEt5Q-1; Thu, 15 Oct 2020 06:57:17 -0400
X-MC-Unique: wtDeNO89PO-91QcpWEEt5Q-1
Received: by mail-wr1-f69.google.com with SMTP id b11so1646135wrm.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 03:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PQhMBWckJ1wDypTpkcDXY1fnxGItvH3KMoQpV05XNz4=;
 b=qh0oH5UjBMH241PZX8waFLB7LfCJRcaimT6bLI95YlnfHQ3H207/xgwZvy0ekn5FME
 4QGiqU+Q6NPE6izqIu/PWef4N6DeIFfp3YqU0AvWMQTzxn5zLme3vNVt0YugucznCuiq
 5XUL7e/NcbXJG2JHe5ZQ07flOzSBK1Hfebn0ILgaGxG7YNLxIqgQvICo4qYfyYDMXTsY
 cPy7ut++f8/3peFnGxNNUenHjE5DBxu9PrNjhDZL03dU+pbFLU/GAGfs82PzwVklECKK
 DRtk6EUdO1nkESotN1bosT05/gec4gQsxE9Qt1rOkJtOydBfSW5+ImI8o2SJB16Ztn1K
 6KZg==
X-Gm-Message-State: AOAM532P14rE1hvOpzycUe4+QeyLLth3KI14Mt+7NZ54bVyxP76lDAiH
 hP4PkT859DMpAvi5IgOyWW4m/17EqvlhBUwiNUHKsvaX7EK42uC0dg2TWxziX+DPNyR9GxRf8Xo
 58FQiHfBB98JMgBU=
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr3290733wmj.7.1602759436078; 
 Thu, 15 Oct 2020 03:57:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3kWVUYeOdTbDYt6hIScfLFH21HLCHacRQux2A3ElUW0PyLbcF8LZdbOjBGWaQOYJTW7RwBg==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr3290711wmj.7.1602759435733; 
 Thu, 15 Oct 2020 03:57:15 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l26sm3887599wmi.41.2020.10.15.03.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 03:57:14 -0700 (PDT)
Subject: Re: [PATCH 10/15] block/nvme: Use definitions instead of magic values
 in add_io_queue()
To: qemu-devel@nongnu.org
References: <20201014155810.102841-1-philmd@redhat.com>
 <20201014155810.102841-11-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6a8250ff-9b98-89a4-7bfa-5bc145328ca6@redhat.com>
Date: Thu, 15 Oct 2020 12:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014155810.102841-11-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 5:58 PM, Philippe Mathieu-Daudé wrote:
> Replace magic values by definitions, and simplifiy since the
> number of queues will never reach 64K.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   block/nvme.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index b841c5950c5..11fba2d754d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -652,6 +652,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs,
>       NvmeCmd cmd;
>       unsigned queue_size = NVME_QUEUE_SIZE;
>   
> +    assert(n <= UINT16_MAX);
>       q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
>       if (!q) {
>           return false;
> @@ -659,8 +660,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs,
>       cmd = (NvmeCmd) {
>           .opcode = NVME_ADM_CMD_CREATE_CQ,
>           .dptr.prp1 = cpu_to_le64(q->cq.iova),
> -        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
> -        .cdw11 = cpu_to_le32(0x3),
> +        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),

We can use NVME_NUM_REQS here and drop the queue_size variable.

> +        .cdw11 = cpu_to_le32(NVME_CQ_IEN | NVME_CQ_PC),
>       };
>       if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>           error_setg(errp, "Failed to create CQ io queue [%u]", n);
> @@ -669,8 +670,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs,
>       cmd = (NvmeCmd) {
>           .opcode = NVME_ADM_CMD_CREATE_SQ,
>           .dptr.prp1 = cpu_to_le64(q->sq.iova),
> -        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
> -        .cdw11 = cpu_to_le32(0x1 | (n << 16)),
> +        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
> +        .cdw11 = cpu_to_le32(NVME_SQ_PC | (n << 16)),
>       };
>       if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>           error_setg(errp, "Failed to create SQ io queue [%u]", n);
> 


