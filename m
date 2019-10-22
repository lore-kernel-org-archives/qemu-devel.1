Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B44A21872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gIRVcg09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B44A21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsXw-0005uu-8N
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@posteo.de>) id 1iMsWV-0004ul-SD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@posteo.de>) id 1iMsWU-00007k-SL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:40:23 -0400
Received: from mout02.posteo.de ([185.67.36.66]:58221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1iMsWU-00006i-CA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:40:22 -0400
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id BB581240105
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 13:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1571744419; bh=6ojfv+yEG/BdrZ8yoOTxeY78Gw+4P+WVjtpPg0CZzGU=;
 h=Subject:To:Cc:From:Date:From;
 b=gIRVcg09zDjoWk0QtFNTCYF+1rYo3/Xr0vbtxUZTtsYwO8PS5soJbusc0LukgkW5/
 +DvZSB/BQeunV2YNCkh/x2CN9m4eqFaJ58vNaTNx0VXdTfz5khCHgjqekLq3dAi88J
 Kz94P/YwH40qtSBU8uLFul0Tsol4R+5+wGjaF6vBjVPtl3BQEwbmQCG88wYdrATPQu
 KrtGb6A87LwRLHfe7WjPMT9vVi91SmFn9BmL19JO/FTe2EPP7m8zu1J8ofC54l2KcY
 3RnCS8SnqiHIxBQyqVA93eYOcGmbwB8UUKc8sFqAA6MYlSopEinV6e0uwOoULEh68V
 Olj/ChDCd4ecw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 46yBQB5wQlz9rxH;
 Tue, 22 Oct 2019 13:40:18 +0200 (CEST)
Subject: Re: [PATCH v2] hw/m68k/mcf5206.c: Switch to transaction-based ptimer
 API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191021140600.10725-1-peter.maydell@linaro.org>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <374ee14a-e462-d839-3997-45f642e849ca@posteo.de>
Date: Tue, 22 Oct 2019 13:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021140600.10725-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.67.36.66
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2019 16.06, Peter Maydell wrote:
> Switch the mcf5206 code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * turn the early-exit in m5206_timer_recalibrate() into a goto-exit
>    so we can end the ptimer transaction

Reviewed-by: Thomas Huth <thuth@redhat.com>

