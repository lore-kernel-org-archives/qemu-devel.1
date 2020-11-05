Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF7C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BBB20786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7xH5Kvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BBB20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagJN-0000Nw-Qb
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagHQ-0006Z0-G7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:30:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagHJ-0004ay-UZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604586616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9uNvn9JPurozDSpo/DgTN6W3xAKcg1M/80P+IxfXws=;
 b=Z7xH5KvfYs+DpffEkqUJLVo7f98Wh5Bog1ML76I3u5vfPK0EAc4ZZffcCjapqb9WV7bMbp
 aCbkXdXowKfQ9mwPsqm9tcgz6Gd0CEa8D+tLuM8K5Xg6J/2ZlFiQIpOyEdF2kBSCOJ2G7G
 dcOgCtVsJPeVDV3UX2Kfa4/PE4nln5Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-64CYzwHsPNG4jZYG0tDmxQ-1; Thu, 05 Nov 2020 09:30:09 -0500
X-MC-Unique: 64CYzwHsPNG4jZYG0tDmxQ-1
Received: by mail-wm1-f71.google.com with SMTP id h2so696476wmm.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S9uNvn9JPurozDSpo/DgTN6W3xAKcg1M/80P+IxfXws=;
 b=MC2Xe2STqhlZwLB53Ev7/aVwmMU5HszoC452Q+TvhWoMdJ6uZlg1qZfCSDh+lA5l8P
 vuNDYaa4HpZ6bHm2N1E2B5459sd5eqTZgC+Y5zxwlarHSvQI7tGAxt8gpXeKrA6Um2sB
 BITM3jWLRh2Y3W00eQIbKBUUbqf/rejfEfxiRKUJqTh0GHD0/prShVAcz5wezF1PYFMx
 56behC/WSABGxDZdUWC15N88BCPNtRHPPqj76vCj1YYWh65ZR0123HdyUaLYUG7LXkXg
 MhRKeP7w2q8HH4zA3gGCFKwSdBLOwvPlKshDw/jtf/BCnddcICrE/FNt4hM0zkcPWROs
 /pTw==
X-Gm-Message-State: AOAM532weNMtLd7+eH9+FNlbElgVb46kZmeAphLLDgQqSLhANOOkANp2
 af5huiFpoIze6eTj35i5ORuI1vkNeF6RXnyzF29Cc6d4rh53ZRyHxsw9uAlNsdzZQ5xfs4Ln+zY
 8sXtjti7DSdHm/VA=
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr3122522wmb.181.1604586604851; 
 Thu, 05 Nov 2020 06:30:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCJtkU1whfEjSSaMhdeST1GuKNM66Cd0T+xdm0iA8yMnNqrDirKkSSIzrozlLWa/21HXqmjQ==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr3122508wmb.181.1604586604704; 
 Thu, 05 Nov 2020 06:30:04 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z6sm2716840wmi.1.2020.11.05.06.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:30:03 -0800 (PST)
Subject: Re: [PATCH 6/6] xhci: move sanity checks
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20201105134112.25119-1-kraxel@redhat.com>
 <20201105134112.25119-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <77ebf520-e083-e05c-f357-f13ee3d47551@redhat.com>
Date: Thu, 5 Nov 2020 15:30:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105134112.25119-7-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 2:41 PM, Gerd Hoffmann wrote:
> The v variable goes negative for reg < 0x20.  Reorder the code
> to first sanity check then calculate v and assign intr to make
> sanity checkers happy.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1902112
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


