Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3640BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA1920739
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqG4hONh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA1920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKWi-0005Y6-7S
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKW1-00057b-Bv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:34:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKVy-0000hG-WF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594254853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/Kt4dUMzFJfKDDMQUMiGjt500u7YdqYZVIrvMup+M6c=;
 b=CqG4hONhFR+ztXX9edxHnBu35LfodZNDIKLotu+HHIbuLIRXD7VSQ3PYF5jjvKrXSQO0up
 B7n31Y1O9UWpNEJRa27Ve1C8vExwQjpkBeosW9f3gLx/z/9i7AVYZ94l3b2ehZCuxxfqTb
 Bd3Y0W3WUSQ0irCrsRojLVArIpoDp94=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-OZJeysTEMs-_MmHLDkYQrA-1; Wed, 08 Jul 2020 04:30:17 -0400
X-MC-Unique: OZJeysTEMs-_MmHLDkYQrA-1
Received: by mail-wm1-f69.google.com with SMTP id v6so2222196wmg.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 01:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/Kt4dUMzFJfKDDMQUMiGjt500u7YdqYZVIrvMup+M6c=;
 b=sjB5Bnu/CnqxDeBUWB42Y/OPlTg02OChlJ2xiT13/xKxGsvfqitg53q8+gXa+CB+OW
 xbt3hirB1Wec0Qxycos6Nw9yQ4zOY27Ohs1RI1/lEim0pEn7DGvWV2WF+TGf+4VuTxuJ
 HkRfF5qZ/tN5/ilcBH6ginyNS0Yc1+9Dw4n2qBCozAI6aDBtpnYlXV/NBs7ENrLkAa9u
 nEeht6Y10BNygCePqIC069PGRRr3O+DbmU8t83sTu8ylTwKJKck6NiUcz1usqCuh+hu8
 ZRoxLbtTKOGal9xN386EJL7o1klxAk6L9cB9piQLTkkZDz8BCbDHsWJgR8R50SFDAhr4
 rlYQ==
X-Gm-Message-State: AOAM530M3SPq6Ieb7qzU4Gu3ixotAFolchYTNLa0iI5m+zG98H3NiBBS
 8gu1W4u6pvjeYfuSxo1LkmMdKdcWGqECEX4lZXxyYk3JR4o0EDu0kbJ6qTeIB9z7uZJyylYI8CF
 Tc1Zgp/wxfZd9ZlQ=
X-Received: by 2002:a5d:458a:: with SMTP id p10mr56614481wrq.184.1594197016886; 
 Wed, 08 Jul 2020 01:30:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3L2nIxk5ApXxwOT3Zp/3WIerQWYd+haUGxeub93QSXuS9JC0flYOvtOgzbo2a/2QYMTyS4Q==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr56614461wrq.184.1594197016674; 
 Wed, 08 Jul 2020 01:30:16 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c206sm5095063wmf.36.2020.07.08.01.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 01:30:16 -0700 (PDT)
Subject: Re: [PATCH] ossaudio: fix out of bounds write
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200707180836.5435-1-vr_qemu@t-online.de>
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
Message-ID: <4591613b-067d-ac5d-99d0-d8b7a3cf0ce1@redhat.com>
Date: Wed, 8 Jul 2020 10:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707180836.5435-1-vr_qemu@t-online.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 8:08 PM, Volker Rümelin wrote:
> In function oss_read() a read error currently does not exit the
> read loop. With no data to read the variable pos will quickly
> underflow and a subsequent successful read overwrites memory
> outside the buffer. This patch adds the missing break statement
> to the error path of the function.

Correct, but ...

> 
> To reproduce start qemu with -audiodev oss,id=audio0 and in the
> guest start audio recording. After some time this will trigger
> an exception.
> 
> Fixes: 3ba4066d08 "ossaudio: port to the new audio backend api"
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>  audio/ossaudio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index f88d076ec2..a7dcaa31ad 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -691,6 +691,7 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
>                             len, dst);
>                  break;
>              }
> +            break;
>          }
>  
>          pos += nread;

... now pos += -1, then the size returned misses the last byte.


