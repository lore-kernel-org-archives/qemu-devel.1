Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC92C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F9F2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7y6/fcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F9F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmpH-0004ns-Oo
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgmoj-0004Nd-Oa
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:09:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgmoi-0001RH-Vz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591265383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OWb86L5WPps7QigoTNsHKIqTAXNKuCACNlrGn8je7VQ=;
 b=Y7y6/fcGYiyQrdtrb5W9EZ01CBle8UT/Ad7QK2ANx0otq0kOMpGdvzkTdOlFOBwRtPBLav
 EEnHaaAv7uPj8gf+kqGIvy4wpytiQxGBidKClfGYZOyw2oSHAx+DUHrM83O3VZ/lwcNMKg
 nWAj0p6chstgB9JgB81dAVsa/v/xBlo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-jN3nL5GIMWK4HtTlMrVVkg-1; Thu, 04 Jun 2020 06:09:41 -0400
X-MC-Unique: jN3nL5GIMWK4HtTlMrVVkg-1
Received: by mail-wm1-f71.google.com with SMTP id h6so1630786wmb.7
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 03:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OWb86L5WPps7QigoTNsHKIqTAXNKuCACNlrGn8je7VQ=;
 b=K3cegY0cvC6wOExxQYk791w8ldzgRooPTqk+ToXowwikDogPIXUaGw+R8YqHDkKHtg
 UboEnQtVp3Q1U28biJ2FqUvsCXsgXGJXdUTFrsFLYCPNgN4wAo+BDjAfBcSclt37tGEz
 rEKxwGsDg3HuUJgfHfYSoLNj8kuAaVUjY2+dP2fcsDrO1b0m2OX57CNWWOggyZX+6jqt
 AznAbFv74FllCN0mulTFHn1lN8bnW4T4r9cWwJP6ij7hDTFphF4ln9PYKy20fOxE2d6n
 gwmaFis3NJ31oL0M4dX6tChbYTWr8S5Rlu06PdRhf8St9feWCzh/InmQLD40HYUC/5La
 Jf6w==
X-Gm-Message-State: AOAM530V9PSwnb+Z5H2Kejg5/5yTUecQl+FrXaCahAImFfzWcG8BZ4d5
 Tk3hIukIlJWVQwyHysYNmtrQ2OhbfGiLUnJRQ/JochOE8z9RlOaWRWtmZAyddR2OERxQN2I7q8o
 U1gIL9gV+fpFBNSo=
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr3883926wrs.115.1591265380652; 
 Thu, 04 Jun 2020 03:09:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu13PPsjQJb54VLjrjnrW3TdAwOeb7rwNb+zbYqjZyu/ZARgOQk24wz+iHStRIL3u8haoyQg==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr3883914wrs.115.1591265380421; 
 Thu, 04 Jun 2020 03:09:40 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o15sm6555338wmm.31.2020.06.04.03.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 03:09:39 -0700 (PDT)
Subject: Re: [PATCH] qga: fix assert regression on guest-shutdown
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200604094425.63020-1-marcandre.lureau@redhat.com>
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
Message-ID: <48df1081-45ec-a5e4-7110-2a7ce027f831@redhat.com>
Date: Thu, 4 Jun 2020 12:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200604094425.63020-1-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 11:44 AM, Marc-André Lureau wrote:
> Since commit 781f2b3d1e ("qga: process_event() simplification"),
> send_response() is called unconditionally, but will assert when "rsp" is
> NULL. This may happen with QCO_NO_SUCCESS_RESP commands, such as
> "guest-shutdown".
> 
> Fixes: 781f2b3d1e5ef389b44016a897fd55e7a780bf35
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/main.c b/qga/main.c
> index f0e454f28d3..3febf3b0fdf 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -531,7 +531,11 @@ static int send_response(GAState *s, const QDict *rsp)
>      QString *payload_qstr, *response_qstr;
>      GIOStatus status;
>  
> -    g_assert(rsp && s->channel);
> +    g_assert(s->channel);
> +
> +    if (!rsp) {
> +        return 0;
> +    }

Why not assert after the check?

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>      payload_qstr = qobject_to_json(QOBJECT(rsp));
>      if (!payload_qstr) {
> 


