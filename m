Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B5C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F83205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATG9Q9Ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F83205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffi0-0001e8-3d
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfffL-0000a4-SY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfffK-0008EY-8E
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:14:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfffK-0008CM-1e
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:14:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so16516047wrt.6
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9iN3LIrbzJrdUEfkRMMoO+dvk2ndcOrHOL08AgasOMo=;
 b=ATG9Q9WwsXPsLRK4MO6lPKJMRlHkkIYTxjgi3NuuvuaukJlTT2gQM1aYo9GtwKjRZg
 HZ/4SvgpjvCFgg6onBhMTqLdB5XDX91+D6hHdWiJAsXrWUeIQRMHdinSdOXCCnsovEmH
 xGWhTV8Yv22U7DWS4qijmZ3gTbkriCZrOQ4zmr0rGo4nynredRpw6vzUpAYGyoBdPKlW
 tbjM2TWqfo3WA9AL9D0XtbbNOhlz6B/Dbc/T/lPUXtG8vbCAYEO1FhDgoUxu2RPX5GaO
 HJoAmFMfukg8AmLoWvtqo3zHiZSTAHgwx3vGjy6eYaCjiiOXDuYYS1rN2nbpARDe6qo7
 Td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9iN3LIrbzJrdUEfkRMMoO+dvk2ndcOrHOL08AgasOMo=;
 b=raiY+eCWvD9EvLTU8tvv7tBJSln6Cg4CzeMJqZM0pfxWtkra4Ts9l16+6jy0hl7j4d
 nhjkI8hh+rA6qL0M9QXkVa2q4t5oqwZ9bw7unMAv9ItJ1RAUo1x4qmu39tTyiqIW0jRi
 XPe6eXp9Rc2OyvOqa1p9PH99/bQVB+WHWbHyhI0aq7dXt68ecOkU23uh4VjxHqsJ7KHe
 DWcAfGbtoNr14zVRrTUuafQhybdN+46iivf7KwyKhyoGfaM3eIDW9spaC8KW+F8BLlUa
 WIojVyu2bOz/7JXdMiDqaaTOeS7evryEJj5vSLJ63R7bV0FwKtc1qUUehqFWKwW2APk5
 nuAQ==
X-Gm-Message-State: APjAAAVsFs0CYFqDLix+hoPCi7BY/MoklV3mJuYP12TB+rYEffEJ1i0b
 cCwlzfhubeaDo4qTUBMA0zI=
X-Google-Smtp-Source: APXvYqwT5i9koCW6SUwciUhJR0S1m2tjhlzpRihBbAtPwCu2tCKf95w77Pqh6kk2y8WPNUdJrO9HZg==
X-Received: by 2002:a05:6000:124a:: with SMTP id
 j10mr11947373wrx.191.1561446890082; 
 Tue, 25 Jun 2019 00:14:50 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l8sm29219432wrg.40.2019.06.25.00.14.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 00:14:49 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-6-f4bug@amsat.org>
 <CAL1e-=iToNHH2nFEC-Z3AtqEZakYNv3fULwcnz1f496Yqjxrjw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <f52a7b4d-1415-c79d-138b-f4aab5944f68@amsat.org>
Date: Tue, 25 Jun 2019 09:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iToNHH2nFEC-Z3AtqEZakYNv3fULwcnz1f496Yqjxrjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 05/10] hw/mips/gt64xxx_pci: Use
 qemu_log_mask() instead of debug printf()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 6/25/19 2:37 AM, Aleksandar Markovic wrote:
> 
> This patch is not only mechanical replacement of printf(), but it also
> improves existing log messages, and adds some new ones as well. Reflect
> that in both commit message title and body. Perhaps there are more spots
> that deserve logging. But, also, please, Philippe, doublecheck in real
> scenarios if we don't flood the log with too many messages.

While qemu_log(...) might flood the user, qemu_log_mask(mask, ...) do
not. By default the mask is empty, and you have to enable the specific
bits you want the relevant information to be logged.

The mask comes from:

$ qemu-system-mips -d help
Log items (comma separated):
out_asm         show generated host assembly code for each compiled TB
in_asm          show target assembly code for each compiled TB
op              show micro ops for each compiled TB
op_opt          show micro ops after optimization
op_ind          show micro ops before indirect lowering
int             show interrupts/exceptions in short format
exec            show trace before each executed TB (lots of logs)
cpu             show CPU registers before entering a TB (lots of logs)
fpu             include FPU registers in the 'cpu' logging
mmu             log MMU-related activities
pcall           x86 only: show protected mode far calls/returns/exceptions
cpu_reset       show CPU state before CPU resets
unimp           log unimplemented functionality
guest_errors    log when the guest OS does something invalid (eg accessing a
non-existent register)
page            dump pages at beginning of user mode emulation
nochain         do not chain compiled TBs so that "exec" and "cpu" show
complete traces
trace:PATTERN   enable trace events

>>  hw/mips/gt64xxx_pci.c | 48 +++++++++++++++++++++++++++++++++----------
>>  1 file changed, 37 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
>> index 0b9fb02475..f44326f14f 100644
>> --- a/hw/mips/gt64xxx_pci.c
>> +++ b/hw/mips/gt64xxx_pci.c
>> @@ -23,6 +23,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/log.h"
>>  #include "hw/hw.h"
>>  #include "hw/mips/mips.h"
>>  #include "hw/pci/pci.h"
>> @@ -466,12 +467,20 @@ static void gt64120_writel(void *opaque, hwaddr
> addr,
>>      case GT_CPUERR_DATAHI:
>>      case GT_CPUERR_PARITY:
>>          /* Read-only registers, do nothing */
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "gt64120: Read-only register write "
>> +                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
>> +                      saddr << 2, size, size << 1, val);
>>          break;
[...]

So here if you do not run with '-d guest_errors', invalid accesses won't
be logged.

Note that there is no equivalent of error_report_once() with qemu_log(),
but IMO in case of I/O access I am not sure it would make sense.

Regards,

Phil.

