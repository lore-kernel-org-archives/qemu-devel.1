Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2AAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D4B208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D4B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kavNm-0001Zp-At
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 01:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kavM9-0000kk-Rr
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:36:17 -0500
Received: from mail.ispras.ru ([83.149.199.84]:54044)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kavM7-0007LZ-EZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:36:17 -0500
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id A9C6740D4004;
 Fri,  6 Nov 2020 06:36:08 +0000 (UTC)
Subject: Re: [PATCH] target/openrisc: fix icount handling for timer
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <160457727672.17573.9713521384015502561.stgit@pasha-ThinkPad-X280>
 <d3185b27-4df1-20b3-605f-cb82e158bb89@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <27a08a38-46c6-20c4-3f45-1fb9f7a1fd78@ispras.ru>
Date: Fri, 6 Nov 2020 09:36:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d3185b27-4df1-20b3-605f-cb82e158bb89@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 01:36:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: shorne@gmail.com, proljc@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.11.2020 00:39, Richard Henderson wrote:
> On 11/5/20 3:54 AM, Pavel Dovgalyuk wrote:
>> This patch adds icount handling to mfspr/mtspr instructions
>> that may deal with hardware timers.
>>
>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
>> ---
>>   target/openrisc/translate.c |   15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
> 
> Looks correct, but it would be better not to duplicate the code from
> trans_l_mtspr, and use an is_jmp code (called DISAS_UPDATE_EXIT in some other
> targets).

mtspr includes the following comment:
* Save all of the cpu state first, allowing it to be overwritten.

Does it mean, that helper can overwrite the PC? Then the PC can't be 
updated in is_jmp handler at the end of instruction translation.


Pavel Dovgalyuk



