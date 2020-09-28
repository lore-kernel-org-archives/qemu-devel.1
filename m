Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9776C208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8uO5F0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9776C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxMq-0008C2-Ki
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kMx2Q-0001bi-UC
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kMx2O-0000DR-R2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:34:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601314448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSMUSkgMhivYKnCvp9TJyLhNx1idYXalGpSr4VhUOkU=;
 b=G8uO5F0NbEk/69ln1hKXjuWAjBRcTQGPicCgiXpb/D9amUzdVpbmRDwixMo8gEQ6jaCGyZ
 L/wcZs8fhY1EI9L+WcMf+XYmF0/hm9LwhZp3C7BGU7lYvdnNXbgc60zRmkP1cxgdcFMw7V
 bgi15HcPq+VpBkM1u4uFUgKYU+MokdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-gx3Z18cePXuzUw_wkZkzdA-1; Mon, 28 Sep 2020 13:32:59 -0400
X-MC-Unique: gx3Z18cePXuzUw_wkZkzdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5814D1074643;
 Mon, 28 Sep 2020 17:32:58 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44C341A8EC;
 Mon, 28 Sep 2020 17:32:56 +0000 (UTC)
Subject: Re: [PATCH v2 6/8] qemu/bswap: Use compiler __builtin_bswap() on
 FreeBSD
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-7-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8d50a945-a6f6-b1f4-392a-867360c50882@redhat.com>
Date: Mon, 28 Sep 2020 19:32:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200928131934.739451-7-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/2020 15.19, Philippe Mathieu-Daudé wrote:
> Since commit efc6c070aca ("configure: Add a test for the minimum
> compiler version") the minimum compiler version required for GCC
> is 4.8, which supports __builtin_bswap().
> Remove the FreeBSD specific ifdef'ry.
> 
> This reverts commit de03c3164accc21311c39327601fcdd95da301f3
> ("bswap: Fix build on FreeBSD 10.0").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Ed Maste <emaste@freebsd.org>
> ---
>  include/qemu/bswap.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 719d620bfe6..1a297bfec22 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -6,8 +6,6 @@
>  #ifdef CONFIG_MACHINE_BSWAP_H
>  # include <sys/endian.h>
>  # include <machine/bswap.h>
> -#elif defined(__FreeBSD__)
> -# include <sys/endian.h>

Ah, well, no I get it ... you're removing this stuff bit by bit. Quite
confusing, IMHO, I'd remove them all in one patch instead.

 Thomas


