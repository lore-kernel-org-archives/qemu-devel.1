Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC40C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 15:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779542074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 15:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIiTzQNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779542074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kToHI-0001EH-LV
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 11:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kToGd-0000RT-JA
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 11:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kToGa-0005Qu-Qt
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 11:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602949027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9YUsxgvD898ElUnh88QiTzPFp4pQAYZhHiYiGC6bEPY=;
 b=OIiTzQNi9+dr0bZNPBFmb6TWR1r8pRipkTgO9ZbonO+Rbj4o7Tt2Mbo36eHjEcNYriETmV
 WUP1hhWPSwDGG2jbnxftDwqQe/sKIWeC6TR1BnKo/Y1BoVhUUsn3RImUi3vSIxYropryeS
 s7fuznosIzr42w8ZSsLDKgDvPMBygnU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-lY0IwT3tNym90ylD3xk55g-1; Sat, 17 Oct 2020 11:37:05 -0400
X-MC-Unique: lY0IwT3tNym90ylD3xk55g-1
Received: by mail-wr1-f70.google.com with SMTP id f11so5185489wro.15
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 08:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9YUsxgvD898ElUnh88QiTzPFp4pQAYZhHiYiGC6bEPY=;
 b=sNUsRBepEEdM7eU+oQOpqhIC7NBksblsNCrbocOWhEsuxdDNXxRrb1x4a0HO56DzRO
 IxtpcgDb5eLxp8V3RgAm5p5KYWvI/TuYuMhS+AXvTJx+KWDhonJSU/aMPkjV1e97fr1g
 JgNeBPMsq70zkM12Dgg2G7Nko12DdsjDM/7BX0EZX/1vjwxzr3ena3rkvuDgE1GT0t7/
 6E+J/ajfRSqUdECBIAW3+i9jvK0jvfPQLIS0sFKaaHH7r1FLw4+O7a4ihw1yLRvys27R
 HHwwgCYorXCrln3DvO/T88HvzwnaPDW/xm8Up21TTYpj3aW2AXH54L81ZSfjxahOwlyX
 6QXA==
X-Gm-Message-State: AOAM533/HiJkausECn4bMTT9GMkQBaG/gnayW4zjRIqUfiqt/jO+cRHO
 rkoPO6N9nMf45GAWmT+WEXdyjg6C96SbmU4FzfblcKIcPM3dSRs9EarODLfBWYUUOnl4kj3ynkm
 EXZKiMY2hDSzIQOw=
X-Received: by 2002:adf:e650:: with SMTP id b16mr10856945wrn.350.1602949024064; 
 Sat, 17 Oct 2020 08:37:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4xvePDynuysJLuo644GqTPwEhwpDg0c3ms9mSorzRAP8D0N8CI4wr04jtmuOKn3ncZKdnoA==
X-Received: by 2002:adf:e650:: with SMTP id b16mr10856932wrn.350.1602949023842; 
 Sat, 17 Oct 2020 08:37:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:64c6:700c:12f3:b63a?
 ([2001:b07:6468:f312:64c6:700c:12f3:b63a])
 by smtp.gmail.com with ESMTPSA id t10sm7603151wmf.46.2020.10.17.08.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 08:37:02 -0700 (PDT)
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201016155331.1613089-1-pbonzini@redhat.com>
 <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
 <ecd2b5bf-0c3c-fa58-ce4d-3d4d55274424@redhat.com>
 <CAFEAcA_HDoheozjRjcAKy3eEJ94cBgU29FDftMe2yn=SdMKHMA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03d83be5-db1a-3856-5243-66b0f7bdc724@redhat.com>
Date: Sat, 17 Oct 2020 17:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HDoheozjRjcAKy3eEJ94cBgU29FDftMe2yn=SdMKHMA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 05:57:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.247, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/20 16:39, Peter Maydell wrote:
> On Sat, 17 Oct 2020 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> OpenBSD and NetBSD call the ninja package "ninja-build" unlike FreeBSD.
>>  I'm sure I had used the right name but well I didn't.  I'll send a v3.
> 
> OpenBSD built OK but meson produces this new warning:
> 
> Library iconv found: NO
> ../src/meson.build:531: WARNING: iconv required for curses UI but not
> available, disabling

Hrm, the curses test was not plainly converted from shell to meson (guys
please do *one* thing per patch, things are already complex enough!);
and it is messed up in more ways than I had first noticed (of which the
most blatant is using /usr/include/ncursesw as a library path).  I'll
fix everything up and resend this pull request when I'm done.

I'm not sure if that will remove the warning or not, but I'll check (and
if it does remain, it'll be of the "useful" kind which documents some
unexpected dependency between options).

Paolo


