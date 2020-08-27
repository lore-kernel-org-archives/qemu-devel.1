Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBECC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1819D20738
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dU4TkgdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1819D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBD9i-0005EJ-CB
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBD8s-0004Qn-Cg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:20:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBD8q-0003vV-OT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598516414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mWHmANSTKJc3pTQy4ki70s2Kr1oMpzTlkJnu+uHw30=;
 b=dU4TkgdTGpMF7clqxDi9IZOfV/mBqFQF3xou1oQdRumbHQQfAdJLn3h+JAt7cnpKkOVCyW
 rOsgy2XJcPMYTYE5Vs6gRz3xq+pKUSQX65rUaykrtpDIyoGV0zrv22Kv7wdREJLgwjsm/P
 TARygb1uqNAdznm/mckIPcD5s5LtEO4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-pANAus4qMxaVkw8S-QvM_Q-1; Thu, 27 Aug 2020 04:20:10 -0400
X-MC-Unique: pANAus4qMxaVkw8S-QvM_Q-1
Received: by mail-ej1-f70.google.com with SMTP id n20so1852768eja.18
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 01:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2mWHmANSTKJc3pTQy4ki70s2Kr1oMpzTlkJnu+uHw30=;
 b=BsImPWPwAfMI4gCis2d9Whi0qCQeTXO0RBCRmEueHk9llmUBkfL7+Z06XqNiHwkyrW
 CYsd3rgByhXiOPnhkKPI0v9AIFL2kwA88N72SQ+y2Cm/fSmWhrBhpzOLIhDOmNCM5Jqj
 xgRey0MdQHxby8Tt6uT8OqmIjXtw4qtqDPSpyvE50doycttNyNBBrkfcaMz2HU4+tzIV
 9sYtvA+BTvjlimj26lNufbf4k5klm8UJAwIAwrZ75ZCQhDY3q/RGH64JSN9+pyYmuHtb
 +wMGtbUSAcAZQEYsjv0GcSFqFmshwdJ/hfqwDtcdDK8aU+Zb38OLvtJFE1+qLunW/fDc
 St3Q==
X-Gm-Message-State: AOAM530Doi6dJdiTbaHQZTEo54a0UrDZHp5VS9MNOPxkQXZP7GQmHxiZ
 tLq4TLdDD8g67HL2H9Aet90I2gNTHGJXxaoXdUIN1KlGMyb66ZoAVIvh1YvvdmPD7Gbsu19eQ6L
 P/8DnzEJ1b5kzPzHSxnzvCoj5yKlmQIo=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr17857028edr.243.1598516408940; 
 Thu, 27 Aug 2020 01:20:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9V0SZoMEOLpBxrYlppyhvRYMWDXEsmxKr4ek78Vv0x8m+BwsWLw1+GLCizwUuoOlvtK2jnSn0Vi9YGF/zX6o=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr17857018edr.243.1598516408710; 
 Thu, 27 Aug 2020 01:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200826070243.11969-1-pbonzini@redhat.com>
 <cc6af807-a24f-42bb-b1f7-8c8c5e59200b@redhat.com>
 <CABgObfYJ=6fRSzTz5C1A8dgbom7-QWtn1J1L7-8+4thkxNTvjA@mail.gmail.com>
 <80f0ce6c-0bc3-42c5-523c-f81f997a5ab5@redhat.com>
In-Reply-To: <80f0ce6c-0bc3-42c5-523c-f81f997a5ab5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 10:19:57 +0200
Message-ID: <CABgObfb5hQr2aEbFUS2F7ys9NcBnjzVcAFUifZAAyPC8n0x4NQ@mail.gmail.com>
Subject: Re: [PATCH] meson: move pixman detection to meson
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000b59b6c05add79ae1"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b59b6c05add79ae1
Content-Type: text/plain; charset="UTF-8"

Il gio 27 ago 2020, 09:28 Thomas Huth <thuth@redhat.com> ha scritto:

> But I've tested the patch now, and it does not work:
>
> .../qemu/meson.build:117:3: ERROR: Unknown variable "have_system".
>
> Should the pixman test maybe be moved to a later spot in the file? It
> currently shows up before the have_system variable is initialized...
>

There are some dependencies with other patches that were posted (I should
have added Based-on), you can test the tags/for-upstream tag in my gitlab
repository.

Paolo


>  Thomas
>
>

--000000000000b59b6c05add79ae1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 27 ago 2020, 09:28 Thomas Huth &lt;<a href=3D"m=
ailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">But I&#39;ve tested the patch now, and it does no=
t work:<br>
<br>
.../qemu/meson.build:117:3: ERROR: Unknown variable &quot;have_system&quot;=
.<br>
<br>
Should the pixman test maybe be moved to a later spot in the file? It<br>
currently shows up before the have_system variable is initialized...<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">There a=
re some dependencies with other patches that were posted (I should have add=
ed Based-on), you can test the tags/for-upstream tag in my gitlab repositor=
y.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div></div></div>

--000000000000b59b6c05add79ae1--


