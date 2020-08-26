Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B20C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1127D2075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HE+1VCcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1127D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAs0W-0005TL-8o
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kArzx-0004yg-G4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kArzu-0000oH-LX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598435136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcmmYjm/owTCOq0Fhfp61RaSa0NPDTyi8PQOHVpSmP8=;
 b=HE+1VCcN6LMSGRs4n3JZ6UPbk1Ejv4H+2C+rXEusDbNZ3Fz3j1agAXvdePPPg1O4VZlYs3
 ooMj+4bXfheoR+uexeIsn5Oh85w+eKadZCZ3CaTU0dFQNZdwu62rjKtaSNKg07InN3FxN/
 gKOl0UZuDU5EsPjisTyYwYjLAvifPbw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-EBYvLrpsPnmDPWcmigddvQ-1; Wed, 26 Aug 2020 05:45:34 -0400
X-MC-Unique: EBYvLrpsPnmDPWcmigddvQ-1
Received: by mail-ed1-f70.google.com with SMTP id dd25so485223edb.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bcmmYjm/owTCOq0Fhfp61RaSa0NPDTyi8PQOHVpSmP8=;
 b=kWQbLeFS32DWinNNh5F4W9wjoQE8NFpp9XFx97F4XqJ4GEKIGfKNeUh8MA+SKG+YTf
 8HdOHDajaQOsVRamn9C126ED6je5/5/uN0tfO1oHgHkQmC3P7K1W0FaHEFuLgjHYXwjP
 6ocXswr3w5xA5TniYC+JxU9VoZNoRleO1ECLuciylr8yS6l7gKhOdTcIEvlCeH5GE5dI
 rgxL23GmqYXk1STBqr93iUBsLLGzUqB6MBpnzuOLvDi86icikHDIBcKnxTG7sZsN7S0r
 ca0BcZML9/rzmMM8/t2JyBZcbBdK4ZGXwnfJYadOOx05spv93AmmhEqkpHsgWejLWZj3
 U+Eg==
X-Gm-Message-State: AOAM5317ssgse31sKZLFYAnw5q5V/S3RybdIpKC9e9EQgp+RoOTTuR7Q
 Icd3OJOBXRGYxrh4+Cf2t8qx+icV2LH6v1xyFQrhcLRav3daKE1JOF2IYz4BtS0F48SttzK/DVR
 9zVI1ST8ipmNknCYs+VaYWCO/ea7J1rE=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr15346029ejw.71.1598435132852; 
 Wed, 26 Aug 2020 02:45:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn//rscvoBcLk9dJFue4bNGNrivSzMAM66Z8JvV3oNsVvqEVPoKO4j1k/o15DcPIA+3JHHVKDbahrzxpgwT+4=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr15346019ejw.71.1598435132656; 
 Wed, 26 Aug 2020 02:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200825175827.355940-1-marcandre.lureau@redhat.com>
 <20200825175827.355940-3-marcandre.lureau@redhat.com>
 <20200826082942.GD168515@redhat.com>
 <CAJ+F1CKxUK=t7vy-QXazi_syCQGdpxhJdb3KKH9PC6rGmcVVxQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CKxUK=t7vy-QXazi_syCQGdpxhJdb3KKH9PC6rGmcVVxQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 11:45:20 +0200
Message-ID: <CABgObfZH3JgXKK7gJRjgjmquHq61_vmCUpKnt2fsezsPA+EOPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] meson: use meson datadir instead of qemu_datadir
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000047637105adc4aee3"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000047637105adc4aee3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You'd need to check first if it works correctly if confsuffix "looks like"
an absolute path ('/qemu'). So + looks correct to me.

(Sorry for top posting).

Paolo

Il mer 26 ago 2020, 10:53 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.co=
m> ha
scritto:

