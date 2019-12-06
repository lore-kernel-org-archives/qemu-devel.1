Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C3CC2BBE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468BD24673
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUmPP798"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468BD24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHDM-0006uV-3U
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idFST-0000WJ-F7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idFSP-0007TU-Bv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:23:53 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:39762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idFSN-0007Rd-5l
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:23:47 -0500
Received: by mail-oi1-x234.google.com with SMTP id a67so74997oib.6
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=OYYWnisRInjSdcH37VEgOTGFFjIYEdsGLDU0/fztoBc=;
 b=aUmPP798m4gPEm5j72KwKn1z/q0ysHXlpxhzlH4Az5IDOP61JDTbzI1920zXASxSLv
 9NWuRjDu4nBXJzAjs4Xq2mxd7iYjTkfd77rXm5vey4WyxuDZ44A/fUE5Wh04/AFSywpJ
 gQHMMBJGaZ6XsRSVaBUjcbTC8AF7vPtSV8cGHTOxay5HU664kRmGRxDhE+EFyKvCZhUT
 trb0P0O1xaXf0h/KIZkaD3zOA+dKEPFB/WWgOF84O8OiYid4LfFTA61EaR1MG9RHLqpY
 x9mnePns6ef++HRzBx1wngjS1Sv+wc7jN6XIrUavf7sJyhYIp7B3psz3wda+NzRoMIAf
 NaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=OYYWnisRInjSdcH37VEgOTGFFjIYEdsGLDU0/fztoBc=;
 b=iKqI9qBvtf5tyAQsv6SuTtpWy95nHJqB2w2PtUp6bNpJju7qxzfb+2UTT7Pk94ybeW
 Ey8t0Z6YKk5/Bt4I8L6mIWL4zQpD1dgvXvQFt7dh0imslg3YtMwQ0AXHytOFnAuUKCxw
 HzWb6NMLUM0Mqn6rlvxDXeGR7/14Tq1qT3w7/19LdBvbr8QzL3aqeOTGYjkgzIt0Mtfp
 8zxgnegM+Sc5HjEyOCdDYlUfY28aYC5iI4Jsvwdm4pqZ73m3wP/vAhwDuWTVLzfFfLeY
 ittU+CI7yfjKhmLaOFWChPv6Zr9iPbiTCxGEKIa3N5ensTpO4MRdF7Ynw/fxpK9dyz2h
 yMyw==
X-Gm-Message-State: APjAAAVXo5/LRrgc3TUS5dU5vWUbwaKxL9Yz2pCtEVnEPdDhIhl2KzVB
 40Z2R5nnZhSnMxm3ML+sHHlPsl+aj8Kh6k6KnJyfjg==
X-Google-Smtp-Source: APXvYqw30K/oaI4rTYoxAT6/035BTE8biz1lFxBaepabyDiWNY1HFVlVDBM1kmGgOQF5yBCXdx+yjKBjJ34KA6yl1bQ=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr501565oib.106.1575620487535;
 Fri, 06 Dec 2019 00:21:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 6 Dec 2019 00:21:27 -0800 (PST)
In-Reply-To: <7f7f98ec-6ee2-ec3d-6807-6b74af547241@redhat.com>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-3-git-send-email-Filip.Bozuta@rt-rk.com>
 <7f7f98ec-6ee2-ec3d-6807-6b74af547241@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 6 Dec 2019 09:21:27 +0100
