Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F252074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOkuYbjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F252074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh762-0000iQ-11
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6za-0005qk-7D
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:42:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6zV-00060A-8H
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BjxyQplq0cq5ZVoWHTlMCaFVq2Lgyv4uaqDCPg0/OHQ=;
 b=gOkuYbjSbreV6GbNfweygtpXIoWN7FLe4Q9ojCEQYanJKrq0st1eACb2jjDXNedPuu9a8x
 XmtTsk14CnxY6nUkwVuLd4dQ8WcvarzMQR2TorTleC3mTViUsroWYPy+myAX0c4ONBKDHJ
 ZyOSXSjCRRhx1+GBWPaGuH6m7kmoCLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-8M9GWfvXOvmv6KsY9ckijg-1; Fri, 05 Jun 2020 03:42:11 -0400
X-MC-Unique: 8M9GWfvXOvmv6KsY9ckijg-1
Received: by mail-wm1-f70.google.com with SMTP id l26so2697161wmh.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BjxyQplq0cq5ZVoWHTlMCaFVq2Lgyv4uaqDCPg0/OHQ=;
 b=MrLJYUL6lgtl1AqtKbqhT+Fqkbxs1WjzRf0FHjQN+0djQS/hwc0MAVhFmoZ6EUordu
 4UQMGC3sjdlQPWtKAQKsQ+FD62m+YGITY0zOvgSVPhKowpDRmpcoX2oWhQztRmI5STpU
 ofCC8MXUByYOZlyU8rMWJ2dqDINVA9Ph+cLu3DX/46CZjuQlCaCKiEIjIfUA/Euor144
 XaM/u4BtDoVWPucxP4+gwqO2YUCLJiexO0m4BhR7sa96HKeIzXVAehINBNGyX2O42r2g
 Sj5COnlAFxmnXVgfC1uPbSqrZe5kq6MiYnEcFWPgvcLF7qUXKHBfyVJ3LnA/u0cVmoxf
 7XOw==
X-Gm-Message-State: AOAM530ZS5iIanBO6LEL67BbB0gdbr6XWusratAJzmOD65+iydU4XoKl
 SZPOWVxHe2uOkHJ3L9lgDy/Qz0229cBl42KQnkeROzp6pE/WabTccm+AcIBvNdTbCuuLgmMbNBW
 G3qU56M162syWtu4=
X-Received: by 2002:adf:e84c:: with SMTP id d12mr8066898wrn.284.1591342929753; 
 Fri, 05 Jun 2020 00:42:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMX+PnPHQQMHa8340EmjTn2Qkob+ESxZV4k5MFhvbI6p419tkE2wsvGl9Zuao8ppiMcrrSog==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr8066886wrn.284.1591342929530; 
 Fri, 05 Jun 2020 00:42:09 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u7sm11203799wrm.23.2020.06.05.00.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 00:42:09 -0700 (PDT)
Subject: Re: [PATCH v5 04/11] rules.mak: Add strequal() and startwith() and
 rules
To: qemu-devel@nongnu.org
References: <20200605073953.19268-1-philmd@redhat.com>
 <20200605073953.19268-5-philmd@redhat.com>
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
Message-ID: <c9d8b7dd-9c3f-a21a-aa82-c2346efb3474@redhat.com>
Date: Fri, 5 Jun 2020 09:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605073953.19268-5-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Err extra 'and' in patch subject, should be:
"rules.mak: Add strequal() and startwith() rules"

I can respin the whole if it is easier for the maintainer.

On 6/5/20 9:39 AM, Philippe Mathieu-Daudé wrote:
> Add a rule to test if two strings are equal,
> and another to test if a string starts with a substring,
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  rules.mak | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/rules.mak b/rules.mak
> index 694865b63e..ccc1c49604 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -191,6 +191,20 @@ ne = $(if $(subst $2,,$1)$(subst $1,,$2),y,n)
>  isempty = $(if $1,n,y)
>  notempty = $(if $1,y,n)
>  
> +# strequal
> +# Usage: $(call strequal, str1, str2)
> +#
> +# This macro returns a string (TRUE) when @str1 and @str2
> +# are equal, else returns the empty string (FALSE)
> +strequal = $(if $(subst $2,,$1)$(subst $1,,$2),,$1)
> +
> +# startwith
> +# Usage: $(call startwith, startstr, fullstr)
> +#
> +# This macro returns a string (TRUE) when @fullstr starts with
> +# @startstr, else returns the empty string (FALSE)
> +startwith = $(findstring :$1,:$2)
> +
>  # Generate files with tracetool
>  TRACETOOL=$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
>  
> 


