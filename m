Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDAFC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4825A205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xu6za6ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4825A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDoLD-0001r5-Mw
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDnw3-0001i1-SQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDnw1-0000Ur-SN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:29:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDnw1-0000Lq-NI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584358169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNJVvsOTx9nhr+VEztQndxE6Xse4s6X2PFMf2IBjuz8=;
 b=Xu6za6ryudcTVCfcdpEiSHJWzzVAHhefnx2CQiDtfasYxlGXtUUJ4gD6SPmcHsSuaJDMvg
 nhl4bXc4e7UAkD8fbjlQR13T3EsRPj6lpEdDMraYijHpy2CIKbLXuL2nWaoFzgR8K41i4F
 opi2sEUqoSfRjTyBiCoZoFpOF/PWNu0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-enWQXXAnMSOToIvw0_oR5A-1; Mon, 16 Mar 2020 07:29:27 -0400
X-MC-Unique: enWQXXAnMSOToIvw0_oR5A-1
Received: by mail-wm1-f71.google.com with SMTP id f207so5666706wme.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 04:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fNJVvsOTx9nhr+VEztQndxE6Xse4s6X2PFMf2IBjuz8=;
 b=ZzfR0ug7oEdSgS4x2rLxsfVmR7uZlWWq3yein2Em3z/36kR6D0GDlXKLPbI+gq0UGB
 vcukoJ4Nt85VkeRoqSwkoWlqUaxFFEPIO+7ye+tAERnWqaaaWY2GXmrsx87+bx8yDG1C
 LXOa1rg0RU4C8t4SLg1sTPqn34grz44MI3CdwTt9+QYRkuBu8GjjBGKJwM/9kE2Ww5gK
 ixCWDbx/rXL43pjMGI5uJ7L7MvAP4e3nQ2WXKWq1ScuTpgr8hD/MVFz5Utlhl2/oD5md
 v7cW64BwlDm4O9k0mJH10SauajM7GYodufE/236QeXni/v9GQWAZ5yD/6he6HSn67W4d
 lczg==
X-Gm-Message-State: ANhLgQ07SUSS3CGkswOf9d2f7IsF5ZBtkUIuFkhV3e4AiW+225DyISEQ
 S838BJ1mfuYwgJ2qHGPdlGD30bhm0wBxOGZNNyT+MRD9FI8hWIT5P7xtRctdrsV+XwgyAh12PPP
 n0EhpU166dC4n2/E=
X-Received: by 2002:a5d:420c:: with SMTP id n12mr35514154wrq.173.1584358166448; 
 Mon, 16 Mar 2020 04:29:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vugvzP2ZYK7NdO0uA63NDbru0cO3x8dndNa17oUdPU3V6yGrloafd/knxdJos2X/1r6QaHGnA==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr35514127wrq.173.1584358166157; 
 Mon, 16 Mar 2020 04:29:26 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.82.39])
 by smtp.gmail.com with ESMTPSA id q4sm48668881wro.56.2020.03.16.04.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 04:29:25 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] thread: add lock guard macros
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200316110957.449700-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0442ea6-fe5c-a246-96ad-f32c10db11b3@redhat.com>
Date: Mon, 16 Mar 2020 12:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316110957.449700-1-stefanha@redhat.com>
Content-Language: en-US
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 12:09, Stefan Hajnoczi wrote:
> Lock guards automatically call qemu_(rec_)mutex_unlock() when returning from a
> function or leaving leaving a lexical scope.  This simplifies code and
> eliminates leaks (especially in error code paths).
> 
> This series adds lock guards for QemuMutex and QemuRecMutex.  It does not
> convert the entire tree but includes example conversions.
> 
> Stefan Hajnoczi (2):
>   lockable: add lock guards
>   lockable: add QemuRecMutex support
> 
>  include/qemu/lockable.h | 67 +++++++++++++++++++++++++++++++++++++++++
>  plugins/core.c          |  7 ++---
>  plugins/loader.c        | 16 +++++-----
>  util/qemu-timer.c       | 23 +++++++-------
>  4 files changed, 89 insertions(+), 24 deletions(-)
> 

Queued, thanks.

Paolo


