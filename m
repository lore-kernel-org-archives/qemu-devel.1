Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BC1248CB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaOMhwHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BC1248CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLpP-0007Nq-5T
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSLmB-0005HN-Lq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSLm9-0005rw-M5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602601181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhMgVRakKrbjjA2oltGoZ89vtWNZqroY218rZ1KElz0=;
 b=AaOMhwHzaCV3SlTs5c8xYA36W0GomuPLkUo6K9vVScKw1A2cAthDrD4WFHGY2yAx1oY8GA
 F++TXAGU6d+4MKmB0z0Wo9wpvOdhLos8cohb5v6+vGLgB0Px2Zo402qzI9e9//A0Ds99VC
 UWk0LO7Wyt9vfPE2LiNAsxdcXkjDx4E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-OUPRiGIjNA6vftgE0pOriA-1; Tue, 13 Oct 2020 10:59:27 -0400
X-MC-Unique: OUPRiGIjNA6vftgE0pOriA-1
Received: by mail-wm1-f71.google.com with SMTP id f2so73813wml.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fhMgVRakKrbjjA2oltGoZ89vtWNZqroY218rZ1KElz0=;
 b=ZIf68MKz5LdHO7irEfMerpQhXgwAdd+Pym4ABI+5PcrF6X4K1AZjnL78tZKb6i0KGA
 aZHHiAqaN4CHc1eVVccl3AsA6aSihJO59vJHJ97EVEM0tnZvM9ZeVKkOUI8LZOk77Rtt
 pSuAJ+DXD4Jyc8kaGL0KUWVLB5KcIfv+SMp3Sx6klU8UJTei5fovus05nOtOCM2F8g8i
 4h+ITWdprkkLCpin94MEQsaQ9dBe5q6NaaP5+4h2u9TfAGtkSqQJcGBuI7nXQ0CdvV9U
 qcfbZO2GL7jxX5Ntv0KLHtky+clV4BmM9kZKO9dr3L3JtF958vO+jPfEqZk6eWa6fd6T
 ripw==
X-Gm-Message-State: AOAM5329m/omqYiHK04ESVRo3ebEzpJ1eZCvdgjGbMGkCL9wyhxwKbrx
 vo9t92qCVYEVKCW+XpaTyARSJf1kKkFaZfrbodd/SWA8pqj/IEWQqMN8eTb0Mw9JOMLGrwIZNJ7
 ROQ7uR/mkcOnNa4A=
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr34022wrp.394.1602601165806;
 Tue, 13 Oct 2020 07:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynjQmfARJ3dqeV+7Q//hqmbmKmxrKWLZJ0iNQzN8/2c9QD/J+EX0iE8ImVGP5CIqyTwEz/mw==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr33995wrp.394.1602601165579;
 Tue, 13 Oct 2020 07:59:25 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l3sm3209wmg.32.2020.10.13.07.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 07:59:24 -0700 (PDT)
Subject: Re: [PATCH 05/10] slirp: update for iOS resolv fix
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-6-j@getutm.app>
 <c99464f7-6fd7-e81f-9037-50942706fc24@redhat.com>
 <CAJ+F1CKrNMNa8vJbhh3DnZ8n_W_ee0+G+yLWnHR9C1DkX3za9A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d52794b-0aed-d8a1-616a-d01226aa8740@redhat.com>
Date: Tue, 13 Oct 2020 16:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKrNMNa8vJbhh3DnZ8n_W_ee0+G+yLWnHR9C1DkX3za9A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Joelle van Dyne <j@getutm.app>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:38 PM, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 13, 2020 at 5:34 PM Philippe Mathieu-Daudé 
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> 
>     On 10/13/20 1:29 AM, Joelle van Dyne wrote:
>      > From: osy <osy86@users.noreply.github.com
>     <mailto:osy86@users.noreply.github.com>>
>      >
>      > We cannot access /etc/resolv.conf on iOS so libslirp is modified
>     to use
>      > libresolv instead.
>      >
>      > Signed-off-by: Joelle van Dyne <j@getutm.app>
>      > ---
>      >   .gitmodules | 2 +-
>      >   meson.build | 2 ++
>      >   slirp       | 2 +-
>      >   3 files changed, 4 insertions(+), 2 deletions(-)
>      >
>      > diff --git a/.gitmodules b/.gitmodules
>      > index 2bdeeacef8..f23e859210 100644
>      > --- a/.gitmodules
>      > +++ b/.gitmodules
>      > @@ -51,7 +51,7 @@
>      >       url = https://git.qemu.org/git/edk2.git
>     <https://git.qemu.org/git/edk2.git>
>      >   [submodule "slirp"]
>      >       path = slirp
>      > -     url = https://git.qemu.org/git/libslirp.git
>     <https://git.qemu.org/git/libslirp.git>
>      > +     url = https://github.com/utmapp/libslirp.git
>     <https://github.com/utmapp/libslirp.git>
> 
>     NAck.
> 
>     You can not take over the SLiRP project submodule that way.
> 
>     I suggest getting your SLiRP changes merged with mainstream
>     instead, see:
>     https://gitlab.freedesktop.org/slirp/libslirp#contributing
>     <https://gitlab.freedesktop.org/slirp/libslirp#contributing>
> 
> 
> I think he did: 
> https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/54 
> <https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/54>

I am being wary because the series is not posted as RFC.

But from the cover it looks like a RFC series:

* slirp updated to support DNS resolving using libresolv; a separate
   patch will be submitted to the project. To allow for builds to
   succeed, the .gitmodule is temporarily changed. We're not entirely
   sure how cross-project patches should be handled here.

> 
> Btw, I also noticed the coroutine library submodule proposed in this 
> series is a fork from the original library. Not sure what the upstream 
> status is and whether this is fine.
> 
>      >   [submodule "roms/opensbi"]
>      >       path = roms/opensbi
>      >       url = https://git.qemu.org/git/opensbi.git
>     <https://git.qemu.org/git/opensbi.git>
>      > diff --git a/meson.build b/meson.build
>      > index 32cf08619f..da96e296e0 100644
>      > --- a/meson.build
>      > +++ b/meson.build
>      > @@ -996,6 +996,8 @@ if have_system
>      >       slirp_deps = []
>      >       if targetos == 'windows'
>      >         slirp_deps = cc.find_library('iphlpapi')
>      > +    elif targetos == 'darwin'
>      > +      slirp_deps = cc.find_library('resolv')
>      >       endif
>      >       slirp_conf = configuration_data()
>      >       slirp_conf.set('SLIRP_MAJOR_VERSION',
>     meson.project_version().split('.')[0])
>      > diff --git a/slirp b/slirp
>      > index ce94eba204..452c389d82 160000
>      > --- a/slirp
>      > +++ b/slirp
>      > @@ -1 +1 @@
>      > -Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275
>      > +Subproject commit 452c389d8288f81ec9d59d983a047d4e54f3194e
> 
> 
> 
> 
> -- 
> Marc-André Lureau


