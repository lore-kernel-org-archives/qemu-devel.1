Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD378C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D7F2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLORlhSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D7F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ScC-0003bT-UD
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0SbQ-0002lD-A0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:37:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0SbO-0004pU-Fb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595954237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dvo9Pp/PY0l93gJ0W6NjKq8Bc0AiONsLFtDmwNGqhMo=;
 b=OLORlhSkQJinlrtcpzuhEnUqbMfxuoJOPx/euSbZ3OndCsUjqv5Evlcom09xxmwRuewVZw
 oyA+Jp+XAn0Dh5T/R+874YBhSD2lDxVXY3+ZnPfwCy1fVtXEIcVekTRs6YfDXXtOxum2OJ
 uCjapzIeuxItQoHM8prX6IalyPr4VOA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-imZYEGy9OFa4mS47XUv12A-1; Tue, 28 Jul 2020 12:37:15 -0400
X-MC-Unique: imZYEGy9OFa4mS47XUv12A-1
Received: by mail-wm1-f69.google.com with SMTP id u14so118052wml.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Dvo9Pp/PY0l93gJ0W6NjKq8Bc0AiONsLFtDmwNGqhMo=;
 b=m/ugtliYVvv/BBLW5fnoMREoCagSJK/Ahl8MRBeSTmzbqk1cnsp/JLHtvlgV0KMVnY
 HbGYhYmV73Onk+NOpSjG45/oB8eOfJ6jJQ2tuaCROxaGQttxVKmmZ6Pjc3mDIqK0a1Gn
 eT8cCq2c7sDumJ6Rdt9TGw8gHww8yRo9cOlpgB4prEJ6xMk/LVBZkQkGimpXpLfNIi4i
 FQvYJFb+cOoxd42JjKVpS78w6xV65WOiRqnmtYr6q/KeqZwqzHbGTj11SecyaNrlXXCb
 jq4ewq0nHvduVGv3c7t7PrlbgTNA2SzUTVJXx9z//qwhJY17U4w+IRVubSd8D/zoc1+u
 lN1A==
X-Gm-Message-State: AOAM531FXCUqpOwfAEDI7f5UxWshb4lEnbZdCSqTEx2JJaRVhIiU1REU
 mfx1DgIuxSXxgEymzaKGGz9kTlYrsDJD1EzA4f2D2BGaHCwOlt9/O2TVg7oDAL7cZaQpdnlnCqF
 wpEL6XvkKoCTN/fA=
X-Received: by 2002:a5d:4005:: with SMTP id n5mr23819974wrp.26.1595954233093; 
 Tue, 28 Jul 2020 09:37:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiIoHgm2Mp3EJhR8zGG9qJpYKryCJKZsq5FnOLll42MQOWigwhsiNgxR0Fe3+OB3ZZNUrASw==
X-Received: by 2002:a5d:4005:: with SMTP id n5mr23819953wrp.26.1595954232904; 
 Tue, 28 Jul 2020 09:37:12 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id 65sm20772070wre.6.2020.07.28.09.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 09:37:12 -0700 (PDT)
Subject: Re: [PATCH 2/7] build: fix device module builds
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com
References: <20200723174615.2370096-1-dinechin@redhat.com>
 <20200723174615.2370096-3-dinechin@redhat.com>
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
Message-ID: <84be9a34-9f87-1660-3a43-aea72d9496cd@redhat.com>
Date: Tue, 28 Jul 2020 18:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723174615.2370096-3-dinechin@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 7:46 PM, Christophe de Dinechin wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> See comment.  Feels quite hackish.  Better ideas anyone?

I don't understand this patch, how is it related to the rest of
your series?

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  dtc           | 2 +-
>  roms/SLOF     | 2 +-
>  roms/openbios | 2 +-
>  roms/opensbi  | 2 +-
>  roms/seabios  | 2 +-
>  slirp         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/dtc b/dtc
> index 85e5d83984..88f18909db 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
> +Subproject commit 88f18909db731a627456f26d779445f84e449536
> diff --git a/roms/SLOF b/roms/SLOF
> index e18ddad851..9546892a80 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit e18ddad8516ff2cfe36ec130200318f7251aa78c
> +Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
> diff --git a/roms/openbios b/roms/openbios
> index 75fbb41d28..7e5b89e429 160000
> --- a/roms/openbios
> +++ b/roms/openbios
> @@ -1 +1 @@
> -Subproject commit 75fbb41d2857d93208c74a8e0228b29fd7bf04c0
> +Subproject commit 7e5b89e4295063d8eba55b9c8ce8bc681c2d129a
> diff --git a/roms/opensbi b/roms/opensbi
> index 9f1b72ce66..be92da280d 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 9f1b72ce66d659e91013b358939e832fb27223f5
> +Subproject commit be92da280d87c38a2e0adc5d3f43bab7b5468f09
> diff --git a/roms/seabios b/roms/seabios
> index 88ab0c1552..f21b5a4aeb 160000
> --- a/roms/seabios
> +++ b/roms/seabios
> @@ -1 +1 @@
> -Subproject commit 88ab0c15525ced2eefe39220742efe4769089ad8
> +Subproject commit f21b5a4aeb020f2a5e2c6503f906a9349dd2f069
> diff --git a/slirp b/slirp
> index 2faae0f778..126c04acba 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit 2faae0f778f818fadc873308f983289df697eb93
> +Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
> 


