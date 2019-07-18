Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4EFC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294E72173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294E72173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho4FT-00040P-5Q
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho4FE-0003Z5-S8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho4FD-0006ht-J7
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:06:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho4FD-0006et-3V
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:06:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so25250268wmj.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 04:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FX9cRg7FO4qut6N3StgNUiJ4hdpV20u38o6YwFO+BWc=;
 b=LN/sEgBRORvVkJ4BHr3n845STqsTtTTSwGnuRlIMp//qELB5Ll+k2RBbos0yGmAL7/
 SDHXTy4VfEMCqiK0WR912Q406BeULIy1EZL0R1n/r1pj5/hFlaYGhINHJxrX0W1Rd0lk
 qfQZ1Vd/hlxWMFBd2zOIJS9ZUC4m9VMUACXCN2T+snGCzkHpS06E9X5dy8Y/g/Q3FrW7
 JQw9JbuUt0FeCB8CS0wB1PA/Ig8ixU1cMEbrYBkOcHhWyEuHpGhNH1bJg7VHTJXTCo3s
 zH0393C5ax0QpBg+BSMt4YCTHKeEexngwC0xoxPK4wIFnCrCvk393i7mqaXVwKSwB1iM
 Vp3A==
X-Gm-Message-State: APjAAAXttw3HNZvru1UL1WM1WdAsUbDCDKoEciwZoCNCE3FtcckkMYK9
 Wm2HOCHE5n/H1EjSco7kfWDWiw==
X-Google-Smtp-Source: APXvYqyW7y5QPFK6eA745m6NMTzDjLSQiRaLS/jupO024Vc8QtDrRrRpD+qm9xBcbneB42H9cIjDhw==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr43461189wmk.40.1563447997223; 
 Thu, 18 Jul 2019 04:06:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id f70sm29018156wme.22.2019.07.18.04.06.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 04:06:36 -0700 (PDT)
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190718103951.10027-1-npiggin@gmail.com>
 <20190718103951.10027-2-npiggin@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c5e19e51-3a46-c56d-c555-691ec63dcf6e@redhat.com>
Date: Thu, 18 Jul 2019 13:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718103951.10027-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: don't emit the RESET event on
 wakeup
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
 Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 12:39, Nicholas Piggin wrote:
> Commit 1405819637f53 ("qmp: don't emit the RESET event on wakeup from
> S3") changed system wakeup to avoid calling qapi_event_send_reset.
> Commit 76ed4b18debfe ("s390/ipl: fix ipl with -no-reboot") appears to
> have inadvertently broken that logic.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> I'm not quite sure if this patch is correct and haven't tested it, I
> found it by inspection. If this patch is incorrect, I will have to
> adjust patch 2.
> 
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 5089fce6c5..ef3c7ab8b8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1550,7 +1550,7 @@ void qemu_system_reset(ShutdownCause reason)
>      } else {
>          qemu_devices_reset();
>      }
> -    if (reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
> +    if (reason && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
>          qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
>      }
>      cpu_synchronize_all_post_reset();
> 

Yes, it seems correct and I've queued it for 4.1.

Paolo

