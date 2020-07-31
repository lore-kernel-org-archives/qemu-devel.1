Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A41CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DD32076B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNA3IItI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DD32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1QX7-0005a7-6W
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1QWX-0005AV-0x
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:36:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1QWV-00061s-Ew
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596184574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oDEG79fDhDRzAcZCqctHOaX5gb+KD+rwmokCry5DqLY=;
 b=HNA3IItIQ/KoIDfOjmQn425PACYBQWh3yiMInDBgAvxJU92SuGNz7HojNopC07oahBdbul
 Sp8pgy4V3To8gQxZY4Vwexq8yz73VJeh401BFaK8RxgHDOEcEk5oPcUdjm/N0iTmDi4c37
 wCm5RqEFe8XllyeR6BgGd5iQjWXjcWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-WCdo_LN0MX2tRldJbtV4IA-1; Fri, 31 Jul 2020 04:36:10 -0400
X-MC-Unique: WCdo_LN0MX2tRldJbtV4IA-1
Received: by mail-wm1-f69.google.com with SMTP id z10so3074748wmi.8
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 01:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=K3WIQHLwC0SIoaiXOTsAuLRK3spHhyhAxBQtJiOZycI=;
 b=k5QZUONuZudSbaUKNMtAhbupPxhQSqZBua7vVT1jOgzyyJhuleQ+EFqTMzR8Er2yMl
 Qpq+UOl8BShjDI9LwX+pWHXI6HYeBQjjohgZUY0i48K7mIgRwt3349IUyB4noM3qOUNL
 QmZdYoUyyEhDam7Lv+CRAGC5c02WW2wlZo8lAmIYf9BrWl2+MqQzb2+1n0FtnqZislQy
 XnguNGTCXc03wpLmXYACg70VaZJv33WttLj1e7T6SUajiX5U043cj3UA+XFtshXlhSiE
 3RiI8uZE+hVgdAUUMzdyrUw5KRzFDoxcUFHzGWc88TV4T9WON/m7KV0yefwqXsBb3n1q
 BGdA==
X-Gm-Message-State: AOAM533PwHj/toA3N538Ql9mVhhrX1XfvtvLUgEr62dxpnKHEFZasp8e
 8bYTpi+odve6+4V5+p3Vo3htiG+mHt/EgoamJEysjynFIcA0TQP+VWJCz/b5DbjvXG54jzd5G1j
 jv0qp/Bv3UZfXhVg=
X-Received: by 2002:adf:dd83:: with SMTP id x3mr2705153wrl.292.1596184569605; 
 Fri, 31 Jul 2020 01:36:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcJ1Ay0dhTZ5OJIAD3rEV0OYzJdlCnyp8iqYs3j28fmoKyE+o6M18jEhY8fu0cYIDYAsG5nQ==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr2705144wrl.292.1596184569451; 
 Fri, 31 Jul 2020 01:36:09 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id s20sm11174001wmh.21.2020.07.31.01.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 01:36:08 -0700 (PDT)
Subject: Re: [PATCH] colo-compare: Remove superfluous NULL-pointer checks for
 s->iothread
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <20200731070604.0c981f41@luklap>
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
Message-ID: <a5667c82-71b4-f70b-3d68-121c5407b7b0@redhat.com>
Date: Fri, 31 Jul 2020 10:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200731070604.0c981f41@luklap>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:33:29
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/20 7:06 AM, Lukas Straub wrote:
> s->iothread is checked for NULL on object creation in colo_compare_complete,
> so it's guaranteed not to be NULL.
> This resolves a false alert from Coverity (CID 1429969).
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  net/colo-compare.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index cc15f23dea..2c20de1537 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1442,9 +1442,7 @@ static void colo_compare_finalize(Object *obj)
>          qemu_chr_fe_deinit(&s->chr_notify_dev, false);
>      }
>  
> -    if (s->iothread) {
> -        colo_compare_timer_del(s);
> -    }
> +    colo_compare_timer_del(s);
>  
>      qemu_bh_delete(s->event_bh);
>  
> @@ -1470,9 +1468,7 @@ static void colo_compare_finalize(Object *obj)
>          g_hash_table_destroy(s->connection_track_table);
>      }
>  
> -    if (s->iothread) {
> -        object_unref(OBJECT(s->iothread));
> -    }
> +    object_unref(OBJECT(s->iothread));
>  
>      g_free(s->pri_indev);
>      g_free(s->sec_indev);
> 


