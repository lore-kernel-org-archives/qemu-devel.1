Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D719C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6380B20857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANvuw2KL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6380B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTKH-0005CV-Jh
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50738 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQTIX-0003cU-QL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:05:06 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQTIX-0007ih-0L
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:05:05 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46218)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jQTIW-0007d6-J6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:05:04 -0400
Received: by mail-lj1-x242.google.com with SMTP id f18so3213669lja.13
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qCahw2vz6QYaMfunEj6B1HZkP+WpPZBcP5RC424Py2Y=;
 b=ANvuw2KLX2+hNzPBYlpCl8Ei2tA+JF8KRr/zQIc4UBGs0pg2o9J7zr3/RuSbbaQiG8
 3Bbg2s6ZmBlNIjsQbAg87NWD2vrA2wbFsWENjqhDz/eAhQj3R5SpOg/PVHl1UaBbxr+B
 BR8h/EjXB85a6+wDS3X3TQrrUWomGLyGG6eNtf01+Fg7h3o0L/BhAteCGxgD3cuHaXPQ
 y9e43rtMPVD1uDHzINOoagvzbBfa+e5a+Kc9hD3FVC0X9rTR6zYkSK802mn7tkH3Pyru
 KnovVQ4Q3fZoTlj/mc3d1LIR/IKtpC0ClDNRsdFSwWcuSx+v/q23m+eXejw5BmIZkj6b
 P2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qCahw2vz6QYaMfunEj6B1HZkP+WpPZBcP5RC424Py2Y=;
 b=FG8DJ3cg975+wV5migmy1xZfrnsRXlmHoCnsVeNGMlNwOh37a2UU0MK8rdoLwjmwFD
 jutiaPj/LGZX2WAdyyVWFzL4xNp2dl9R5b8t67TeE5BKukU91d4AbjkJQ4tK+MI7bdfw
 VlMRhiLbFONGKgY9/mdKIXTWr51Mk6N9NhZjdiNkOaGk5TlUj0TIQokoOeCGI/XXvtDh
 GrdVN8eks7Nlq+H8HvH5vZDtl7pTnvHpK1NjgaJCJzBup6Re9jkAgbcxbqFLaRfw1Abb
 SjtE59ztn3HAgL+c1STu1LO/cJCsAsJT9UXMpJMOi4ywvndzflaFwkwb1xmYGO5iXP3f
 pmMQ==
X-Gm-Message-State: AGi0PubDqS/vOViD25L3qnFrxU0uVjkWRa+EQ6egQr84I0pgZwEUGUOK
 RKj9UQq2PjcWTVVbpOqJsddnnPxXnwfehRhfH2c=
X-Google-Smtp-Source: APiQypL296dv5aWUiG6BuTwdIatd5h3e6g/W+XZ1H4U1Ogoba6J9n89TWSXzDuXOjX1tL+AYhHkhPUaUr/A3stgju98=
X-Received: by 2002:a2e:8745:: with SMTP id q5mr9894412ljj.157.1587377102633; 
 Mon, 20 Apr 2020 03:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
In-Reply-To: <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
From: Nikolay Igotti <igotti@gmail.com>
Date: Mon, 20 Apr 2020 13:04:51 +0300
Message-ID: <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="00000000000053bd2305a3b6086f"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=igotti@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, riku.voipio@iki.fi,
 "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000053bd2305a3b6086f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, maybe this version will work better (gmail web interface may be not the
best one for sending patches):
----

In linux-user multithreaded scenarious CPU could be inited many times with
the same id,
so avoid assertions on already present hashtable entry.

Signed-off-by: Nikolay Igotti <igotti@gmail.com>
---
 plugins/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index 51bfc94787..889cc6441a 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum
qemu_plugin_event ev,

 void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
-    bool success;
-
     qemu_rec_mutex_lock(&plugin.lock);
     plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
-    success =3D g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
+    g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
-    g_assert(success);
     qemu_rec_mutex_unlock(&plugin.lock);

     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
--=20
2.24.2 (Apple Git-127)



On Mon, Apr 20, 2020 at 12:51 PM Laurent Vivier <laurent@vivier.eu> wrote:

> Nikolay,
>
> the patch seems corrupted by your mailer.
>
> CC: Alex and Emilio as this code is theirs.
>
> Thanks,
> Laurent
>
> Le 20/04/2020 =C3=A0 11:15, Nikolay Igotti a =C3=A9crit :
> > In linux-user multithreaded scenarious CPU could be inited many times
> > with the same id,
> >
> > so avoid assertions on already present hashtable entry.
> >
> >
> > Signed-off-by: Nikolay Igotti <igotti@gmail.com <mailto:igotti@gmail.co=
m
> >>
> >
> > ---
> >
> >  plugins/core.c | 5 +----
> >
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> >
> > diff --git a/plugins/core.c b/plugins/core.c
> >
> > index 51bfc94787..889cc6441a 100644
> >
> > --- a/plugins/core.c
> >
> > +++ b/plugins/core.c
> >
> > @@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enu=
m
> > qemu_plugin_event ev,
> >
> >
> >
> >  void qemu_plugin_vcpu_init_hook(CPUState *cpu)
> >
> >  {
> >
> > -    bool success;
> >
> > -
> >
> >      qemu_rec_mutex_lock(&plugin.lock);
> >
> >      plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
> >
> > -    success =3D g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
> >
> > +    g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
> >
> >                                    &cpu->cpu_index);
> >
> > -    g_assert(success);
> >
> >      qemu_rec_mutex_unlock(&plugin.lock);
> >
> >
> >
> >      plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
> >
> > --
> >
> > 2.24.2 (Apple Git-127)
> >
>
>

