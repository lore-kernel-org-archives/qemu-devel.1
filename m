Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92BFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FA42075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="esQ3nOJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FA42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YoJ-0001W2-1Y
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k8YRR-0000S0-B7
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:28:29 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:46562)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k8YRP-000460-MW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:28:29 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 7CB22405C7;
 Thu, 20 Aug 2020 10:28:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597883306;
 bh=hFxkh0+V3du6LgPZ6ZP8Q4fCgpu8z9lmCzUBvUwYYLI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=esQ3nOJRT87NvklyZxASUmo6LZHg4ddfnjhOEpzGbwUfuC/Kt60ShteLae+cFIN0e
 voSSm9AyWXbBn9RjQvLdjY4EnYv9nGg7SHC+SLbHdqvCS4KsfiBANEX5hWicBqSwR+
 rMB/cShA/eO/U1bnd0ODLkMGvfU0zdPJfzuKK5NE=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 6D7B79F149;
 Thu, 20 Aug 2020 10:28:26 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Aug 2020 10:28:26 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: Re: [PATCH v7 0/1] audio/jack: fix use after free segfault
In-Reply-To: <20200820002729.76290-1-geoff@hostfission.com>
References: <20200820002729.76290-1-geoff@hostfission.com>
Message-ID: <00fa7c0ab750435faa8f49abac85ad17@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:25:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Forgot to update this cover letter too, sorry for the spam, there are no 
changes to spice-input.c anymore

On 2020-08-20 10:27, Geoffrey McRae wrote:
> v7:
>   * removed accidental inclusion of spice-input changes
> 
> Geoffrey McRae (1):
>   audio/jack: fix use after free segfault
> 
>  audio/jackaudio.c | 51 +++++++++++++++++++++++++++++++++--------------
>  ui/spice-input.c  |  2 ++
>  2 files changed, 38 insertions(+), 15 deletions(-)

