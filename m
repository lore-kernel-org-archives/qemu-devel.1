Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BD6C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C212070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9CEi+5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C212070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TMv-0002Zu-6C
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TLD-000111-9M
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TLC-0005Qp-8y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:44:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TLC-0005QK-3P
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:44:22 -0400
Received: by mail-pl1-x641.google.com with SMTP id go14so11121967plb.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/ERrc7ntQcBAEMSy3wpgmt5hIu2OWu9So91yWQUGZfQ=;
 b=F9CEi+5bNFLtKT5j/af9yTk2Kpsa1yxZkXRRprdufdMt7oTCc6Xzm/4vbjoEZGcCr/
 iKZxMoHTJ+DpBmiNONVwO3XECY77LW9UVhSoBFQV8O49tdjj7qZI4javcmiI2+4ClsCS
 jUJblnFe5XsaVjfZdQh1SspU3ulvl8Qwdef5Ki5ad4KQT9aFirHH+GdyxpdkF8OThZnW
 hch+C/ZEfTN8nRrxzrKSdL8rMXuNwf1kIoucjanANqJ4gjH7rbiFRYK5Ohr6tsN9g8Rm
 gewkt6gplNdxxdlvTbaH29T2VW3vRkY2tMp7/xcALndoepUB/cdBQf32RfJt0BzmM2+K
 OFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/ERrc7ntQcBAEMSy3wpgmt5hIu2OWu9So91yWQUGZfQ=;
 b=j1xHzv60iOifyNyOtWKT94AyOIY0hFu6qqGDmIFTLXZ0oJbfn+T7VecNqQd0t6ljPQ
 ElTyzZQuW5LkU1uLVK9Cd4OWyLqMCtBUX78nGYfJoQ6Le9WDax1e9IX0DdRPtdrQQrZa
 m36lEsRlXtWUSiRaPh9PuXifRphavK5UiGkmRy155V8/jC43vSSDB3r8Ldhlrw6etSkE
 NJ97gNcG0l6+pUBeIYOjFakqjaHjXaXtPCU+bpUuZuhj+XpZYr2rJvAGbKrNZayyiOc5
 a20EvZFwm2dyKxS36bftF/pXCF9RQN3AibuALjIZngbUPXpQnAVgGaGjU0CZwXVCgUAk
 g3bw==
X-Gm-Message-State: APjAAAWJzTd1IyPXGliVI5Vx0g+5nRoYu3hXzEBdrsYzgPrRuXphW2sG
 gcAVwBv5f/6Yq4cLqdMgFFdOjnge
X-Google-Smtp-Source: APXvYqwlAQp8ZA/pIvGsv/wj8tUaD5AM3pughIbZZ+FI3BlBY1XghAZCfB5FsvT4qG9c1SiJuC3r7A==
X-Received: by 2002:a17:902:9b86:: with SMTP id
 y6mr22520153plp.217.1566881061002; 
 Mon, 26 Aug 2019 21:44:21 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 143sm13053159pgc.6.2019.08.26.21.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:44:20 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:44:18 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827044418.GR24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-14-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-14-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 13/13] target/openrisc: Update cpu "any" to
 v1.3
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 05:07:45PM -0700, Richard Henderson wrote:
> Now that the two updates from v3.1 are implemented,
> update the "any" cpu to enable it.

It should say 1.3 not 3.1 above.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Other than that.

Reviewed-by: Stafford Horne <shorne@gmail.com>
 

