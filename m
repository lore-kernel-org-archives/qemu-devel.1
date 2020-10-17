Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D01C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E382073A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E382073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTr1o-0000ax-2Z
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 14:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kTr0T-0008P3-CH; Sat, 17 Oct 2020 14:32:42 -0400
Received: from relay64.bu.edu ([128.197.228.104]:48814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kTr0R-0007rw-HV; Sat, 17 Oct 2020 14:32:40 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 09HIVu6S019041
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 17 Oct 2020 14:32:00 -0400
Date: Sat, 17 Oct 2020 14:31:56 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 0/6] hw/sd/sdcard: Do not attempt to erase out of
 range addresses
Message-ID: <20201017183156.tdfjbqcm4bbrd7dw@mozz.bu.edu>
References: <20201015063824.212980-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201015063824.212980-1-f4bug@amsat.org>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 14:32:35
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201015 0838, Philippe Mathieu-Daudé wrote:
> Yet another bug in the sdcard model found by libfuzzer:
> https://bugs.launchpad.net/bugs/1895310
> 
> Since RFC: Settled migration issue
> 
> Philippe Mathieu-Daudé (6):
>   hw/sd/sdcard: Add trace event for ERASE command (CMD38)
>   hw/sd/sdcard: Introduce the INVALID_ADDRESS definition
>   hw/sd/sdcard: Do not use legal address '0' for INVALID_ADDRESS
>   hw/sd/sdcard: Reset both start/end addresses on error
>   hw/sd/sdcard: Do not attempt to erase out of range addresses
>   hw/sd/sdcard: Assert if accessing an illegal group
> 
>  hw/sd/sd.c         | 30 ++++++++++++++++++++++--------
>  hw/sd/trace-events |  2 +-
>  2 files changed, 23 insertions(+), 9 deletions(-)
> 
> -- 
> 2.26.2
> 

Hi Phil,
For this series:
Tested-by: Alexander Bulekov <alxndr@bu.edu>

Thanks
-Alex

