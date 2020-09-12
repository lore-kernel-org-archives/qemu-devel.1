Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ED2C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECE420796
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J47AsVBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECE420796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0OT-0002Tv-Lc
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 03:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kH0NZ-00011U-5T
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:55:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kH0NX-0006E4-9Q
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599897321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u25KEQC6eVVe2saFQOzFU/aJND23q2S25WCbXP4AL9k=;
 b=J47AsVBVOcB6RoyIh5FB92lSPhCWWInDQ4aBiou/WgNTMJ2Osj7SNe+cmI88s9nKHCQguG
 svYigbHbqQi/VehMh+VHIxUnXoa5mk9ysHejv2XXUNd7rBdYV6nfbHJrYMDIVwtf/1mBZG
 yHtDEwGG2a2OyU3uNspiMUskTpgFqTI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-lUVdZDlyO82IbAX9OXNgzw-1; Sat, 12 Sep 2020 03:55:19 -0400
X-MC-Unique: lUVdZDlyO82IbAX9OXNgzw-1
Received: by mail-wr1-f72.google.com with SMTP id o6so4121771wrp.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 00:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=u25KEQC6eVVe2saFQOzFU/aJND23q2S25WCbXP4AL9k=;
 b=opeV8ok5uXNBI/JEJ6p+343yCzOiopczrCMXMU6JH2vDemxTWK59c8DZAbx/TcOn3i
 KlouQefN5YZ3dKbqPa3O1xfM0Sw1h7vAdZd5VvN5uykop3zLtNA1UWxhMzXB+c0sbfY4
 ekIwJMEUSdiWWFLR6GCfBo6KLi25d4/2rto7kgqP3IYvWdEs2/jAwzyRlm/mjuZ93qFe
 GIBi8xWavofE8XfdOgtpiVphLejt8hSWTH8vPXXuzEG0BQxxg7Acl2a0uZkB41RSPJ1d
 PTHemW81BuixAV0kaDgnHE7+rsl5tQ3u7N+mqGTQzmsTnxS1Mr14TtvmyG7O4jMHPhKX
 PPYA==
X-Gm-Message-State: AOAM532Vha7i1tULZV8zwRqMZay0yiewE7xkIIg5zKZCs9VwjQlhR+N6
 Y0CmylcJYNl/AWew4gJTEa3XL0Q5f+e0NPpGB32ZRi8Qp8WGrjHZUDqRmnll9+jaZTm99lEWqho
 sdRIEfjftwoJkzBk=
X-Received: by 2002:a1c:a911:: with SMTP id s17mr5869194wme.77.1599897318623; 
 Sat, 12 Sep 2020 00:55:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkIaOHlTxpeLBZg+CiYOVCPYaxKEFtMFkUI78F2tuPelOmhPgF3leOFnhNmpM9VqlXr95MGw==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr5869179wme.77.1599897318406; 
 Sat, 12 Sep 2020 00:55:18 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m1sm8580697wmc.28.2020.09.12.00.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 00:55:17 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest/qmp-cmd-test: Use inclusive language
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200912074922.26103-1-thuth@redhat.com>
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
Message-ID: <7413d130-270e-51d6-d56b-8ee928d6c033@redhat.com>
Date: Sat, 12 Sep 2020 09:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912074922.26103-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:18:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 9:49 AM, Thomas Huth wrote:
> We simply want to ignore certain queries here, so let's rather
> use the term 'ignore' to express this intention.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qtest/qmp-cmd-test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 3109a9fe96..18069a82fa 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -82,9 +82,9 @@ static void test_query(const void *data)
>      qtest_quit(qts);
>  }
>  
> -static bool query_is_blacklisted(const char *cmd)
> +static bool ignore_query(const char *cmd)
>  {
> -    const char *blacklist[] = {
> +    const char *ignorelist[] = {
>          /* Not actually queries: */
>          "add-fd",
>          /* Success depends on target arch: */
> @@ -101,8 +101,8 @@ static bool query_is_blacklisted(const char *cmd)
>      };
>      int i;
>  
> -    for (i = 0; blacklist[i]; i++) {
> -        if (!strcmp(cmd, blacklist[i])) {
> +    for (i = 0; ignorelist[i]; i++) {
> +        if (!strcmp(cmd, ignorelist[i])) {
>              return true;
>          }
>      }
> @@ -179,7 +179,7 @@ static void add_query_tests(QmpSchema *schema)
>              continue;
>          }
>  
> -        if (query_is_blacklisted(si->name)) {
> +        if (ignore_query(si->name)) {
>              continue;
>          }
>  
> 


