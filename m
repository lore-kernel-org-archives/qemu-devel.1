Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00667C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCDF206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceqspJgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCDF206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATl4-0003ix-19
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATkI-0002qw-CP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:51:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATkG-0004JS-JI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598341911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tGAlwAWi/BDkgxVdhpGUzgiF+KH832G9maqRl8UY6iU=;
 b=ceqspJgYSV8hAzVqyN/mhW9eTwSiOuH/acXDo0VcoNau7FerWZbcFhWUq2OyEHOa8XJ7CS
 T1cn1bOLb2A2gCUNEFT8IkUoDBpuvuEGGCQqpMQ3Q8LhC3vRPkI1IyEoS88TvFkMXS4dgu
 qBht2kpoEUACzqm+BMRW+lFvdLeSiTM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-HWv2BqMJOrCvnX6ItuGizA-1; Tue, 25 Aug 2020 03:51:47 -0400
X-MC-Unique: HWv2BqMJOrCvnX6ItuGizA-1
Received: by mail-ed1-f70.google.com with SMTP id dd25so4273521edb.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tGAlwAWi/BDkgxVdhpGUzgiF+KH832G9maqRl8UY6iU=;
 b=lLitewGiFXzfN9FCMkMnE+6EiJIzjeUSMmCG5OLr/izHztXhBfCRbg4b6S90I8kxFO
 AjjgXNtWjD8+74pXzZY4d798Ii9aoZgKuATcj1FOYjelilPh89ricsmzRWyk0gBkt/9X
 /2as1eH246hjZqlckONknjHiJ8zNaxuVTKe90Y1l1+MhB6qfiQpZGSQ5ve/aO8lc/mkH
 SdBSaWPAr95I9pMG57AvmwbwNuekgZKjp5akc/97fwM0MCHHZoCVi6lCwU7NsxY8eGez
 1A2lY/Nok1qza4M7jgghRp0IpVYsHb8UFjLqL7cSBf5wdB2IJogmVV0+DSl1ot0RqdfK
 SZtg==
X-Gm-Message-State: AOAM530g6PdyI1wqj87XPhPfiOCJ3Ctiwzw1FR99bfSMMAEzV9JXK/Vh
 ynQrPzBXrxnYBsLssZCrbNE8JD/YXCH6h+Za9t49gVndal0EnRnIeNfGFFj6EYWFlbSAhrW8NNc
 7hpaLYWRcVyVHELgWxP/jcsYQ1iSa0Hg=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr8514506edr.243.1598341905983; 
 Tue, 25 Aug 2020 00:51:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNzXEqCxRsHymRTuEqmE3Ps/lZhNvoZT/sQtKF0cfje4ccwRUvqoNmWIOTWh5BwwE4EWUsNhG+Lh+Nw467dgk=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr8514490edr.243.1598341905753; 
 Tue, 25 Aug 2020 00:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200824155236.789635-1-brogers@suse.com>
In-Reply-To: <20200824155236.789635-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:51:34 +0200
Message-ID: <CABgObfYpyWT7GcUkiL46NqQtakyL8qcRVtD3g0=Xc=n684npNg@mail.gmail.com>
Subject: Re: [PATCH] meson: Fix chardev-baum.so name
To: Bruce Rogers <brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000085bf9205adaef95d"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000085bf9205adaef95d
Content-Type: text/plain; charset="UTF-8"

Queued, thanks.

Paolo

Il lun 24 ago 2020, 17:52 Bruce Rogers <brogers@suse.com> ha scritto:

> Somehow in the conversion to meson, the module named chardev-baum got
> renamed to chardev-brlapi. Change it back.
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  chardev/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/meson.build b/chardev/meson.build
> index a46a6237be..7726837e34 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -39,7 +39,7 @@ chardev_modules = {}
>  if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
>    module_ss = ss.source_set()
>    module_ss.add(when: [sdl, brlapi], if_true: files('baum.c'))
> -  chardev_modules += { 'brlapi': module_ss }
> +  chardev_modules += { 'baum': module_ss }
>  endif
>
>  modules += { 'chardev': chardev_modules }
> --
> 2.28.0
>
>

--00000000000085bf9205adaef95d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-family:sans-serif">Queued, thanks.</s=
pan><div dir=3D"auto" style=3D"font-family:sans-serif"><br></div><div dir=
=3D"auto" style=3D"font-family:sans-serif">Paolo</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 24 ago 2020, =
17:52 Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com">brogers@suse.com=
</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Somehow in the=
 conversion to meson, the module named chardev-baum got<br>
renamed to chardev-brlapi. Change it back.<br>
<br>
Signed-off-by: Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com" target=
=3D"_blank" rel=3D"noreferrer">brogers@suse.com</a>&gt;<br>
---<br>
=C2=A0chardev/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/chardev/meson.build b/chardev/meson.build<br>
index a46a6237be..7726837e34 100644<br>
--- a/chardev/meson.build<br>
+++ b/chardev/meson.build<br>
@@ -39,7 +39,7 @@ chardev_modules =3D {}<br>
=C2=A0if config_host.has_key(&#39;CONFIG_BRLAPI&#39;) and sdl.found()<br>
=C2=A0 =C2=A0module_ss =3D ss.source_set()<br>
=C2=A0 =C2=A0module_ss.add(when: [sdl, brlapi], if_true: files(&#39;baum.c&=
#39;))<br>
-=C2=A0 chardev_modules +=3D { &#39;brlapi&#39;: module_ss }<br>
+=C2=A0 chardev_modules +=3D { &#39;baum&#39;: module_ss }<br>
=C2=A0endif<br>
<br>
=C2=A0modules +=3D { &#39;chardev&#39;: chardev_modules }<br>
-- <br>
2.28.0<br>
<br>
</blockquote></div>

--00000000000085bf9205adaef95d--


