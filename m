Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B67C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3F7206CB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGYLfgiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3F7206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYROU-0006W3-3g
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYRMn-0005W8-Kl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:10:41 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYRMl-00037Y-Rk
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:10:41 -0400
Received: by mail-ed1-x543.google.com with SMTP id a71so668890edf.9
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/olE3Y7IJ5GtS//VI0e7zU851C8mYu1v9fo9olB5HUg=;
 b=XGYLfgivX3E+CYYM5D5Jpa0aDw8V/0drG6Uxxta5Cv6zuhoV5Kv+3LOCbYEO4K1Z7h
 FFqw6mLdQEXB77CCFLJZY52KXwBmjU7K8iU868JSM2/if4rMB+LEiQu0q9qNqhehaRFz
 LJFPzFnupGKfO91/fH4IUBLDCF4/HVv1WWiSEenhwywhxic7a/t3Wvz7TzifZgZ7yywy
 eOLSrnLLp+1dQFyNv14jHlU484T4a1EwCaaF1V0Yj6YS9oS9qKIJe+NDGi3HhnTqE804
 iBulfSNItLnOsMh3UJE2x1cP585+ZRpjLekhqzqDFz8DfrC+A6+s6y9F8OdY+KEhzVxK
 vtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/olE3Y7IJ5GtS//VI0e7zU851C8mYu1v9fo9olB5HUg=;
 b=hThaVosdAeah/nfyKggGM0dj/hJ7+IhHTGMFf9yZJxxQQWcMKWUA8jZp8c+aw+QIJG
 kgVDA65T5+H+n2P02L/r/CcmOaDEBfKZ7X+S0MYErpSEti9TOJUZWZXGTay9YxR7EQ3O
 VybDdBpetSgizKcFOYKh3+iFEozVTOeX6rwzhN42AoGUJBBy8X6xE0FJZUZfCEcE8BEC
 rtxbgSZXJpyN23LI7UF4S2RHPmR2JF31KPwUNZb6TicNpJhjlb4LyF5cOrswbrScsjs4
 9WZlcSlmfuHysHq831Fp8D92WP5qIgEVtMzkTxdLaJd4/Hy2BTPoKUWFAKOEdOQqZ7zz
 0ssg==
X-Gm-Message-State: AOAM530j8H1AdLFckm1M1zHd0Xfjn212Zrm6xKWVCYgNmz91BG/rCqLv
 2hdYZXIj156L7u7Q/IMbvxVHLBaXK6p0oVcl6Zs=
X-Google-Smtp-Source: ABdhPJyfsvPAhC/6IMrKBy2F7QfGKy+RQMVwuB50Ynu+u8zvka9YxndxE65bZ8W58oiiNEgLyr65+euzdIMofzt9S3o=
X-Received: by 2002:aa7:cd56:: with SMTP id v22mr1138184edw.245.1604052638390; 
 Fri, 30 Oct 2020 03:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-20-ehabkost@redhat.com>
 <CAJ+F1CJmU0G1CJnaj-i1KYCfN_ir+tppcfQESY1xpv50nJAxHg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJmU0G1CJnaj-i1KYCfN_ir+tppcfQESY1xpv50nJAxHg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 14:10:26 +0400
Message-ID: <CAJ+F1C+vhmBOW9u8SspnHa-wgu6+F75PoQHbfJu7btZxKoLi7Q@mail.gmail.com>
Subject: Re: [PATCH 19/36] qdev: Move array property creation/registration to
 separate functions
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b65ede05b2e09bec"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b65ede05b2e09bec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:03 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

>
>
> On Fri, Oct 30, 2020 at 2:17 AM Eduardo Habkost <ehabkost@redhat.com>
> wrote:
>
>> The array property registration code is hard to follow.  Move the
>> two steps into separate functions that have clear
>> responsibilities.
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: qemu-devel@nongnu.org
>> ---
>>  hw/core/qdev-properties.c | 60 ++++++++++++++++++++++++++-------------
>>  1 file changed, 41 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 27c09255d7..1f06dfb5d5 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -588,6 +588,32 @@ typedef struct {
>>      ObjectPropertyRelease *release;
>>  } ArrayElementProperty;
>>
>> +/**
>> + * Create ArrayElementProperty based on array length property
>> + * @array_len_prop (which was previously defined using
>> DEFINE_PROP_ARRAY()).
>> + */
>>
>
> (some day we will have to clarify our API doc style, but not now ;)
>
>
Actually, I didn't realize but we do use kerneldoc in sphinx nowadays.

Peter, shouldn't you have updated CODING_STYLE.rst to say explicitly that
our C API should be documented with it?

How do we enforce or check the comment style across the code base, or
per-files (without necessarily including it in the generated manual/doc)?

thanks

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b65ede05b2e09bec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:03 PM Marc-=
Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcand=
re.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 20=
20 at 2:17 AM Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" ta=
rget=3D"_blank">ehabkost@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">The array property registration code is =
hard to follow.=C2=A0 Move the<br>
two steps into separate functions that have clear<br>
responsibilities.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br>
---<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_b=
lank">ehabkost@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0hw/core/qdev-properties.c | 60 ++++++++++++++++++++++++++------------=
-<br>
=C2=A01 file changed, 41 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 27c09255d7..1f06dfb5d5 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -588,6 +588,32 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0ObjectPropertyRelease *release;<br>
=C2=A0} ArrayElementProperty;<br>
<br>
+/**<br>
+ * Create ArrayElementProperty based on array length property<br>
+ * @array_len_prop (which was previously defined using DEFINE_PROP_ARRAY()=
).<br>
+ */<br></blockquote><div><br></div><div>(some day we will have to clarify =
our API doc style, but not now ;)</div><br clear=3D"all"></div></div></bloc=
kquote><div><br></div><div>Actually, I didn&#39;t realize but we do use ker=
neldoc in sphinx nowadays.</div><div><br></div><div>Peter, shouldn&#39;t yo=
u have updated CODING_STYLE.rst to say explicitly that our C API should be =
documented with it?</div><div><br></div><div>How do we enforce or check the=
 comment style across the code base, or per-files (without necessarily incl=
uding it in the generated manual/doc)?</div><div><br></div><div>thanks<br><=
/div></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=
=C3=A9 Lureau<br></div></div>

--000000000000b65ede05b2e09bec--

