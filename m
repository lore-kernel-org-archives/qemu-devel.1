Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B48AC10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9222021D91
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoT1yaGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9222021D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzoj-0002BZ-LX
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFzo0-0000uv-9W
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:06:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFzny-0002NQ-Fc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599656789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yT97iK1XUEMkrS8HYNQgXovKPaIbcjmkfPOn5PNA1E4=;
 b=KoT1yaGj1OXDiR4BthOo6eRG/h/3q5X/D8wR4GtfEc9kl9ffKAgdE3KshKQl+zWxpc9GRF
 aLjyRTZlyeU0b5ycXAczQ8wbyL7TWZkb+vc5Dd8NqsMpuc6SA9tBgmUC8ce1ykNys82oYR
 aIf2EA9OZt1zUKyJQ46jyTvH4lwip0E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-H4bcW11oNum_Mc419myItQ-1; Wed, 09 Sep 2020 09:06:25 -0400
X-MC-Unique: H4bcW11oNum_Mc419myItQ-1
Received: by mail-wm1-f71.google.com with SMTP id s19so93944wme.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yT97iK1XUEMkrS8HYNQgXovKPaIbcjmkfPOn5PNA1E4=;
 b=i9c82Sesk9SIMJ4Zyydy6qMMGcqWgT5O4GxP9hao47Als0nZhFNoVX0R9skxALZTgn
 /sIsYVaLJ6I+m4fCFMEb2aEEZTETxKtycHdg1NYcQjuTU0I+96r51YFgMFBvl4eELSVi
 uZwbWwGYFT/W0wIu17vH57XtPeYAdwGfRLE5W5Pujh4KXSbdmZ5hlJsGu36R2gm3svu6
 xuc2fw966wwEuzl6vCq1SokVIRjydh4AFi7lHimeWoXSrA7DneEUa5E3UGp3c1Uw0o24
 Z7emvvk6C3k+DVRaPJTjibmQQBd/9FQN/KvDlaSt6opatuQBMNUGAARs2RBKQoXZFb0S
 O0GA==
X-Gm-Message-State: AOAM533n9bop/Vj+aGPpqQeNQYnjiEhIvuMeYCjbR19ShywV4Mly43Pp
 ALjTJyli/ZZPokdyyA5PkIikbhadzV/HEDCWooO+sb5Ov1WR20nTqC+hqG2SrdPB9s5E+ZiTk5h
 w80bs5ynm0w9XuIQ=
X-Received: by 2002:a7b:c749:: with SMTP id w9mr3277717wmk.29.1599656783826;
 Wed, 09 Sep 2020 06:06:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpqbSwCVxZkd4x+PJyq/OmDavsRwMYtuX8KSRvEu6WwnIPP8JpBbXMyah9UladifrBlRgu/Q==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr3277662wmk.29.1599656783051;
 Wed, 09 Sep 2020 06:06:23 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o4sm4117844wru.55.2020.09.09.06.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 06:06:22 -0700 (PDT)
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
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
Message-ID: <ff7ef6e4-254a-b171-22bf-c5cca4945160@redhat.com>
Date: Wed, 9 Sep 2020 15:06:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87pn6vw2he.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 2:37 PM, Markus Armbruster wrote:
> Watch this:
> 
>     $ rm qapi/qapi-types-error.h 
>     $ make
>     Generating qemu-version.h with a meson_exe.py custom command
>     Compiling C object qom/libqom.fa.p/object_interfaces.c.o
>     In file included from ../qom/object_interfaces.c:4:
>     /work/armbru/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
>       275 | #include "qapi/qapi-types-error.h"
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>     make: *** [Makefile.ninja:348: qom/libqom.fa.p/object_interfaces.c.o] Error 1
> 
> To recover, I have to run qapi-gen.py manually and exactly right, or
> blow away the build tree and start over.
> 
> The old build system did what a build system should: it remade the files
> that are missing or out of date.
> 
> I'm still too clueless about Meson to debug this, but I hope I can learn
> from watching you fix it.

Maybe related:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg736135.html
and later:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg738777.html


