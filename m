Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B321AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DAB23D4E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfGy7ZCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DAB23D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptT2-0006tr-Pu
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jptRX-0005Ys-8a
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:03:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jptRV-0002tH-JM
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593435804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRf76ArlwJyesDHGeAnuSZDeEhaebfrbEK0j8IMGjGE=;
 b=dfGy7ZCaemQnExG7gmJaUYW0oyTVvA7sCz87pEU2wFMU0I8RybtVC0P9+Tvx18cl1z6I+1
 KesO9brYG7/vQpmfpcEq8Y3ptpCqYWlEDW5mHuuEduxO32l/9d95eGBqXNKbvWSqbQKHFg
 pbk41dqlOy8wQPZWv1uTKbKBKdhYtLc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-lEtF7DdBNKqGH4P_0MdYIA-1; Mon, 29 Jun 2020 09:03:22 -0400
X-MC-Unique: lEtF7DdBNKqGH4P_0MdYIA-1
Received: by mail-wm1-f72.google.com with SMTP id g187so18433981wme.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 06:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CRf76ArlwJyesDHGeAnuSZDeEhaebfrbEK0j8IMGjGE=;
 b=mivQRGAdfhnrnmtkgiZdJx9T/jLgMvKGyvP+P9NxfO802DZsDjjs//wF05/rdhQN2R
 lZYZPGa05l4Ao/uQFFWb6R3ZUoT+R77Icv3HupMvwsoJV2ltAVxaFQjix3XpVsUtwp5q
 GVs1CHSY12zYwro/YauRGaXsX/g62lsP5L83TShGGq0JyicK1epxfWLouwXc6m490Qc2
 1ZM+WGlw3GdjbeYw7mzcEtQAd0pNqOgW6nVI9bcosO+N1hGaLMm5pO1g8LOCRsA3DvWT
 Wvzk3iDW7URu3mEp8LEdStgVKdBDOIwFY36Moji5+Fjjp6HhU6C/ocWTQB3j16oTFv4o
 spaA==
X-Gm-Message-State: AOAM532DC562sJF8ynsAtydgnDWbjcpESxKK6gCLGyyAyx0cYU/G8pzP
 ccCVJc/NEYFhmMFTwkRk9OnNerChObC/Q9zzKP0pewgRcsdm8jpsglzDL/dsVUEd68k5aYMK8pS
 hRMBD1I7OO3+yb1g=
X-Received: by 2002:adf:82a1:: with SMTP id 30mr18096844wrc.210.1593435801466; 
 Mon, 29 Jun 2020 06:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB05fztfkJk2u3yxaekMX+FSjnnbJ8jWTHPqOSkA5NWeZ/OnO4oZxUhG1GWohyBta71sX0Aw==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr18096826wrc.210.1593435801259; 
 Mon, 29 Jun 2020 06:03:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id m4sm12966711wmi.48.2020.06.29.06.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 06:03:20 -0700 (PDT)
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
 <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
 <20200629113107.GL25104@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1d7cf19-d56c-c095-a3b8-45e2be0752ea@redhat.com>
Date: Mon, 29 Jun 2020 15:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629113107.GL25104@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
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
Cc: Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 13:31, Roman Bolshakov wrote:
> I implemented what you proposed using VMX-preemption timer in Pin-based
> controls and regular hv_vcpu_run(). It works fine without noticable
> regressions, I'll send that in v2.
> 
> hv_vcpu_run_until() was also evaluated on macOS 10.15.5 but it degrades
> VM performance significantly compared to explicit setting of
> VMX-preepmtion timer value and hv_vcpu_run(). The performance issue was
> observed on Broadwell-based MacBook Air and Ivy Bridge-based MacBook
> Pro.
> 
> macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special
> declaration for hv_vcpu_run_until(), that's not available 10.15 -
> HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of
> VMX-preeemption counter). Perhaps the performance issue is addressed
> there.

Possibly.  I'm worried that the preemption-timer trick will fail to run
there, but we'll see.

Paolo


