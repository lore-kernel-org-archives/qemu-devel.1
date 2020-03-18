Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B20C4332D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0B120754
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co4giBml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0B120754
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEi6S-0008R8-Nj
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 19:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1jEi5A-0007cS-V5
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1jEi59-0001Pa-Ex
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:26:40 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1jEi59-0001GD-7J
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:26:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id d62so683568oia.11
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=44bHZ+W0YJmnXbzRSeCqbQcbWvyLTBCJmdsYg0kfSjQ=;
 b=Co4giBml33IeLEOb1U2OwFKAdvnCcdzwASDyzpRDHBKxMWXUEFq/SApPhZRQgaveGa
 wuy3AA4+3WhJ/3MSfPZ5gh/GcO1Rscbhj/Bei7vrFTvcgLdB4w++7h9+KOnUsTaqbsNY
 Blm8Wgp/aSZ6RckLHqSfCflQ82F9/4wJZHEeWpOAsYTJ9ATrs94DrDSNRXqFYJVNHFJM
 WMz/BYRXHzu30sLNXo7LhkTs+LC/V7Y67F/HIatzaPPGkSWeRpayFZR8Q9dyAwdO8LX2
 DlngzL1Hie2OC25IQOQmhPx8Ae+22UdFaIcMPfmtnM3rR45m1BVk6aEVWjPuYCbtvK8B
 PraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=44bHZ+W0YJmnXbzRSeCqbQcbWvyLTBCJmdsYg0kfSjQ=;
 b=uHD0IzIi/KjY6SmhNaxgLVY3nk196k5D7jGWaNgln0TEekiUTXZXKTFnrtZ+UX7tm7
 h8ejL9ZEmB9T8jmwJDuptAPJFJdnStSLTxL5DG55zausAytlF6WbCe5/jpe0AzfwTq8i
 1qTMCkKMAgFIxf2k1YrrJOOFwPsgxZaIbGGitHqoJnmMSx5s1chBCTg4R39MdG7dAvUN
 PK40P8rbXx3id/gtMw2haeZdgupgqGb7u6NhtBl3GeoxKoIXPrS27oWgI4ejdmJNCGpA
 74ZvHuiEd07/7gw63YrNfNAOg3npnA4YevJ3Q+3y71VJy/S6wOIzbfzvppvtv/LuwbM9
 qv/A==
X-Gm-Message-State: ANhLgQ1mE67NvPRBo0FdTHWvzgVULeJeCadBGT7g3salEdAaWTqgYQ5J
 EkQeUQZyE4vbuvCZmeGF/9ghFkn3OATXyV2vEupa7kM1FJKTHQ==
X-Google-Smtp-Source: ADFU+vuhdvWER9VLENYuhw2I+CBjn7Buj90e5clX52J0WwbuvmJQk+N03xbmVzmJoCh2dsf+eYldDjuYea1dOV8XV1c=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr301647oif.131.1584573997326; 
 Wed, 18 Mar 2020 16:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200307010051.97022-1-yuanzi@google.com>
In-Reply-To: <20200307010051.97022-1-yuanzi@google.com>
From: Lirong Yuan <yuanzi@google.com>
Date: Wed, 18 Mar 2020 16:26:26 -0700
Message-ID: <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>
Content-Type: multipart/alternative; boundary="0000000000003b881d05a1296265"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

--0000000000003b881d05a1296265
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2020 at 5:01 PM Lirong Yuan <yuanzi@google.com> wrote:

