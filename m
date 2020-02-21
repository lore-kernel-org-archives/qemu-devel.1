Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD892C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A949124650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsvpJ6b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949124650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BJY-0000fv-RR
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j5BGf-0004XI-EI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j5BGe-0001dU-9M
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:35:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j5BGe-0001dG-4O
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582302907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FqQ5bmfN4OvNYtgAf68tgPqRdiyELkuny+qMvcIHj/0=;
 b=AsvpJ6b4p/AwJmHLKQnEG9CVtBiIshjt7/7qnob7SSEtFRrjY9cT1sOOGyV7dsDXIAtk/9
 bSgsoNLAFujek+0EgpXNsjdHSwXkinBNNwCY46M4lOyt2Hx64iMgXrNboH2vFpYkwIU2uI
 KLMiAe1rhwAvrcaJU8YgK7Q2lvG8CO8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-vVYiuvRDPimPKJYArCl_oA-1; Fri, 21 Feb 2020 11:34:59 -0500
X-MC-Unique: vVYiuvRDPimPKJYArCl_oA-1
Received: by mail-wm1-f72.google.com with SMTP id f66so796131wmf.9
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i2hRe049UcKIW7MyO7lEttWfezkFKVpAk4hp99MlBoc=;
 b=ULpTvmQ2ORBbcyZ7jd63ThPOyy1YtkD0aa5IIKASwEDON7ErCVGMhChjZ4ITPsuQl+
 Fl92u7RyPm4GfyaRVdRygKivxTJ3P9TZ+mXfj2NqP75uw7kiXC5X3X9xcHbZmj9bvKuH
 J4evELBzNP1Uxtfi8cPKS2numdHe5UFNBfy16aGZy1uHItmtDI76NBmmsZOyjk8fq4Jv
 iOdKwvbXujRKGtvQtyv09E4+NMXohKVm5LwjW7l2UEDCENd9l3c0DISW4pTU78k6qixi
 FwkzHXA0AUKuSlccL0J+8i2nb2uIn5HdIX33bpHTrnqOagcxn7/md+kOo+65PSIdKgiC
 a35Q==
X-Gm-Message-State: APjAAAWR6L4HNb98BSxcXxon4uzQBmSsQLe3O+U2ZzyY09dsoWnf8NZO
 llpsZ1ZwGLvyL6aMgzWCq0t0TmLM/V0nJipsA7HRJjh7Pv9wF/WaI3GY8JspTaXfaJufdhSjxyU
 8pp+bkayIid5ET+Q=
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr4960234wmb.114.1582302898459; 
 Fri, 21 Feb 2020 08:34:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeJts/QQTUhXQ/uKONSZcGSrougRhSKU35ysYxj/9uRlk5htcaoe04HbbcPmVIRAsRPf3t3Q==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr4960215wmb.114.1582302898244; 
 Fri, 21 Feb 2020 08:34:58 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id l6sm4436172wmg.42.2020.02.21.08.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 08:34:57 -0800 (PST)
Subject: Re: [PATCH 0/3] hw: More dma_memory_read/write() API cleanup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200221132550.22156-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37f2a340-339e-bcf9-05ac-947e50caa339@redhat.com>
Date: Fri, 21 Feb 2020 17:34:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221132550.22156-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 14:25, Philippe Mathieu-Daud=C3=A9 wrote:
> Following up "global exec/memory/dma APIs cleanup"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg681475.html
>=20
> Few more cleanups in PCNET & SCSI ESP devices.

Can you send a pull request for everything?

Paolo


