Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21512C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE19120725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZYbU+sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE19120725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtung-0002Uj-6X
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtumq-0001dQ-El
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:18:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtump-00040u-0D
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:18:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id a6so6348511wrm.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/WYIO9BrIBpug4SqrjwVxOv5g8GW1doshoEqeRS23oY=;
 b=UZYbU+sxrBVlPxYSqT6xlVUdS7stVGbOgmwZ0iQkeNmneuRKFOzFPyTS39xmXHMa2N
 6xinCr2KxEyBtjdfrwdaL1C0hCmi+hkmeVlvuV5xVASNvZsEFr6S/E385LPOV/NAIBH4
 Dkj60Auf38LJ6Ry3p7zW4FITTn5iob0kzLjenimRvg3VoMuTpz/10dfTBHb5FThEA2xE
 O3FGtbNVvqCiMPG4GfFoMn5fR0GlzVYozpHq1ppAUT0HUvRwQn5oFrF/+Xo6F4BL9/5h
 Gfpr+OOYbj/rQSthDd1OHGLyMHJkVv2vf+Db31QW82WP1tAx8zNqeeshUm44md2qgE6n
 6ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/WYIO9BrIBpug4SqrjwVxOv5g8GW1doshoEqeRS23oY=;
 b=jIFGQSthbIk2mjPr02HhoVDYE3Utvwa/jXi4BvRI+f/L31bCUcbZSs3mUDrmkxS62K
 ccGXV/DM5eJNWu8ona+RR2jsk7LnvXLrbp3O1ekiTi05lM688V6bo8Bh91Nhjz5o2DC2
 mKnRlk4SFqxZI0QuuPql+/nfFdyCZpr46HTrYEJ5eHaFs95gH6NKxoe94exGjflZG5OV
 pViVMbZucYv3YOk8b1r59WaBTPJvqG2kBmKs3qRT4EsM2wNPXPjm37LS80RLiPp4RaQh
 QMmv4xb+eZ5hO7ZkqAg0kYVXc+E/rAyg2/Bx032GSeikKBkRUu3zbZP0KmeTRaXP/M8N
 Gn1A==
X-Gm-Message-State: AOAM531VcYSgutbDeLX5iq6TxuOoxLWqBs8Qhc+Exfnvyu9sMMlJgycL
 d+ReawefOCPq1c8hbnVkLss=
X-Google-Smtp-Source: ABdhPJxegX0jBbHtzItO+gENVIlPA+Za/Gl+c8fLOW399VqLby2byE9sJazMyKat4sjTNQIH/R/gqQ==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr65628726wro.137.1594394281417; 
 Fri, 10 Jul 2020 08:18:01 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f16sm9611353wmh.27.2020.07.10.08.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 08:18:00 -0700 (PDT)
Subject: Re: [PULL 00/32] AVR port
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20200707181710.30950-1-f4bug@amsat.org>
 <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
 <47ca6b92-cedb-a6c4-754b-b7cd5da597e7@redhat.com>
 <CAFEAcA_wBT+Yfsn+DFZkcRxYWKmF04U2JHNVz5mNuXabeDcN5g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <544208da-9dad-5fab-ab43-b2537a1f2f90@amsat.org>
Date: Fri, 10 Jul 2020 17:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_wBT+Yfsn+DFZkcRxYWKmF04U2JHNVz5mNuXabeDcN5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 5:12 PM, Peter Maydell wrote:
> On Fri, 10 Jul 2020 at 16:03, Thomas Huth <thuth@redhat.com> wrote:
>> Endianess bug ... this should fix it:
>>
>> diff --git a/target/avr/helper.c b/target/avr/helper.c
>> --- a/target/avr/helper.c
>> +++ b/target/avr/helper.c
>> @@ -337,6 +337,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data,
>> uint32_t addr)
>>          helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
>>      } else {
>>          /* memory */
>> -        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
>> +        uint8_t data8 = data;
>> +        cpu_physical_memory_write(OFFSET_DATA + addr, &data8, 1);
>>      }
> 
> Or equivalently
>   address_space_stb(&address_space_memory, data, MEMTXATTRS_UNSPECIFIED, NULL);
> 
> (better choices of address space may be available, but this is
> the exact-same-behaviour one).

Ah, this is my stashed fix:

-- >8 --
@@ -320,8 +320,10 @@ target_ulong helper_fullrd(CPUAVRState *env,
uint32_t addr)
  *  this function implements ST instruction when there is a posibility
to write
  *  into a CPU register
  */
-void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
+void helper_fullwr(CPUAVRState *env, uint32_t data32, uint32_t addr)
 {
+    uint8_t data = data32;
+    assert(data == data32);
+
     env->fullacc = false;

---

3 ways to do the same :) The assert is probably superfluous.

I don't like the fact that env->r[addr] (which is u8) is silently casted
from u32.

