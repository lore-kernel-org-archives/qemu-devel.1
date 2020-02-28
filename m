Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB788C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8227320665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE55ZvCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8227320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7czt-00085a-M6
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7cys-000785-Qy
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7cyr-0008Mv-4T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:34:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7cyp-0008MK-Jl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAR3RpoqGnkINoviA1d7W2jJYb67of4WLZtMwjT9FP8=;
 b=cE55ZvCrDnht/XMPkKaa0zJtfl7L80BuS+975LmC8pqzMRyejKy6ifwA7RLXi3s3b2u8I/
 AwRRXyzMqFbhV5sGKlzo9vr0QlZS5NeYdJBn8XzUkLjyXZKsIX/lil+KglhMZwkWiREEi8
 vQolK4M5kdLsfZ0cgd2MubqiKj5P6qo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-6dFkZavRPVK6Dl-2r-J4dg-1; Fri, 28 Feb 2020 05:34:49 -0500
X-MC-Unique: 6dFkZavRPVK6Dl-2r-J4dg-1
Received: by mail-wm1-f71.google.com with SMTP id r19so988614wmh.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qAR3RpoqGnkINoviA1d7W2jJYb67of4WLZtMwjT9FP8=;
 b=F2Gz3yMlaxKMF7jot0Ei97ucaErxE7fgkFdkuIN5XkbTYgHlKlok9C2jh56iJDCuTW
 d7DnxjKi4mTS85s0et288SHMafkMbX9Rj9SLdk1DC8U926npV5hp0lx+BNJu3smLD+Mh
 h4Utt859xF67GQkmFR0V1BTWLpdD1Q/FJUD1tEnXTaTm+k+hAvWeDc2h9r2jxquYv1xa
 sdPdrmE/tNo/FiwbXXSUmvYHHxFfrkWBlcYi2Xcb5AyD5VOzHpZQZhGUgtSmuWjj4zcJ
 qiY3nM1BalNxv8OxgVUxI5Ljenmx7l6i+VkpCeizCXGnTT2vRLjUuybGq+u9osRfW+4w
 10JA==
X-Gm-Message-State: APjAAAUqsIBR4jF5CI1xKmMbqsybr2puDKkrCFcJjVB+Cg6Mzm6+y+bi
 2yl2wizHXQ6OTMl/pfP/fvF2uBiZf9yDKfg2FsaRrkN6FVVfIxG4jrJuM0RmoZxKNiwmykMRXfk
 CcWsxAQc9XQUoQe8=
X-Received: by 2002:adf:b6a2:: with SMTP id j34mr4386390wre.277.1582886087892; 
 Fri, 28 Feb 2020 02:34:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFcl44+DmpP7Rd0GJStqOUSAj0Qmw5GES39SZIpxWYqcHOGl95RT5sBpkDmekdS9HtmBDvCA==
X-Received: by 2002:adf:b6a2:: with SMTP id j34mr4386370wre.277.1582886087626; 
 Fri, 28 Feb 2020 02:34:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h17sm12262758wro.52.2020.02.28.02.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:34:47 -0800 (PST)
Subject: Re: [PATCH 4/5] KVM: Kick resamplefd for split kernel irqchip
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200226225510.217077-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c8147b1-ee26-cd5d-1592-f07371feaeb8@redhat.com>
Date: Fri, 28 Feb 2020 11:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226225510.217077-1-peterx@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/02/20 23:55, Peter Xu wrote:
> +
> +            /* Kick resamplefd if KVM is bypassed */
> +            kvm_resample_fd_notify(n);

This is only needed for level-triggered interrupts, so it can be placed
below the test.

Paolo

> +            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=
> +                IOAPIC_TRIGGER_LEVEL) {
>                  continue;


