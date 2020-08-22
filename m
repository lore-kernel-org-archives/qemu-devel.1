Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152ACC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 12:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE1820720
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 12:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikk1Ega7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE1820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ShB-0007fR-1G
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 08:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9SgQ-0007F7-4R
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 08:31:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9SgL-00084b-VH
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 08:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598099495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+mXslqVbulcl0bht9RQeTNVl2Xfx6SPn+lTtFneRWPo=;
 b=ikk1Ega7aUIlK2l0wmwaflSLCfz5CUBZp5KnaBGkDR1N4XhMRNC234vdX1+sWiiT+aghzJ
 DcLTuQKd8PbNPf2fWzs1mmNBxPn1UGG/xx7P2mUlOWw/ohaFV9F1jj4lkw+N8r5rdV1Ex9
 XXY7+QDR01Ac6m3+12sIG31i3vJjSTE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Z5djyi3ZNAGmYKZofm7XQg-1; Sat, 22 Aug 2020 08:31:33 -0400
X-MC-Unique: Z5djyi3ZNAGmYKZofm7XQg-1
Received: by mail-wr1-f70.google.com with SMTP id t3so1671265wrr.5
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 05:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+mXslqVbulcl0bht9RQeTNVl2Xfx6SPn+lTtFneRWPo=;
 b=sj53N2O3BBCDdI7iuo7urydOp4V5pmKxq/+GuIF0Vh84gm5jDDtxl05eThwNe0Z8HG
 EOynljiX4NUD60N4idv/j2hNKG2yUtbenGtBUxEodnZQSq9d3D0aQFvcwZmID9S2kfXz
 rho3861K+yGCKAAzpiQukDZQpsWJnHhdEkn9LZUEN3o62kLt+bCSIpn1CKFQRepMz0gu
 4yh+tFd3pULUItBqN2mnxlP2IQ4S7jqieSKRDFEaBSYnp0ZIGKqgbZDBES1a4s45sK25
 DkbEzrtjpk8L5uhSr3TXW0V0GQ0G51S52x8rlB+G8ormE2uWIo1mQms0fRCOJUsfkWKZ
 yvIw==
X-Gm-Message-State: AOAM532JF+4EFMfRuqqP6R85r2fYxM2c96JJkvvoWIWkZMXpifPwQ5qL
 V/EY4So3zHJOjeOVC9s+k4c84nb27pvTNdJgEYD52Lm6m9iyvryh5qxQ9hR4xT27HrinSYcGiNU
 wLA4lj0nL02DQlog=
X-Received: by 2002:a1c:e006:: with SMTP id x6mr245139wmg.128.1598099492172;
 Sat, 22 Aug 2020 05:31:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy3LLpM5iH7+dMd8zWI+RP7oPJy06SPxzSzPLlYsz4rCDCgmdBx52XAND33eaNXGkrD8w8UQ==
X-Received: by 2002:a1c:e006:: with SMTP id x6mr245113wmg.128.1598099491897;
 Sat, 22 Aug 2020 05:31:31 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o2sm10352365wrj.21.2020.08.22.05.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 05:31:31 -0700 (PDT)
Subject: Re: [PATCH] ati-vga: Fix checks in ati_2d_blt() to avoid crash
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20200406204029.19559747D5D@zero.eik.bme.hu>
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
Message-ID: <2041026f-7a88-d8f7-8738-968e1394e8c6@redhat.com>
Date: Sat, 22 Aug 2020 14:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200406204029.19559747D5D@zero.eik.bme.hu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 08:31:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 10:34 PM, BALATON Zoltan wrote:
> In some corner cases (that never happen during normal operation but a
> malicious guest could program wrong values) pixman functions were
> called with parameters that result in a crash. Fix this and add more
> checks to disallow such cases.

(Fair) question on IRC. Is this patch fixing CVE-2020-24352?

Public on August 14, 2020

Description

An out-of-bounds memory access flaw was found in the ATI VGA device
implementation of the QEMU emulator. This flaw occurs in the
ati_2d_blt() routine while handling MMIO write operations through the
ati_mm_write() callback. A malicious guest could use this flaw to crash
the QEMU process on the host, resulting in a denial of service.

This points to a BZ#1847385 which is private:

"You are not authorized to access bug #1847385.

Most likely the bug has been restricted for internal development
processes and we cannot grant access."

https://bugzilla.redhat.com/show_bug.cgi?id=1847385

Maybe we could improve the security process, when a CVE embargo
expires, the public statement could point at the commit(s) fixing
the bug.

> 
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>

I'm not sure this is the correct CVE because CVE-2020-24352
is said reported by Yi Ren from the Alibaba Cloud Intelligence
Security Team.

Thanks,

Phil.

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati_2d.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 42e82311eb..23a8ae0cd8 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -53,12 +53,20 @@ void ati_2d_blt(ATIVGAState *s)
>              s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
>              surface_bits_per_pixel(ds),
>              (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> -    int dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                 s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> -    int dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                 s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> +    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> +                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> +    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
>      int bpp = ati_bpp_from_datatype(s);
> +    if (!bpp) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
> +        return;
> +    }
>      int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
> +    if (!dst_stride) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
> +        return;
> +    }
>      uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
>                          s->regs.dst_offset : s->regs.default_offset);
>  
> @@ -82,12 +90,16 @@ void ati_2d_blt(ATIVGAState *s)
>      switch (s->regs.dp_mix & GMC_ROP3_MASK) {
>      case ROP3_SRCCOPY:
>      {
> -        int src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                     s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
> -        int src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                     s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
> +        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> +                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
> +        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
>          int src_stride = DEFAULT_CNTL ?
>                           s->regs.src_pitch : s->regs.default_pitch;
> +        if (!src_stride) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
> +            return;
> +        }
>          uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
>                              s->regs.src_offset : s->regs.default_offset);
>  
> @@ -137,8 +149,10 @@ void ati_2d_blt(ATIVGAState *s)
>                                      dst_y * surface_stride(ds),
>                                      s->regs.dst_height * surface_stride(ds));
>          }
> -        s->regs.dst_x += s->regs.dst_width;
> -        s->regs.dst_y += s->regs.dst_height;
> +        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> +                         dst_x + s->regs.dst_width : dst_x);
> +        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +                         dst_y + s->regs.dst_height : dst_y);
>          break;
>      }
>      case ROP3_PATCOPY:
> @@ -179,7 +193,8 @@ void ati_2d_blt(ATIVGAState *s)
>                                      dst_y * surface_stride(ds),
>                                      s->regs.dst_height * surface_stride(ds));
>          }
> -        s->regs.dst_y += s->regs.dst_height;
> +        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +                         dst_y + s->regs.dst_height : dst_y);
>          break;
>      }
>      default:
> 


