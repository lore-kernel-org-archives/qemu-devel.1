Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDAEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CB420702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9KYPYtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CB420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvUF-00032W-IN
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvTh-0002dH-Lt
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:25:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvTf-0005vy-Aq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593681954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGFylmIN2ZxP+sdppFFjaTbrVB+ecrJJEe8IPWBp5K8=;
 b=b9KYPYtC2a6lX09LQeFYa2Gk4WDH9/B1UTTNq6tbAuK8oCT6KR2OU1zc+illIqb+9pvrGT
 Wk/cGW36gIO5CzodHutY7b1R0/uo7xDPVsB9W9sof/fqhkS8lLpWO1eXU6xCzVAR9HP5Pt
 T4LuzLgxsi2WVlT4mOzRKD9bthq1AAI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-dgIQgCGvPrmo4kQRmvgaZw-1; Thu, 02 Jul 2020 05:25:52 -0400
X-MC-Unique: dgIQgCGvPrmo4kQRmvgaZw-1
Received: by mail-wm1-f70.google.com with SMTP id 65so7815880wmd.8
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KGFylmIN2ZxP+sdppFFjaTbrVB+ecrJJEe8IPWBp5K8=;
 b=jKg2FRnAMjau+/jhFfOBIKDig3BSUfhRAMXab+I9jNi1kJSl7MQ178X3YMNViBKQNH
 Oc0lQpNo76Rel2SCe9JaY34vFzc00O0KNJlL8tGdJ0F8o2lhfN7828+kTR6EQAFM1kYb
 u2PUu6udesHFztkQKlZwkb4WAbZKQbXzjYvS1vy2TUVw/8A4RZIbQaDp5b4oolzzernI
 XWKZ7LxG2lW6O2eRSq1v6KokHcN+lQCOxlDBD4I1ujq2ChafteIx/ixorUhEXKqWlDKo
 qkHBm1W0jtTs1G7hLIgJXzXtu7OvHO5Q84Qv9ZBMvFj9lgPoBrG0ukLFNkPqVYhz1YTK
 bUew==
X-Gm-Message-State: AOAM530DqgznLpA+KDsrqOQHqnjIN5i3UGg9PMlOV37KAXOJLFuBwPGB
 +fRc5CDxcKUlXr5oaTWt6XjAUcgzl3Qe8VjPFqBiYwpbbyqo84ZZ5srNvkgSEMIcZyb3b+ySjS/
 RcEnkeEw80lcqkCQ=
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr29414059wrm.379.1593681951488; 
 Thu, 02 Jul 2020 02:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4ZGjEI+a7Kex21x62r2ELqay2efpQ8dMbVYmLuzYsXzosyGuYC0wYl/Yv6VBzx/Whxp8PhQ==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr29414044wrm.379.1593681951281; 
 Thu, 02 Jul 2020 02:25:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id 63sm10969289wra.86.2020.07.02.02.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:25:50 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
 <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
 <20200701185530.GB1090525@aurel32.net> <20200702050912.GA1126181@aurel32.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bad9f814-eeb0-574b-eaae-dc88ef665da2@redhat.com>
Date: Thu, 2 Jul 2020 11:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200702050912.GA1126181@aurel32.net>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, aleksandar.rikalo@syrmia.com,
 qemu-devel@nongnu.org, Paul Burton <paulburton@kernel.org>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 07:09, Aurelien Jarno wrote:
> On 2020-07-01 20:55, Aurelien Jarno wrote:
>> NACK
> This NACK was because I find inacceptable to claim that you got not
> answer from Paul or from myself after very few time.
> 
> Now about the content of the patch, QEMU used to be a fun ride, but it
> happens that interactions are now hurtful, especially on the MIPS side.
> It's time for me to leave this community and say goodbye.
> 
> So as far as removing me goes:
> 
>   Acked-by: Aurelien Jarno <aurelien@aurel32.net> 

So long, and thanks for all the fish, Aurelien. :)

Aleksandar, I strongly suggest that you take a break from MIPS
maintainership.  To be clear: this is not a reprimand or a retaliation
of any kind, just a suggestion to improve the interactions on the MIPS side.

Let Philippe, and Aurelien if he changes his mind now or at any time in
the future, do their job; act as a "regular contributor" for some time.
 You'll see that the world will not end and learn to appreciate the
effort that other people put in making MIPS support in QEMU a little
better, a step at a time.

Thanks,

Paolo


