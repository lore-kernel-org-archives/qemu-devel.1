Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210A5C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA07205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8vZi3qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA07205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDa9L-0006iw-Sa
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 16:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDa4a-00054G-At
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDa4Z-0004Bx-5t
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:41:24 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDa4Y-00045o-UN
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:41:23 -0400
Received: by mail-pj1-x1041.google.com with SMTP id nu11so4128550pjb.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ptWp7DiJgrQmGpFT+cURd2sayWW2ITlf8l13syF2CGc=;
 b=n8vZi3qH28OwzWiE8KfIc9it3IHgWAxBcK7e2tNBJxkX75+SoaJvHDljDff/UenDo/
 m9oolZXvZfgHYNBtVUmMef6F9arSacrn9QJPuS09zf9zQGVpd1OJyHRG0IA9+hv2YZAA
 WmpKJTxN000P4Dxuc4iTDehOXcbq8UOZCw6ZGHTb3Jx/6EBg4INkIf+0aTneZvSA25mh
 Qw2oCxi/lNq4oHX5ZTh+oZmu63M9mkXvnHW4VnXyvud/OqIfMrCl46yp65zzHGRBmcng
 Yp0o7IVRpDPL9eWJQNYW4VCQQNzTqWywou9jv+XR1ylAlBsqFuHRKi43uEsZN78salYL
 9rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ptWp7DiJgrQmGpFT+cURd2sayWW2ITlf8l13syF2CGc=;
 b=T7MCAbRq1KrdWa/IEJJaDBwkFGfoa75yFTkPvEfDVYFQmCUwKHa+l4+f+s7zyMeIRQ
 +n3r9mdBf6sdlMiqGMs+xKtnxZohQjn7isaAxuulW7wDNfYDKSVlqD5RWy5N1CMJEU33
 K/r3N1FuCllqyRtLLQ4yt+bpHH9mJU/8IpSv2pM3R2q4pXcYYygnzD9sDyFipH9Grpmw
 qWqrfs0lEp3qEaz4cMu3kgEYEJy0ShkFH/2zRC4hXS5YDg5reXgctW0SgKpstB+ZzUQf
 Qv+XMZIV8JVYT332oM844jsoB2AtoF/4OYfNzV4EJhBsm5RRH7vBTidE8RqHOjwRQRVC
 A00Q==
X-Gm-Message-State: ANhLgQ0eZqgTsbTVSSS90wgz78de/qQayV7XfUq1fDOps4tiSV+XA1Tn
 XbnA5+Co2WGkCQMXpvZHDYGMeA==
X-Google-Smtp-Source: ADFU+vse27WxJ2ELddAnrCxJTG3eOKRMRKL1GYKnUYoEFJco84s7vgy56r/l5kZbHu0FK6EzKNb8uA==
X-Received: by 2002:a17:90b:1a89:: with SMTP id
 ng9mr20994362pjb.102.1584304881822; 
 Sun, 15 Mar 2020 13:41:21 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z15sm29706547pfg.152.2020.03.15.13.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 13:41:21 -0700 (PDT)
Subject: Re: [PATCH 10/14] arch_init: Remove unused 'qapi-commands-misc.h'
 include
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-11-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48b4eacf-e95c-ce1c-e198-c1c9c96b9f33@linaro.org>
Date: Sun, 15 Mar 2020 13:41:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
> Commit ffaee83bcb2 moved qmp_query_target but forgot to remove
> this include.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  arch_init.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


