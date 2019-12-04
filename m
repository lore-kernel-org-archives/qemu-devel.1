Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BAFC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC55205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FsPwH7tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC55205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUrM-0003hl-Gm
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icUom-0002su-I9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icUol-0005mq-9m
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:35:48 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:48770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icUog-0005lx-Be; Wed, 04 Dec 2019 08:35:42 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A2AEA96EF0;
 Wed,  4 Dec 2019 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575466540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfOQ/XuakjnWsNeoSdUr3UbRkZAPKweMNeEUHV4Xnuw=;
 b=FsPwH7tUIlPN+HEcjUAFkh6QI5D5MxlR5GSZf71wEkbnloI2SWr1EcTtiGDazvuvDHSv1e
 kZkzJtDEolHMEDmv/7f7WiNmiRy9LKFAHXO14fuQ/+9l0J/lPuHgvfFK8QAU0968EQfxzA
 8FYZMLgPqklsa1uwF08ooTC3t63VdG4=
Subject: Re: [PATCH v6 8/9] hw/char/cadence_uart: add clock support
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-9-damien.hedde@greensocs.com>
 <CAFEAcA8=7yhQR4Gw2OYmiF0cFJDaVn2hnUrfnZGFJK6wyuB97Q@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <75c38376-bbe9-1c52-d7a5-cc3aa73cbac2@greensocs.com>
Date: Wed, 4 Dec 2019 14:35:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=7yhQR4Gw2OYmiF0cFJDaVn2hnUrfnZGFJK6wyuB97Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575466540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfOQ/XuakjnWsNeoSdUr3UbRkZAPKweMNeEUHV4Xnuw=;
 b=ZscCWZk7LlsX8kd02cRVKUwB1nMABjLhOmUc1PXXfZbZnq2OypHT4t49Wh2r3GkhDeJRgY
 Z9qV0aUv76SUzD51IgtrM6Wdr18gD74B0d0/8wUWiVNTwVFZ4zOBhVaTou6VI3ndT8W4Do
 1Wr4V7PgTq5x/uPcfOlchRN/7HFpxIs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575466540; a=rsa-sha256; cv=none;
 b=7hg/tmCb64KH5gTd7e1YfQlpOb0Kta8faJfKWjxmQq96wCOQ6V8Qme84h/PY0hjkgS74wz
 NKc4vsbiipK9Ic/5rhp42A6MQZK4/KhznzfS1GaMlCLz2lrqSbVJcr1li1Q/kSQCGg5R8S
 zmddbVnXlKnDB1jJSn8AGOzdsAg+C+k=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 4:24 PM, Peter Maydell wrote:
> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Switch the cadence uart to multi-phase reset and add the
>> reference clock input.
>>
>> The input clock frequency is added to the migration structure.
>>
>> The reference clock controls the baudrate generation. If it disabled,
>> any input characters and events are ignored.
>>
>> If this clock remains unconnected, the uart behaves as before
>> (it default to a 50MHz ref clock).
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> 
>>  static void uart_parameters_setup(CadenceUARTState *s)
>>  {
>>      QEMUSerialSetParams ssp;
>> -    unsigned int baud_rate, packet_size;
>> +    unsigned int baud_rate, packet_size, input_clk;
>> +    input_clk = clock_get_frequency(s->refclk);
>>
>> -    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ?
>> -            UART_INPUT_CLK / 8 : UART_INPUT_CLK;
>> +    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ? input_clk / 8 : input_clk;
>> +    baud_rate /= (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
>> +    trace_cadence_uart_baudrate(baud_rate);
>> +
>> +    ssp.speed = baud_rate;
>>
>> -    ssp.speed = baud_rate / (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
>>      packet_size = 1;
>>
>>      switch (s->r[R_MR] & UART_MR_PAR) {
>> @@ -215,6 +220,13 @@ static void uart_parameters_setup(CadenceUARTState *s)
>>      }
>>
>>      packet_size += ssp.data_bits + ssp.stop_bits;
>> +    if (ssp.speed == 0) {
>> +        /*
>> +         * Avoid division-by-zero below.
>> +         * TODO: find something better
>> +         */
> 
> Any ideas what might be better? :-)

Well maybe the comment is misplaced. Because it is probably a good thing
to round up the ssp.speed in case it becomes 0 (which is very unlikely
apart from the case where the input clock is 0/disabled).

The problem is what should we do when the clock is disabled ?
Right now we:
+ set a minimal baudrate
+ ignore input characters/events
+ still forward output characters... (I just checked)

I suppose we could at least fix the last point: we can drop any output
characters. But if this happen, there is definitely a problem somewhere
(a firmware should not try to send characters to an unclocked uart). Is
there a qemu way of reporting this kind of situation ?

It would be best to somehow tell the backend we're not handling anything
anymore. So I could put that in the comment instead.

I really don't know if/how we can do that. When I looked I did not see
any way to do the opposite of qemu_chr_fe_accept_input() which is done
to start receiving stuff.

--
Damien