Message-ID: <CAL1e-=iXj6K2vsNv2VODXPLc2wEbpwhFej_5Rrsqd3cdzdEq+w@mail.gmail.com>
Subject: Re: [PATCH 2/5] mips: malta: Renovate coding style
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000075e070059904bbf5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000075e070059904bbf5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 1, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Hi Filip,
>
> On 11/25/19 2:04 PM, Filip Bozuta wrote:
>
>> The script checkpatch.pl located in scripts folder was
>> used to detect all errors and warrnings in files:
>>      hw/mips/mips_malta.c
>>      hw/mips/gt64xxx_pci.c
>>      tests/acceptance/linux_ssh_mips_malta.py
>>
>> All these mips malta machine files were edited and
>> all the errors and warrings generated by the checkpatch.pl
>> script were corrected and then the script was
>> ran again to make sure there are no more errors and warnings.
>>
>> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
>> ---
>>   hw/mips/mips_malta.c                     | 139
>> ++++++++++++++++---------------
>>   tests/acceptance/linux_ssh_mips_malta.py |   6 +-
>>   2 files changed, 75 insertions(+), 70 deletions(-)
>>
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index 92e9ca5..18eafac 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -137,7 +137,8 @@ static void malta_fpga_update_display(void *opaque)
>>    */
>>     #if defined(DEBUG)
>> -#  define logout(fmt, ...) fprintf(stderr, "MALTA\t%-24s" fmt, __func__=
,
>> ## __VA_ARGS__)
>> +#  define logout(fmt, ...) \
>> +          fprintf(stderr, "MALTA\t%-24s" fmt, __func__, ## __VA_ARGS__)
>>
>
> This is deprecated code, if you look in the repository history, we usuall=
y
> don't touch it, except to get rid of it. The way to get rid of it is to
> replace the calls by trace events.
>
>
Code must be read, whatever its history or destiny is. If slated for
refactoring, one reason more to be visible in less than 80 columns. This
hunk improves code visibility, clearly separates two parts of a macro, and
is fine to me.


>   #else
>>   #  define logout(fmt, ...) ((void)0)
>>   #endif
>> @@ -569,7 +570,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion
>> *address_space,
>>       MaltaFPGAState *s;
>>       Chardev *chr;
>>   -    s =3D (MaltaFPGAState *)g_malloc0(sizeof(MaltaFPGAState));
>> +    s =3D (MaltaFPGAState *)g_new0(sizeof(MaltaFPGAState));
>>
>
> This change doesn't even compile... Please compile your patches before
> posting them to the list.
>
> You can find the prototype of this macro here:
> https://developer.gnome.org/glib/stable/glib-Memory-Allocation.html#g-new=
0
>
>
This must be fixed. Filip, you need to send v2 with the fix for build error
and other improvements asked in replies to this series.


>         memory_region_init_io(&s->iomem, NULL, &malta_fpga_ops, s,
>>                             "malta-fpga", 0x100000);
>> @@ -844,9 +845,9 @@ static void write_bootloader(uint8_t *base, int64_t
>> run_addr,
>>       /* Small bootloader */
>>       p =3D (uint32_t *)base;
>>   -    stl_p(p++, 0x08000000 |                                      /* j
>> 0x1fc00580 */
>> +    stl_p(p++, 0x08000000 |                                   /* j
>> 0x1fc00580 */
>>                    ((run_addr + 0x580) & 0x0fffffff) >> 2);
>> -    stl_p(p++, 0x00000000);                                      /* nop
>> */
>> +    stl_p(p++, 0x00000000);                                   /* nop */
>>         /* YAMON service vector */
>>       stl_p(base + 0x500, run_addr + 0x0580);      /* start: */
>> @@ -892,104 +893,106 @@ static void write_bootloader(uint8_t *base,
>> int64_t run_addr,
>>       stl_p(p++, 0x34e70000 | (loaderparams.ram_low_size & 0xffff));
>>         /* Load BAR registers as done by YAMON */
>> -    stl_p(p++, 0x3c09b400);                                      /* lui
>> t1, 0xb400 */
>> +    stl_p(p++, 0x3c09b400);                 /* lui t1, 0xb400 */
>>     #ifdef TARGET_WORDS_BIGENDIAN
>> -    stl_p(p++, 0x3c08df00);                                      /* lui
>> t0, 0xdf00 */
>> +    stl_p(p++, 0x3c08df00);                  /* lui t0, 0xdf00 */
>>   #else
>> -    stl_p(p++, 0x340800df);                                      /* ori
>> t0, r0, 0x00df */
>> +    stl_p(p++, 0x340800df);                  /* ori t0, r0, 0x00df */
>>   #endif
>> -    stl_p(p++, 0xad280068);                                      /* sw
>> t0, 0x0068(t1) */
>> +    stl_p(p++, 0xad280068);                  /* sw t0, 0x0068(t1) */
>>   -    stl_p(p++, 0x3c09bbe0);                                      /*
>> lui t1, 0xbbe0 */
>> +    stl_p(p++, 0x3c09bbe0);                  /* lui t1, 0xbbe0 */
>>     #ifdef TARGET_WORDS_BIGENDIAN
>> -    stl_p(p++, 0x3c08c000);                                      /* lui
>> t0, 0xc000 */
>> +    stl_p(p++, 0x3c08c000);                  /* lui t0, 0xc000 */
>>   #else
>> -    stl_p(p++, 0x340800c0);                                      /* ori
>> t0, r0, 0x00c0 */
>> +    stl_p(p++, 0x340800c0);                  /* ori t0, r0, 0x00c0 */
>>   #endif
>> -    stl_p(p++, 0xad280048);                                      /* sw
>> t0, 0x0048(t1) */
>> +    stl_p(p++, 0xad280048);                  /* sw t0, 0x0048(t1) */
>>   #ifdef TARGET_WORDS_BIGENDIAN
>> -    stl_p(p++, 0x3c084000);                                      /* lui
>> t0, 0x4000 */
>> +    stl_p(p++, 0x3c084000);                  /* lui t0, 0x4000 */
>>   #else
>> -    stl_p(p++, 0x34080040);                                      /* ori
>> t0, r0, 0x0040 */
>> +    stl_p(p++, 0x34080040);                  /* ori t0, r0, 0x0040 */
>>   #endif
>> -    stl_p(p++, 0xad280050);                                      /* sw
>> t0, 0x0050(t1) */
>> +    stl_p(p++, 0xad280050);                  /* sw t0, 0x0050(t1) */
>>     #ifdef TARGET_WORDS_BIGENDIAN
>> -    stl_p(p++, 0x3c088000);                                      /* lui
>> t0, 0x8000 */
>> +    stl_p(p++, 0x3c088000);                  /* lui t0, 0x8000 */
>>   #else
>> -    stl_p(p++, 0x34080080);                                      /* ori
>> t0, r0, 0x0080 */
>> +    stl_p(p++, 0x34080080);                  /* ori t0, r0, 0x0080 */
>>   #endif
>> -    stl_p(p++, 0xad280058);                                      /* sw
>> t0, 0x0058(t1) */
>> +    stl_p(p++, 0xad280058);                  /* sw t0, 0x0058(t1) */
>>   #ifdef TARGET_WORDS_BIGENDIAN
>> -    stl_p(p++, 0x3c083f00);                                      /* lui
>> t0, 0x3f00 */
>> +    stl_p(p++, 0x3c083f00);                  /* lui t0, 0x3f00 */
>>   #else
>> -    stl_p(p++, 0x3408003f);                                      /* ori
>> t0, r0, 0x003f */
>> +    stl_p(p++, 0x3408003f);                  /* ori t0, r0, 0x003f */
>>   #endif
>> -    stl_p(p++, 0xad280060);                                      /* sw
>> t0, 0x0060(t1) */
>> +    stl_p(p++, 0xad280060);                  /* sw t0, 0x0060(t1) */
>>     #ifdef TARGET_WORDS_BIGENDIAN
>> -    stl_p(p++, 0x3c08c100);                                      /* lui
>> t0, 0xc100 */
>> +    stl_p(p++, 0x3c08c100);                  /* lui t0, 0xc100 */
>>   #else
>> -    stl_p(p++, 0x340800c1);                                      /* ori
>> t0, r0, 0x00c1 */
>> +    stl_p(p++, 0x340800c1);                  /* ori t0, r0, 0x00c1 */
>>   #endif
>> -    stl_p(p++, 0xad280080);                                      /* sw
>> t0, 0x0080(t1) */
>> +    stl_p(p++, 0xad280080);                  /* sw t0, 0x0080(t1) */
>>   #ifdef TARGET_WORDS_BIGENDIAN
>> -    stl_p(p++, 0x3c085e00);                                      /* lui
>> t0, 0x5e00 */
>> +    stl_p(p++, 0x3c085e00);                  /* lui t0, 0x5e00 */
>>   #else
>> -    stl_p(p++, 0x3408005e);                                      /* ori
>> t0, r0, 0x005e */
>> +    stl_p(p++, 0x3408005e);                  /* ori t0, r0, 0x005e */
>>   #endif
>> -    stl_p(p++, 0xad280088);                                      /* sw
>> t0, 0x0088(t1) */
>> +    stl_p(p++, 0xad280088);                  /* sw t0, 0x0088(t1) */
>>         /* Jump to kernel code */
>> -    stl_p(p++, 0x3c1f0000 | ((kernel_entry >> 16) & 0xffff));    /* lui
>> ra, high(kernel_entry) */
>> -    stl_p(p++, 0x37ff0000 | (kernel_entry & 0xffff));            /* ori
>> ra, ra, low(kernel_entry) */
>> -    stl_p(p++, 0x03e00009);                                      /* jal=
r
>> ra */
>> -    stl_p(p++, 0x00000000);                                      /* nop
>> */
>> +    stl_p(p++, 0x3c1f0000 |
>> +          ((kernel_entry >> 16) & 0xffff));  /* lui ra,
>> high(kernel_entry) */
>> +    stl_p(p++, 0x37ff0000 |
>> +          (kernel_entry & 0xffff));          /* ori ra, ra,
>> low(kernel_entry) */
>> +    stl_p(p++, 0x03e00009);                  /* jalr ra */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>>         /* YAMON subroutines */
>>       p =3D (uint32_t *) (base + 0x800);
>> -    stl_p(p++, 0x03e00009);                                     /* jalr
>> ra */
>> -    stl_p(p++, 0x24020000);                                     /* li
>> v0,0 */
>> +    stl_p(p++, 0x03e00009);                  /* jalr ra */
>> +    stl_p(p++, 0x24020000);                  /* li v0,0 */
>>       /* 808 YAMON print */
>> -    stl_p(p++, 0x03e06821);                                     /* move
>> t5,ra */
>> -    stl_p(p++, 0x00805821);                                     /* move
>> t3,a0 */
>> -    stl_p(p++, 0x00a05021);                                     /* move
>> t2,a1 */
>> -    stl_p(p++, 0x91440000);                                     /* lbu
>> a0,0(t2) */
>> -    stl_p(p++, 0x254a0001);                                     /* addi=
u
>> t2,t2,1 */
>> -    stl_p(p++, 0x10800005);                                     /* beqz
>> a0,834 */
>> -    stl_p(p++, 0x00000000);                                     /* nop =
*/
>> -    stl_p(p++, 0x0ff0021c);                                     /* jal
>> 870 */
>> -    stl_p(p++, 0x00000000);                                     /* nop =
*/
>> -    stl_p(p++, 0x1000fff9);                                     /* b 81=
4
>> */
>> -    stl_p(p++, 0x00000000);                                     /* nop =
*/
>> -    stl_p(p++, 0x01a00009);                                     /* jalr
>> t5 */
>> -    stl_p(p++, 0x01602021);                                     /* move
>> a0,t3 */
>> +    stl_p(p++, 0x03e06821);                  /* move t5,ra */
>> +    stl_p(p++, 0x00805821);                  /* move t3,a0 */
>> +    stl_p(p++, 0x00a05021);                  /* move t2,a1 */
>> +    stl_p(p++, 0x91440000);                  /* lbu a0,0(t2) */
>> +    stl_p(p++, 0x254a0001);                  /* addiu t2,t2,1 */
>> +    stl_p(p++, 0x10800005);                  /* beqz a0,834 */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>> +    stl_p(p++, 0x0ff0021c);                  /* jal 870 */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>> +    stl_p(p++, 0x1000fff9);                  /* b 814 */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>> +    stl_p(p++, 0x01a00009);                  /* jalr t5 */
>> +    stl_p(p++, 0x01602021);                  /* move a0,t3 */
>>       /* 0x83c YAMON print_count */
>> -    stl_p(p++, 0x03e06821);                                     /* move
>> t5,ra */
>> -    stl_p(p++, 0x00805821);                                     /* move
>> t3,a0 */
>> -    stl_p(p++, 0x00a05021);                                     /* move
>> t2,a1 */
>> -    stl_p(p++, 0x00c06021);                                     /* move
>> t4,a2 */
>> -    stl_p(p++, 0x91440000);                                     /* lbu
>> a0,0(t2) */
>> -    stl_p(p++, 0x0ff0021c);                                     /* jal
>> 870 */
>> -    stl_p(p++, 0x00000000);                                     /* nop =
*/
>> -    stl_p(p++, 0x254a0001);                                     /* addi=
u
>> t2,t2,1 */
>> -    stl_p(p++, 0x258cffff);                                     /* addi=
u
>> t4,t4,-1 */
>> -    stl_p(p++, 0x1580fffa);                                     /* bnez
>> t4,84c */
>> -    stl_p(p++, 0x00000000);                                     /* nop =
*/
>> -    stl_p(p++, 0x01a00009);                                     /* jalr
>> t5 */
>> -    stl_p(p++, 0x01602021);                                     /* move
>> a0,t3 */
>> +    stl_p(p++, 0x03e06821);                  /* move t5,ra */
>> +    stl_p(p++, 0x00805821);                  /* move t3,a0 */
>> +    stl_p(p++, 0x00a05021);                  /* move t2,a1 */
>> +    stl_p(p++, 0x00c06021);                  /* move t4,a2 */
>> +    stl_p(p++, 0x91440000);                  /* lbu a0,0(t2) */
>> +    stl_p(p++, 0x0ff0021c);                  /* jal 870 */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>> +    stl_p(p++, 0x254a0001);                  /* addiu t2,t2,1 */
>> +    stl_p(p++, 0x258cffff);                  /* addiu t4,t4,-1 */
>> +    stl_p(p++, 0x1580fffa);                  /* bnez t4,84c */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>> +    stl_p(p++, 0x01a00009);                  /* jalr t5 */
>> +    stl_p(p++, 0x01602021);                  /* move a0,t3 */
>>       /* 0x870 */
>> -    stl_p(p++, 0x3c08b800);                                     /* lui
>> t0,0xb400 */
>> -    stl_p(p++, 0x350803f8);                                     /* ori
>> t0,t0,0x3f8 */
>> -    stl_p(p++, 0x91090005);                                     /* lbu
>> t1,5(t0) */
>> -    stl_p(p++, 0x00000000);                                     /* nop =
*/
>> -    stl_p(p++, 0x31290040);                                     /* andi
>> t1,t1,0x40 */
>> -    stl_p(p++, 0x1120fffc);                                     /* beqz
>> t1,878 <outch+0x8> */
>> -    stl_p(p++, 0x00000000);                                     /* nop =
*/
>> -    stl_p(p++, 0x03e00009);                                     /* jalr
>> ra */
>> -    stl_p(p++, 0xa1040000);                                     /* sb
>> a0,0(t0) */
>> +    stl_p(p++, 0x3c08b800);                  /* lui t0,0xb400 */
>> +    stl_p(p++, 0x350803f8);                  /* ori t0,t0,0x3f8 */
>> +    stl_p(p++, 0x91090005);                  /* lbu t1,5(t0) */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>> +    stl_p(p++, 0x31290040);                  /* andi t1,t1,0x40 */
>> +    stl_p(p++, 0x1120fffc);                  /* beqz t1,878 <outch+0x8>
>> */
>> +    stl_p(p++, 0x00000000);                  /* nop */
>> +    stl_p(p++, 0x03e00009);                  /* jalr ra */
>> +    stl_p(p++, 0xa1040000);                  /* sb a0,0(t0) */
>>
>
> Are you planning to move/rename this file? Telling this now would justify
> your cleanup.
>
>
Planing or not planing, this hunk improves code visibility, looks good to
me.



>     }
>>   diff --git a/tests/acceptance/linux_ssh_mips_malta.py
>> b/tests/acceptance/linux_ssh_mips_malta.py
>> index fc13f9e..44e1118 100644
>> --- a/tests/acceptance/linux_ssh_mips_malta.py
>> +++ b/tests/acceptance/linux_ssh_mips_malta.py
>> @@ -99,10 +99,12 @@ class LinuxSSH(Test):
>>       def ssh_command(self, command, is_root=3DTrue):
>>           self.ssh_logger.info(command)
>>           result =3D self.ssh_session.cmd(command)
>> -        stdout_lines =3D [line.rstrip() for line in
>> result.stdout_text.splitlines()]
>> +        stdout_lines =3D [line.rstrip() for line
>> +        in result.stdout_text.splitlines()]
>>
>
> I think QEMU Python coding style is to align below the opening bracket.
>
>           for line in stdout_lines:
>>               self.ssh_logger.info(line)
>> -        stderr_lines =3D [line.rstrip() for line in
>> result.stderr_text.splitlines()]
>> +        stderr_lines =3D [line.rstrip() for line
>> +        in result.stderr_text.splitlines()]
>>           for line in stderr_lines:
>>               self.ssh_logger.warning(line)
>>           return stdout_lines, stderr_lines
>>
>>
>
>

--00000000000075e070059904bbf5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBTdW5kYXksIERlY2VtYmVyIDEsIDIwMTksIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpICZsdDs8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iPnBoaWxtZEByZWRoYXQu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPkhpIEZpbGlwLDxicj4NCjxicj4NCk9uIDExLzI1LzE5IDI6MDQgUE0sIEZpbGlw
IEJvenV0YSB3cm90ZTo8YnI+DQo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij4NClRoZSBzY3JpcHQgPGEgaHJlZj0iaHR0cDovL2NoZWNrcGF0Y2gucGwiIHRhcmdl
dD0iX2JsYW5rIj5jaGVja3BhdGNoLnBsPC9hPiBsb2NhdGVkIGluIHNjcmlwdHMgZm9sZGVyIHdh
czxicj4NCnVzZWQgdG8gZGV0ZWN0IGFsbCBlcnJvcnMgYW5kIHdhcnJuaW5ncyBpbiBmaWxlczo8
YnI+DQrCoCDCoCDCoGh3L21pcHMvbWlwc19tYWx0YS5jPGJyPg0KwqAgwqAgwqBody9taXBzL2d0
NjR4eHhfcGNpLmM8YnI+DQrCoCDCoCDCoHRlc3RzL2FjY2VwdGFuY2UvbGludXhfc3NoX21pPHdi
cj5wc19tYWx0YS5weTxicj4NCjxicj4NCkFsbCB0aGVzZSBtaXBzIG1hbHRhIG1hY2hpbmUgZmls
ZXMgd2VyZSBlZGl0ZWQgYW5kPGJyPg0KYWxsIHRoZSBlcnJvcnMgYW5kIHdhcnJpbmdzIGdlbmVy
YXRlZCBieSB0aGUgPGEgaHJlZj0iaHR0cDovL2NoZWNrcGF0Y2gucGwiIHRhcmdldD0iX2JsYW5r
Ij5jaGVja3BhdGNoLnBsPC9hPjxicj4NCnNjcmlwdCB3ZXJlIGNvcnJlY3RlZCBhbmQgdGhlbiB0
aGUgc2NyaXB0IHdhczxicj4NCnJhbiBhZ2FpbiB0byBtYWtlIHN1cmUgdGhlcmUgYXJlIG5vIG1v
cmUgZXJyb3JzIGFuZCB3YXJuaW5ncy48YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBGaWxpcCBC
b3p1dGEgJmx0OzxhIGhyZWY9Im1haWx0bzpGaWxpcC5Cb3p1dGFAcnQtcmsuY29tIiB0YXJnZXQ9
Il9ibGFuayI+RmlsaXAuQm96dXRhQHJ0LXJrLmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqAg
aHcvbWlwcy9taXBzX21hbHRhLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTM5
ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLTx3YnI+LTxicj4NCsKgIHRlc3RzL2FjY2Vw
dGFuY2UvbGludXhfc3NoX21pcDx3YnI+c19tYWx0YS5weSB8wqAgwqA2ICstPGJyPg0KwqAgMiBm
aWxlcyBjaGFuZ2VkLCA3NSBpbnNlcnRpb25zKCspLCA3MCBkZWxldGlvbnMoLSk8YnI+DQo8YnI+
DQpkaWZmIC0tZ2l0IGEvaHcvbWlwcy9taXBzX21hbHRhLmMgYi9ody9taXBzL21pcHNfbWFsdGEu
Yzxicj4NCmluZGV4IDkyZTljYTUuLjE4ZWFmYWMgMTAwNjQ0PGJyPg0KLS0tIGEvaHcvbWlwcy9t
aXBzX21hbHRhLmM8YnI+DQorKysgYi9ody9taXBzL21pcHNfbWFsdGEuYzxicj4NCkBAIC0xMzcs
NyArMTM3LDggQEAgc3RhdGljIHZvaWQgbWFsdGFfZnBnYV91cGRhdGVfZGlzcGxheSh2b2lkICpv
cGFxdWUpPGJyPg0KwqAgwqAqLzxicj4NCsKgIMKgICNpZiBkZWZpbmVkKERFQlVHKTxicj4NCi0j
wqAgZGVmaW5lIGxvZ291dChmbXQsIC4uLikgZnByaW50ZihzdGRlcnIsICZxdW90O01BTFRBXHQl
LTI0cyZxdW90OyBmbXQsIF9fZnVuY19fLCAjIyBfX1ZBX0FSR1NfXyk8YnI+DQorI8KgIGRlZmlu
ZSBsb2dvdXQoZm10LCAuLi4pIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIs
ICZxdW90O01BTFRBXHQlLTI0cyZxdW90OyBmbXQsIF9fZnVuY19fLCAjIyBfX1ZBX0FSR1NfXyk8
YnI+DQo8L2Jsb2NrcXVvdGU+DQo8YnI+DQpUaGlzIGlzIGRlcHJlY2F0ZWQgY29kZSwgaWYgeW91
IGxvb2sgaW4gdGhlIHJlcG9zaXRvcnkgaGlzdG9yeSwgd2UgdXN1YWxseSBkb24mIzM5O3QgdG91
Y2ggaXQsIGV4Y2VwdCB0byBnZXQgcmlkIG9mIGl0LiBUaGUgd2F5IHRvIGdldCByaWQgb2YgaXQg
aXMgdG8gcmVwbGFjZSB0aGUgY2FsbHMgYnkgdHJhY2UgZXZlbnRzLjxicj4NCjxicj48L2Jsb2Nr
cXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5Db2RlIG11c3QgYmUgcmVhZCwgd2hhdGV2ZXIgaXRz
IGhpc3Rvcnkgb3IgZGVzdGlueSBpcy4gSWYgc2xhdGVkIGZvciByZWZhY3RvcmluZywgb25lIHJl
YXNvbiBtb3JlIHRvIGJlIHZpc2libGUgaW4gbGVzcyB0aGFuIDgwIGNvbHVtbnMuIFRoaXMgaHVu
ayBpbXByb3ZlcyBjb2RlIHZpc2liaWxpdHksIGNsZWFybHkgc2VwYXJhdGVzIHR3byBwYXJ0cyBv
ZiBhIG1hY3JvLCBhbmQgaXMgZmluZSB0byBtZS48L2Rpdj48ZGl2PsKgPGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KPGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQrCoCAjZWxzZTxicj4NCsKgICPCoCBkZWZp
bmUgbG9nb3V0KGZtdCwgLi4uKSAoKHZvaWQpMCk8YnI+DQrCoCAjZW5kaWY8YnI+DQpAQCAtNTY5
LDcgKzU3MCw3IEBAIHN0YXRpYyBNYWx0YUZQR0FTdGF0ZSAqbWFsdGFfZnBnYV9pbml0KE1lbW9y
eVJlZ2lvbiAqYWRkcmVzc19zcGFjZSw8YnI+DQrCoCDCoCDCoCBNYWx0YUZQR0FTdGF0ZSAqczs8
YnI+DQrCoCDCoCDCoCBDaGFyZGV2ICpjaHI7PGJyPg0KwqAgLcKgIMKgIHMgPSAoTWFsdGFGUEdB
U3RhdGUgKilnX21hbGxvYzAoc2l6ZW9mKE1hbHRhRlBHQVN0PHdicj5hdGUpKTs8YnI+DQorwqAg
wqAgcyA9IChNYWx0YUZQR0FTdGF0ZSAqKWdfbmV3MChzaXplb2YoTWFsdGFGUEdBU3RhdGU8d2Jy
PikpOzxicj4NCjwvYmxvY2txdW90ZT4NCjxicj4NClRoaXMgY2hhbmdlIGRvZXNuJiMzOTt0IGV2
ZW4gY29tcGlsZS4uLiBQbGVhc2UgY29tcGlsZSB5b3VyIHBhdGNoZXMgYmVmb3JlIHBvc3Rpbmcg
dGhlbSB0byB0aGUgbGlzdC48YnI+DQo8YnI+DQpZb3UgY2FuIGZpbmQgdGhlIHByb3RvdHlwZSBv
ZiB0aGlzIG1hY3JvIGhlcmU6PGJyPg0KPGEgaHJlZj0iaHR0cHM6Ly9kZXZlbG9wZXIuZ25vbWUu
b3JnL2dsaWIvc3RhYmxlL2dsaWItTWVtb3J5LUFsbG9jYXRpb24uaHRtbCNnLW5ldzAiIHRhcmdl
dD0iX2JsYW5rIj5odHRwczovL2RldmVsb3Blci5nbm9tZS5vcmcvZ2w8d2JyPmliL3N0YWJsZS9n
bGliLU1lbW9yeS1BbGxvY2F0aTx3YnI+b24uaHRtbCNnLW5ldzA8L2E+PGJyPg0KPGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoaXMgbXVzdCBiZSBmaXhlZC4gRmlsaXAsIHlv
dSBuZWVkIHRvIHNlbmQgdjIgd2l0aCB0aGUgZml4IGZvciBidWlsZCBlcnJvciBhbmQgb3RoZXIg
aW1wcm92ZW1lbnRzIGFza2VkIGluIHJlcGxpZXMgdG8gdGhpcyBzZXJpZXMuPC9kaXY+PGRpdj7C
oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KPGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQrCoCDCoCDCoCDCoCBt
ZW1vcnlfcmVnaW9uX2luaXRfaW8oJmFtcDtzLSZndDtpb21lPHdicj5tLCBOVUxMLCAmYW1wO21h
bHRhX2ZwZ2Ffb3BzLCBzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICZxdW90O21hbHRhLWZwZ2EmcXVvdDssIDB4MTAwMDAwKTs8YnI+DQpAQCAtODQ0LDkg
Kzg0NSw5IEBAIHN0YXRpYyB2b2lkIHdyaXRlX2Jvb3Rsb2FkZXIodWludDhfdCAqYmFzZSwgaW50
NjRfdCBydW5fYWRkciw8YnI+DQrCoCDCoCDCoCAvKiBTbWFsbCBib290bG9hZGVyICovPGJyPg0K
wqAgwqAgwqAgcCA9ICh1aW50MzJfdCAqKWJhc2U7PGJyPg0KwqAgLcKgIMKgIHN0bF9wKHArKywg
MHgwODAwMDAwMCB8wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLyogaiAweDFmYzAwNTgwICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgw
ODAwMDAwMCB8wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAvKiBqIDB4MWZjMDA1ODAgKi88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCgocnVuX2FkZHIgKyAweDU4MCkgJmFtcDsgMHgwZmZmZmZmZikgJmd0OyZndDsgMik7PGJyPg0K
LcKgIMKgIHN0bF9wKHArKywgMHgwMDAwMDAwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbm9wICovPGJyPg0KK8KgIMKgIHN0bF9w
KHArKywgMHgwMDAwMDAwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAvKiBub3AgKi88YnI+DQrCoCDCoCDCoCDCoCAvKiBZQU1PTiBzZXJ2aWNl
IHZlY3RvciAqLzxicj4NCsKgIMKgIMKgIHN0bF9wKGJhc2UgKyAweDUwMCwgcnVuX2FkZHIgKyAw
eDA1ODApO8KgIMKgIMKgIC8qIHN0YXJ0OiAqLzxicj4NCkBAIC04OTIsMTA0ICs4OTMsMTA2IEBA
IHN0YXRpYyB2b2lkIHdyaXRlX2Jvb3Rsb2FkZXIodWludDhfdCAqYmFzZSwgaW50NjRfdCBydW5f
YWRkciw8YnI+DQrCoCDCoCDCoCBzdGxfcChwKyssIDB4MzRlNzAwMDAgfCAobG9hZGVycGFyYW1z
LnJhbV9sb3dfc2l6ZSAmYW1wOyAweGZmZmYpKTs8YnI+DQrCoCDCoCDCoCDCoCAvKiBMb2FkIEJB
UiByZWdpc3RlcnMgYXMgZG9uZSBieSBZQU1PTiAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4
M2MwOWI0MDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIC8qIGx1aSB0MSwgMHhiNDAwICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgz
YzA5YjQwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBsdWkgdDEsIDB4YjQwMCAqLzxi
cj4NCsKgIMKgICNpZmRlZiBUQVJHRVRfV09SRFNfQklHRU5ESUFOPGJyPg0KLcKgIMKgIHN0bF9w
KHArKywgMHgzYzA4ZGYwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgLyogbHVpIHQwLCAweGRmMDAgKi88YnI+DQorwqAgwqAgc3RsX3Ao
cCsrLCAweDNjMDhkZjAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBsdWkgdDAsIDB4
ZGYwMCAqLzxicj4NCsKgICNlbHNlPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgzNDA4MDBkZik7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Lyogb3JpIHQwLCByMCwgMHgwMGRmICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgzNDA4MDBk
Zik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogb3JpIHQwLCByMCwgMHgwMGRmICovPGJy
Pg0KwqAgI2VuZGlmPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHhhZDI4MDA2OCk7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogc3cgdDAs
IDB4MDA2OCh0MSkgKi88YnI+DQorwqAgwqAgc3RsX3AocCsrLCAweGFkMjgwMDY4KTvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBzdyB0MCwgMHgwMDY4KHQxKSAqLzxicj4NCsKgIC3CoCDC
oCBzdGxfcChwKyssIDB4M2MwOWJiZTApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGx1aSB0MSwgMHhiYmUwICovPGJyPg0KK8KgIMKg
IHN0bF9wKHArKywgMHgzYzA5YmJlMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbHVp
IHQxLCAweGJiZTAgKi88YnI+DQrCoCDCoCAjaWZkZWYgVEFSR0VUX1dPUkRTX0JJR0VORElBTjxi
cj4NCi3CoCDCoCBzdGxfcChwKyssIDB4M2MwOGMwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGx1aSB0MCwgMHhjMDAwICovPGJy
Pg0KK8KgIMKgIHN0bF9wKHArKywgMHgzYzA4YzAwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgLyogbHVpIHQwLCAweGMwMDAgKi88YnI+DQrCoCAjZWxzZTxicj4NCi3CoCDCoCBzdGxfcChw
KyssIDB4MzQwODAwYzApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwgcjAsIDB4MDBjMCAqLzxicj4NCivCoCDCoCBzdGxf
cChwKyssIDB4MzQwODAwYzApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwg
cjAsIDB4MDBjMCAqLzxicj4NCsKgICNlbmRpZjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4YWQy
ODAwNDgpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIC8qIHN3IHQwLCAweDAwNDgodDEpICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHhh
ZDI4MDA0OCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogc3cgdDAsIDB4MDA0OCh0MSkg
Ki88YnI+DQrCoCAjaWZkZWYgVEFSR0VUX1dPUkRTX0JJR0VORElBTjxicj4NCi3CoCDCoCBzdGxf
cChwKyssIDB4M2MwODQwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC8qIGx1aSB0MCwgMHg0MDAwICovPGJyPg0KK8KgIMKgIHN0bF9w
KHArKywgMHgzYzA4NDAwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbHVpIHQwLCAw
eDQwMDAgKi88YnI+DQrCoCAjZWxzZTxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MzQwODAwNDAp
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IC8qIG9yaSB0MCwgcjAsIDB4MDA0MCAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MzQwODAw
NDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwgcjAsIDB4MDA0MCAqLzxi
cj4NCsKgICNlbmRpZjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4YWQyODAwNTApO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIHN3IHQw
LCAweDAwNTAodDEpICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHhhZDI4MDA1MCk7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogc3cgdDAsIDB4MDA1MCh0MSkgKi88YnI+DQrCoCDCoCAj
aWZkZWYgVEFSR0VUX1dPUkRTX0JJR0VORElBTjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4M2Mw
ODgwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIC8qIGx1aSB0MCwgMHg4MDAwICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgzYzA4
ODAwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbHVpIHQwLCAweDgwMDAgKi88YnI+
DQrCoCAjZWxzZTxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MzQwODAwODApO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwg
cjAsIDB4MDA4MCAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MzQwODAwODApO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwgcjAsIDB4MDA4MCAqLzxicj4NCsKgICNlbmRp
Zjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4YWQyODAwNTgpO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIHN3IHQwLCAweDAwNTgodDEp
ICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHhhZDI4MDA1OCk7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgLyogc3cgdDAsIDB4MDA1OCh0MSkgKi88YnI+DQrCoCAjaWZkZWYgVEFSR0VUX1dP
UkRTX0JJR0VORElBTjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4M2MwODNmMDApO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGx1aSB0
MCwgMHgzZjAwICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgzYzA4M2YwMCk7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgLyogbHVpIHQwLCAweDNmMDAgKi88YnI+DQrCoCAjZWxzZTxicj4N
Ci3CoCDCoCBzdGxfcChwKyssIDB4MzQwODAwM2YpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwgcjAsIDB4MDAzZiAqLzxi
cj4NCivCoCDCoCBzdGxfcChwKyssIDB4MzQwODAwM2YpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC8qIG9yaSB0MCwgcjAsIDB4MDAzZiAqLzxicj4NCsKgICNlbmRpZjxicj4NCi3CoCDCoCBz
dGxfcChwKyssIDB4YWQyODAwNjApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIHN3IHQwLCAweDAwNjAodDEpICovPGJyPg0KK8KgIMKg
IHN0bF9wKHArKywgMHhhZDI4MDA2MCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogc3cg
dDAsIDB4MDA2MCh0MSkgKi88YnI+DQrCoCDCoCAjaWZkZWYgVEFSR0VUX1dPUkRTX0JJR0VORElB
Tjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4M2MwOGMxMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGx1aSB0MCwgMHhjMTAwICov
PGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgzYzA4YzEwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgLyogbHVpIHQwLCAweGMxMDAgKi88YnI+DQrCoCAjZWxzZTxicj4NCi3CoCDCoCBzdGxf
cChwKyssIDB4MzQwODAwYzEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwgcjAsIDB4MDBjMSAqLzxicj4NCivCoCDCoCBz
dGxfcChwKyssIDB4MzQwODAwYzEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0
MCwgcjAsIDB4MDBjMSAqLzxicj4NCsKgICNlbmRpZjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4
YWQyODAwODApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIC8qIHN3IHQwLCAweDAwODAodDEpICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywg
MHhhZDI4MDA4MCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogc3cgdDAsIDB4MDA4MCh0
MSkgKi88YnI+DQrCoCAjaWZkZWYgVEFSR0VUX1dPUkRTX0JJR0VORElBTjxicj4NCi3CoCDCoCBz
dGxfcChwKyssIDB4M2MwODVlMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGx1aSB0MCwgMHg1ZTAwICovPGJyPg0KK8KgIMKgIHN0
bF9wKHArKywgMHgzYzA4NWUwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbHVpIHQw
LCAweDVlMDAgKi88YnI+DQrCoCAjZWxzZTxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MzQwODAw
NWUpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC8qIG9yaSB0MCwgcjAsIDB4MDA1ZSAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MzQw
ODAwNWUpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG9yaSB0MCwgcjAsIDB4MDA1ZSAq
Lzxicj4NCsKgICNlbmRpZjxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4YWQyODAwODgpO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIHN3
IHQwLCAweDAwODgodDEpICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHhhZDI4MDA4OCk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogc3cgdDAsIDB4MDA4OCh0MSkgKi88YnI+DQrCoCDC
oCDCoCDCoCAvKiBKdW1wIHRvIGtlcm5lbCBjb2RlICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywg
MHgzYzFmMDAwMCB8ICgoa2VybmVsX2VudHJ5ICZndDsmZ3Q7IDE2KSAmYW1wOyAweGZmZmYpKTvC
oCDCoCAvKiBsdWkgcmEsIGhpZ2goa2VybmVsX2VudHJ5KSAqLzxicj4NCi3CoCDCoCBzdGxfcChw
KyssIDB4MzdmZjAwMDAgfCAoa2VybmVsX2VudHJ5ICZhbXA7IDB4ZmZmZikpO8KgIMKgIMKgIMKg
IMKgIMKgIC8qIG9yaSByYSwgcmEsIGxvdyhrZXJuZWxfZW50cnkpICovPGJyPg0KLcKgIMKgIHN0
bF9wKHArKywgMHgwM2UwMDAwOSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogamFsciByYSAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyss
IDB4MDAwMDAwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIC8qIG5vcCAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4M2MxZjAwMDAg
fDxicj4NCivCoCDCoCDCoCDCoCDCoCAoKGtlcm5lbF9lbnRyeSAmZ3Q7Jmd0OyAxNikgJmFtcDsg
MHhmZmZmKSk7wqAgLyogbHVpIHJhLCBoaWdoKGtlcm5lbF9lbnRyeSkgKi88YnI+DQorwqAgwqAg
c3RsX3AocCsrLCAweDM3ZmYwMDAwIHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgKGtlcm5lbF9lbnRy
eSAmYW1wOyAweGZmZmYpKTvCoCDCoCDCoCDCoCDCoCAvKiBvcmkgcmEsIHJhLCBsb3coa2VybmVs
X2VudHJ5KSAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MDNlMDAwMDkpO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIC8qIGphbHIgcmEgKi88YnI+DQorwqAgwqAgc3RsX3AocCsrLCAweDAw
MDAwMDAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBub3AgKi88YnI+DQrCoCDCoCDC
oCDCoCAvKiBZQU1PTiBzdWJyb3V0aW5lcyAqLzxicj4NCsKgIMKgIMKgIHAgPSAodWludDMyX3Qg
KikgKGJhc2UgKyAweDgwMCk7PGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgwM2UwMDAwOSk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBq
YWxyIHJhICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgyNDAyMDAwMCk7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBsaSB2MCwwICov
PGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwM2UwMDAwOSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgLyogamFsciByYSAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MjQwMjAwMDApO8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGxpIHYwLDAgKi88YnI+DQrCoCDCoCDCoCAvKiA4
MDggWUFNT04gcHJpbnQgKi88YnI+DQotwqAgwqAgc3RsX3AocCsrLCAweDAzZTA2ODIxKTvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIG1v
dmUgdDUscmEgKi88YnI+DQotwqAgwqAgc3RsX3AocCsrLCAweDAwODA1ODIxKTvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIG1vdmUgdDMs
YTAgKi88YnI+DQotwqAgwqAgc3RsX3AocCsrLCAweDAwYTA1MDIxKTvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIG1vdmUgdDIsYTEgKi88
YnI+DQotwqAgwqAgc3RsX3AocCsrLCAweDkxNDQwMDAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGxidSBhMCwwKHQyKSAqLzxicj4N
Ci3CoCDCoCBzdGxfcChwKyssIDB4MjU0YTAwMDEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogYWRkaXUgdDIsdDIsMSAqLzxicj4NCi3C
oCDCoCBzdGxfcChwKyssIDB4MTA4MDAwMDUpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogYmVxeiBhMCw4MzQgKi88YnI+DQotwqAgwqAg
c3RsX3AocCsrLCAweDAwMDAwMDAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIG5vcCAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4
MGZmMDAyMWMpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgLyogamFsIDg3MCAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MDAwMDAwMDAp
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Lyogbm9wICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgxMDAwZmZmOSk7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBiIDgxNCAqLzxi
cj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MDAwMDAwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogbm9wICovPGJyPg0KLcKgIMKgIHN0
bF9wKHArKywgMHgwMWEwMDAwOSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBqYWxyIHQ1ICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywg
MHgwMTYwMjAyMSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAvKiBtb3ZlIGEwLHQzICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwM2Uw
NjgyMSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbW92ZSB0NSxyYSAqLzxicj4NCivC
oCDCoCBzdGxfcChwKyssIDB4MDA4MDU4MjEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8q
IG1vdmUgdDMsYTAgKi88YnI+DQorwqAgwqAgc3RsX3AocCsrLCAweDAwYTA1MDIxKTvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBtb3ZlIHQyLGExICovPGJyPg0KK8KgIMKgIHN0bF9wKHAr
KywgMHg5MTQ0MDAwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbGJ1IGEwLDAodDIp
ICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgyNTRhMDAwMSk7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgLyogYWRkaXUgdDIsdDIsMSAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MTA4
MDAwMDUpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGJlcXogYTAsODM0ICovPGJyPg0K
K8KgIMKgIHN0bF9wKHArKywgMHgwMDAwMDAwMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Lyogbm9wICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwZmYwMDIxYyk7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgLyogamFsIDg3MCAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MDAw
MDAwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG5vcCAqLzxicj4NCivCoCDCoCBz
dGxfcChwKyssIDB4MTAwMGZmZjkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGIgODE0
ICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwMDAwMDAwMCk7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgLyogbm9wICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwMWEwMDAwOSk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogamFsciB0NSAqLzxicj4NCivCoCDCoCBzdGxfcChw
KyssIDB4MDE2MDIwMjEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG1vdmUgYTAsdDMg
Ki88YnI+DQrCoCDCoCDCoCAvKiAweDgzYyBZQU1PTiBwcmludF9jb3VudCAqLzxicj4NCi3CoCDC
oCBzdGxfcChwKyssIDB4MDNlMDY4MjEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogbW92ZSB0NSxyYSAqLzxicj4NCi3CoCDCoCBzdGxf
cChwKyssIDB4MDA4MDU4MjEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLyogbW92ZSB0MyxhMCAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyss
IDB4MDBhMDUwMjEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLyogbW92ZSB0MixhMSAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MDBj
MDYwMjEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLyogbW92ZSB0NCxhMiAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4OTE0NDAwMDAp
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
LyogbGJ1IGEwLDAodDIpICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgwZmYwMDIxYyk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBq
YWwgODcwICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgwMDAwMDAwMCk7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBub3AgKi88YnI+
DQotwqAgwqAgc3RsX3AocCsrLCAweDI1NGEwMDAxKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGFkZGl1IHQyLHQyLDEgKi88YnI+DQot
wqAgwqAgc3RsX3AocCsrLCAweDI1OGNmZmZmKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGFkZGl1IHQ0LHQ0LC0xICovPGJyPg0KLcKg
IMKgIHN0bF9wKHArKywgMHgxNTgwZmZmYSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBibmV6IHQ0LDg0YyAqLzxicj4NCi3CoCDCoCBz
dGxfcChwKyssIDB4MDAwMDAwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogbm9wICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgw
MWEwMDAwOSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAvKiBqYWxyIHQ1ICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgwMTYwMjAyMSk7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAv
KiBtb3ZlIGEwLHQzICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwM2UwNjgyMSk7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbW92ZSB0NSxyYSAqLzxicj4NCivCoCDCoCBzdGxfcChw
KyssIDB4MDA4MDU4MjEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG1vdmUgdDMsYTAg
Ki88YnI+DQorwqAgwqAgc3RsX3AocCsrLCAweDAwYTA1MDIxKTvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAvKiBtb3ZlIHQyLGExICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwMGMwNjAy
MSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbW92ZSB0NCxhMiAqLzxicj4NCivCoCDC
oCBzdGxfcChwKyssIDB4OTE0NDAwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGxi
dSBhMCwwKHQyKSAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MGZmMDAyMWMpO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC8qIGphbCA4NzAgKi88YnI+DQorwqAgwqAgc3RsX3AocCsrLCAw
eDAwMDAwMDAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBub3AgKi88YnI+DQorwqAg
wqAgc3RsX3AocCsrLCAweDI1NGEwMDAxKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBh
ZGRpdSB0Mix0MiwxICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgyNThjZmZmZik7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogYWRkaXUgdDQsdDQsLTEgKi88YnI+DQorwqAgwqAgc3Rs
X3AocCsrLCAweDE1ODBmZmZhKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBibmV6IHQ0
LDg0YyAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MDAwMDAwMDApO8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIC8qIG5vcCAqLzxicj4NCivCoCDCoCBzdGxfcChwKyssIDB4MDFhMDAwMDkp
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIGphbHIgdDUgKi88YnI+DQorwqAgwqAgc3Rs
X3AocCsrLCAweDAxNjAyMDIxKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBtb3ZlIGEw
LHQzICovPGJyPg0KwqAgwqAgwqAgLyogMHg4NzAgKi88YnI+DQotwqAgwqAgc3RsX3AocCsrLCAw
eDNjMDhiODAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoC8qIGx1aSB0MCwweGI0MDAgKi88YnI+DQotwqAgwqAgc3RsX3AocCsrLCAweDM1
MDgwM2Y4KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC8qIG9yaSB0MCx0MCwweDNmOCAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4OTEw
OTAwMDUpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLyogbGJ1IHQxLDUodDApICovPGJyPg0KLcKgIMKgIHN0bF9wKHArKywgMHgwMDAwMDAw
MCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAvKiBub3AgKi88YnI+DQotwqAgwqAgc3RsX3AocCsrLCAweDMxMjkwMDQwKTvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGFuZGkgdDEs
dDEsMHg0MCAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MTEyMGZmZmMpO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogYmVxeiB0MSw4
NzggJmx0O291dGNoKzB4OCZndDsgKi88YnI+DQotwqAgwqAgc3RsX3AocCsrLCAweDAwMDAwMDAw
KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oC8qIG5vcCAqLzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4MDNlMDAwMDkpO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogamFsciByYSAq
Lzxicj4NCi3CoCDCoCBzdGxfcChwKyssIDB4YTEwNDAwMDApO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogc2IgYTAsMCh0MCkgKi88YnI+
DQorwqAgwqAgc3RsX3AocCsrLCAweDNjMDhiODAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAvKiBsdWkgdDAsMHhiNDAwICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgzNTA4MDNmOCk7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogb3JpIHQwLHQwLDB4M2Y4ICovPGJyPg0KK8Kg
IMKgIHN0bF9wKHArKywgMHg5MTA5MDAwNSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyog
bGJ1IHQxLDUodDApICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgwMDAwMDAwMCk7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogbm9wICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgz
MTI5MDA0MCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogYW5kaSB0MSx0MSwweDQwICov
PGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHgxMTIwZmZmYyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgLyogYmVxeiB0MSw4NzggJmx0O291dGNoKzB4OCZndDsgKi88YnI+DQorwqAgwqAgc3Rs
X3AocCsrLCAweDAwMDAwMDAwKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBub3AgKi88
YnI+DQorwqAgwqAgc3RsX3AocCsrLCAweDAzZTAwMDA5KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAvKiBqYWxyIHJhICovPGJyPg0KK8KgIMKgIHN0bF9wKHArKywgMHhhMTA0MDAwMCk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogc2IgYTAsMCh0MCkgKi88YnI+DQo8L2Jsb2NrcXVv
dGU+DQo8YnI+DQpBcmUgeW91IHBsYW5uaW5nIHRvIG1vdmUvcmVuYW1lIHRoaXMgZmlsZT8gVGVs
bGluZyB0aGlzIG5vdyB3b3VsZCBqdXN0aWZ5IHlvdXIgY2xlYW51cC48YnI+DQo8YnI+PC9ibG9j
a3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+UGxhbmluZyBvciBub3QgcGxhbmluZywgdGhpcyBo
dW5rIGltcHJvdmVzIGNvZGUgdmlzaWJpbGl0eSwgbG9va3MgZ29vZCB0byBtZS48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+DQo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4NCsKgIMKgIH08YnI+DQrCoCBkaWZmIC0tZ2l0IGEvdGVzdHMvYWNjZXB0YW5jZS9saW51eF9z
c2hfbTx3YnI+aXBzX21hbHRhLnB5IGIvdGVzdHMvYWNjZXB0YW5jZS9saW51eF9zc2hfbTx3YnI+
aXBzX21hbHRhLnB5PGJyPg0KaW5kZXggZmMxM2Y5ZS4uNDRlMTExOCAxMDA2NDQ8YnI+DQotLS0g
YS90ZXN0cy9hY2NlcHRhbmNlL2xpbnV4X3NzaF9tPHdicj5pcHNfbWFsdGEucHk8YnI+DQorKysg
Yi90ZXN0cy9hY2NlcHRhbmNlL2xpbnV4X3NzaF9tPHdicj5pcHNfbWFsdGEucHk8YnI+DQpAQCAt
OTksMTAgKzk5LDEyIEBAIGNsYXNzIExpbnV4U1NIKFRlc3QpOjxicj4NCsKgIMKgIMKgIGRlZiBz
c2hfY29tbWFuZChzZWxmLCBjb21tYW5kLCBpc19yb290PVRydWUpOjxicj4NCsKgIMKgIMKgIMKg
IMKgIDxhIGhyZWY9Imh0dHA6Ly9zZWxmLnNzaF9sb2dnZXIuaW5mbyIgdGFyZ2V0PSJfYmxhbmsi
PnNlbGYuc3NoX2xvZ2dlci5pbmZvPC9hPihjb21tYW5kKTxicj4NCsKgIMKgIMKgIMKgIMKgIHJl
c3VsdCA9IHNlbGYuc3NoX3Nlc3Npb24uY21kKGNvbW1hbmQpPGJyPg0KLcKgIMKgIMKgIMKgIHN0
ZG91dF9saW5lcyA9IFtsaW5lLnJzdHJpcCgpIGZvciBsaW5lIGluIHJlc3VsdC5zdGRvdXRfdGV4
dC5zcGxpdGxpbmVzKDx3YnI+KV08YnI+DQorwqAgwqAgwqAgwqAgc3Rkb3V0X2xpbmVzID0gW2xp
bmUucnN0cmlwKCkgZm9yIGxpbmU8YnI+DQorwqAgwqAgwqAgwqAgaW4gcmVzdWx0LnN0ZG91dF90
ZXh0LnNwbGl0bGluZXMoPHdicj4pXTxicj4NCjwvYmxvY2txdW90ZT4NCjxicj4NCkkgdGhpbmsg
UUVNVSBQeXRob24gY29kaW5nIHN0eWxlIGlzIHRvIGFsaWduIGJlbG93IHRoZSBvcGVuaW5nIGJy
YWNrZXQuPGJyPg0KPGJyPg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+DQrCoCDCoCDCoCDCoCDCoCBmb3IgbGluZSBpbiBzdGRvdXRfbGluZXM6PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgPGEgaHJlZj0iaHR0cDovL3NlbGYuc3NoX2xvZ2dlci5pbmZvIiB0
YXJnZXQ9Il9ibGFuayI+c2VsZi5zc2hfbG9nZ2VyLmluZm88L2E+KGxpbmUpPGJyPg0KLcKgIMKg
IMKgIMKgIHN0ZGVycl9saW5lcyA9IFtsaW5lLnJzdHJpcCgpIGZvciBsaW5lIGluIHJlc3VsdC5z
dGRlcnJfdGV4dC5zcGxpdGxpbmVzKDx3YnI+KV08YnI+DQorwqAgwqAgwqAgwqAgc3RkZXJyX2xp
bmVzID0gW2xpbmUucnN0cmlwKCkgZm9yIGxpbmU8YnI+DQorwqAgwqAgwqAgwqAgaW4gcmVzdWx0
LnN0ZGVycl90ZXh0LnNwbGl0bGluZXMoPHdicj4pXTxicj4NCsKgIMKgIMKgIMKgIMKgIGZvciBs
aW5lIGluIHN0ZGVycl9saW5lczo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnNzaF9s
b2dnZXIud2FybmluZyhsaW5lKTxicj4NCsKgIMKgIMKgIMKgIMKgIHJldHVybiBzdGRvdXRfbGlu
ZXMsIHN0ZGVycl9saW5lczxicj4NCjxicj4NCjwvYmxvY2txdW90ZT4NCjxicj4NCjxicj4NCjwv
YmxvY2txdW90ZT4NCg==
--00000000000075e070059904bbf5--