--00000000000053bd2305a3b6086f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK, maybe this version will work better (gmail web interfa=
ce may be not the best one for sending patches):<div>----</div><div><br></d=
iv><div>In linux-user multithreaded scenarious CPU could be inited many tim=
es with the same id,<br>so avoid assertions on already present hashtable en=
try.<br><br>Signed-off-by: Nikolay Igotti &lt;<a href=3D"mailto:igotti@gmai=
l.com">igotti@gmail.com</a>&gt;<br>---<br>=C2=A0plugins/core.c | 5 +----<br=
>=C2=A01 file changed, 1 insertion(+), 4 deletions(-)<br><br>diff --git a/p=
lugins/core.c b/plugins/core.c<br>index 51bfc94787..889cc6441a 100644<br>--=
- a/plugins/core.c<br>+++ b/plugins/core.c<br>@@ -196,13 +196,10 @@ plugin_=
register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,<br>=C2=A0=
<br>=C2=A0void qemu_plugin_vcpu_init_hook(CPUState *cpu)<br>=C2=A0{<br>- =
=C2=A0 =C2=A0bool success;<br>-<br>=C2=A0 =C2=A0 =C2=A0qemu_rec_mutex_lock(=
&amp;plugin.lock);<br>=C2=A0 =C2=A0 =C2=A0plugin_cpu_update__locked(&amp;cp=
u-&gt;cpu_index, NULL, NULL);<br>- =C2=A0 =C2=A0success =3D g_hash_table_in=
sert(plugin.cpu_ht, &amp;cpu-&gt;cpu_index,<br>+ =C2=A0 =C2=A0g_hash_table_=
insert(plugin.cpu_ht, &amp;cpu-&gt;cpu_index,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cpu-&gt;cpu_index);<br>- =C2=A0 =C2=A0g_ass=
ert(success);<br>=C2=A0 =C2=A0 =C2=A0qemu_rec_mutex_unlock(&amp;plugin.lock=
);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN=
_EV_VCPU_INIT);<br>-- <br>2.24.2 (Apple Git-127)<br><div><br></div><div><br=
></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Apr 20, 2020 at 12:51 PM Laurent Vivier &lt;<a href=3D=
"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Nikolay,<br>
<br>
the patch seems corrupted by your mailer.<br>
<br>
CC: Alex and Emilio as this code is theirs.<br>
<br>
Thanks,<br>
Laurent<br>
<br>
Le 20/04/2020 =C3=A0 11:15, Nikolay Igotti a =C3=A9crit=C2=A0:<br>
&gt; In linux-user multithreaded scenarious CPU could be inited many times<=
br>
&gt; with the same id,<br>
&gt; <br>
&gt; so avoid assertions on already present hashtable entry.<br>
&gt; <br>
&gt; <br>
&gt; Signed-off-by: Nikolay Igotti &lt;<a href=3D"mailto:igotti@gmail.com" =
target=3D"_blank">igotti@gmail.com</a> &lt;mailto:<a href=3D"mailto:igotti@=
gmail.com" target=3D"_blank">igotti@gmail.com</a>&gt;&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; <br>
&gt; =C2=A0plugins/core.c | 5 +----<br>
&gt; <br>
&gt; =C2=A01 file changed, 1 insertion(+), 4 deletions(-)<br>
&gt; <br>
&gt; <br>
&gt; diff --git a/plugins/core.c b/plugins/core.c<br>
&gt; <br>
&gt; index 51bfc94787..889cc6441a 100644<br>
&gt; <br>
&gt; --- a/plugins/core.c<br>
&gt; <br>
&gt; +++ b/plugins/core.c<br>
&gt; <br>
&gt; @@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, en=
um<br>
&gt; qemu_plugin_event ev,<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt; =C2=A0void qemu_plugin_vcpu_init_hook(CPUState *cpu)<br>
&gt; <br>
&gt; =C2=A0{<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 bool success;<br>
&gt; <br>
&gt; -<br>
&gt; <br>
&gt; =C2=A0=C2=A0 =C2=A0 qemu_rec_mutex_lock(&amp;plugin.lock);<br>
&gt; <br>
&gt; =C2=A0=C2=A0 =C2=A0 plugin_cpu_update__locked(&amp;cpu-&gt;cpu_index, =
NULL, NULL);<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 success =3D g_hash_table_insert(plugin.cpu_ht, &amp;cpu=
-&gt;cpu_index,<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 g_hash_table_insert(plugin.cpu_ht, &amp;cpu-&gt;cpu_ind=
ex,<br>
&gt; <br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cpu-&gt;cpu_in=
dex);<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 g_assert(success);<br>
&gt; <br>
&gt; =C2=A0=C2=A0 =C2=A0 qemu_rec_mutex_unlock(&amp;plugin.lock);<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt; =C2=A0=C2=A0 =C2=A0 plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IN=
IT);<br>
&gt; <br>
&gt; --=C2=A0<br>
&gt; <br>
&gt; 2.24.2 (Apple Git-127)<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000053bd2305a3b6086f--