> Hi
>
> On Wed, Aug 26, 2020 at 12:30 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com>
> wrote:
>
>> On Tue, Aug 25, 2020 at 09:58:24PM +0400, marcandre.lureau@redhat.com
>> wrote:
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > When cross-compiling, by default qemu_datadir is 'c:\Program
>> > Files\QEMU', which is not recognized as being an absolute path, and
>> > meson will end up adding the prefix again.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  contrib/vhost-user-gpu/meson.build | 2 +-
>> >  meson.build                        | 3 ++-
>> >  pc-bios/descriptors/meson.build    | 2 +-
>> >  pc-bios/keymaps/meson.build        | 6 +++---
>> >  pc-bios/meson.build                | 2 +-
>> >  tools/virtiofsd/meson.build        | 2 +-
>> >  trace/meson.build                  | 2 +-
>> >  7 files changed, 10 insertions(+), 9 deletions(-)
>> >
>>
>> > diff --git a/meson.build b/meson.build
>> > index f0fe5f8799..20f20a7bfc 100644
>> > --- a/meson.build
>> > +++ b/meson.build
>> > @@ -17,6 +17,7 @@ config_all_disas =3D
>> keyval.load(meson.current_build_dir() / 'config-all-disas.mak
>> >  enable_modules =3D 'CONFIG_MODULES' in config_host
>> >  enable_static =3D 'CONFIG_STATIC' in config_host
>> >  build_docs =3D 'BUILD_DOCS' in config_host
>> > +qemu_datadir =3D get_option('datadir') + get_option('confsuffix')
>>
>> This needs to be
>>
>>    get_option('datadir') / get_option('confsuffix')
>>
>> to add the dir separator if we're using the default meson value
>> for "confsuffix" which lacks a leading "/".
>>
>
> right, fixed
>
> --
> Marc-Andr=C3=A9 Lureau
>

--00000000000047637105adc4aee3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">You&#39;d need to check first if it works correctly if co=
nfsuffix &quot;looks like&quot; an absolute path (&#39;/qemu&#39;). So + lo=
oks correct to me.<div dir=3D"auto"><br></div><div dir=3D"auto">(Sorry for =
top posting).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>Il mer 26 ago 2020, 10:53 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@gmail.com">marcandre.lureau@gmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi<b=
r></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Aug 26, 2020 at 12:30 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"m=
ailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Tue, Aug 25, 2020 at 09:58:24PM +0400, <a href=3D"mailto:marcand=
re.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau=
@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com<=
/a>&gt;<br>
&gt; <br>
&gt; When cross-compiling, by default qemu_datadir is &#39;c:\Program<br>
&gt; Files\QEMU&#39;, which is not recognized as being an absolute path, an=
d<br>
&gt; meson will end up adding the prefix again.<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@re=
dhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 contrib/vhost-user-gpu/meson.build | 2 +-<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>
&gt;=C2=A0 pc-bios/descriptors/meson.build=C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 pc-bios/keymaps/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 6 +++--=
-<br>
&gt;=C2=A0 pc-bios/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 tools/virtiofsd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br=
>
&gt;=C2=A0 trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 7 files changed, 10 insertions(+), 9 deletions(-)<br>
&gt; <br>
<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index f0fe5f8799..20f20a7bfc 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -17,6 +17,7 @@ config_all_disas =3D keyval.load(meson.current_build=
_dir() / &#39;config-all-disas.mak<br>
&gt;=C2=A0 enable_modules =3D &#39;CONFIG_MODULES&#39; in config_host<br>
&gt;=C2=A0 enable_static =3D &#39;CONFIG_STATIC&#39; in config_host<br>
&gt;=C2=A0 build_docs =3D &#39;BUILD_DOCS&#39; in config_host<br>
&gt; +qemu_datadir =3D get_option(&#39;datadir&#39;) + get_option(&#39;conf=
suffix&#39;)<br>
<br>
This needs to be<br>
<br>
=C2=A0 =C2=A0get_option(&#39;datadir&#39;) / get_option(&#39;confsuffix&#39=
;)<br>
<br>
to add the dir separator if we&#39;re using the default meson value<br>
for &quot;confsuffix&quot; which lacks a leading &quot;/&quot;.<br></blockq=
uote><div><br></div><div>right, fixed<br></div><br></div>-- <br><div dir=3D=
"ltr">Marc-Andr=C3=A9 Lureau<br></div></div>
</blockquote></div>

--00000000000047637105adc4aee3--


