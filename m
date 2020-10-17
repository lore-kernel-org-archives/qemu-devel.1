Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8290620758
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8290620758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTgUh-0001gA-HT
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 03:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kTgTd-0000kX-NK
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 03:18:05 -0400
Received: from mailout07.t-online.de ([194.25.134.83]:34718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kTgTb-0005kq-KU
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 03:18:05 -0400
Received: from fwd32.aul.t-online.de (fwd32.aul.t-online.de [172.20.26.144])
 by mailout07.t-online.de (Postfix) with SMTP id 0C7F342DFDEE;
 Sat, 17 Oct 2020 09:17:59 +0200 (CEST)
Received: from [192.168.211.200]
 (ZwiFCsZBZhW1EQTazdTL7+DHZnLZqdVBUtWhSO1JDs5Gb4hXGiUwt0ieO9uwQvmQyJ@[46.86.52.112])
 by fwd32.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kTgTT-0HmP4K0; Sat, 17 Oct 2020 09:17:55 +0200
Subject: Re: [PULL 07/37] cpus: extract out hax-specific code to target/i386/
To: Claudio Fontana <cfontana@suse.de>
References: <20201006072947.487729-1-pbonzini@redhat.com>
 <20201006072947.487729-8-pbonzini@redhat.com>
 <a412667e-c486-b002-1e9c-5128345cad75@t-online.de>
 <39069adb-ee6d-ddf9-cc70-f069bcab5843@suse.de>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <7e8b24b1-98a1-0908-03b3-aad22419c941@t-online.de>
Date: Sat, 17 Oct 2020 09:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <39069adb-ee6d-ddf9-cc70-f069bcab5843@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: ZwiFCsZBZhW1EQTazdTL7+DHZnLZqdVBUtWhSO1JDs5Gb4hXGiUwt0ieO9uwQvmQyJ
X-TOI-EXPURGATEID: 150726::1602919075-0000C7C3-7814E52F/0/0 CLEAN NORMAL
X-TOI-MSGID: df1d7c51-3ad5-46d2-a6f7-b4a92042b462
Received-SPF: none client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 03:17:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>> Hi Claudio,
>>
>> is there a reason why you removed current_cpu = cpu; from hax_cpu_thread_fn() when you moved that function to target/i386/hax-cpus.c? This change broke HAX on Windows. Adding back that line makes it work again.
>
> Hello Volker, I see the change in the history and it was clearly an ugly mistake on my part.
> There was no reason or intention to remove the current_cpu = cpu assignment
>
> The fix seems indeed to just + current_cpu = cpu;
> and I will send a patch momentarily that does just that,
>
> but I don't know of any CI coverage for Windows + hax currently,
> so it would be good if you could spin the change to verify that it fixes the problem.
>

That was very quick. Only 5 hours from bug report to pull request. I've tested current master together with the patch from Paolo's PR. HAX on Windows works.

With best regards,
Volker

