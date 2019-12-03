Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCCFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A922070A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPf9+i6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A922070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7xP-0003Bn-LS
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ic7m3-0005iq-Hz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ic7lv-0006LT-Ky
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:59:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ic7lu-0006EQ-BF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575377953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVcXkrQE0MBjZ9L2CSdb9vSOINsPrRYIG+sD6FoKQEs=;
 b=gPf9+i6kf8jUJSmlz2j4w9SLQVQozn9Psm79E5H3lUC0AGWPu4f28s2Qp4qet6gLVh9pcz
 mjVfaOasRIVLmZXzqeBMyMyCJSt9esVxB6GlUD58Cy3VR6ja1G3qRgOimovakpGTwEmptI
 QrFsHStU/N9eg6VV+Jwl9uiW+rzLG1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-_PnFX1TfMAeYmlAvSyD7lw-1; Tue, 03 Dec 2019 07:59:02 -0500
Received: by mail-wm1-f72.google.com with SMTP id 7so934590wmf.9
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 04:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CVcXkrQE0MBjZ9L2CSdb9vSOINsPrRYIG+sD6FoKQEs=;
 b=MzecbbuKFdVWDV73JWduitaEggRU+USLTDu3R6WaUBCXF8Xe76RL8BiHJM55hfrc3T
 3KRYYNRloTJa4+W5oPUn82F4vYsOhlOGK63twbAhc5EEGrmwJEtOS/YVtTkASkOhK0i/
 XQn84VD/iRWu+PHyxvPQwtrGlD6CNRJQGPg22efEojBu8GJBSeXlz8d82Hi8MMv/VYzP
 MjTxUyYXPJ//fsZlK08GgHyw2j9TMR7R9PWg5TTmzDcZTH9a/4YdBLWLtxrGWl02FO7Y
 k/66CpnJqietLaOjH2bfqY2poZsDkzCeV8r5bQxKUL7ui+UHWxfWdSnb8rXAZ4V6YZMq
 dcTw==
X-Gm-Message-State: APjAAAVZp93Kzz0IPm53U59Wx4QxhiK08+MJqOfaGNsF3Xpo4yIehhJy
 gQw4TaTdAG+znMhBItWCbJJJfisPhMs3QbJqH/Cvtk3UUEGD3pb54CNdjQMnHD7rMzs7WYCsEOH
 gEAutYsCWICtXpCo=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr4981407wrq.396.1575377941561; 
 Tue, 03 Dec 2019 04:59:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwI0TUixu7roXMLrCnFcGn4FFGFBXWbnCVE0ei+SoFiyEC9g9yLMso/ro/YcduV+l+9L4SPqg==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr4981385wrq.396.1575377941274; 
 Tue, 03 Dec 2019 04:59:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id y139sm3027735wmd.24.2019.12.03.04.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 04:59:00 -0800 (PST)
Subject: Re: virtiofsd: Where should it live?
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com> <20191126121416.GE2928@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db27af39-62a8-46e5-fccd-f09ed497b7bd@redhat.com>
Date: Tue, 3 Dec 2019 13:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191126121416.GE2928@work-vm>
Content-Language: en-US
X-MC-Unique: _PnFX1TfMAeYmlAvSyD7lw-1
X-Mimecast-Spam-Score: 0
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
Cc: mszeredi@redhat.com, vgoyal@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/11/19 13:14, Dr. David Alan Gilbert wrote:
>> IOW, if we did decide we want it in QEMU, then instead of
>> '$GIT/contrib/virtiofsd', I'd prefer to see '$GIT/virtiofsd'.
>
> I'm not sure it deserves a new top level for such a specific tool.
> 

It could be in fsdev/virtiofsd, but I agree with Daniel that at this
point the QEMU build system introduces baggage that you may not want for
virtiofsd.

Paolo


