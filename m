Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABB5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C0D24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AysqhNyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C0D24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFIv-0006UE-72
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEZR-0004u4-Aa
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEZQ-0003Hr-21
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:27:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEZP-0003E9-Pr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drrlUBeRXsH4//fRAOs9Q0PWBLoHnYTTfAGzS/Zfl0M=;
 b=AysqhNygj4IEzdGIZImvEUJ57eHdtatrH6YYSqeDyjhYYjfpbp7kUFaGow6n7o5S5HkEdD
 ZAcBxtpXRghbGW9gsBgW3rVt2+/aOlpXOYjBJ4c4EklyfVcDnqKuiidAmwuynl/6HK0Rni
 98UP9OdaHTrbENyiRyegb7PIuj+AI8Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-hNCOUhXaOK202cR_MjAeoQ-1; Fri, 06 Dec 2019 09:26:58 -0500
Received: by mail-wr1-f71.google.com with SMTP id u12so3212372wrt.15
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=drrlUBeRXsH4//fRAOs9Q0PWBLoHnYTTfAGzS/Zfl0M=;
 b=rTfLon7zq1F17EGw5BZ7ziBMPFRPM/79kX6GQxBJi7cTvog729OQ5l7AKMxzt83KoC
 mNADRtkrfiU7oP1LCSmVmAingp+pgHoWz6K3WMabQtMbM4lniUAHzepzcnwpHPnrKXFW
 G7b+FRdQNsN0JRKVQs08oodh+j0pRp4sGqy2U9L7eiQrZe1UfiHX6DeMK6EfW95YH7OX
 HfWL9wm9keFxUzz/VQwJTvnO6owx4dglDoX+WTKWDpTf9UCSSv5Bx4EVeFEe+XAWpw+U
 WcO6fujngRYhp6mtSCj77W79hP9deVoidH/BUJb5AdG20wdNMcOXaBm39hsfcCZVEwIP
 5rug==
X-Gm-Message-State: APjAAAX4a7+lGphH04CL8A7VFiaHlLNhezXyLI0ts/IsAFmctk8F+WWL
 eVIkD79pe3CS5bmNzulobupvWdab4aVNVbUclzDraNs81oNoLDxaxr4jytHU4vNgZ5/t4XeYdxi
 YSVV/2lTocXpoci0=
X-Received: by 2002:a7b:c851:: with SMTP id c17mr9297087wml.71.1575642416829; 
 Fri, 06 Dec 2019 06:26:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzICzQzyAC9nTfuBbYeu+41iRx2AFm5TwOleq1EQSVuLNkCx8pCAq4pXMsBhWBpOhGml4FVzA==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr9297072wml.71.1575642416652; 
 Fri, 06 Dec 2019 06:26:56 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c2sm16462376wrp.46.2019.12.06.06.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 06:26:56 -0800 (PST)
Subject: Re: [PATCH v2] s390x/tcg: clear local interrupts on reset normal
To: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Hildenbrand <david@redhat.com>
References: <20191206135404.16051-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2556651d-d5bd-6753-96fd-0bcc1c4df8c3@redhat.com>
Date: Fri, 6 Dec 2019 15:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206135404.16051-1-cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: hNCOUhXaOK202cR_MjAeoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 2:54 PM, Cornelia Huck wrote:
> We neglected to clean up pending interrupts and emergency signals;
> fix that.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> v1->v2:
> - rebased on top of my s390-next branch; we can now move the fields
>    to be reset instead of clearing them manually

Yep, much cleaner than v1 :)

> Further cleanup possible in a follow-up patch.
> 
> ---
>   target/s390x/cpu.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 7f5fa1d35b73..e195e5c7c8bb 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -98,10 +98,6 @@ struct CPUS390XState {
>   
>       uint64_t cregs[16]; /* control registers */
>   
> -    int pending_int;
> -    uint16_t external_call_addr;
> -    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
> -
>       uint64_t ckc;
>       uint64_t cputm;
>       uint32_t todpr;
> @@ -117,6 +113,10 @@ struct CPUS390XState {
>       struct {} start_normal_reset_fields;
>       uint8_t riccb[64];     /* runtime instrumentation control */
>   
> +    int pending_int;
> +    uint16_t external_call_addr;
> +    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
> +
>       /* Fields up to this point are cleared by a CPU reset */
>       struct {} end_reset_fields;
>   
> 


