Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D56DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6B820899
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNTRoHrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6B820899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlri2-0007pE-4f
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlrhH-00077T-BT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:23:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlrhB-0004wv-82
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592475776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kg/Au3i8xAiMATJYGt8yPIZ3pzTYPFlzMFCdCoP6cJg=;
 b=hNTRoHrRSgRMBd3L7NxzA1n/dSKVI53iXGiWIUdR5P4Q9MctYIJrXQlOh7rV63nVbrvyB0
 BqRv7vqoiY+yKj7KiTu0njeSMIo984P21c78OGYWBTpgs7Ur2mukhXjKublS50Z9fbm9XZ
 sSV+7tf3C7UvBNff85XtiZG4XRrHMDU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-pHbtMGtxNSWmrRbRZDxufw-1; Thu, 18 Jun 2020 06:22:54 -0400
X-MC-Unique: pHbtMGtxNSWmrRbRZDxufw-1
Received: by mail-wr1-f69.google.com with SMTP id m14so2610028wrj.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Kg/Au3i8xAiMATJYGt8yPIZ3pzTYPFlzMFCdCoP6cJg=;
 b=g+TZ0+8G6H+naAkhU9ThBzDZSZaBQAmqz2dY5YGqMLPz2z7iBpf0czfu9srzCadUy5
 CeQXvGS9h3O/Wq9zLuM7X+tAi8CLMyP9B7MVOLfnmephjEbix5+ldlraWkHant0o2xvg
 bkol57HrAKzP2i58Etbjpc3iDqqg9dO0yOOKBFM8c6Zhje5Irn7g+b6D/QvuNJmPpR0e
 UE3mETnGkc+dkXOaPZxhkZubzv8Ntp8gLHikqlElnosscW7CCT6C1BeEP1pz3oNRqlpb
 SvtcwUhaT91IM5TuxuJsaja5nKHIjdgLPrbj2BxHeeOJ3huUn0KiO4Saw2SryIgwe9HN
 Sh5A==
X-Gm-Message-State: AOAM533hda72LmVbT8+1CHHK2TVLwQhgVuYAMfM6eWfWdna8RprROBG2
 JCgVHTnNCf58QqrRmPlnCItgEOvHZmwAtON76hbe4iliXkqvyg5Tji3y4RBAEOuS0ZkXKH4t5oH
 ih7q/uv3cirsc7g0=
X-Received: by 2002:a1c:2d83:: with SMTP id t125mr3367261wmt.187.1592475772936; 
 Thu, 18 Jun 2020 03:22:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK3doaHWNxJh1hIdlCzQ0iyCmGb15O1H0pnc3socjJk5AmdMPnawJuTKsCNTImX0sh3vCEPQ==
X-Received: by 2002:a1c:2d83:: with SMTP id t125mr3367233wmt.187.1592475772602; 
 Thu, 18 Jun 2020 03:22:52 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id c11sm214107wrq.36.2020.06.18.03.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 03:22:51 -0700 (PDT)
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: Peter Maydell <peter.maydell@linaro.org>,
 Allan Peramaki <aperamak@pp1.inet.fi>
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
 <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
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
Message-ID: <fdb9eabf-2663-f2e4-6b40-2455261eaa46@redhat.com>
Date: Thu, 18 Jun 2020 12:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 10:23 PM, Peter Maydell wrote:
> On Mon, 15 Jun 2020 at 22:23, Allan Peramaki <aperamak@pp1.inet.fi> wrote:
>>
>> Fix audio on software that accesses DRAM above 64k via register peek/poke
>> and some cases when more than 16 voices are used.
>>
>> Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
>> Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>
> 
> This patch is quite difficult to read because it mixes some
> whitespace only changes with some actual changes of
> behaviour.

In such cases the author might add a comment in the commit
description "this patch is easier to review with git-diff -w"
or other options.

Allan, can we get the patch with only the changed lines?

See:

---
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index ae40ca341c..e35e941926 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -32,7 +32,7 @@

 #define GUSregb(position) (*(gusptr + (position)))
 #define GUSregw(position) (*(uint16_t *)(gusptr + (position)))
-#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
+#define GUSregd(position) (*(uint32_t *)(gusptr + (position)))

 /* size given in bytes */
 unsigned int gus_read(GUSEmuState * state, int port, int size)
diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index 00b9861b92..3b39254518 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -28,7 +28,7 @@

 #define GUSregb(position)  (*(gusptr + (position)))
 #define GUSregw(position)  (*(uint16_t *)(gusptr + (position)))
-#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
+#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))

 #define GUSvoice(position) (*(uint16_t *)(voiceptr + (position)))

---

> 
>> -#define GUSregb(position) (*            (gusptr+(position)))
>> -#define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
>> -#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
>> +#define GUSregb(position) (*(gusptr + (position)))
>> +#define GUSregw(position) (*(uint16_t *)(gusptr + (position)))
>> +#define GUSregd(position) (*(uint32_t *)(gusptr + (position)))
> 
> So, I think the actual bugfix change here is just the changing
> of uint16_t to uint32_t in the GUSregd definition...
> 
>> -#define GUSregb(position)  (*            (gusptr+(position)))
>> -#define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
>> -#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
>> +#define GUSregb(position)  (*(gusptr + (position)))
>> +#define GUSregw(position)  (*(uint16_t *)(gusptr + (position)))
>> +#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))
> 
> ...and similarly here, and all the other changes are purely
> cleaning up the spaces. Is that right?
> 
>> -#define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
>> +#define GUSvoice(position) (*(uint16_t *)(voiceptr + (position)))
> 
> Are these accesses all guaranteed to be correctly aligned
> to be 16 or 32 bit loads/stores ? Otherwise it would be
> better to use the ldl_p/stl_p/ldw_p/stw_p/etc accessors,
> which correctly handle possibly misaligned pointers.
> 
> thanks
> -- PMM
> 


