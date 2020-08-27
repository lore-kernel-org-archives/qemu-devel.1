Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47662C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1109B2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHbc2Cp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1109B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9Ib-0001uX-CI
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kB9Hv-0001UI-Jv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:13:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kB9Hs-0006Ly-J8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598501599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADHy+c6CJ3rLiVmrE1fCybCvCg91kml18SQu77TjMic=;
 b=SHbc2Cp8nujLyd2XfHvlQQwBs2AVgHCb1aZrjb0YGKh3mljPCRvOugQpvYHfcnrAiGRzn5
 1Wk/qpGHUkHyJSBNV6frU3Bz3oLmfMwYmhn3fTcapb6yqPOz0Uc1AXDoNxpHy2RmwLc7h7
 l+gqOltbJIEL4MPrrDCgoFKzy24v7k0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-P4HVAVFeM_6nwXVixu4XJQ-1; Thu, 27 Aug 2020 00:13:16 -0400
X-MC-Unique: P4HVAVFeM_6nwXVixu4XJQ-1
Received: by mail-ej1-f71.google.com with SMTP id jz22so1992900ejb.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 21:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ADHy+c6CJ3rLiVmrE1fCybCvCg91kml18SQu77TjMic=;
 b=W0L1Vqgjlq1fa/pi6HyAKhVwmkj3USEUS+I2LocYjeoUSruQdT5a74qVI1U59pcGYh
 sUkxZSDhZElnGsClagDZQq1hFQzQJQUwVdu2yEQdd+p6QwQ84YxZwsK9ZuammcOYauQo
 4UGAOhW/b33uNHC0mqET2j0dw3oUumgh+bo2yXeS5Yrh4nZ0aoPtGNpajFdE4aa9+h+b
 IxuA42H5KeuAmPW+GE+phHAxUxASP1TMnLYeD12VmCnkCf1tufsJt+E5djVQRH2Qy1pm
 ASbMabGz6ZF668kCIRYHUZhepVfd4ops+ZWalQsBdrRxc9ODORFV3M6rwFPly4deyZJ5
 Qjtw==
X-Gm-Message-State: AOAM533S4aUMO4/xmJiLVeoxsBte/2MO9A0Ler3XWVfvEEALkmPBdMnE
 YvygEufGevRZWJqPIJ4XOSDxLT+JSv0J7OAeYI/yIkOujsfK5UR1rw/W42rP6zBDCFld8B0rbAy
 HW3ODhUwZtqbQmlrsLxNIIRCXvUVw240=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr17952195ejr.543.1598501595216; 
 Wed, 26 Aug 2020 21:13:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdy4lCC0SrrgHamqAQHjLSHmJJ5zacGLQDrQ/eDysmcUyKPxquXqNEF42N606kWxKOzLy1bDoVxO3TLBmoH0Q=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr17952183ejr.543.1598501594997; 
 Wed, 26 Aug 2020 21:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200826190128.22707-1-pbonzini@redhat.com>
 <CAFEAcA8MSzo7+zSWTr8vmU294M3oYkZKk17SFRrBZLmqfxGdmQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8MSzo7+zSWTr8vmU294M3oYkZKk17SFRrBZLmqfxGdmQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 06:13:03 +0200
Message-ID: <CABgObfaO8TB=LYgpn871c82me8e83CzRuDYyi1UGWZFopLgfbQ@mail.gmail.com>
Subject: Re: [PATCH] ninjatool: quote dollars in variables
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000be3a6905add427f9"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000be3a6905add427f9
Content-Type: text/plain; charset="UTF-8"

Il mer 26 ago 2020, 21:34 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Wed, 26 Aug 2020 at 20:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Otherwise, dollars (such as in the special $ORIGIN rpath) are
> > eaten by Make.
>
> Incidentally, why are we using rpath anyway? I'm pretty
> sure the old build system didn't need it, and it's one of
> those features I have mentally filed away under "liable
> to confusing and non-portable weirdness"...
>

It's only done in the build tree, to allow running against uninstalled
shared_library. Installed binaries have no rpath (distros don't want it
anyway). QEMU doesn't need it since it has no shared library yet.

Paolo

>

--000000000000be3a6905add427f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 26 ago 2020, 21:34 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Wed, 26 Aug 2020 at 20:03, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Otherwise, dollars (such as in the special $ORIGIN rpath) are<br>
&gt; eaten by Make.<br>
<br>
Incidentally, why are we using rpath anyway? I&#39;m pretty<br>
sure the old build system didn&#39;t need it, and it&#39;s one of<br>
those features I have mentally filed away under &quot;liable<br>
to confusing and non-portable weirdness&quot;...<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s only done in the b=
uild tree, to allow running against uninstalled shared_library. Installed b=
inaries have no rpath (distros don&#39;t want it anyway). QEMU doesn&#39;t =
need it since it has no shared library yet.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000be3a6905add427f9--