> This allows gdb to access the target=E2=80=99s auxiliary vector,
> which can be helpful for telling system libraries important details
> about the hardware, operating system, and process.
>
> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> ---
>  gdbstub.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 22a2d630cd..a946af7007 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2105,6 +2105,12 @@ static void handle_query_supported(GdbCmdContext
> *gdb_ctx, void *user_ctx)
>          pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
>                  ";qXfer:features:read+");
>      }
> +#ifdef CONFIG_USER_ONLY
> +    if (gdb_ctx->s->c_cpu->opaque) {
> +        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> +                ";qXfer:auxv:read+");
> +    }
> +#endif
>
>      if (gdb_ctx->num_params &&
>          strstr(gdb_ctx->params[0].data, "multiprocess+")) {
> @@ -2166,6 +2172,47 @@ static void
> handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
>      put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
>  }
>
> +#ifdef CONFIG_USER_ONLY
> +static void handle_query_xfer_auxv(GdbCmdContext *gdb_ctx, void *user_ct=
x)
> +{
> +    TaskState *ts;
> +    unsigned long offset, len, saved_auxv, auxv_len;
> +    const char *mem;
> +
> +    if (gdb_ctx->num_params < 2) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    offset =3D gdb_ctx->params[0].val_ul;
> +    len =3D gdb_ctx->params[1].val_ul;
> +
> +    ts =3D gdb_ctx->s->c_cpu->opaque;
> +    saved_auxv =3D ts->info->saved_auxv;
> +    auxv_len =3D ts->info->auxv_len;
> +    mem =3D (const char *)(saved_auxv + offset);
> +
> +    if (offset >=3D auxv_len) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
> +        len =3D (MAX_PACKET_LENGTH - 5) / 2;
> +    }
> +
> +    if (len < auxv_len - offset) {
> +        gdb_ctx->str_buf[0] =3D 'm';
> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, len);
> +    } else {
> +        gdb_ctx->str_buf[0] =3D 'l';
> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, auxv_len - offset);
> +    }
> +
> +    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
> +}
> +#endif
> +
>  static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx=
)
>  {
>      put_packet(gdb_ctx->s, GDB_ATTACHED);
> @@ -2271,6 +2318,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D =
{
>          .cmd_startswith =3D 1,
>          .schema =3D "s:l,l0"
>      },
> +#ifdef CONFIG_USER_ONLY
> +    {
> +        .handler =3D handle_query_xfer_auxv,
> +        .cmd =3D "Xfer:auxv:read:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l,l0"
> +    },
> +#endif
>      {
>          .handler =3D handle_query_attached,
>          .cmd =3D "Attached:",
> --
> 2.25.1.481.gfbce0eb801-goog
>
>
Friendly ping~

Link to the patchwork page:
http://patchwork.ozlabs.org/patch/1250727/

--0000000000003b881d05a1296265
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, 2020 at 5:01 PM Lirong Yua=
n &lt;<a href=3D"mailto:yuanzi@google.com">yuanzi@google.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This allows gdb=
 to access the target=E2=80=99s auxiliary vector,<br>
which can be helpful for telling system libraries important details<br>
about the hardware, operating system, and process.<br>
<br>
Signed-off-by: Lirong Yuan &lt;<a href=3D"mailto:yuanzi@google.com" target=
=3D"_blank">yuanzi@google.com</a>&gt;<br>
---<br>
=C2=A0gdbstub.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 55 insertions(+)<br>
<br>
diff --git a/gdbstub.c b/gdbstub.c<br>
index 22a2d630cd..a946af7007 100644<br>
--- a/gdbstub.c<br>
+++ b/gdbstub.c<br>
@@ -2105,6 +2105,12 @@ static void handle_query_supported(GdbCmdContext *gd=
b_ctx, void *user_ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pstrcat(gdb_ctx-&gt;str_buf, sizeof(gdb_c=
tx-&gt;str_buf),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;;qXfer:=
features:read+&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#ifdef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 if (gdb_ctx-&gt;s-&gt;c_cpu-&gt;opaque) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pstrcat(gdb_ctx-&gt;str_buf, sizeof(gdb_ctx-&g=
t;str_buf),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;;qXfer:auxv:=
read+&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (gdb_ctx-&gt;num_params &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strstr(gdb_ctx-&gt;params[0].data, &quot;=
multiprocess+&quot;)) {<br>
@@ -2166,6 +2172,47 @@ static void handle_query_xfer_features(GdbCmdContext=
 *gdb_ctx, void *user_ctx)<br>
=C2=A0 =C2=A0 =C2=A0put_packet_binary(gdb_ctx-&gt;s, gdb_ctx-&gt;str_buf, l=
en + 1, true);<br>
=C2=A0}<br>
<br>
+#ifdef CONFIG_USER_ONLY<br>
+static void handle_query_xfer_auxv(GdbCmdContext *gdb_ctx, void *user_ctx)=
<br>
+{<br>
+=C2=A0 =C2=A0 TaskState *ts;<br>
+=C2=A0 =C2=A0 unsigned long offset, len, saved_auxv, auxv_len;<br>
+=C2=A0 =C2=A0 const char *mem;<br>
+<br>
+=C2=A0 =C2=A0 if (gdb_ctx-&gt;num_params &lt; 2) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_packet(gdb_ctx-&gt;s, &quot;E22&quot;);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 offset =3D gdb_ctx-&gt;params[0].val_ul;<br>
+=C2=A0 =C2=A0 len =3D gdb_ctx-&gt;params[1].val_ul;<br>
+<br>
+=C2=A0 =C2=A0 ts =3D gdb_ctx-&gt;s-&gt;c_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 saved_auxv =3D ts-&gt;info-&gt;saved_auxv;<br>
+=C2=A0 =C2=A0 auxv_len =3D ts-&gt;info-&gt;auxv_len;<br>
+=C2=A0 =C2=A0 mem =3D (const char *)(saved_auxv + offset);<br>
+<br>
+=C2=A0 =C2=A0 if (offset &gt;=3D auxv_len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_packet(gdb_ctx-&gt;s, &quot;E22&quot;);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (len &gt; (MAX_PACKET_LENGTH - 5) / 2) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D (MAX_PACKET_LENGTH - 5) / 2;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (len &lt; auxv_len - offset) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_ctx-&gt;str_buf[0] =3D &#39;m&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D memtox(gdb_ctx-&gt;str_buf + 1, mem, l=
en);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_ctx-&gt;str_buf[0] =3D &#39;l&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D memtox(gdb_ctx-&gt;str_buf + 1, mem, a=
uxv_len - offset);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 put_packet_binary(gdb_ctx-&gt;s, gdb_ctx-&gt;str_buf, len + =
1, true);<br>
+}<br>
+#endif<br>
+<br>
=C2=A0static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_=
ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0put_packet(gdb_ctx-&gt;s, GDB_ATTACHED);<br>
@@ -2271,6 +2318,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cmd_startswith =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.schema =3D &quot;s:l,l0&quot;<br>
=C2=A0 =C2=A0 =C2=A0},<br>
+#ifdef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .handler =3D handle_query_xfer_auxv,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd =3D &quot;Xfer:auxv:read:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd_startswith =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .schema =3D &quot;l,l0&quot;<br>
+=C2=A0 =C2=A0 },<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.handler =3D handle_query_attached,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cmd =3D &quot;Attached:&quot;,<br>
-- <br>
2.25.1.481.gfbce0eb801-goog<br>
<br></blockquote><div><br></div><div>Friendly ping~</div><div><br></div><di=
v>Link to the patchwork page:</div><div><a href=3D"http://patchwork.ozlabs.=
org/patch/1250727/">http://patchwork.ozlabs.org/patch/1250727/</a></div></d=
iv></div>

--0000000000003b881d05a1296265--

