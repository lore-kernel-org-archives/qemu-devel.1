Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5692EC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 23:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F419B2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 23:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlDKznA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F419B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFRWN-0003PG-45
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 19:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1jFRVj-00030T-I7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 19:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1jFRVh-0007Bj-Lb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 19:57:07 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1jFRVh-0007AU-E2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 19:57:05 -0400
Received: by mail-oi1-x244.google.com with SMTP id 9so8405258oiq.12
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 16:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Prq1DTsYQjUead4PM+Qk5dnZe6+G68fmb097N6nWcQ=;
 b=RlDKznA+8M46v4P+6xIzIj2HsSpHaqYsLwgS2zIGJzGkgYClYEyT5QCIMd+LTvD5+b
 +yd3t8MjLKnU0ajMxCAaNaRkhzDT7GpbTAwEptVim91HLTKEiYFF6jYsju3IeMbTyMX3
 87C/webDuptW7VIPbl4/IKrsoiMAIaoHoARPVDBajRier95qBw9tID1LiI9+QPuwvPev
 Jut4lvb4WXD3QiOwxJvBIHahlfgP7Vo0aes73avKejdX3LuBlt1m9yOXK0iKVNIJ/ZwF
 PG6jbsWHg2026aDchGDy3cZFsG+StOrEOS0cC1C+Xy4dRRqhKkNrQNS2go4QBs62PAPR
 FFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Prq1DTsYQjUead4PM+Qk5dnZe6+G68fmb097N6nWcQ=;
 b=UyDJJfVV43NoQQ/pbCqnr2urK0bryHoJPGAuvB0DFRtz0RZ2ghPctI2+PBUpPSMnJv
 YPhxPKawiUV4QToXwCBSS/WrVz1j7iEOyNtA5glz2bjkHR9z073VjYy9QxoIdr+iYdRC
 2+5jJ4zbVZ/wZmnXT2HWsusBHxY1j3JlWWv8872pVXMronYIbrT2P91nq8In5hZTo1Ri
 w4Udm7T429mpvMdmfv35o8q245GJbh3pjBSbcAKxJICncuSi59/ZDDlwpEyZTCtpFVee
 Pwyr2JAgNBqAOg7S4NMCcotGztHQtI4JTKVYkN6CyVTNh9BIAIslmx43ChtHX2jYo/Rx
 oZ3g==
X-Gm-Message-State: ANhLgQ0wefzyj0aeaqLdMlFNuBRkFVBdlhPw34C+L6MorGdzn8d6l40q
 a/uFCq110rSah9y7aR14Ad/KcdXiksZlPmJsK1zbEw==
X-Google-Smtp-Source: ADFU+vvt91jQc6rWvprfqIXlFiuFIwG7zCXtVkEh3uqZh16H1aPZnHvfdKsgdI67d5kmPM0Y9B3ovy6pGq5xWvIzIFY=
X-Received: by 2002:a05:6808:8:: with SMTP id u8mr8498971oic.37.1584748623730; 
 Fri, 20 Mar 2020 16:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200307010051.97022-1-yuanzi@google.com>
 <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
 <87imizidwc.fsf@linaro.org>
