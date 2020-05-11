Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85CEC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A56820735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ij1R2jac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A56820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY2dY-0006YZ-Q2
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY2Yu-00025I-9J
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:09:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY2Yt-0000Ed-L5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589180954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJH+0FhgWB31ew/3xujSyw7arTj8XDNkT4Re2ahoBVA=;
 b=ij1R2jacHo7b3U7sIJMpnFU4kcXMyPD8WkRBm2kvhMjVrhW0MB+1PmYrtjGVmjb1ddJpd+
 ySwYcVz9RjBogxO7qjdECS/PRvW3W602DzN0z1D12fnIR9TmQ55qvkyW8nYDkuqCBhxUbl
 zrR5sMSvqq1ws7Zr6ZSAanalIqWk4q0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-j5UEszKXPJ-IiFQCPvCmWQ-1; Mon, 11 May 2020 03:09:10 -0400
X-MC-Unique: j5UEszKXPJ-IiFQCPvCmWQ-1
Received: by mail-wm1-f70.google.com with SMTP id e15so142197wme.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 00:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dJH+0FhgWB31ew/3xujSyw7arTj8XDNkT4Re2ahoBVA=;
 b=ljI5+3tcry17TdNxMg+boV7osttVlsRzXG0YiRUqNJwEJaEQjXKAVcehdZi8T4UGPz
 h9Vc//Rjh3r5DKO+0Pz0snr81HDyxNfa9pOs9Wl6aQpUz3FgbrfHL+r+8xtzNPLiAbkj
 NNVkZL/h3KlpYhWKOHynJpkLG6PVk0/s72cJ+Gkm10PG2i9vREt/4prt+nQ9LLhKjlkB
 h8YjIGgZl7iiox62fP+Qw2qX/I/y1cyEeIr9WLad7Di1X3AvVoQb94HOiOKGnY0PcO3d
 +QAMce0cKeRROtJS7iad5w+SzNZsKvC14VyQs5mGoUWAWZxRwYgdC11K24RzuubLBOmD
 MKdQ==
X-Gm-Message-State: AGi0PuYx9vXziN7HeVUO8tPCl/dlgOoz3t6n/+AL1VnJyvwjD3LQOyRY
 E3SjAC2RkE2J3nq28krx8/YxiU5o8fcgcIm2I3+euAFFuFVf2uGbJ8oFgTYasX8tRjneNSz/anj
 WFBGE3AkYiGajpNQ=
X-Received: by 2002:adf:d841:: with SMTP id k1mr16783191wrl.129.1589180949751; 
 Mon, 11 May 2020 00:09:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4LOL3HZtKmNX3XsZkEEsEbRHYZugqIsAnDUbQ/gnB6eGkctZSq9XqZyoaLqrSq5vwrFYYFg==
X-Received: by 2002:adf:d841:: with SMTP id k1mr16783163wrl.129.1589180949532; 
 Mon, 11 May 2020 00:09:09 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n9sm9225376wru.90.2020.05.11.00.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 00:09:09 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/block/nvme: fixes for interrupt behavior
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200505203603.278339-1-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <635fa8aa-8c8d-98e3-3610-3f3a73a476ef@redhat.com>
Date: Mon, 11 May 2020 09:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505203603.278339-1-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+ Michael & Marcel for MSIX,
and ping to Keith :)

On 5/5/20 10:36 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Klaus Jensen (2):
>    hw/block/nvme: fix pin-based interrupt behavior
>    hw/block/nvme: allow use of any valid msix vector
> 
>   hw/block/nvme.c | 14 +++++++++-----
>   hw/block/nvme.h |  2 +-
>   2 files changed, 10 insertions(+), 6 deletions(-)


