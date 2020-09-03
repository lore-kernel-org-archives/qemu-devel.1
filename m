Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF256C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D81E2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry1bhgQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D81E2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDo8L-000726-Of
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDo7c-0006Yf-S3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDo7a-0005vQ-RZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599135221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KM+pXzBKOu/ypS/w1IYgz3FGqmRSR3DkbQ/18aGndIg=;
 b=Ry1bhgQul/inMyUR2SCO+u9z3TTqOa8ha36jV63YV2lakAY72YhtCWVVMN+7YEZLv45M71
 HAR5yt6iCPrigpoNJWQVbyEzXK4pTSx8hbFFIVaGtK9H7/1y+Jf0eFhe8A7HurjsHoE85f
 /hd1JLZozWsfMqJ1/41OMFejmUMDP1s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-LZBTsFpPPWipkMpQTy19bQ-1; Thu, 03 Sep 2020 08:13:37 -0400
X-MC-Unique: LZBTsFpPPWipkMpQTy19bQ-1
Received: by mail-ej1-f71.google.com with SMTP id i21so1147943ejj.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KM+pXzBKOu/ypS/w1IYgz3FGqmRSR3DkbQ/18aGndIg=;
 b=HEfJVHpKpx6aw+4RPpQUm6x/BpLuHqdTNWXEO2b9hIW2aA3Dtf1VIkgQSMNFSnF0JQ
 nA71jVH1p7mqlOfnhLwQm7ewaUqpz1zsLfx5mKLOrbKcd6wvUmkMwH+8rgTiTmtx9p35
 9dRTVCinAWgmx1CQR6C1fSsJVisxhj0/G1GLg9yy/F00D0KEInepsOU+cAXjS64HBUqG
 idKFaNcNPn8XDUkVLwyOjFK8y1iXGeDIksq4J2//oVjLD53ldGNoYilQ7wikGWoK6c58
 6jHsu9dYQQN2cyxPxx3iDVWErjWZs4uRTf9Z0WLpbih3ztulKZuw+vuv52LD58zC3AlN
 kQrw==
X-Gm-Message-State: AOAM531hVf3CGIXGF+HnUxKYggv/X2oS8KKMX3pZLZQ4pDemhlLKU5/B
 gqQJahnQ4Z1xcnz/KI2zaJ8/FGO5TlgXGZ90iRgKXl85cwox4rMf29Tmm7KrPfj94o+aG0AC5p4
 JN9k7DeTiqIJ7fqHvACtH9ycAPouu18A=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr2600700edo.243.1599135216351; 
 Thu, 03 Sep 2020 05:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaqet8yN+jd1hLERq1/HPi7pXhWP24MVjp5VpcMEfSJ9yzIzypi1mby95axC6omv3mUqOiCbG0NZti8+KafcE=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr2600674edo.243.1599135216125; 
 Thu, 03 Sep 2020 05:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-9-alex.bennee@linaro.org>
In-Reply-To: <20200903112107.27367-9-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 14:13:24 +0200
Message-ID: <CABgObfZCiQZ2RhriWj+xmCuYfAXVkXmAAJFKpNA7VS0avo4qUA@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] migration: use pstrcpy to copy run state
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000081655005ae67ae85"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Juan Quintela <quintela@redhat.com>, richard.henderson@linaro.org,
 qemu-devel <qemu-devel@nongnu.org>, f4bug@amsat.org,
 "Emilio G. Cota" <cota@braap.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000081655005ae67ae85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 3 set 2020, 13:21 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scrit=
to:

> The gcov build triggered:
>
>   ../../migration/global_state.c:47:5: error: =E2=80=98strncpy=E2=80=99 s=
pecified
>       bound 100 equals destination size [-Werror=3Dstringop-truncation]
>       strncpy((char *)global_state.runstate
>
> As we shouldn't be using strncpy anyway lets use the suggested
> pstrcpy.
>

This is wrong, we want the all-zeros behavior of strncpy that pstrcpy lacks=
.

Paolo


>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  migration/global_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 25311479a4b..5fbe6d1ff07 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>  {
>      const char *state =3D RunState_str(RUN_STATE_RUNNING);
>      assert(strlen(state) < sizeof(global_state.runstate));
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    pstrcpy((char *)global_state.runstate, sizeof(global_state.runstate)=
,
> +            state);
>  }
>
>  bool global_state_received(void)
> --
> 2.20.1
>
>

--00000000000081655005ae67ae85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 3 set 2020, 13:21 Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">The gcov build triggered:<br>
<br>
=C2=A0 ../../migration/global_state.c:47:5: error: =E2=80=98strncpy=E2=80=
=99 specified<br>
=C2=A0 =C2=A0 =C2=A0 bound 100 equals destination size [-Werror=3Dstringop-=
truncation]<br>
=C2=A0 =C2=A0 =C2=A0 strncpy((char *)global_state.runstate<br>
<br>
As we shouldn&#39;t be using strncpy anyway lets use the suggested<br>
pstrcpy.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">This is wrong, we want the all-zeros behavior of strncpy that pst=
rcpy lacks.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br><br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0migration/global_state.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/migration/global_state.c b/migration/global_state.c<br>
index 25311479a4b..5fbe6d1ff07 100644<br>
--- a/migration/global_state.c<br>
+++ b/migration/global_state.c<br>
@@ -44,8 +44,8 @@ void global_state_store_running(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *state =3D RunState_str(RUN_STATE_RUNNING);<=
br>
=C2=A0 =C2=A0 =C2=A0assert(strlen(state) &lt; sizeof(global_state.runstate)=
);<br>
-=C2=A0 =C2=A0 strncpy((char *)global_state.runstate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state, sizeof(global_state.runsta=
te));<br>
+=C2=A0 =C2=A0 pstrcpy((char *)global_state.runstate, sizeof(global_state.r=
unstate),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state);<br>
=C2=A0}<br>
<br>
=C2=A0bool global_state_received(void)<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div></div></div>

--00000000000081655005ae67ae85--


