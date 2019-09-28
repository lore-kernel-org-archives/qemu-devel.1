Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F473C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 22:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E736520866
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 22:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyLOrOTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E736520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEKwO-0005fq-20
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 18:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <avi.kivity@gmail.com>) id 1iEKv8-00055V-UL
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 18:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <avi.kivity@gmail.com>) id 1iEKv7-00006E-R2
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 18:10:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <avi.kivity@gmail.com>)
 id 1iEKv7-00004y-IO
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 18:10:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id r19so9406831wmh.2
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nkeUxjj36ZepM8oWB49mPStqiELyxq80JidP7FmdzpI=;
 b=fyLOrOTrR+ar2kpeOl5p633ihn/L85zIiZ0r6GKEFiBT6WaiMakAtcBkikUWYOZBVF
 DKDQhg9HIknom6pPmEa1U7R3/u5qukUAmR2v/81saoQ1UfC18ruonheiaKOqKqKylVqb
 0VYXwBkgyjTk5oOv/0UKwqnQ6D2d4QPVU1mzE2dpOGFcXe1o7HUl3HuQMN1xVt0GvHNw
 nLXig5FtPpGrXhP3ozjlJLq0WYsHHlNk1otEl0qCU3TNiEk7IrNlV0XB3YC45KjakGVp
 CaCBughdqekAfD06P8zN3Ku1vUWRkafS6iVpS/Vb4osh7f5QFLZMxkxGp9g10nGbd+Sb
 allg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=nkeUxjj36ZepM8oWB49mPStqiELyxq80JidP7FmdzpI=;
 b=X2m/F9o4Z+CY3xuOj0sEX4GiFJHKoiW+gPP+b3OMYpwZfBSDZ/q5QTyUMfmbAEV6pP
 WId87sj7J4yTEJaZNzlKf0ThmGdmgEktHYTKlU3xB1sjQsjFTPFXo8n9kA8qTqRmaVfz
 XhGZhCe6T+NLjzdR/nESmT2Sd50kk2jMWljGLUbD3Rr466jWevi0MASCTi/pVNlWlzXu
 b/LLHYpVWMhulWddlimPA8GQrw0ZzEdQrlVIkIDniqFG9pJaDhhSLvrd2IC/xKvAq5Wv
 VPDxY7ZYq2vfOLYm8Mwu/N///XAfgN3e/2V5+61Wusiu/BbgqKkKFoquiO1XgvSEgolX
 g8zw==
X-Gm-Message-State: APjAAAXbW1z2AEOSg4S6rj4KwNs7YO3Uo5L7OLSAdMS/MiNXxxn2y18X
 7Ju+36bIVUft7j/+3FYxulY=
X-Google-Smtp-Source: APXvYqzut3I/wq8vUdfB3A0iM3UBN8PybS2liifUUl+ID9TCM1fKtxDMndKSgK+FV3ty/vFuMWVmBw==
X-Received: by 2002:a1c:2645:: with SMTP id m66mr11465773wmm.33.1569708628188; 
 Sat, 28 Sep 2019 15:10:28 -0700 (PDT)
Received: from tmp.scylladb.com (bzq-109-66-63-150.red.bezeqint.net.
 [109.66.63.150])
 by smtp.googlemail.com with ESMTPSA id q3sm6720309wru.33.2019.09.28.15.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Sep 2019 15:10:27 -0700 (PDT)
Subject: Re: Questions about the real mode in kvm/qemu
To: Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky
 <mlevitsk@redhat.com>, Li Qiang <liq3ea@gmail.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
 <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
 <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
From: Avi Kivity <avi.kivity@gmail.com>
Message-ID: <ff5ba70d-f87e-5a79-58e5-19f2306e8946@gmail.com>
Date: Sun, 29 Sep 2019 01:10:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 12:18 PM, Paolo Bonzini wrote:
> On 26/09/19 10:59, Maxim Levitsky wrote:
>> If you mean to ask if there is a way to let guest access use no
>> paging at all, that is access host physical addresses directly, then
>> indeed there is no way, since regular non 'unrestricted guest' mode
>> required both protected mode and paging, and 'unrestricted guest'
>> requires EPT. Academically speaking it is of course possible to
>> create paging tables that are 1:1...
> Not so academically, it's exactly what KVM does.  However, indeed it
> would also be possible to switch out of EPT mode when CR0.PG=0.  I'm not
> sure why it was done this way, maybe when the code was written it was
> simpler to use the identity map.
>
> Let's see if Avi is listening... :)


I think it was just simpler for the people who implemented it at the 
time. Switching out of EPT would have been a better solution as it would 
no longer require allocating guest physical address space with the few 
warts that requires.




