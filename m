Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E24C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA64207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9834zBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA64207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKz3-0004WJ-MC
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmKxB-0001F0-Af
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:37:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmKx8-0001Fv-64
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592588240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=skoyLe7v9teEu7TZ0Z9jUWPEMCFLkOzg/Ip11WHtgFs=;
 b=J9834zBI6xyCDlNN4JIknFgFae8dFAy2rDLrYLFQ398jp9Z3+fL1Auid3sJN8eLQAG/KPr
 HdNEXfI2Fu14fVDRYTsrejTh9kGBgA4+BH+FIokDT693rl8funorFSD+UFGbP13LdGlvtR
 0dzmWLD8jM18nvRhkmtu9NGjLWH0snk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-AIM5PsVSNrS6YG0hdxJ_5g-1; Fri, 19 Jun 2020 13:37:17 -0400
X-MC-Unique: AIM5PsVSNrS6YG0hdxJ_5g-1
Received: by mail-wm1-f72.google.com with SMTP id u15so2824629wmm.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=skoyLe7v9teEu7TZ0Z9jUWPEMCFLkOzg/Ip11WHtgFs=;
 b=B2O6r3ohxjlWjDpECED4nOedmRVVX62tU5JdTo+HYnff4Jbafj/y6gRyjXhs4WAKAn
 BkIjvmXb5jkeS783qyoZUzLezFjroEdT8kpxica3lGIMhCLhIcfFcqwl6zYS/JUF41mx
 oAY0yhiTlVyYJ9ADDwyG3HSlZ62JJbLVK0IAIkPHErPFjzoDTLdSB1yXgEVedCRJhQ26
 XkhUz0nNadOo3BC1//ofvVY2amJ8WiD+5ycMOR6vEkO4lkboXzEmTqjpXeyanLXfYNVo
 UL0tYMb7aw1rcyz2RLEOJ0RJ86YD7QLIkzpixH+FhyYJKoJd85uEvTdLvk65RuOvUHLP
 qlAA==
X-Gm-Message-State: AOAM531AYkXE2BiYvgj2XM8UzAk9M909PnQB53S2cg2NVVpwapom/jgc
 xMsRLvL9AmG/a1VfxOc5ii2S5vrqRBpbAeZWl7Op+4EdUnYL5w4vF/0vITaRfKJYNdf+epJVkt+
 kXJvNb0j+qPhbRpk=
X-Received: by 2002:a5d:604b:: with SMTP id j11mr5183586wrt.193.1592588235885; 
 Fri, 19 Jun 2020 10:37:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznNMa2cg8zTRXYovNmGYPYcqeEFfGoZN9pLlzdRntm2+tVpuN+14VaN6D+WrE9uiF6rlI/kQ==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr5183566wrt.193.1592588235683; 
 Fri, 19 Jun 2020 10:37:15 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id v27sm8553338wrv.81.2020.06.19.10.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 10:37:14 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add an entry to review Avocado based
 acceptance tests
To: qemu-devel@nongnu.org
References: <20200605165656.17578-1-philmd@redhat.com>
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
Message-ID: <8c2d6cae-55ce-9715-0534-8c2c01df9514@redhat.com>
Date: Fri, 19 Jun 2020 19:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605165656.17578-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 6:56 PM, Philippe Mathieu-Daudé wrote:
> Add an entry for to allow reviewers to be notified when acceptance /
> integration tests are added or modified.
> The designated reviewers are not maintainers, subsystem maintainers
> are expected to merge their tests.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e7d9cb0a5..c2ae2bf390 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2923,6 +2923,14 @@ S: Maintained
>  F: tests/tcg/Makefile
>  F: tests/tcg/Makefile.include
>  
> +Acceptance (Integration) Testing with the Avocado framework
> +W: https://trello.com/b/6Qi1pxVn/avocado-qemu
> +R: Cleber Rosa <crosa@redhat.com>
> +R: Philippe Mathieu-Daudé <philmd@redhat.com>
> +R: Wainer dos Santos Moschetta <wainersm@redhat.com>
> +S: Odd Fixes
> +F: tests/acceptance/
> +
>  Documentation
>  -------------
>  Build system architecture
> 

Eh I already sent a similar patch... [1].

Considering Wainer reply in [2], patch applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675105.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675698.html


