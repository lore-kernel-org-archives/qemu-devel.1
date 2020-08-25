Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1C42065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8i0rS52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1C42065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATt2-0001cm-Aw
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATr9-00088o-6q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:58:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATr6-00057H-4z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598342335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VfI1iInsF4fpYyIAsw8lT0nmsxB8+o3ItleabtMEUL0=;
 b=b8i0rS527JAYKplIN3yUNJ5tHa8x/wZXT3WixZmM8mdDb9BTtZt6RVzgJiFyfPQAVc4siX
 U/wViNRGvxam6IoU6e7mWd/de1g0QqM2gElrrrfT16P7AmrNeCjyn+jTUUexpe0GdQN0BS
 scAQeY+ibsHiqZzvabYgtWWUEmMxDPs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-GUT3xzK1NueFrmlwsR1hcA-1; Tue, 25 Aug 2020 03:58:53 -0400
X-MC-Unique: GUT3xzK1NueFrmlwsR1hcA-1
Received: by mail-ed1-f70.google.com with SMTP id dj21so2068349edb.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VfI1iInsF4fpYyIAsw8lT0nmsxB8+o3ItleabtMEUL0=;
 b=NpgqbqXuFAmhITua/qAgjCw9O1zy3ndbAQsQIBh1FV98kU2oYmtCMEmvPRLuDGPTEW
 2idFmHMXpbJsvCWwhh7mh5U4x3zvQ+b2MwprtIbqor3mgeDfdsL5EfKrxHMiGGU/747U
 R/Kr0R5/Sn25HEAryiMFbGfJVXx8x0VOqWDxhEZ7UVUWnRliJjLON+St7NIPTGFIFQRV
 8lR4t9V9utX8J7UHIAhMVD2sWecb7mrtp7RttOnnVOIVpOXrWlRbcf+iV9tkaBQPkrPX
 PphndsUKlcMFSEU4JJuVoqxQRzcLS0jiviLTcocZ1x958Y9ZC0NeH23+lgtCJRd2kxiN
 LFwA==
X-Gm-Message-State: AOAM5313IMJ+ZeVuXr5eIcfi6wD1hxR/C1YcNVD7oW0P+RGY1AdJhCKG
 u9r27fZVN16ivl83GuHmi2KCVo9hlvHcXFS8lcuUWtbNC6V81OkLFy9At8ExRPFXWbD9OcTi5Ka
 Kx7KMnU+xklI6evWrnfxszxh8O/NLxiQ=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr8445972ejr.543.1598342331938; 
 Tue, 25 Aug 2020 00:58:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwugtsy1HGtwH9S0OURTisocsMt2s3JJsU1t24kcmdw0ril0pqzvMhZ3AnHiMTahR005wbOeZppJFJNnIYkGUQ=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr8445958ejr.543.1598342331714; 
 Tue, 25 Aug 2020 00:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200823102617.32358-1-thuth@redhat.com>
In-Reply-To: <20200823102617.32358-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:58:40 +0200
Message-ID: <CABgObfYPWnfmAnfeqeTg=9K=-kVOWMzUSaPWej9OTjmWC9p6Xw@mail.gmail.com>
Subject: Re: [PATCH] scripts/qemu-version.sh: Add missing space before ']'
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e958bb05adaf12ac"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e958bb05adaf12ac
Content-Type: text/plain; charset="UTF-8"

Queued, thanks.

Paolo

Il dom 23 ago 2020, 12:26 Thomas Huth <thuth@redhat.com> ha scritto:

> When configure has been run with --with-pkgversion=xyz, the shell complains
> about a missing ']' in this script.
>
> Fixes: 2c273f32d3 ("meson: generate qemu-version.h")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/qemu-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> index 4847385e42..03128c56a2 100755
> --- a/scripts/qemu-version.sh
> +++ b/scripts/qemu-version.sh
> @@ -6,7 +6,7 @@ dir="$1"
>  pkgversion="$2"
>  version="$3"
>
> -if [ -z "$pkgversion"]; then
> +if [ -z "$pkgversion" ]; then
>      cd "$dir"
>      if [ -e .git ]; then
>          pkgversion=$(git describe --match 'v*' --dirty | echo "")
> --
> 2.18.2
>
>

--000000000000e958bb05adaf12ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-family:sans-serif">Queued, thanks.</s=
pan><div dir=3D"auto" style=3D"font-family:sans-serif"><br></div><div dir=
=3D"auto" style=3D"font-family:sans-serif">Paolo</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 23 ago 2020, =
12:26 Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">When configure =
has been run with --with-pkgversion=3Dxyz, the shell complains<br>
about a missing &#39;]&#39; in this script.<br>
<br>
Fixes: 2c273f32d3 (&quot;meson: generate qemu-version.h&quot;)<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qemu-version.sh | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh<br>
index 4847385e42..03128c56a2 100755<br>
--- a/scripts/qemu-version.sh<br>
+++ b/scripts/qemu-version.sh<br>
@@ -6,7 +6,7 @@ dir=3D&quot;$1&quot;<br>
=C2=A0pkgversion=3D&quot;$2&quot;<br>
=C2=A0version=3D&quot;$3&quot;<br>
<br>
-if [ -z &quot;$pkgversion&quot;]; then<br>
+if [ -z &quot;$pkgversion&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0cd &quot;$dir&quot;<br>
=C2=A0 =C2=A0 =C2=A0if [ -e .git ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D$(git describe --match &#39;=
v*&#39; --dirty | echo &quot;&quot;)<br>
-- <br>
2.18.2<br>
<br>
</blockquote></div>

--000000000000e958bb05adaf12ac--


