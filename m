Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A2DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E2320772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjakBpBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E2320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8Yv-000760-8T
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jh8Xy-0005zx-Qt
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:21:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jh8Xx-00025o-Cp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591348911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WBzg25FLBqjdqC+h7+MrkiWgt5N9IXlx9jXwMXRePiU=;
 b=LjakBpBdts2FO24jW6vMH+cqAYCJL0IYaF0s0W9UXqGLS+XFG7mwUY+mJPiTYB1D5/tFEm
 o10V63AoaSqpOX1teNd4jfZXZD6PicQOMpRVvZlixvycINl6YXFfuvUxZR6f3aGJko81bU
 cBCqwxv53P5RMOwpErRZB7Xqj5uw3dU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-1JSftFAyOWGYMtywQt_usg-1; Fri, 05 Jun 2020 05:21:49 -0400
X-MC-Unique: 1JSftFAyOWGYMtywQt_usg-1
Received: by mail-ed1-f71.google.com with SMTP id k17so3708346edo.20
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WBzg25FLBqjdqC+h7+MrkiWgt5N9IXlx9jXwMXRePiU=;
 b=YD2N7eBRvi57+yF2NI/k6PfoOuYmxHjcdJ5X/iQegNnUf5SnWlQ3znKlkiSViFZBLi
 +NYQsJFdTQtXYuvBmtQ21raWaH3deWG9m6Htasmh0HbkgWgCrdDXkGQ6rHRYoopzfypY
 nVb3u77MoUewdMMEH79G8lWdpSmnCeyHItgKPzgmU+GVxmWmmQ6hSjdgb+dvJRc0uRkI
 xWMvZqQsQqRb6LFOb9BbIQ632f+BJcBYpe+V6rmhsa0aZtOsxaBXR3HH/vZmrx5ptGyt
 Yu+Z48Yo2RecPoXit7NNERRU416WS5lDhXlF7uAf9IYKe7qefiEBv8h7KoA6hpLkHiw8
 BOwg==
X-Gm-Message-State: AOAM532tpsOmfnAtXfCWMBOn9BppLulCckpJgPSSraUZrHvjTn7fwV60
 az4gdIDCtsrPMoUzr6DecdD+Pyh84fCW+5nx4Yp4FvwU2jPFOFtPe+GU/OBHF9gx3sVuF8kkp1A
 Cnbyz1e3z2s+BBHynPZAw7MJ+wBVV0Ro=
X-Received: by 2002:a17:906:fa03:: with SMTP id
 lo3mr8058137ejb.196.1591348908417; 
 Fri, 05 Jun 2020 02:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNbnfoLh1I8CyrvjsH5W9lT/uuEjQUSOJclkgyA2gKWlTwxhR6e+KDswsQceutyhJVU6tjBgt2YhrJaQez46I=
X-Received: by 2002:a17:906:fa03:: with SMTP id
 lo3mr8058121ejb.196.1591348908186; 
 Fri, 05 Jun 2020 02:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200604231716.11354-1-pbonzini@redhat.com>
 <280da8d7-187a-ea53-72db-cb36e5d76b4f@redhat.com>
In-Reply-To: <280da8d7-187a-ea53-72db-cb36e5d76b4f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jun 2020 11:21:36 +0200
Message-ID: <CABgObfYuVSE90co+zoT8LvGXnKCe08XbpayD69-qgktKjmPdkQ@mail.gmail.com>
Subject: Re: [PATCH] docker: update Ubuntu to 20.04
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000062ef5305a752ca66"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000062ef5305a752ca66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 5 giu 2020, 10:32 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> ha
scritto:

> Still not sure how to do. Add ubuntu-old.docker based on 19.04 and then
> roll 'ubuntu.docker' -> 'ubuntu-old.docker' for each new releases?
>

We have an image for 18.04 already, I think we should roll ubuntu.docker
every six months and, when 22.04 comes out, roll the older LTS image to
20.04.

Paolo


> >  ENV PACKAGES flex bison \
> >      ccache \
> >      clang \
> >
>
>

--00000000000062ef5305a752ca66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 5 giu 2020, 10:32 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Still not sure how to do. Add ub=
untu-old.docker based on 19.04 and then<br>
roll &#39;ubuntu.docker&#39; -&gt; &#39;ubuntu-old.docker&#39; for each new=
 releases?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">We have an image for 18.04 already, I think we should roll ubuntu=
.docker every six months and, when 22.04 comes out, roll the older LTS imag=
e to 20.04.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 ENV PACKAGES flex bison \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ccache \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 clang \<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000062ef5305a752ca66--


