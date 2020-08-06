Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593AFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA2422D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMsuHn0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA2422D0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3a3q-0007rF-BD
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 03:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3a3H-0007NU-1u
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:10:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3a3F-0007fJ-E2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596697856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HjlUUyt6q/M0L0xwbOd4+39YgejlfpZMIsAnnnkGegQ=;
 b=CMsuHn0TWN+GxJ8/8uUnS6TaB5JJKKFR+l3C9CXXDi247FroWibmagCZUoy0VRn/DpvLE+
 2QC6xy4OXF+b9RAakhaPP4e5Xo9PO6czxUcEz/w0DzJu+V0P4QxiKCZhHnVxCbzO8Sey7m
 WmbdZo7NxFFSfUkt84qDCxSMKJFW/iE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-P9oGoIBaOTScqt7t8IJ62A-1; Thu, 06 Aug 2020 03:10:55 -0400
X-MC-Unique: P9oGoIBaOTScqt7t8IJ62A-1
Received: by mail-wm1-f70.google.com with SMTP id z1so3736899wmf.9
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 00:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HjlUUyt6q/M0L0xwbOd4+39YgejlfpZMIsAnnnkGegQ=;
 b=gT2/XLRhdTW3RyCs3FIjBEN8lzLDN4JR9xsh5poSv7uKOeZOFqcCXoA0CiWiviz8Wf
 0wwJtRtpZM+lnd5IrW3n9PcvdtwTxM60Eva6OSKsq0uWCpLEJVBuJWD8FZQwvLpezQIl
 wRMUqf5+Af7H1/kQGY4CVFuab0VKDwUkA3LmJybHkdX6G2+8kuraBmU2XbvvvM7nEMnY
 QQ8uAFrHwfeLNsTlVe2Np6UvkqmihndTixLkPS8B5U9TTB8vxexk80G+h9XwFnWNumOK
 OkSENwKQldU/AucPLbNzn409+CrPvtx1c+KEIvOGBhdwNvHQHYZArD3fPiu7NB0S84xg
 Yi2Q==
X-Gm-Message-State: AOAM531WMUiujwWJMfxr7ev6zIsMWLXaChBsFB6iBGlaWmfOrTJ/T2df
 H/0DFf7hFA43WjVBGupZVwbCWJq+Ouri96qKtAYROZNAcL9lyjzoZUY3b9X2KRljX8Ai0iZbwSW
 8TKw1dwvsuoxeuH8=
X-Received: by 2002:adf:82a5:: with SMTP id 34mr6082788wrc.266.1596697853770; 
 Thu, 06 Aug 2020 00:10:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhuuT2VeTa8kg9J31SADd2roKrRa7yOH0tH/ssvjEywsfQbnaZ+9PGJnQn0hr+Ix7NtRMIwg==
X-Received: by 2002:adf:82a5:: with SMTP id 34mr6082774wrc.266.1596697853606; 
 Thu, 06 Aug 2020 00:10:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v29sm5388568wrv.51.2020.08.06.00.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 00:10:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] async: rename event_notifier_dummy_cb/poll()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200805100051.361547-1-stefanha@redhat.com>
 <20200805100051.361547-2-stefanha@redhat.com>
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
Message-ID: <10c4385a-f251-cf3b-a76d-268c3ef734d8@redhat.com>
Date: Thu, 6 Aug 2020 09:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200805100051.361547-2-stefanha@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 12:00 PM, Stefan Hajnoczi wrote:
> The event_notifier_*() prefix can be confused with the EventNotifier
> APIs that are also called event_notifier_*().
> 
> Rename the functions to aio_context_notifier_*() to make it clear that
> they relate to the AioContext::notifier field.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  util/async.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/util/async.c b/util/async.c
> index 1319eee3bc..d9f987e133 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -445,12 +445,12 @@ static void aio_timerlist_notify(void *opaque, QEMUClockType type)
>      aio_notify(opaque);
>  }
>  
> -static void event_notifier_dummy_cb(EventNotifier *e)
> +static void aio_context_notifier_dummy_cb(EventNotifier *e)
>  {
>  }
>  
>  /* Returns true if aio_notify() was called (e.g. a BH was scheduled) */
> -static bool event_notifier_poll(void *opaque)
> +static bool aio_context_notifier_poll(void *opaque)
>  {
>      EventNotifier *e = opaque;
>      AioContext *ctx = container_of(e, AioContext, notifier);
> @@ -508,8 +508,8 @@ AioContext *aio_context_new(Error **errp)
>  
>      aio_set_event_notifier(ctx, &ctx->notifier,
>                             false,
> -                           event_notifier_dummy_cb,
> -                           event_notifier_poll);
> +                           aio_context_notifier_dummy_cb,
> +                           aio_context_notifier_poll);
>  #ifdef CONFIG_LINUX_AIO
>      ctx->linux_aio = NULL;
>  #endif
> 


