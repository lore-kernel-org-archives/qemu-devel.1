Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B9C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E067207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5sqC7HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E067207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoZM-0002hl-Ho
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCni7-0002gf-IF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCni6-0006wz-Jp
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCni6-0006wU-Cr
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:42 -0400
Received: by mail-pf1-x443.google.com with SMTP id 205so1694632pfw.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aTtS8qV3trO8mRsFgFOU8pjFuPXPct5Lf5U7HXg9JUw=;
 b=O5sqC7HR6qWUWjDZm4SPh+Cu5tI4JzsilgxFSkJynPQ9DNhAmtzLQeWvMTHPOpG2te
 2OPZ6lPNfZYrudeqzIHrN65rqyJbtGw3VlXclbPb+9TxSS42Og6F9R9Ip4GK0RRLLobr
 6UuInSTvjPz+bFtGkXqciyyi+/VRa2g/ftM2g2uwVFEcKdrOFZGiyzYLJkKHHAqIoIhq
 eclkxPZstluYEdmIr8PLX/Bbe9wlpApxmeOYV/F6BRenALFPIbCoSyejegZMl0zSwZ9s
 TE3NucEMGWDM9T3Gs2nV6xobuAC0Sr2wspsGwTcPuoAF4HOhJk2Cwn66m3iN3mf2tLyH
 lnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aTtS8qV3trO8mRsFgFOU8pjFuPXPct5Lf5U7HXg9JUw=;
 b=HDGvYkIv+TWkGHK2hXJWJUIZQhEB0zgQyzCzRoE/CU4qMRqz7SW7kNuCue2Xs8tcmy
 hm8pEKzRW69km8lYruH9DPbsh7hz61cYAVp9zEz6QvR5nbbqSt0WIVFvNu3SGbbDzz0l
 RFsmd609SRpez8OORABOvlD8bSFLScflU5C/9CQQrKqeDMh/5U93Pt9Xt9Dm6DPl8qGX
 3zJweL5w8yChnsoOiZJzq0eGBMQMroGyLeFQJQG5cLfPgBFZJV8w9Ya7qyGWwIkxcifN
 1v5sikxbyjNwqlnu3m93JsfOEQynYxRi+gXGkJr83uQFUQDiomq0Jptn+RWW+xzf3BCK
 lxYg==
X-Gm-Message-State: APjAAAUfu4Xp6WxEg6Lbqp8rJIXYqLC753qX60TODt9RNkxrl6CC8eMe
 0oX960m/wUf6GVNGklMEnMp3UQ==
X-Google-Smtp-Source: APXvYqw7Kgq4AFTAQF9LSaE4u7sCtdKbxOJREih4K8VGHxXvB5mNVUB2HKxeJthmVpTA8sO78yAl0A==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr4194696pfl.79.1569342641546; 
 Tue, 24 Sep 2019 09:30:41 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id p88sm493715pjp.22.2019.09.24.09.30.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 09:30:40 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 3/4] migration: ram: Switch to ram block
 writeback
To: Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-4-beata.michalska@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <999eee11-71f3-bd5d-e9fa-85d1fc7179da@linaro.org>
Date: Tue, 24 Sep 2019 09:30:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910095610.4546-4-beata.michalska@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 2:56 AM, Beata Michalska wrote:
> Switch to ram block writeback for pmem migration.
> 
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  migration/ram.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

