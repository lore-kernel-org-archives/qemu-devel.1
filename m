Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA8920739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7U3kLoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA8920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw2kj-0003yw-JY
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw2jy-0003TH-L7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:11:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22519
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw2ju-0005zN-Em
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594901508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=npHidU2crb4EQ+ll44BnSlywKEDjfc9ilKdB1rD9HnY=;
 b=F7U3kLoBn8o2ufZVjDjCXjHwL2FUW/pJvs+PeC2t5upJz9kZPDxbAbTPl0YfuTl3Z0hSJw
 1QfjLuDRJpkAzGjyDRw6dmlyp9+rAIXdL9KVnjOk63zfFI32XsRgncNGCkhBCB9ggzWL/O
 +w93ilT+kv87pYBPsbf1Aczo4+jZmDY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-__mbBbX4NZSF3w-0NBUdTw-1; Thu, 16 Jul 2020 08:11:43 -0400
X-MC-Unique: __mbBbX4NZSF3w-0NBUdTw-1
Received: by mail-wm1-f72.google.com with SMTP id u68so4944998wmu.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 05:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=npHidU2crb4EQ+ll44BnSlywKEDjfc9ilKdB1rD9HnY=;
 b=L96Fm05wKeDS7IlQEFBbtxqCFNLE6ltnfngA8SX1ROcQpFNfdezVQayHVKbRkaFuUT
 vYX+oQxGn+cZWbTgHFtZj1njWeHb+vjRKZRv4WHDm9CmOyJVeC5aE+m7JCdbbxG/RFYU
 rMpfCbtt/QciZpvj41IALT7buUAV4lGdXCSq5U0l8REz6UOIPTvhbHJ7fgSo4Gi7BRAG
 7xDZLeOqMuWe6of0s/9rs6qf7Y8D8WdigtLrdIiJnXC8zU0RBAEYWtZe7wP1aURqlEuU
 VsjoQ0SKvy3U3Chy5jqe1nZyZV8/iZUstgLfweL+wGBgGbYCXgRxpoO5BNGKlWk5ARO5
 wT7w==
X-Gm-Message-State: AOAM531rR7xmRXmEAG8pbWhlTpDKK6OWrS3v1gG9fHXZu6vYYneySFiR
 xaYmeEJJrs7sXXSSCqzp+AcwFDFwtl99IJEghO7St9ZaNlGF+zytGMoQCcBEpueaeDFy3FwhBjz
 865MRQAkDqI0JnsI=
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr4893236wro.317.1594901502822; 
 Thu, 16 Jul 2020 05:11:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy42waCOCF6p/bxrb4PMkgFRE7uIdL2UCMLdFQIg+29Pf5mNWTO/z+7pKKbJADzQ9IzDdTwkQ==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr4893223wro.317.1594901502540; 
 Thu, 16 Jul 2020 05:11:42 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 133sm8738663wme.5.2020.07.16.05.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 05:11:41 -0700 (PDT)
Subject: Re: qemu test-qga failure on mergebuild after VERSION file change:
 dependency issues??
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
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
Message-ID: <6e12e924-aefc-cd19-7fcb-4a919a4322ca@redhat.com>
Date: Thu, 16 Jul 2020 14:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 12:53 PM, Peter Maydell wrote:
> The first merge I tried to process after bumping VERSION for rc0
> failed on test-qga like this:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qga -m=quick -k --tap < /dev/null | ./scripts/tap-driv
> er.pl --test-name="test-qga"
> PASS 1 test-qga /qga/sync-delimited
> PASS 2 test-qga /qga/sync
> PASS 3 test-qga /qga/ping
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga_info:
> assertion failed (version == QEMU_VERSION): ("5.0.9
> 0" == "5.0.50")
> ERROR test-qga - Bail out!
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga_info:
> assertion failed (versio
> n == QEMU_VERSION): ("5.0.90" == "5.0.50")
> Aborted (core dumped)
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:659:
> recipe for target 'check-unit' failed
> 
> Looking at timestamps on files, tests/test-qga.o never got rebuilt,
> even though config-host.h has been updated (and so has the new
> QEMU_VERSION). Any idea what's gone wrong here?
> 
> Also weird: this build tree has no .d files in it.

Yes. We chatted about that yesterday on IRC, I ran this test:

- checkout master
- build after distclean
- checkout mytest
- change a function prototype in qdev-properties.c
  (simply because I had it opened in my editor)
- build

make: *** [rules.mak:69: hw/core/qdev-properties.o] Error 1

But the file is still here from the previous 'master' build:

$ ls -ln hw/core/qdev-properties.o
-rw-rw-r--. 1 1000 1000 140624 Jul 15 16:27 hw/core/qdev-properties.o

$ touch hw/core/qdev-properties.o

$ make -> link success... but prototype doesn't match...

> 
> thanks
> -- PMM
> 


