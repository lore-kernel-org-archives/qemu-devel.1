Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EFFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF58D206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrMv1Gw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF58D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYEm-0007WP-3P
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtYDJ-0006LD-Fr
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:11:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtYDE-0000Hu-0Y
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594307505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sw3kfpl7g2gRO76rFFygnHkMTOn7qHN5EK3NYoIgzkE=;
 b=GrMv1Gw4rW5RGZ3MfCRMCFrwXfS73Ct0PmzB07YsMnUwt7BHS1BHOM6nigRuSrFVnExeIz
 mWZRvb+8oDWdb51ZNTK0wGCDtcHqGa/VtIlJZJy9Az6gnhuRKY+/2CzUoG7Gc5uWFCDb/h
 vlROO9WPRZ/xB/2xjAmnKrKg2FASuW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-WrUzR7EeOUSe3_j2mutEFg-1; Thu, 09 Jul 2020 11:11:42 -0400
X-MC-Unique: WrUzR7EeOUSe3_j2mutEFg-1
Received: by mail-wr1-f71.google.com with SMTP id a18so2190965wrm.14
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sw3kfpl7g2gRO76rFFygnHkMTOn7qHN5EK3NYoIgzkE=;
 b=g39LJrSMvnDltiJDBrlHcilYdcdrMQp7j8ym8aQ/T/dWuGvOiJoNHgF1lsKbnJbZTs
 iVa+aE0gJlAkSxrhK5DGcd9P7GLYtHK7LsAZCIwNbJULkwylG1eoX87/2g8M5Nsp8QrU
 iYQ2ezf7grSI1m7YkEhZxE1KExJLsTsW8sUeM3lanMZw/sgUdoIV20wA7CvEXpiKb0AY
 oRi3XW6R23HSIm4g+4NL0E7kiHkbkwY9VGBWVuip/TXp1zntNwKqq7MOAsmbvwf8BeqL
 1TVEojxiTDQfn9EDcbrP0nNtNN+W3gql9CmE35Rl3JqSwH2BJAPZ696tQeRnghIO8i0s
 oFpg==
X-Gm-Message-State: AOAM531kIKxc22dbXQ6TR+E9HhwkLVMu+YJ4sOwR/SVQdA548zdtR546
 CH+p+OfkPFxgmr41+U5cClsRmoQ36+f/PgOGHeI5zHQzZ+ZeHkYCVsD0KeV+VPNBSNKamX3PqsN
 FSbRDFmVnUdGDHr8=
X-Received: by 2002:adf:e6c1:: with SMTP id y1mr37731196wrm.116.1594307500863; 
 Thu, 09 Jul 2020 08:11:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6GXC4KkipWoIwX/ID73YLGupfcFC1424puqciAuoKodVw4AH0xihWXOip0xsb93TasgxKkQ==
X-Received: by 2002:adf:e6c1:: with SMTP id y1mr37731169wrm.116.1594307500622; 
 Thu, 09 Jul 2020 08:11:40 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w7sm5197648wmc.32.2020.07.09.08.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 08:11:39 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] scripts/performance: Add dissect.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, eblake@redhat.com,
 ldoktor@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
References: <20200709052055.2650-1-ahmedkhaledkaraman@gmail.com>
 <20200709052055.2650-2-ahmedkhaledkaraman@gmail.com>
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
Message-ID: <845a6259-67df-c0c2-5f82-b7e00ce95106@redhat.com>
Date: Thu, 9 Jul 2020 17:11:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709052055.2650-2-ahmedkhaledkaraman@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:34:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:20 AM, Ahmed Karaman wrote:
> Python script that dissects QEMU execution into three main phases:
> code generation, JIT execution and helpers execution.
> 
> Syntax:
> dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
>                  <target executable> [<target executable options>]
> 
> [-h] - Print the script arguments help message.
> 
> Example of usage:
> dissect.py -- qemu-arm coulomb_double-arm
> 
> Example output:
> Total Instructions:        4,702,865,362
> 
> Code Generation:             115,819,309	 2.463%
> JIT Execution:             1,081,980,528	23.007%
> Helpers:                   3,505,065,525	74.530%
> 
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  scripts/performance/dissect.py | 166 +++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100755 scripts/performance/dissect.py

Thanks for the update Ahmed!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


