Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B61AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CEB2074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlxqCNpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CEB2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQniB-0002ao-8c
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQngz-0001cv-Uv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQngy-0006jO-QI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:51:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQngy-0006i0-Cu; Tue, 21 Apr 2020 03:51:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id k11so15321275wrp.5;
 Tue, 21 Apr 2020 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rh8lP+ZKlGJACC/4etpR6jG3GBulcocB38fajDj7kT0=;
 b=WlxqCNplY5mhBUHYDJCMD8A4zI8oRBo5WkTnt1iksTdONbIa1gNsALUgt3xRPfTzE3
 4YL7qyE0plWOADrofFtFEJGT342v8NpjR5UEV3q0U2CDMdtyEHgoZ03FdSQvHJXncOul
 Y0wKUuZy/FnKP5tjvkevOHu3MtGLz9YUKRMscpCoXp2NNqVY99553t9/szbsqQTJ4wS5
 kAosR9obUsxcw/qubDkzVy7BxQsZVs5Y4qOadZf/+ff3wLRyunbsCiP4WuLsQ3OfMqwF
 VaIfNDWMZeqBwQ7qrP8XFgqkULl4Z/b/dCB8PYZo0pCNrOg5JuH3nW49XHQ4zQv3pWRs
 Xe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Rh8lP+ZKlGJACC/4etpR6jG3GBulcocB38fajDj7kT0=;
 b=bBfuQosXI5GE8kLb+EKFlDsxm1OwZ8Q2XjFyJg8CegtucaZndHWP1X5SOiP6NOmS8X
 ssjh1Q7chiE2+FxeUEqmEuGlugEkp5VjLNvIxxK8JpDJ7VjOykKQmXRIgswn9HvLFbcp
 6Zp36KG8/v8nl1rZgkac376ClexxVYYQsdZTUYP6xlfMPkeBMAiGzjey4zz87Nj83w0F
 RUIlBN+TfvqQgpmGkiI5021fRQWMGZCaL/USJl9UYVJ8BX43kgmrozWuICONo3Y9cE67
 6IyR3hFIwhSIV6eyUhEnyzmSUWWv1GGUnwwoDfcmgXv995Icn7twcWZ6/pTr5x+bHMpe
 68wA==
X-Gm-Message-State: AGi0PuaZCLJ9VSXm43y/+YI8vxLEK7HBSxvyWxr/FSY2ZCfjqWW7nr17
 G9sLWRshQ3xMcyqZmN/aWVCMiSXcq7A=
X-Google-Smtp-Source: APiQypLfW9tbtXWoB6rxOdb5TocYIj0TGZ9tU7bhXk4p5BBhAUfMLjkGvh3HX0vwKMYQEJlLKBaFRw==
X-Received: by 2002:adf:db0a:: with SMTP id s10mr22992995wri.361.1587455498879; 
 Tue, 21 Apr 2020 00:51:38 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y10sm2365740wma.5.2020.04.21.00.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 00:51:38 -0700 (PDT)
Subject: Re: [PATCH 3/4] linux-user/arm: Handle invalid arm-specific syscalls
 correctly
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-4-peter.maydell@linaro.org>
 <20200421074400.GE2669@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ccadb30c-2f38-b51c-beb4-532b044918f5@amsat.org>
Date: Tue, 21 Apr 2020 09:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200421074400.GE2669@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: omerg681@gmail.com, qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 9:44 AM, Edgar E. Iglesias wrote:
> On Mon, Apr 20, 2020 at 10:22:05PM +0100, Peter Maydell wrote:
>> The kernel has different handling for syscalls with invalid
>> numbers that are in the "arm-specific" range 0x9f0000 and up:
>>  * 0x9f0000..0x9f07ff return -ENOSYS if not implemented
>>  * other out of range syscalls cause a SIGILL
>> (see the kernel's arch/arm/kernel/traps.c:arm_syscall())
>>
>> Implement this distinction. (Note that our code doesn't look
>> quite like the kernel's, because we have removed the
>> 0x900000 prefix by this point, whereas the kernel retains
>> it in arm_syscall().)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  linux-user/arm/cpu_loop.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
>> index 025887d6b86..f042108b0be 100644
>> --- a/linux-user/arm/cpu_loop.c
>> +++ b/linux-user/arm/cpu_loop.c
>> @@ -332,10 +332,32 @@ void cpu_loop(CPUARMState *env)
>>                              env->regs[0] = cpu_get_tls(env);
>>                              break;
>>                          default:
>> -                            qemu_log_mask(LOG_UNIMP,
>> -                                          "qemu: Unsupported ARM syscall: 0x%x\n",
>> -                                          n);
>> -                            env->regs[0] = -TARGET_ENOSYS;
>> +                            if (n < 0xf0800) {
>> +                                /*
>> +                                 * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
>> +                                 * 0x9f07ff in OABI numbering) are defined
>> +                                 * to return -ENOSYS rather than raising
>> +                                 * SIGILL. Note that we have already
>> +                                 * removed the 0x900000 prefix.
>> +                                 */
>> +                                qemu_log_mask(LOG_UNIMP,
>> +                                    "qemu: Unsupported ARM syscall: 0x%x\n",
>> +                                              n);
>> +                                env->regs[0] = -TARGET_ENOSYS;
>> +                            } else {
>> +                                /* Otherwise SIGILL */
>> +                                info.si_signo = TARGET_SIGILL;
>> +                                info.si_errno = 0;
>> +                                info.si_code = TARGET_ILL_ILLTRP;
>> +                                info._sifields._sigfault._addr = env->regs[15];
>> +                                if (env->thumb) {
>> +                                    info._sifields._sigfault._addr -= 2;
>> +                                } else {
>> +                                    info._sifields._sigfault._addr -= 2;
>> +                                }
> 
> 
> Am I missing some detail or are both branches of the if-else doing the
> same thing?

Oops good catch. R-b stands using '-= 4' on 2nd line.

> 
> Cheers,
> Edgar
> 
> 
> 
>> +                                queue_signal(env, info.si_signo,
>> +                                             QEMU_SI_FAULT, &info);
>> +                            }
>>                              break;
>>                          }
>>                      } else {
>> -- 
>> 2.20.1
>>
>>
> 