In-Reply-To: <87imizidwc.fsf@linaro.org>
From: Lirong Yuan <yuanzi@google.com>
Date: Fri, 20 Mar 2020 16:56:52 -0700
Message-ID: <CADjx4CJJdQep+K3ibfhjin7Eo6uCEFGQ6R6yVC0OcNo8MsfvJw@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>
Content-Type: multipart/alternative; boundary="000000000000c6fce005a1520a2b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c6fce005a1520a2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Lirong Yuan <yuanzi@google.com> writes:
>
> > On Fri, Mar 6, 2020 at 5:01 PM Lirong Yuan <yuanzi@google.com> wrote:
> >
> >> This allows gdb to access the target=E2=80=99s auxiliary vector,
> >> which can be helpful for telling system libraries important details
> >> about the hardware, operating system, and process.
> >>
> >> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> >> ---
> >>  gdbstub.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 55 insertions(+)
> >>
> >> diff --git a/gdbstub.c b/gdbstub.c
> >> index 22a2d630cd..a946af7007 100644
> >> --- a/gdbstub.c
> >> +++ b/gdbstub.c
> >> @@ -2105,6 +2105,12 @@ static void handle_query_supported(GdbCmdContex=
t
> >> *gdb_ctx, void *user_ctx)
> >>          pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> >>                  ";qXfer:features:read+");
> >>      }
> >> +#ifdef CONFIG_USER_ONLY
> >> +    if (gdb_ctx->s->c_cpu->opaque) {
> >> +        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> >> +                ";qXfer:auxv:read+");
> >> +    }
> >> +#endif
> >>
> >>      if (gdb_ctx->num_params &&
> >>          strstr(gdb_ctx->params[0].data, "multiprocess+")) {
> >> @@ -2166,6 +2172,47 @@ static void
> >> handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
> >>      put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
> >>  }
> >>
> >> +#ifdef CONFIG_USER_ONLY
> >> +static void handle_query_xfer_auxv(GdbCmdContext *gdb_ctx, void
> *user_ctx)
> >> +{
> >> +    TaskState *ts;
> >> +    unsigned long offset, len, saved_auxv, auxv_len;
> >> +    const char *mem;
> >> +
> >> +    if (gdb_ctx->num_params < 2) {
> >> +        put_packet(gdb_ctx->s, "E22");
> >> +        return;
> >> +    }
> >> +
> >> +    offset =3D gdb_ctx->params[0].val_ul;
> >> +    len =3D gdb_ctx->params[1].val_ul;
> >> +
> >> +    ts =3D gdb_ctx->s->c_cpu->opaque;
> >> +    saved_auxv =3D ts->info->saved_auxv;
> >> +    auxv_len =3D ts->info->auxv_len;
> >> +    mem =3D (const char *)(saved_auxv + offset);
> >> +
> >> +    if (offset >=3D auxv_len) {
> >> +        put_packet(gdb_ctx->s, "E22");
> >> +        return;
> >> +    }
> >> +
> >> +    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
> >> +        len =3D (MAX_PACKET_LENGTH - 5) / 2;
> >> +    }
> >> +
> >> +    if (len < auxv_len - offset) {
> >> +        gdb_ctx->str_buf[0] =3D 'm';
> >> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, len);
> >> +    } else {
> >> +        gdb_ctx->str_buf[0] =3D 'l';
> >> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, auxv_len - offset);
> >> +    }
> >> +
> >> +    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
> >> +}
> >> +#endif
> >> +
> >>  static void handle_query_attached(GdbCmdContext *gdb_ctx, void
> *user_ctx)
> >>  {
> >>      put_packet(gdb_ctx->s, GDB_ATTACHED);
> >> @@ -2271,6 +2318,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =
=3D {
> >>          .cmd_startswith =3D 1,
> >>          .schema =3D "s:l,l0"
> >>      },
> >> +#ifdef CONFIG_USER_ONLY
> >> +    {
> >> +        .handler =3D handle_query_xfer_auxv,
> >> +        .cmd =3D "Xfer:auxv:read:",
> >> +        .cmd_startswith =3D 1,
> >> +        .schema =3D "l,l0"
> >> +    },
> >> +#endif
> >>      {
> >>          .handler =3D handle_query_attached,
> >>          .cmd =3D "Attached:",
> >> --
> >> 2.25.1.481.gfbce0eb801-goog
> >>
> >>
> > Friendly ping~
>
> Sorry I missed this on my radar. There was a minor re-factor of gdbstub
> that was just merged which will mean this patch needs a re-base to use
> g_string_* functions to expand stings.
>
> Also we have some simple gdbstub tests now - could we come up with a
> multiarch gdbstub test to verify this is working properly?
>
> >
> > Link to the patchwork page:
> > http://patchwork.ozlabs.org/patch/1250727/
>
>
> --
> Alex Benn=C3=A9e
>

Hi Alex,

For sure, I will re-base this patch to use g_string_* functions.

Currently we are using qemu aarch64. I am not sure how to do this yet, but
I could try to add something to
https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub

Does this sound good?

Thanks!
Lirong

--000000000000c6fce005a1520a2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><div><br></div></div></div></div></div><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 2=
0, 2020 at 2:17 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linar=
o.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br>
Lirong Yuan &lt;<a href=3D"mailto:yuanzi@google.com" target=3D"_blank">yuan=
zi@google.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Mar 6, 2020 at 5:01 PM Lirong Yuan &lt;<a href=3D"mailto:yuanz=
i@google.com" target=3D"_blank">yuanzi@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; This allows gdb to access the target=E2=80=99s auxiliary vector,<b=
r>
&gt;&gt; which can be helpful for telling system libraries important detail=
s<br>
&gt;&gt; about the hardware, operating system, and process.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Lirong Yuan &lt;<a href=3D"mailto:yuanzi@google.com=
" target=3D"_blank">yuanzi@google.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 gdbstub.c | 55 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++<br>
&gt;&gt;=C2=A0 1 file changed, 55 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/gdbstub.c b/gdbstub.c<br>
&gt;&gt; index 22a2d630cd..a946af7007 100644<br>
&gt;&gt; --- a/gdbstub.c<br>
&gt;&gt; +++ b/gdbstub.c<br>
&gt;&gt; @@ -2105,6 +2105,12 @@ static void handle_query_supported(GdbCmdCo=
ntext<br>
&gt;&gt; *gdb_ctx, void *user_ctx)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pstrcat(gdb_ctx-&gt;str_buf, siz=
eof(gdb_ctx-&gt;str_buf),<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;;qXfer:features:read+&quot;);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +#ifdef CONFIG_USER_ONLY<br>
&gt;&gt; +=C2=A0 =C2=A0 if (gdb_ctx-&gt;s-&gt;c_cpu-&gt;opaque) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pstrcat(gdb_ctx-&gt;str_buf, sizeof(g=
db_ctx-&gt;str_buf),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;;qX=
fer:auxv:read+&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +#endif<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (gdb_ctx-&gt;num_params &amp;&amp;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strstr(gdb_ctx-&gt;params[0].dat=
a, &quot;multiprocess+&quot;)) {<br>
&gt;&gt; @@ -2166,6 +2172,47 @@ static void<br>
&gt;&gt; handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 put_packet_binary(gdb_ctx-&gt;s, gdb_ctx-&gt;s=
tr_buf, len + 1, true);<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +#ifdef CONFIG_USER_ONLY<br>
&gt;&gt; +static void handle_query_xfer_auxv(GdbCmdContext *gdb_ctx, void *=
user_ctx)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 TaskState *ts;<br>
&gt;&gt; +=C2=A0 =C2=A0 unsigned long offset, len, saved_auxv, auxv_len;<br=
>
&gt;&gt; +=C2=A0 =C2=A0 const char *mem;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (gdb_ctx-&gt;num_params &lt; 2) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_packet(gdb_ctx-&gt;s, &quot;E22&q=
uot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 offset =3D gdb_ctx-&gt;params[0].val_ul;<br>
&gt;&gt; +=C2=A0 =C2=A0 len =3D gdb_ctx-&gt;params[1].val_ul;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 ts =3D gdb_ctx-&gt;s-&gt;c_cpu-&gt;opaque;<br>
&gt;&gt; +=C2=A0 =C2=A0 saved_auxv =3D ts-&gt;info-&gt;saved_auxv;<br>
&gt;&gt; +=C2=A0 =C2=A0 auxv_len =3D ts-&gt;info-&gt;auxv_len;<br>
&gt;&gt; +=C2=A0 =C2=A0 mem =3D (const char *)(saved_auxv + offset);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (offset &gt;=3D auxv_len) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_packet(gdb_ctx-&gt;s, &quot;E22&q=
uot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (len &gt; (MAX_PACKET_LENGTH - 5) / 2) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D (MAX_PACKET_LENGTH - 5) / 2;<=
br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (len &lt; auxv_len - offset) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_ctx-&gt;str_buf[0] =3D &#39;m&#39=
;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D memtox(gdb_ctx-&gt;str_buf + =
1, mem, len);<br>
&gt;&gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_ctx-&gt;str_buf[0] =3D &#39;l&#39=
;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D memtox(gdb_ctx-&gt;str_buf + =
1, mem, auxv_len - offset);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 put_packet_binary(gdb_ctx-&gt;s, gdb_ctx-&gt;str_bu=
f, len + 1, true);<br>
&gt;&gt; +}<br>
&gt;&gt; +#endif<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 static void handle_query_attached(GdbCmdContext *gdb_ctx, vo=
id *user_ctx)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 put_packet(gdb_ctx-&gt;s, GDB_ATTACHED);<br>
&gt;&gt; @@ -2271,6 +2318,14 @@ static GdbCmdParseEntry gdb_gen_query_table=
[] =3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd_startswith =3D 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .schema =3D &quot;s:l,l0&quot;<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;&gt; +#ifdef CONFIG_USER_ONLY<br>
&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .handler =3D handle_query_xfer_auxv,<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd =3D &quot;Xfer:auxv:read:&quot;,=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd_startswith =3D 1,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .schema =3D &quot;l,l0&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 },<br>
&gt;&gt; +#endif<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .handler =3D handle_query_attach=
ed,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd =3D &quot;Attached:&quot;,<=
br>
&gt;&gt; --<br>
&gt;&gt; 2.25.1.481.gfbce0eb801-goog<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Friendly ping~<br>
<br>
Sorry I missed this on my radar. There was a minor re-factor of gdbstub<br>
that was just merged which will mean this patch needs a re-base to use<br>
g_string_* functions to expand stings.<br>
<br>
Also we have some simple gdbstub tests now - could we come up with a<br>
multiarch gdbstub test to verify this is working properly?<br>
<br>
&gt;<br>
&gt; Link to the patchwork page:<br>
&gt; <a href=3D"http://patchwork.ozlabs.org/patch/1250727/" rel=3D"noreferr=
er" target=3D"_blank">http://patchwork.ozlabs.org/patch/1250727/</a><br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br></blockquote><div><br></div><div>Hi Alex,</div><div><br=
></div><div>For sure, I will re-base this patch to use g_string_* functions=
.</div><div><br></div><div>Currently we are using qemu aarch64. I am not su=
re how to do this yet, but I could try to add something to=C2=A0</div><div>=
<a href=3D"https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbst=
ub" target=3D"_blank">https://github.com/qemu/qemu/tree/master/tests/tcg/aa=
rch64/gdbstub</a></div><div><br></div><div>Does this sound good?</div><div>=
<br></div><div>Thanks!</div><div>Lirong</div><div><br></div></div></div>

--000000000000c6fce005a1520a2b--

