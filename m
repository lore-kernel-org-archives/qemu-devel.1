Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED57C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC25206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjefQzq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC25206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyzmE-0003v8-Df
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyzl9-0003PX-73
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:37:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyzl7-0007oV-Ac
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:37:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id z18so5147222wrm.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rz8FGST7LPeSDK1OGr/hHw1mxI1+So7brMFVnBYI45w=;
 b=KjefQzq9PA9QhmmFIkP9ACMbRD4GglO4YeFOn5723H9Ejs1LYyLUWMWE1HMD1S1Tdk
 qoeBkN/UxkJlZQEqSBYTZDJZmFFY3MUhV6Aw2eQWRT9N/gl5e9efFa7QD4iMqXiSTFXq
 EaMiwUZ9lOvDJTt0VUH5spaJyCZ9mvA7vvAFPxfrN92a5nJHRk3c41DzxNmxhdpnH+Za
 KEQZKcA3TU5trYU0psrsNHZwylhbvWSqKtmhvrOHKCjT3NLOYgfVx/sHWuj1C+hZfNeC
 hzNyKb++ev5ukJLwPloZXli9Jvn75Q2CVRq2f4Hz19bA8IgpkMghmRlR0sxRKtumk+Vh
 0dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rz8FGST7LPeSDK1OGr/hHw1mxI1+So7brMFVnBYI45w=;
 b=T5c90pgTGEoEPh2f39MZk5VopybVYRfJ58LmK4EDT2DdXm4o0omcU+HYsixvoNIKTb
 LIenlFo0pLYTzd1CVGYfH1G7AbPAd19CXOBx9VdNpVg1YyANcYJBw412rWsMrt74YSu6
 Ut92RrJppRYFm4LC7rJrFuQC8GZTRTtk8bfqDXOpU+Ii/4o2jWrWppLNuQIG0HK2gWdZ
 IuM/4tldvCGXmHu6B8iK+T+30eSpq3YfBJ2gdh01l/Ho7eMlpZFQ+TJY/VPRbSUKZMzg
 NY21/JzjmCboCY/aVfeiGUtflDP0r2nkarOE8aUlBazZOkqxwcdqFlXy9s6PGsKQn3/r
 jtiQ==
X-Gm-Message-State: AOAM531YhP2aIxGB7OV8a5Epw0sRHHioeBp0k761HWVNsRUaqL0Duy2S
 CYAMK0RNJQkdp15rPgOO6fAx4Os5uId7hBPXen0=
X-Google-Smtp-Source: ABdhPJzlbouXVCoB6z7n2Jt9xaMogypr4g6THYzh4ad5XGHwdAjpNc5jhiJNDNpmY6Z7KfShLNxUDB0V9USYw7gC+G8=
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr9429185wrp.96.1595605035792;
 Fri, 24 Jul 2020 08:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200724141552.2505990-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200724141552.2505990-1-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Jul 2020 19:37:02 +0400
