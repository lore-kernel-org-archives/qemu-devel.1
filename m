Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E346FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4D02068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c43+a1nN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4D02068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1L9-0003IZ-Ez
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1Jj-0002TM-MD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1Jh-0005Jn-Lh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:05:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1Jg-0005FC-EG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575353143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvedzpt4OkIgx2yiLQUlMfryhKEnzzdOmhEosWuDBL0=;
 b=c43+a1nNFnnvJu73mRFRnh0tKF/Brq9vvjIA4fnJAYzd9OUEqQMCgXG1iKybWQji2Cx79V
 bTCbtA6ry7hFJ7jZqkPn1OtpTx729q9BXfpvPBAIZsb1BRGJe1Oaxv8mlYD28fNh/v9zlB
 rxDE6emjpv2619RXSd7+pAEHAnicdeY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-9Hha_srfMvmXNprJRUt5Lg-1; Tue, 03 Dec 2019 01:05:42 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so1194607wrm.16
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uvedzpt4OkIgx2yiLQUlMfryhKEnzzdOmhEosWuDBL0=;
 b=BtPU/9fgYL4DrX68oJVVk8C5pqAMk5F+A0H/oTHb/cvPLfDBVU3JMUuj/EtsqoU5xu
 iyqGwyZ3XSzmfXWApd0YH04nP91oFmt4J5Bak4sPQ10zl8mTovTRpYeL9hnEzFDnvUPH
 0DBpG5500tqP8PZ98fp4m59P3J3peESQqbDTl9JPcwyJHx9sOdM5aIUiWV8w8wNxPMso
 7nnEBkOBTR0nWnj7c8klsY3hcg7Z22hkYPghhNlU6LfMUGKuv8L7upjmMrvNENT0wfMf
 XuU8RvBkjRQlzK03sPsvqs15CJzFsiiAbN935w6IqnUJmndnXP2vvANho+oywlAZfsW0
 gagw==
X-Gm-Message-State: APjAAAVkin1nemNJrlYwk3NmCPjN3BKMEEZiugocwaneF3GN2zgM+RQ7
 +1MxI4XHuvyK/dKdmPNebwV7CQDXNVPQeNxp7PpvXKa3X8zSuKy5oNNxJoJbP9Hihg0xliMdAVl
 WcXvtyo0PzGfWG0s=
X-Received: by 2002:a1c:6707:: with SMTP id b7mr28806152wmc.54.1575353141307; 
 Mon, 02 Dec 2019 22:05:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqynBA4BKlHbizkr07q/TJ9zRcFl9uM4rbB1rmsHfs6GRcs9s8m3GQRpyZYLhRDClmm64FjAhQ==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr28806135wmc.54.1575353141122; 
 Mon, 02 Dec 2019 22:05:41 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id n188sm1991006wme.14.2019.12.02.22.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:05:40 -0800 (PST)
Subject: Re: [PATCH v2 0/4] Expose GT CNTFRQ as a CPU property to support
 AST2600
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20191203041440.6275-1-andrew@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6540201e-b8dc-753b-cdaf-5d7da8716714@redhat.com>
Date: Tue, 3 Dec 2019 07:05:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203041440.6275-1-andrew@aj.id.au>
Content-Language: en-US
X-MC-Unique: 9Hha_srfMvmXNprJRUt5Lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, qemu-devel@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 5:14 AM, Andrew Jeffery wrote:
> Hello,
> 
> This is a v2 of the belated follow-up from a few of my earlier attempts to fix
> up the ARM generic timer for correct behaviour on the ASPEED AST2600 SoC. The
> AST2600 clocks the generic timer at the rate of HPLL, which is configured to
> 1125MHz.  This is significantly quicker than the currently hard-coded generic
> timer rate of 62.5MHz and so we see "sticky" behaviour in the guest.

Glad you fixed this! I hit the same problem with the Raspi4.


