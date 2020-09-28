Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C293C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D505A207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="kCaQoNDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D505A207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMooR-0004Lj-QI
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMojU-0001Gn-Uc; Mon, 28 Sep 2020 04:42:04 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:39440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMojT-0006cQ-3G; Mon, 28 Sep 2020 04:42:04 -0400
Received: from [172.16.11.103] (unknown [172.16.11.103])
 by beetle.greensocs.com (Postfix) with ESMTPSA id E548921C31;
 Mon, 28 Sep 2020 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1601282521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWXjV7DmwmcnRdVAwMT85HhjjlH/4iMcWRCXlKeY8sk=;
 b=kCaQoNDdDfD8DoQyHbbNlEShUebp0zP3p8urRDhkHkmXat7aeYtNjGZrSkpEt53h8YC+LY
 uY1Ai3xrPKkofsqUGMs/aC93el70OGF/562py43BGMznvJksL9ex6HH4mGXJymowV580l9
 9V0bJmZHrp1Tga0U97Q1R3x5FuYnNVg=
Subject: Re: [PATCH 02/14] hw/core/clock: trace clock values in Hz instead of
 ns
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-3-luc@lmichel.fr>
 <f5f6c8ca-d4f7-d06f-94d9-ded36ebf5753@amsat.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <41490d3c-e497-dbab-6e30-446ea9bffefd@greensocs.com>
Date: Mon, 28 Sep 2020 10:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f5f6c8ca-d4f7-d06f-94d9-ded36ebf5753@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=damien.hedde@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 04:38:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.011,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/26/20 10:36 PM, Philippe Mathieu-Daudé wrote:
> On 9/25/20 12:17 PM, Luc Michel wrote:
>> The nanosecond unit greatly limits the dynamic range we can display in
>> clock value traces, for values in the order of 1GHz and more. The
>> internal representation can go way beyond this value and it is quite
>> common for today's clocks to be within those ranges.
>>
>> For example, a frequency between 500MHz+ and 1GHz will be displayed as
>> 1ns. Beyond 1GHz, it will show up as 0ns.
>>
>> Replace nanosecond periods traces with frequencies in the Hz unit
>> to have more dynamic range in the trace output.
> 
> I have a similar patch adding the freq but keeping the periods in
> case, as it might be a matter of taste (for me too the frequency
> is more meaningful).
> 
>>
>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>> ---
>>  hw/core/clock.c      | 6 +++---
>>  hw/core/trace-events | 4 ++--
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/core/clock.c b/hw/core/clock.c
>> index 7066282f7b..81184734e0 100644
>> --- a/hw/core/clock.c
>> +++ b/hw/core/clock.c
>> @@ -37,12 +37,12 @@ void clock_clear_callback(Clock *clk)
>>  bool clock_set(Clock *clk, uint64_t period)
>>  {
>>      if (clk->period == period) {
>>          return false;
>>      }
>> -    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
>> -                    CLOCK_PERIOD_TO_NS(period));
>> +    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_HZ(clk->period),
>> +                    CLOCK_PERIOD_TO_HZ(period));
>>      clk->period = period;
>>  
>>      return true;
>>  }
>>  
>> @@ -52,11 +52,11 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
>>  
>>      QLIST_FOREACH(child, &clk->children, sibling) {
>>          if (child->period != clk->period) {
>>              child->period = clk->period;
>>              trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
>> -                               CLOCK_PERIOD_TO_NS(clk->period),
>> +                               CLOCK_PERIOD_TO_HZ(clk->period),
>>                                 call_callbacks);
>>              if (call_callbacks && child->callback) {
>>                  child->callback(child->callback_opaque);
>>              }
>>              clock_propagate_period(child, call_callbacks);
>> diff --git a/hw/core/trace-events b/hw/core/trace-events
>> index 1ac60ede6b..6f96d8bfd0 100644
>> --- a/hw/core/trace-events
>> +++ b/hw/core/trace-events
>> @@ -29,8 +29,8 @@ resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%
>>  resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
>>  
>>  # clock.c
>>  clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
>>  clock_disconnect(const char *clk) "'%s'"
>> -clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
>> +clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', %"PRIu64"hz->%"PRIu64"hz"
> 
> Unit is spell 'Hz'.
> 
>>  clock_propagate(const char *clk) "'%s'"
>> -clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
>> +clock_update(const char *clk, const char *src, uint64_t hz, int cb) "'%s', src='%s', val=%"PRIu64"hz cb=%d"
> 
> Ditto.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

