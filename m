Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA87BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B128723128
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGfhtzdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B128723128
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gE9-0003Nr-QZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3gDE-0002Rf-VO
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:45:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51120
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3gDD-0003lr-8K
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596721538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncXzU+YizjMaNV8NQVgWZrei20YIatCWUDyBNki1/ek=;
 b=bGfhtzdiL2sdB8/4V58+EHyQXW1ODGCHuPs7tEydbq4FOepjsCyvD/W7PhswazO07Y9srO
 KgTIHAzhZNX56WBOP3Dl3p87q5666zlWJpqhehJjWzz1vWmtMuSHq9Uu9z69xci/OSXqAA
 a2Wf4Mw5Jt10wl1thSiXLTsBQBnHUEg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-C4xVzqqePQObBqPHiz0hIg-1; Thu, 06 Aug 2020 09:45:36 -0400
X-MC-Unique: C4xVzqqePQObBqPHiz0hIg-1
Received: by mail-wr1-f69.google.com with SMTP id w1so12866875wro.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ncXzU+YizjMaNV8NQVgWZrei20YIatCWUDyBNki1/ek=;
 b=BRSM1XkLsQbpu14SjjcR8xhktsbADHzAWnOqqvZuwhwZLOLd9Dn5fwp2LKkU9NuPgq
 PHtvdTRwLyOFJCIsh8A4AEIaTCIbHGgeAgn5b00lfHNVBvved+SB+j3crHAsM48wMRhk
 9xjj6H/AQif+bK9ouRMS1IAqim6kDKDI6cGF3hbHw+yimXZc4F8awBJZZ17fW19yVEPt
 yByJlSJpU7xO4Iva7CjGBWAOGlBIif71WuushzppgTPmoMh60xbWl7e43pm3MC9DrDes
 ZCPxDWvWN6txy5SCT/wfXuthjrtu0NDifg/CnI4FP6WSb6WY4tCdLCtCAZ1h0ouRki+4
 BPog==
X-Gm-Message-State: AOAM532cEelPd9U5HIbTD0sMQs96AhaJDdAWC31XnLgrCZxUFELXxFk+
 /N/3j1ZI3JmPjSPmlfWRkUwKAI6PoEyrIw8e8QeJmYHgd4jti5VgTOpwzqRANvIZu1QWl5EDA/Q
 dehq/3pKytx7/QRA=
X-Received: by 2002:a5d:4144:: with SMTP id c4mr7500187wrq.200.1596721535439; 
 Thu, 06 Aug 2020 06:45:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFUTwOCVAsxEn6ui0pGjzeiGxkUbnLTIYua55eOcXtjQvPGpYkgmtZAnqw+Wb562ZY/SvYDg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr7500171wrq.200.1596721535173; 
 Thu, 06 Aug 2020 06:45:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id j11sm6554854wrq.69.2020.08.06.06.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 06:45:34 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] async: always set ctx->notified in aio_notify()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200806131802.569478-1-stefanha@redhat.com>
 <20200806131802.569478-3-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e47af10-47fb-0a2f-7aa2-8a426ec86361@redhat.com>
Date: Thu, 6 Aug 2020 15:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806131802.569478-3-stefanha@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/20 15:18, Stefan Hajnoczi wrote:
> +    atomic_set(&ctx->notified, false);
> +
> +    /*
> +     * Write ctx->notified before reading e.g. bh->flags.  Pairs with smp_mb in
> +     * aio_notify.
> +     */
> +    smp_wmb();

Sorry I was not clear: the memory barrier has to be smp_mb(), but the
comment has to say smp_wmb().  No need to repost for this.

Paolo


