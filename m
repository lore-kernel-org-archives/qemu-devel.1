Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF4220679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAURGdpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF4220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLcB-00057m-3V
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgLbY-0004To-Qe
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:06:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgLbY-0007FG-2p
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591160779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vHCnmTHhUO6Ty+LJKao770znh8X+NBqjpuCl1/GoNcY=;
 b=gAURGdpv0YXmI+kSlN08prSWCyII4hAjG2Z5/tUVhjNAT5UDmv4wlad/X9gKkdjH13w80T
 mHv6ppq1dGl3tnN79V86UKTfe+rZ4JvxoBG0LlJsi8/Ocb+O6jkmP94hTr/Ap4VqmMCnAa
 uwtAluCco7cEXO19RsxKici0/xJsqNs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-R2F30d4xMZiLOL7sOsAGYQ-1; Wed, 03 Jun 2020 01:06:17 -0400
X-MC-Unique: R2F30d4xMZiLOL7sOsAGYQ-1
Received: by mail-wr1-f69.google.com with SMTP id h92so572790wrh.23
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 22:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vHCnmTHhUO6Ty+LJKao770znh8X+NBqjpuCl1/GoNcY=;
 b=Cb4ry8yU0sshO7Wtx298jEfu8j4KIS8K/rNALOqYWzOXTzWFIGELrCFdJGAl9siaOo
 SvpL8qyyGzDVlp5n8twyUVdSD3G67KvkcJvAn129P2Vg5+lnAE6v8fnn5JC0MeJdpKYe
 mJ1pCIX6cWd7wH3IvhTi47adC+IvNxVrZ48EfB87Cqj9R+0Dz+Vt5+eIAuPMP7mHiQ0r
 oWsXJej5QqwJNzbfof4DVnOrhUBoZ60lvjzHIT3PcBT00N+EvaYyybbzthZ+br9l3Fkp
 fMur18vwAdPPUdXm0vp5Ob9jzQeZJTyJLJIdSB2J3kZ6KqKCDNZkEUGcdXJWsX1FkIFH
 zzkA==
X-Gm-Message-State: AOAM530TSYmRt7CJpCqlVp1yhICl/fjiOpKo5V99o1kDAN90859fr0EO
 G08AHlKQ5jd1ZIWdg6Crp78CQqZmIocyEapN5/30grUilq6Cmz0mO/2Hvr3NJVfRmbIQPk9+6fI
 2Z976jiryA5X9BNg=
X-Received: by 2002:a5d:518b:: with SMTP id k11mr31722472wrv.58.1591160776594; 
 Tue, 02 Jun 2020 22:06:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNtJomm93d+A1c8knffSgNQYZZ7Wic9F6MBszuJIJPwOFAe+amMmLpCK+5cSms0ZGossiUuA==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr31722459wrv.58.1591160776387; 
 Tue, 02 Jun 2020 22:06:16 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a3sm1386341wrp.91.2020.06.02.22.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 22:06:15 -0700 (PDT)
Subject: Re: [PATCH] net: Do not include a newline in the id of -nic devices
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
References: <20200518074352.23125-1-thuth@redhat.com>
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
Message-ID: <db954c99-53f8-bc6c-3dd5-23928c52e31a@redhat.com>
Date: Wed, 3 Jun 2020 07:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518074352.23125-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 9:43 AM, Thomas Huth wrote:
> The '\n' sneaked in by accident here, an "id" string should really
> not contain a newline character at the end.
> 
> Fixes: 78cd6f7bf6b ('net: Add a new convenience option "--nic" ...')
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index 38778e831d..cbeeeadff8 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1506,7 +1506,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
>      /* Create an ID if the user did not specify one */
>      nd_id = g_strdup(qemu_opts_id(opts));
>      if (!nd_id) {
> -        nd_id = g_strdup_printf("__org.qemu.nic%i\n", idx);
> +        nd_id = g_strdup_printf("__org.qemu.nic%i", idx);
>          qemu_opts_set_id(opts, nd_id);
>      }
>  
> 

ping?


