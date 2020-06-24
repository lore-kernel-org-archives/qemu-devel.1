Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CAA32084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boFwOeKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAA32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2PH-0002UH-Jf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo2Oh-00025I-83
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:12:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo2Oe-0003Tr-Qn
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592993567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MeQh0KcKMS16uBdDw1SUqVjKqcyJX1kjNgKInvzc3sw=;
 b=boFwOeKnxM3Ul2TqYTDbJK5ai5GUw8Dp1E5zGzKaLb2xA0aTkI6Kzvr7SZmh7rJTYBGr56
 N2HmWGOilva1ujFOhVRMd5BqyNMm0ZKzz0YOCp0nR0pqXM+2fe7EePkfrxg04oYi6IxqgU
 vraSTrWrcrri3HAWAwb9W4D3JP5xMPc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-IRG9or8aNYSQYUWWna0Miw-1; Wed, 24 Jun 2020 06:12:43 -0400
X-MC-Unique: IRG9or8aNYSQYUWWna0Miw-1
Received: by mail-wr1-f71.google.com with SMTP id i14so2319959wru.17
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MeQh0KcKMS16uBdDw1SUqVjKqcyJX1kjNgKInvzc3sw=;
 b=ta4Lp0LPiXREPN3XSylvRiPtIQoUdJpkXRYscWfII/oWIXaq01uHb4yt78AzA19GM1
 20PvdEVUsETujBFxNONmXQAu3E0EEcXdmUbpUmWSO0q35f4GVE80CVE3dpJDP+RPLX5M
 D7cv02XkEsomnKI+wXbOj20A+rl9w2+fDkWjduuHBcpBS6L8ItluL5dfNxmR+4WkrdFK
 vOKBKEDtlJ95Im1RAIuKi7/NGn/29ydVNhL2jKgovAbcMw3C/ffOYuoIfsJpAMRwAy96
 XOaqYo0LBiehHdANCsfA92kxk5pvya45r6tcebYEoFqdl42e2Z0pfferflWyX1HPQ41Q
 uT2g==
X-Gm-Message-State: AOAM530/MpJGGDqQgqHhr9qpScbCfb2TYvmAqJiSXRCBaynI4tzHajXL
 iBr+54vh/G2QePiu50yopyaUgLgCBMExjKQI5FhK2FPAgXmrQsURHIhhFeNo9wi1ZqVacUGMb+6
 TclAdfHUkDQjfzow=
X-Received: by 2002:adf:e948:: with SMTP id m8mr26749868wrn.398.1592993562565; 
 Wed, 24 Jun 2020 03:12:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweIPHaNDF82fRCH576dq3MzIxV3bjcxKM+HI05vKyRfReu/sxuLbihAZANGop8B6DM8O3mmw==
X-Received: by 2002:adf:e948:: with SMTP id m8mr26749838wrn.398.1592993562319; 
 Wed, 24 Jun 2020 03:12:42 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u84sm4056268wme.42.2020.06.24.03.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 03:12:41 -0700 (PDT)
Subject: Re: [PATCH v1] chardev/char-socket: fix double free of err after
 socket is disconnected
To: Derek Su <dereksu@qnap.com>, qemu-devel@nongnu.org
References: <20200624100054.7168-1-dereksu@qnap.com>
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
Message-ID: <c0bcaab9-9a9f-e8a7-8ae7-e886a44a968e@redhat.com>
Date: Wed, 24 Jun 2020 12:12:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200624100054.7168-1-dereksu@qnap.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: marcandre.lureau@redhat.com, lichun <lichun@ruijie.com.cn>,
 jwsu1986@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 12:00 PM, Derek Su wrote:
> The err is freed in check_report_connect_error() conditionally,
> calling error_free() directly may lead to a double-free bug.

This seems the same issue Lichun is working on, right?
https://www.mail-archive.com/qemu-devel@nongnu.org/msg714709.html

> 
> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>  chardev/char-socket.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index afebeec5c3..a009bed5ee 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1086,7 +1086,11 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
>      if (qio_task_propagate_error(task, &err)) {
>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>          check_report_connect_error(chr, err);
> -        error_free(err);
> +
> +        if (!s->connect_err_reported) {
> +            error_free(err);
> +        }
> +
>          goto cleanup;
>      }
>  
> 


