Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28845C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E497421871
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1XKj55w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E497421871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHvH0-0004Tg-18
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 15:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHvEY-0003GO-8e
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHvEW-0006kE-Nq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:33:21 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHvEW-0006k9-IP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:33:20 -0400
Received: by mail-yb1-xb41.google.com with SMTP id v37so6316970ybi.6
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zTW+zQM77byi14NBaZZqr3jmfYx6TCwB7mEyXcs+Ras=;
 b=Y1XKj55wzp8fZZhY+MwRRFWy37kmORqMWlXAbgg+jsvcQk+2hevyF5q0u8JgmRzZE9
 yYLtUzK/mtHTFu3EbInqf0mDX3DTcspcG20m77Rq9crlcP9FeuydPBuaowx77x9Zhc5J
 R/LGH22I3QeOKwnU3jEiRCQPdohlZQ4Ql7sPnSzTSQKaBg/Stz7s7p9D9lk0To8mgfB5
 +QRAA/EFBIP6okaejXD+OjKU/zJqMMW0rJeJyxz9ZOdEZYVaANn5MDPs32Q6iJjwC0Bu
 QKYJbGUzDHuLUyAVN3Qh0/z0dW8Qdt4qiFDxQ7fEw2Mbx23mfK1Ru5oelcKRQAD2LUEx
 GvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zTW+zQM77byi14NBaZZqr3jmfYx6TCwB7mEyXcs+Ras=;
 b=d2pDInPneKgh5SCOhC7mUr2HguDca6rEWPFHcIguHJTI5U2YwscfEXIOCa4BeyHcdI
 agDUtgw0um/iBvotXYzmSknsaDsyDzfpx5u771WGWzgjjNnPO1ZUFnBegAqhQm012qBw
 QVLo5tORcSwywUoxGwMUEnuJt+IHfm6mTfK5HS2lOecLSq4PpSyFIq+Y5h3e5dfEKyjW
 4YGrx+aTftSV5mb3k9i8xMqz/XSFPXLi47JsPGsVOnw6vfaJgBBNJI6cdXkOGVrR9FNz
 I6rZcb5y34A3FdOv8wbWwDOGsea+oReavaOgodSPYmDeLovifRpiGCS9Ph8lec89FKgs
 n1mQ==
X-Gm-Message-State: APjAAAV3MbOQIlCRcphURvKUkuEjjq/Z8d45uCeexbcjELU9Bhw79Tdt
 BMXudzPdlyIZxZ7lrtCqJQgG5w==
X-Google-Smtp-Source: APXvYqyHAmWXLsiprak5DFAUqHIIS8fuoVKx5sYk/Msk23N6Lm214P7l6qoGs0Yh0SBq2ICmA94wAQ==
X-Received: by 2002:a25:770e:: with SMTP id s14mr15699629ybc.242.1570563199666; 
 Tue, 08 Oct 2019 12:33:19 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id o135sm5329920ywo.75.2019.10.08.12.33.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 12:33:19 -0700 (PDT)
Subject: Re: [PATCH v9 11/13] accel/tcg: adding integration with linux perf
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <98aa7273-c504-1cd0-23e7-0b3226122bd8@linaro.org>
Date: Tue, 8 Oct 2019 15:33:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> +static uint32_t get_e_machine(void)
> +{
> +    uint32_t e_machine = EM_NONE;
> +    Elf64_Ehdr elf_header;

Not ideal, as this appears to not work on 32-bit hosts, but the two structures
do match up within the first 24 bytes, in which this is located.

That said, this value is present within tcg/host/tcg-target.inc.c as
ELF_HOST_MACHINE.  So we really don't have to play /proc/self/exec games.

> +void start_jitdump_file(void)
> +{
> +    g_autofree gchar *dumpfile_name = g_strdup_printf("./jit-%d.dump", getpid());
> +    dumpfile = fopen(dumpfile_name, "w+");
> +
> +    /* 'Perf record' saves mmaped files during the execution of a program and
> +     * 'perf inject' iterate over them to reconstruct all used/executed binary.
> +     * So, we create a mmap with the path of our jitdump that is processed
> +     * and used by 'perf inject' to reconstruct jitted binaries.
> +     */
> +    perf_marker = mmap(NULL, sysconf(_SC_PAGESIZE),
> +                          PROT_READ | PROT_EXEC,
> +                          MAP_PRIVATE,
> +                          fileno(dumpfile), 0);

(1) sysconf(_SC_PAGESIZE) is qemu_real_host_page_size.
(2) This is a page-sized mapping of a new, zero-sized file?
    I assume this mapping event gets logged, and that it its
    only purpose?
(3) I really need to read the kernel docs...

> +void append_load_in_jitdump_file(TranslationBlock *tb)
> +{
> +    gchar *func_name = g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->pc);
> +
> +    /* Serialise the writing of the dump file */
> +    qemu_mutex_lock(&dumpfile_lock);
> +
> +    struct jr_code_load load_event;
> +    load_event.p.id = JIT_CODE_LOAD;
> +    load_event.p.total_size =
> +        sizeof(struct jr_code_load) + func_name->len + 1 + tb->tc.size;

How does a "gchar *func_name" have ->len?  Did this used to be GString, but a
last-minute change means it no longer compiles?

> +    fflush(dumpfile);

Why fflushing all of the time?  Surely the file contents doesn't matter until
after the final close.

> +    qemu_mutex_unlock(&dumpfile_lock);

Why a separate qemu locking instead of using stdio's own locking (flockfile).

> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 871d91d559..3fafb656e7 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -58,6 +58,10 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/tcg.h"
>  
> +#ifdef __linux__
> +#include "perf/jitdump.h"
> +#endif

Why the ifdefs?  We're not dependent on other headers are we?
Not that there's a "perf" on other hosts, but AFACT it should
at least compile...


r~

