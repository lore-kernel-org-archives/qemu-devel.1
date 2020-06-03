Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D6EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 19:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446272067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 19:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyFinhka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446272067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgYy0-00060D-8W
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 15:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgYxN-0005a2-2B
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 15:21:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgYxK-0005gN-2a
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 15:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591212100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k8285MDWcfyV44Y+XiAljCfZIGlq0RLvlauedL/giG8=;
 b=iyFinhkaI6Czr/2r3lNUldvmW7DsQBooDG8JCtMpdqGRL1MPfNmFrIHIXAi0dCfjKXnmX1
 ARyZz+V5H/ZaJNAtjHfMSvcmEwm4Bl+y+HaNSkVvkHvILGcfx5eFeGK+eiVRTMTyLY0R0c
 VbsJN7HPWyUwW4BK+ietbtCZYfaa3Qs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-fmAbdYt3PHuubowBJw73Gw-1; Wed, 03 Jun 2020 15:21:36 -0400
X-MC-Unique: fmAbdYt3PHuubowBJw73Gw-1
Received: by mail-wm1-f72.google.com with SMTP id g84so1207432wmf.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 12:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=k8285MDWcfyV44Y+XiAljCfZIGlq0RLvlauedL/giG8=;
 b=QpIdZXLJlSSG+3bCKLblk8QtN859gOVUy5MgCnoZcqBRoeTPyGwegkcehezV29Wo4d
 Zjec6syHjPFWjSJxaKaSjMnS497u6I0ruPr30y7TvFxowFdNamxFcH5BX2NQGvG/ph+E
 hjP5EbF2HPWQfj4y7AQ7CZknIAOBypo58udmZqn3X85lCU4x9djTT6oOYpG/hKysDVD7
 TPrPno00vX5s9y3G8vcCSHduYyQGch8vj5b2+qKWzw99Yn9mW8MobgTJPBib7j6XAjql
 7fKOJkCHmEXmYEVb7doMWj8t8PrgowG8j0J6UFr3Nrmcg4N/m/Sb6dIpaxIUDRLPMRsY
 NWCA==
X-Gm-Message-State: AOAM530dy+Yr68+a7VIVsj/bkllXQil6icZ/9BAJcUuoAuW5DnbAgnI5
 Kt5rciZHUAjJwYCe3BjClv7yZZe650GH7SL0Fg5PBnIZlaMRAJkZf95iGs1RIj725yCMfTtMYXp
 sbRD7LQgHih+zxnc=
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr922178wrn.217.1591212095011; 
 Wed, 03 Jun 2020 12:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOh+ILTcnITAoA66vugo6z4CGp3gvPdDG0x5HdA/lz4j/73EiOxR7sdYe9jALwUJSUXQ8nMA==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr922154wrn.217.1591212094803; 
 Wed, 03 Jun 2020 12:21:34 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h15sm4449625wrt.73.2020.06.03.12.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 12:21:34 -0700 (PDT)
Subject: Re: [PATCH v2] ati-vga: check mm_index before recursive call
To: P J P <ppandit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200603185522.1173354-1-ppandit@redhat.com>
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
Message-ID: <796d9032-cbfe-0a2a-b2ce-be8974dc579f@redhat.com>
Date: Wed, 3 Jun 2020 21:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603185522.1173354-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ren Ding <rding@gatech.edu>, Yi Ren <c4tren@gmail.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Hanqing Zhao <hanqing@gatech.edu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 8:55 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While accessing VGA registers via ati_mm_read/write routines,
> a guest may set 's->regs.mm_index' such that it leads to infinite
> recursion. Check mm_index value to avoid it.
> 
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Yi Ren <c4tren@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/ati.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Update v2: add check before recursive call
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00781.html
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 065f197678..bda4a2d816 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -285,7 +285,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>              if (idx <= s->vga.vram_size - size) {
>                  val = ldn_le_p(s->vga.vram_ptr + idx, size);
>              }
> -        } else {
> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>              val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);

We usually log unexpected guest accesses with:

           } else {
               qemu_log_mask(LOG_GUEST_ERROR, ...

>          }
>          break;
> @@ -520,7 +520,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>              if (idx <= s->vga.vram_size - size) {
>                  stn_le_p(s->vga.vram_ptr + idx, size, data);
>              }
> -        } else {
> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>              ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);

Ditto:

           } else {
               qemu_log_mask(LOG_GUEST_ERROR, ...

>          }
>          break;
> 


