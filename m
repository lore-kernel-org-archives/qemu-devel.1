Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF14C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5A020708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgWml7Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5A020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtOhH-0004KY-3L
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtOgW-0003uB-Qj
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:01:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtOgT-0006vM-4E
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594270880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t39HbuJlwrLWEj5xeLiNgwhfhJLhKFLesAfbSD+qgdI=;
 b=BgWml7Q2NUXPg9ETJLX2a1c/tAx1wV91XMVAgs9knUKydCugAXZUe07ZigRY2aE32S3yZy
 KovqvL74j6B9NVSLWrLwhnpgXmz8zC56aIkmodUtcTELZfSmdeOND42Ge85nb7oTYvzz76
 3YVxVuw2WQytM/5vOJQeNJaBWw+uJHM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-kXIB6b8XNkOY8_oi9YQGGA-1; Thu, 09 Jul 2020 01:01:18 -0400
X-MC-Unique: kXIB6b8XNkOY8_oi9YQGGA-1
Received: by mail-wr1-f71.google.com with SMTP id o25so1018977wro.16
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 22:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=t39HbuJlwrLWEj5xeLiNgwhfhJLhKFLesAfbSD+qgdI=;
 b=ZWNSjQH/xqRKhxvqypDHE17CUwheLBc/w27lsWigg3GtnXElaGFsCXtSPOZY2p7B8d
 Vj+U4/ndTA9ohFCmM4+DJynp2R8LeTvnakuQrwDHbAkUqsEGCiKzLstdNAKgfAF0F/xM
 7lm1XUxsZTDdDXP+j1IlDMvwgtbFm+7SWhGJeX+zGlGUx2vnGPv2BGNTzQMSmLX0vQCD
 3TEqkLLQ/bjlXlovVRrfNcj4JrN19Z7cBkmq9cza90SM7Zmv+3ih/cX7B+6K+oo98Rct
 vZZmgtPATMA8W86o70owCRzjB9c3Dql81AQPLptDDttyLzrgZCIMmi2rSaxOM6m/+TnU
 dtCg==
X-Gm-Message-State: AOAM531OhbKBJUmxDBr27MQhZSo0NEH9DWnaXvbsJXdGE9rclzvEq26S
 1rdKhM0Ih2vFQ4oPXJ5wfq0XWuK+dPVj7fNED2UXew40hjruuETl7nVSat6hAjRV+xDhgNJxFLy
 9ausJCvdWHYLMEp0=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr33663606wrq.1.1594270876503; 
 Wed, 08 Jul 2020 22:01:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEH1pZ2yWfYxhCcX2RmpcjNBL0aX54X5dSPeje47XVtl/MyBp1Z0PlcqSVy8I+EoZ4cFODbg==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr33663587wrq.1.1594270876308; 
 Wed, 08 Jul 2020 22:01:16 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p29sm2919477wmi.43.2020.07.08.22.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 22:01:15 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 1/2] configure: do not clobber CFLAGS with
 --enable-fuzzing
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200708200104.21978-1-alxndr@bu.edu>
 <20200708200104.21978-2-alxndr@bu.edu>
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
Message-ID: <e74e6719-c9cd-7004-cfc6-13a392cd803f@redhat.com>
Date: Thu, 9 Jul 2020 07:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200708200104.21978-2-alxndr@bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: liq3ea@163.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 10:01 PM, Alexander Bulekov wrote:
> When configuring with --enable-fuzzing, we overwrote the CFLAGS
> added by all the preceding checks. Instead of overwriting CFLAGS, append
> the ones we need.
> 
> Fixes: adc28027ff ("fuzz: add configure flag --enable-fuzzing")
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index ee6c3c6792..078ebaa9f3 100755
> --- a/configure
> +++ b/configure
> @@ -7898,7 +7898,7 @@ if test "$fuzzing" = "yes" ; then
>    if test "$have_fuzzer" = "yes"; then
>      FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
>      FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
> -    CFLAGS=" -fsanitize=address,fuzzer-no-link"
> +    CFLAGS="$CFLAGS -fsanitize=address,fuzzer-no-link"
>    else
>      error_exit "Your compiler doesn't support -fsanitize=address,fuzzer"
>      exit 1
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


