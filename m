Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F374C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEDA206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hxhy+UDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEDA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjki-0004KR-9H
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjk2-0003qg-B9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:52:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28939
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgjk0-0002Hc-Te
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591253559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KEL0yA6tnzflu3BRb5G//Jy1AvSu0jeBn74uDKB4n08=;
 b=Hxhy+UDqnflokd6zvlKClj5qYPRYKN3Xd2ahNN47oDKrh4jpgq8W5g09quaPI+B5x5hq8w
 SEA/RR8gNC0hQ8B7u1z8aaO1+xKjda31VZLirh3x1LciyPTa2NlbvECojDSoT2zxkxDusD
 k4rH0oJL9pc24/R6LREO7958w+nCRR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ZI4iwi2-MrmVZHKHbrhyxQ-1; Thu, 04 Jun 2020 02:52:37 -0400
X-MC-Unique: ZI4iwi2-MrmVZHKHbrhyxQ-1
Received: by mail-wm1-f72.google.com with SMTP id 11so1446251wmj.6
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 23:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KEL0yA6tnzflu3BRb5G//Jy1AvSu0jeBn74uDKB4n08=;
 b=FDwu2SiYj1jsmt68YqhoHxOF3TeMPv3OXeMeBh0g6uGNFkhlRX3YBMPpN2gol3p/JK
 8nFDwM6b1X8AE4k/iGuFsDY7tDUHkaI3hrYcFJxtvBi8A0sFK/KCSJ0Fa6i8hhpUv5/C
 QIajGGCjNiNNCAT2IfFTqRyml4O8O5z02L2MTC2yeewK5mHOxrVho9JG8sUXeBiibA2f
 JhJmhgbY0V96lz7MyOgQ9QokR88J7HPCd+BkeGQLEeU+uoQ+t+UZop75j72wKyjOylbR
 VcIqtrbM+ttO5Z29cp6HCpMuLoZscJRpwoiMaFf73bnYMjEpGfiPIn2lDb504IccJUG5
 lJ3g==
X-Gm-Message-State: AOAM531beSeUtDh7x4OAtSy4fQcjUFP245kyQqU23DUoU9GjxIo4fXo9
 m5dOHjrx8OmydQSAf7b9VqTykrNwX6GzHER0CS+ZnNIRzKyeeYjue7A9UMvtYALaifxy0ObN5wQ
 ZdkoeUC0YVO7tcXA=
X-Received: by 2002:adf:e887:: with SMTP id d7mr2874008wrm.62.1591253556420;
 Wed, 03 Jun 2020 23:52:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSqORaGTcteDKFiAR3wMEG+9PN6mQDX9VJIvGWQdKCgZ+s3JAGp/nkUfuFt2oozneGrf2Utg==
X-Received: by 2002:adf:e887:: with SMTP id d7mr2873986wrm.62.1591253556179;
 Wed, 03 Jun 2020 23:52:36 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z16sm6543674wrm.70.2020.06.03.23.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 23:52:35 -0700 (PDT)
Subject: Re: [PATCH 5/9] target/i386: sev: Partial cleanup to sev_state global
To: David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net,
 pbonzini@redhat.com, ekabkost@redhat.com, qemu-devel@nongnu.org
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
 <20200604064219.436242-6-david@gibson.dropbear.id.au>
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
Message-ID: <32902884-75c1-7221-6dc7-012a9248ca21@redhat.com>
Date: Thu, 4 Jun 2020 08:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200604064219.436242-6-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>, brijesh.singh@amd.com,
 dgilbert@redhat.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 8:42 AM, David Gibson wrote:
> The SEV code uses a pretty ugly global to access its internal state.  Now
> that SEVState is embedded in SevGuestState, we can avoid accessing it via
> the global in some cases.  In the remaining cases use a new global
> referencing the containing SevGuestState which will simplify some future
> transformations.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/sev.c | 92 ++++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


