Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FDCC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16822071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3Kyydel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16822071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4k1J-0001bi-TJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4k0k-00011x-6e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4k0j-0000jV-9C
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:28:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4k0j-0000j2-54
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582198132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eLaGLe/1FrLGSQbvP2Ey17N730BAci5QD+lJ4VFXjg=;
 b=H3Kyydel8k89KZV7M+XFi9OjOSE4Z/cQyiV+YZKUvTHxUnodO33TzZbo/tsYwMoxgrKnJh
 EpeylZxVCETOLagRLMrXG5L5+NIVKgEFxQCBjg2pqnI0LYnwhy8TNGUWos0FyQcStYqgzP
 4CzDADND6HRlyJVRSKVpD12AaelkcnM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-zr7aD4OjM_ubYLfKWAEV3Q-1; Thu, 20 Feb 2020 06:28:51 -0500
Received: by mail-wm1-f72.google.com with SMTP id u11so700277wmb.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 03:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5eLaGLe/1FrLGSQbvP2Ey17N730BAci5QD+lJ4VFXjg=;
 b=Tqefu65GzT5Jd/wtVOkfp94BqAArUNNKzN9NMOJZikzztEhS+nMGhkNDDlRB9jLSAj
 6B3mWpkLXtV6HXOGL3S603GUlIGuGAoTq3/xGoFPnK0n5ZUedAMAlbuiRwvoGgEmYvjH
 FUlgO1q9vZfCCDGGit6iCqz5jRWQo+Q/w+XmNHamSaZwdIOQvGeHOqRFAiDDwU38MKzb
 rPm5+B3KjYx22sbbmuy+SMsn6VpVJ9+UvbKU+uU6t5dCbJpGbRoNHOR1GfUnEAGers5X
 jO34IlexXr1LqCND1RZ/43w0WoMUt/ujAv8Q8a1n+mFWPH8LF84dnRiRmrQbP8cpN2i5
 S+OA==
X-Gm-Message-State: APjAAAUb5qy4W4CEO/dwiUG2tgGfN3KkPnYVoYmaLHaOZiTtl11694h0
 u4F+/fFShXieFfd/hIBRNU+QHaunjdcxFMZXUdOZ4U/z4M++v+smWn1y0HWqz3dBMTN57qLyLnM
 GKaOKErzmd7TBy2o=
X-Received: by 2002:a05:6000:1208:: with SMTP id
 e8mr43805121wrx.351.1582198129958; 
 Thu, 20 Feb 2020 03:28:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzB0c7Ji28jWOeIGFEIsgdYwa4PIwSgBqobYfjMywrqpWBlb0DVEK4DBD75O7+jFGiSyQOWOw==
X-Received: by 2002:a05:6000:1208:: with SMTP id
 e8mr43805087wrx.351.1582198129713; 
 Thu, 20 Feb 2020 03:28:49 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id q3sm3992574wmj.38.2020.02.20.03.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 03:28:49 -0800 (PST)
Subject: Re: [PATCH v2] Avoid address_space_rw() with a constant is_write
 argument
To: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200218112457.22712-1-peter.maydell@linaro.org>
 <fc70075c-0098-632e-7d60-4534202bf2f5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d56cf836-e3ed-b76a-fa08-3cff10aba156@redhat.com>
Date: Thu, 20 Feb 2020 12:28:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fc70075c-0098-632e-7d60-4534202bf2f5@redhat.com>
Content-Language: en-US
X-MC-Unique: zr7aD4OjM_ubYLfKWAEV3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 14:13, Laurent Vivier wrote:
> There is one in target/i386/hvf/vmx.h: macvm_set_cr0() you didn't change.
> 
> You must update the script name in the script comment (as suggested by
> Philippe) and in the commit message.
> 
> Anyway:
> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks, I squashed the change to vmx.h.

Paolo


