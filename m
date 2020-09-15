Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28364206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm5joaHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28364206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kID1R-0003B0-Te
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kID0h-0002Jc-58
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:36:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kID0f-0004IA-4w
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600184204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=saQfClsBHSI3Dm4A06zPAKhihmkN6sWCtXHqGXJ/hOQ=;
 b=gm5joaHMMmEpYqWzaN1h7u84g1groPCx5S8/oew+0RIAKZa8Csl8hl+wJSZNQsxs7abJDh
 RpfYnNdjQkZnhCjrbGCicY/xwTbnkP1TNcbmeTcV+Zo4RI9GF87E+3guyMYVfJ3JAZwlij
 aRBYA9MwUh4HM8a6wyiWK4uNMB0Vaq8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589--CoWYDKwNO291Yc5EQx6Mw-1; Tue, 15 Sep 2020 11:36:42 -0400
X-MC-Unique: -CoWYDKwNO291Yc5EQx6Mw-1
Received: by mail-wm1-f69.google.com with SMTP id c200so1034956wmd.5
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 08:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=saQfClsBHSI3Dm4A06zPAKhihmkN6sWCtXHqGXJ/hOQ=;
 b=PHtmP4i72C36ibdw7cVN7hg4TEGdnHhR3PIP/h1gaozg0QATxc2q2FWhY+gE4IkeI1
 wZDf9idjc8RnPKCqpLvB2LvuEuBuJKs2EgAm9xC3jgZOB+ejlKOiAi8pr8Jpj8U6oVZv
 4sjMZy1KofQSByZiuv6qT7WL0FkifA0LblSwSEpDd0WL9xqobS07BLknPJVTdOJk5ENT
 fvBx24gspKYJk8DGw+cpwczV23K8T7VXG/ywpbs22+eWwdGLNiFRzmjy04G4OlIhzUDX
 38vQZ4O+PAaS9zdZ0lY/H4DJRETBGoO4I0OrKsyqKX7yt/kwiAqbG0aVqFepz5YdHqke
 cB4w==
X-Gm-Message-State: AOAM530F8rY8obOnnt5ektHLdoH1kGTNP3m5CdPGaXuafWApI1GJFv+0
 g8k+o34XwGqQsYoA3dOVKJxeV5pieLBQ1O5cUY8xZC5jrfG7O5nSK+v8lt1yllDN09M9VT13m/I
 jOmp+EyGbcjT8RtY=
X-Received: by 2002:a5d:5042:: with SMTP id h2mr22449160wrt.409.1600184201062; 
 Tue, 15 Sep 2020 08:36:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz7PMCUiqrIDTT3J7QUtGhas3cib3bEXTeKl0XCkCn8PWq361WKlQLRLBOZsdrhmx5HsdDbA==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr22449135wrt.409.1600184200804; 
 Tue, 15 Sep 2020 08:36:40 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b194sm27071407wmd.42.2020.09.15.08.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 08:36:40 -0700 (PDT)
Subject: Re: [PATCH v2] docs/system: clarify deprecation schedule
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200915150734.711426-1-stefanha@redhat.com>
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
Message-ID: <886e82e6-2015-9939-4bb6-dc93ec58c2fb@redhat.com>
Date: Tue, 15 Sep 2020 17:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915150734.711426-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 5:07 PM, Stefan Hajnoczi wrote:
> The sentence explaining the deprecation schedule is ambiguous. Make it
> clear that a feature deprecated in the Nth release is guaranteed to
> remain available in the N+1th release. Removal can occur in the N+2nd
> release or later.
> 
> As an example of this in action, see commit
> 25956af3fe5dd0385ad8017bc768a6afe41e2a74 ("block: Finish deprecation of
> 'qemu-img convert -n -o'"). The feature was deprecated in QEMU 4.2.0. It
> was present in the 5.0.0 release and removed in the 5.1.0 release.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2:
>  * Use Dan's suggested wording [Daniel Berrange]
> ---
>  docs/system/deprecated.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0cb8b01424..f2d5bd8ce1 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -3,10 +3,11 @@ Deprecated features
>  
>  In general features are intended to be supported indefinitely once
>  introduced into QEMU. In the event that a feature needs to be removed,
> -it will be listed in this section. The feature will remain functional
> -for 2 releases prior to actual removal. Deprecated features may also
> -generate warnings on the console when QEMU starts up, or if activated
> -via a monitor command, however, this is not a mandatory requirement.
> +it will be listed in this section. The feature will remain functional for the
> +release in which it was deprecated and one further release. After these two
> +releases, the feature is liable to be removed. Deprecated features may also
> +generate warnings on the console when QEMU starts up, or if activated via a
> +monitor command, however, this is not a mandatory requirement.
>  
>  Prior to the 2.10.0 release there was no official policy on how
>  long features would be deprecated prior to their removal, nor
> 