Message-ID: <CAJ+F1CK364=vgJ1zw9H3nYoiAXNWA-MTHUuSrEUaL1uDBmnLeQ@mail.gmail.com>
Subject: Re: [PATCH V2] tpm_emulator: Report an error if chardev is missing
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000005c3ce905ab31bfd2"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005c3ce905ab31bfd2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jul 24, 2020 at 6:16 PM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> This patch fixes the odd error reporting when trying to send a file
> descriptor to the TPM emulator if one has not passed a valid chardev.
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Failed to s=
end
> CMD_SET_DATAFD: Success
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Could not
> cleanly shutdown the TPM: Success
>
> This is the new error report:
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0
> qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: parameter
> 'chardev' is missing
>
> This change does not hide the display of supported TPM types if a
> non-existent type is passed:
>
> $ x86_64-softmmu/qemu-system-x86_64 -tpmdev nonexistent,id=3Dtpm0
> qemu-system-x86_64: -tpmdev nonexistent,id=3Dtpm0: Parameter 'type' expec=
ts
> a TPM backend type
> Supported TPM types (choose only one):
>  passthrough   Passthrough TPM backend driver
>     emulator   TPM emulator backend driver
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  backends/tpm/tpm_emulator.c | 38 ++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 9605339f93..a9b0f55e67 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -549,27 +549,30 @@ err_exit:
>  static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpt=
s
> *opts)
>  {
>      const char *value;
> +    Error *err =3D NULL;
> +    Chardev *dev;
>
>      value =3D qemu_opt_get(opts, "chardev");
> -    if (value) {
> -        Error *err =3D NULL;
> -        Chardev *dev =3D qemu_chr_find(value);
> -
> -        if (!dev) {
> -            error_report("tpm-emulator: tpm chardev '%s' not found.",
> value);
> -            goto err;
> -        }
> +    if (!value) {
> +        error_report("tpm-emulator: parameter 'chardev' is missing");
> +        goto err;
> +    }
>
> -        if (!qemu_chr_fe_init(&tpm_emu->ctrl_chr, dev, &err)) {
> -            error_prepend(&err, "tpm-emulator: No valid chardev found at
> '%s':",
> -                          value);
> -            error_report_err(err);
> -            goto err;
> -        }
> +    dev =3D qemu_chr_find(value);
> +    if (!dev) {
> +        error_report("tpm-emulator: tpm chardev '%s' not found", value);
> +        goto err;
> +    }
>
> -        tpm_emu->options->chardev =3D g_strdup(value);
> +    if (!qemu_chr_fe_init(&tpm_emu->ctrl_chr, dev, &err)) {
> +        error_prepend(&err, "tpm-emulator: No valid chardev found at
> '%s':",
> +                      value);
> +        error_report_err(err);
> +        goto err;
>      }
>
> +    tpm_emu->options->chardev =3D g_strdup(value);
> +
>      if (tpm_emulator_prepare_data_fd(tpm_emu) < 0) {
>          goto err;
>      }
> @@ -925,6 +928,11 @@ static void tpm_emulator_shutdown(TPMEmulator
> *tpm_emu)
>  {
>      ptm_res res;
>
> +    if (!tpm_emu->options->chardev) {
> +        /* was never properly initialized */
> +        return;
> +    }
> +
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0, sizeof(res)=
)
> < 0) {
>          error_report("tpm-emulator: Could not cleanly shutdown the TPM:
> %s",
>                       strerror(errno));
> --
> 2.24.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005c3ce905ab31bfd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 24, 2020 at 6:16 PM Ste=
fan Berger &lt;<a href=3D"mailto:stefanb@linux.vnet.ibm.com">stefanb@linux.=
vnet.ibm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">This patch fixes the odd error reporting when trying to send a =
file<br>
descriptor to the TPM emulator if one has not passed a valid chardev.<br>
<br>
$ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0<br>
qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Failed to sen=
d CMD_SET_DATAFD: Success<br>
qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: Could not cle=
anly shutdown the TPM: Success<br>
<br>
This is the new error report:<br>
<br>
$ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=3Dtpm0<br>
qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0: tpm-emulator: parameter &#3=
9;chardev&#39; is missing<br>
<br>
This change does not hide the display of supported TPM types if a non-exist=
ent type is passed:<br>
<br>
$ x86_64-softmmu/qemu-system-x86_64 -tpmdev nonexistent,id=3Dtpm0<br>
qemu-system-x86_64: -tpmdev nonexistent,id=3Dtpm0: Parameter &#39;type&#39;=
 expects a TPM backend type<br>
Supported TPM types (choose only one):<br>
=C2=A0passthrough=C2=A0 =C2=A0Passthrough TPM backend driver<br>
=C2=A0 =C2=A0 emulator=C2=A0 =C2=A0TPM emulator backend driver<br>
<br>
Signed-off-by: Stefan Berger &lt;<a href=3D"mailto:stefanb@linux.ibm.com" t=
arget=3D"_blank">stefanb@linux.ibm.com</a>&gt;<br></blockquote><div><br></d=
iv><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0backends/tpm/tpm_emulator.c | 38 ++++++++++++++++++++++--------------=
-<br>
=C2=A01 file changed, 23 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c<br>
index 9605339f93..a9b0f55e67 100644<br>
--- a/backends/tpm/tpm_emulator.c<br>
+++ b/backends/tpm/tpm_emulator.c<br>
@@ -549,27 +549,30 @@ err_exit:<br>
=C2=A0static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, Qemu=
Opts *opts)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *value;<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 Chardev *dev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0value =3D qemu_opt_get(opts, &quot;chardev&quot;);<br>
-=C2=A0 =C2=A0 if (value) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *err =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Chardev *dev =3D qemu_chr_find(value);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dev) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;tpm-emulator:=
 tpm chardev &#39;%s&#39; not found.&quot;, value);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!value) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;tpm-emulator: parameter &#3=
9;chardev&#39; is missing&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!qemu_chr_fe_init(&amp;tpm_emu-&gt;ctrl_ch=
r, dev, &amp;err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(&amp;err, &quot;tp=
m-emulator: No valid chardev found at &#39;%s&#39;:&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 value);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 dev =3D qemu_chr_find(value);<br>
+=C2=A0 =C2=A0 if (!dev) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;tpm-emulator: tpm chardev &=
#39;%s&#39; not found&quot;, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tpm_emu-&gt;options-&gt;chardev =3D g_strdup(v=
alue);<br>
+=C2=A0 =C2=A0 if (!qemu_chr_fe_init(&amp;tpm_emu-&gt;ctrl_chr, dev, &amp;e=
rr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(&amp;err, &quot;tpm-emulator: No=
 valid chardev found at &#39;%s&#39;:&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 tpm_emu-&gt;options-&gt;chardev =3D g_strdup(value);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (tpm_emulator_prepare_data_fd(tpm_emu) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -925,6 +928,11 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ptm_res res;<br>
<br>
+=C2=A0 =C2=A0 if (!tpm_emu-&gt;options-&gt;chardev) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was never properly initialized */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &amp;re=
s, 0, sizeof(res)) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;tpm-emulator: Could no=
t cleanly shutdown the TPM: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strerror(errno));<br>
-- <br>
2.24.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000005c3ce905ab31bfd2--

