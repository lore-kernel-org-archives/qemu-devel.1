Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE16C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F88A2065C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F88A2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhpQ-0002Ls-Ts
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jfhnZ-0007x3-Jh
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:36:05 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33188)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jfhnY-0003QA-Oh
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:36:05 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0D1ABCD461;
 Mon,  1 Jun 2020 13:36:02 +0300 (MSK)
Subject: Re: [PATCH] replay: fix replay shutdown for console mode
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159012995470.27967.18129611453659045726.stgit@pasha-ThinkPad-X280>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <9d0d9986-e225-104b-b83d-fb7dd14f25d7@ispras.ru>
Date: Mon, 1 Jun 2020 13:36:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159012995470.27967.18129611453659045726.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=83.149.199.45; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 06:35:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, pavel.dovgaluk@ispras.ru,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On 22.05.2020 09:45, Pavel Dovgalyuk wrote:
> When QEMU is used without any graphical window,
> QEMU execution is terminated with the signal (e.g., Ctrl-C).
> Signal processing in QEMU does not include
> qemu_system_shutdown_request call. That is why shutdown
> event is not recorded by record/replay in this case.
> This patch adds shutdown event to the end of the record log.
> Now every replay will shutdown the machine at the end.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>   0 files changed
>
> diff --git a/replay/replay.c b/replay/replay.c
> index 53edad1377..83ed9e0e24 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -366,6 +366,11 @@ void replay_finish(void)
>       /* finalize the file */
>       if (replay_file) {
>           if (replay_mode == REPLAY_MODE_RECORD) {
> +            /*
> +             * Can't do it in the signal handler, therefore
> +             * add shutdown event here for the case of Ctrl-C.
> +             */
> +            replay_shutdown_request(SHUTDOWN_CAUSE_HOST_SIGNAL);
>               /* write end event */
>               replay_put_event(EVENT_END);
>   
>

