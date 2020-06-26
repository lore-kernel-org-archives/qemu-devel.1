Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C5E207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMiwfT1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C5E207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josOX-0000GA-L2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1josNr-0008Cs-5O
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:43:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24588
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1josNp-0001A7-Ft
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593193404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GLH+qjmtdJRiEFR35qzgch+R0KInn1y878pjML2nRfI=;
 b=EMiwfT1iwI85ruLdvzR8ff/2QjZMZ8TT2RXnlKsYILnNk6NAKLJm80Hc9EtC+e4m0hRZt5
 d6nTxhWwsUJ6G/veJMbggUvPAOa8tbdgy+2FGvgEd1bnsWMtJ3GbQvRPIy+2wV+GnEOFeO
 GWNZJBTCHncH6e+2+hvBsVIQnlpmWTc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-QmxZi0PWN7C7ickgqx7D0g-1; Fri, 26 Jun 2020 13:43:20 -0400
X-MC-Unique: QmxZi0PWN7C7ickgqx7D0g-1
Received: by mail-wm1-f70.google.com with SMTP id a21so11771659wmd.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 10:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GLH+qjmtdJRiEFR35qzgch+R0KInn1y878pjML2nRfI=;
 b=m3StZ70Euc5jAACD+ZnYkINEimOnDZz+9dd2oDUtcCyak3VGkB9PqtWH+LPGk5K18h
 MIpaClFH9/z3+orDZBXiYXuBRLFjCyc8HM2goGlphPRbdioPLZdOWJXZOH2rxxuhTrgK
 DG0eNHVvb2y+0Z5Y3E7J3dwYlNwgynt1iGxL1oF3TRwJOrpaFnNQGNJ4Zp6da0U0xQ40
 21clfj9XEoidUIKVDiI/q0tffs+fzSd1R3FkRnqTdPTjUm3N/UsqTKvMCWigM5ijodWD
 FsqInbSQONMg8LdO2/bGcAKESumN7QVF6DC5rLsk+pDyPumv1I9uA9WaIIoq6rgDCDXH
 Ztog==
X-Gm-Message-State: AOAM531Ie+YBEKjOj3XsHHP/nPGDX9jbgKDsJtItYbWZDWeKLDDPPOwV
 NbPvfdWYaoUAsJxQaSU/Sg8hK7jtfBQRd8B5My7PG/m5R15naimAf7yu6PwvbP5G824kq0NkrzG
 7NyBTlMdBeHYVSGM=
X-Received: by 2002:a1c:238d:: with SMTP id j135mr4440511wmj.46.1593193399255; 
 Fri, 26 Jun 2020 10:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8FcXlkV8A5oYF8EkVv9yiHbvLNLZ9iEC9xswAx2RL1TwnCUVXHlFqrc/LTxgl+oMdpmtKbQ==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr4440482wmj.46.1593193398893; 
 Fri, 26 Jun 2020 10:43:18 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s18sm41378236wra.85.2020.06.26.10.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 10:43:18 -0700 (PDT)
Subject: Re: [PATCH v5 08/15] hw/sd/sdcard: Check address is in range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200626164026.766-1-f4bug@amsat.org>
 <20200626164026.766-9-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <001fb1d8-c689-36b9-3d49-31285c82422a@redhat.com>
Date: Fri, 26 Jun 2020 19:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626164026.766-9-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 6:40 PM, Philippe Mathieu-Daudé wrote:
> As a defense, assert if the requested address is out of the card area.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 22392e5084..2689a27b49 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -537,8 +537,10 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
>      stl_be_p(response, sd->vhs);
>  }
>  
> -static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
> +static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
>  {
> +    assert(addr < sd->size);

This should be:

       assert(addr <= sd->size);

> +
>      return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
>  }
>  
> @@ -575,7 +577,7 @@ static void sd_reset(DeviceState *dev)
>      sd_set_cardstatus(sd);
>      sd_set_sdstatus(sd);
>  
> -    sect = sd_addr_to_wpnum(size) + 1;
> +    sect = sd_addr_to_wpnum(sd, size) + 1;
>      g_free(sd->wp_groups);
>      sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
>      sd->wpgrps_size = sect;
> @@ -759,8 +761,8 @@ static void sd_erase(SDState *sd)
>          erase_end *= HWBLOCK_SIZE;
>      }
>  
> -    erase_start = sd_addr_to_wpnum(erase_start);
> -    erase_end = sd_addr_to_wpnum(erase_end);
> +    erase_start = sd_addr_to_wpnum(sd, erase_start);
> +    erase_end = sd_addr_to_wpnum(sd, erase_end);
>      sd->erase_start = 0;
>      sd->erase_end = 0;
>      sd->csd[14] |= 0x40;
> @@ -777,7 +779,7 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
>      uint32_t i, wpnum;
>      uint32_t ret = 0;
>  
> -    wpnum = sd_addr_to_wpnum(addr);
> +    wpnum = sd_addr_to_wpnum(sd, addr);
>  
>      for (i = 0; i < 32; i++, wpnum++, addr += WPGROUP_SIZE) {
>          if (addr < sd->size && test_bit(wpnum, sd->wp_groups)) {
> @@ -819,7 +821,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>  
>  static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
>  {
> -    return test_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
> +    return test_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
>  }
>  
>  static void sd_lock_command(SDState *sd)
> @@ -1331,7 +1333,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              }
>  
>              sd->state = sd_programming_state;
> -            set_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
> +            set_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
>              /* Bzzzzzzztt .... Operation complete.  */
>              sd->state = sd_transfer_state;
>              return sd_r1b;
> @@ -1350,7 +1352,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              }
>  
>              sd->state = sd_programming_state;
> -            clear_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
> +            clear_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
>              /* Bzzzzzzztt .... Operation complete.  */
>              sd->state = sd_transfer_state;
>              return sd_r1b;
> 


