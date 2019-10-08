Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990CC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A45206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heciCnyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A45206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHmcl-0000vT-3f
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHmbv-0000ML-Ot
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHmbu-0006N0-D7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:20:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHmbu-0006Mc-7L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:20:54 -0400
Received: by mail-ot1-x344.google.com with SMTP id m19so13611884otp.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pkuL1h4GcIIYt9dCt+v/CLcNYi5BDU4k4nAmkdM/Apo=;
 b=heciCnyJNusVPQ5/HkdxMnjyxNfS76XFTrHk4hbsMVHoE77vIZTHLxtO17QA5x3kLZ
 L/MyiJd++KrRgF3tw3pq61z9bVdqH6EYJAmuIsITUeMpdcWe2odH2MFyOs4R8L1pBS6z
 XiUi6ne0qQ8kMAweG3t5pNvX9Bm866u9Xb/6HqHZaF9qW5tOdlI21XChCyH7aAmVr7P2
 WCqIba4Bk4HedQy2HiVcsDR4NC6AeNLOw7HOofoYh6PFJEG3k0zEe0YVwIqbkOKP7gC4
 vCtoIsc+LrxflkQRZq+5qqjinEMngEoKYUAsEmJEvJgFkURtW5srC2OHi2nWJoSb9Jte
 gKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pkuL1h4GcIIYt9dCt+v/CLcNYi5BDU4k4nAmkdM/Apo=;
 b=Zb0YpuZOj1qxkwz0kHu0LRlkcrTGv0V58gUap5XhfC6UiS9J6ogOv1fKWtYrrNNh/R
 f/ucf18tb/arGV3t6QYXf4xxuD/OEsa4DtHF4TAx+lVzVswTqF+/kFq4tYoRNEJrH6yn
 Fm7cxM69yZiAJyyPVtISaIEJTOC5rvVGojG7V45liAsR+AlRfDtPmHQTtMguW/o2Q2wY
 WH+FuHyGYLnHCX/aybDM1yNLjXtkRjKPr79lo9c9gA8gppC3Kef3oeH+rO5sO/43kZik
 3ZqIehp5GB1oKwivN4tEPUEFhepa6yRZxqKT1vv3IRhMaw6l7NhI68DkELxEFpohmXgk
 NEHA==
X-Gm-Message-State: APjAAAXzSb82zkdCzIfCDnFdzQ6oDjVAL07LtEza1erKb6DMHzohDyaz
 1iPI7RzU8PLNNrwtHKSFoolswdTp+AhzOKSVRPLuoSGg
X-Google-Smtp-Source: APXvYqx6H+PV23al1dmkf4BsybUZdE5X7T71vkDW1zB10pDgVGJFLMsLI1nzyJ7PYaw0SFgpGeaGor08+8kGmKRLLgI=
X-Received: by 2002:a9d:67cb:: with SMTP id c11mr13602740otn.149.1570530053407; 
 Tue, 08 Oct 2019 03:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-3-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-3-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 18:20:17 +0800
Message-ID: <CAKXe6SLUUfR6X_hDXyW=uXB7KhbVxRahxT71qx4oCtEcm1+P4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] tests/libqos/fw_cfg: Document mm_fw_cfg_init to
 drop mm_fw_cfg_uninit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f1484205946385d8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f1484205946385d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:19=E5=86=99=E9=81=
=93=EF=BC=9A

> Document mm_fw_cfg_init() return value must be released
> with g_free(). mm_fw_cfg_uninit() was never used, remove it.
>
> This partly reverts commit 0729d833d6d6:
> "tests/libqos: Add mm_fw_cfg_uninit()"
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  tests/libqos/fw_cfg.c |  5 -----
>  tests/libqos/fw_cfg.h | 10 +++++++++-
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index 37c3f2cf4d..ddeec821db 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -126,11 +126,6 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t bas=
e)
>      return fw_cfg;
>  }
>
> -void mm_fw_cfg_uninit(QFWCFG *fw_cfg)
> -{
> -    g_free(fw_cfg);
> -}
> -
>  static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>  {
>      qtest_outw(fw_cfg->qts, fw_cfg->base, key);
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 15604040bd..3247fd4000 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -34,8 +34,16 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)=
;
>  size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>                          void *data, size_t buflen);
>
> +/**
> + * mm_fw_cfg_init():
> + * @qts: The #QTestState that will be referred to by the QFWCFG object.
> + * @base: The MMIO base address of the fw_cfg device in the guest.
> + *
> + * Returns a newly allocated QFWCFG object which must be released
> + * with a call to g_free() when no longer required.
> + */
>  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
> -void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
> +
>  /**
>   * io_fw_cfg_init():
>   * @qts: The #QTestState that will be referred to by the QFWCFG object.
> --
> 2.21.0
>
>

--000000000000f1484205946385d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:19=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Document mm_fw_cfg_init() return value must be released<br>
with g_free(). mm_fw_cfg_uninit() was never used, remove it.<br>
<br>
This partly reverts commit 0729d833d6d6:<br>
&quot;tests/libqos: Add mm_fw_cfg_uninit()&quot;<br>
<br>
Reviewed-by: Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com" target=
=3D"_blank">lersek@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div><br></div><div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mail=
to:liq3ea@gmail.com">liq3ea@gmail.com</a>&gt;<br></div><div></div></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0tests/libqos/fw_cfg.c |=C2=A0 5 -----<br>
=C2=A0tests/libqos/fw_cfg.h | 10 +++++++++-<br>
=C2=A02 files changed, 9 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c<br>
index 37c3f2cf4d..ddeec821db 100644<br>
--- a/tests/libqos/fw_cfg.c<br>
+++ b/tests/libqos/fw_cfg.c<br>
@@ -126,11 +126,6 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)=
<br>
=C2=A0 =C2=A0 =C2=A0return fw_cfg;<br>
=C2=A0}<br>
<br>
-void mm_fw_cfg_uninit(QFWCFG *fw_cfg)<br>
-{<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
-}<br>
-<br>
=C2=A0static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qtest_outw(fw_cfg-&gt;qts, fw_cfg-&gt;base, key);<br>
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h<br>
index 15604040bd..3247fd4000 100644<br>
--- a/tests/libqos/fw_cfg.h<br>
+++ b/tests/libqos/fw_cfg.h<br>
@@ -34,8 +34,16 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);<=
br>
=C2=A0size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0void *data, size_t buflen);<br>
<br>
+/**<br>
+ * mm_fw_cfg_init():<br>
+ * @qts: The #QTestState that will be referred to by the QFWCFG object.<br=
>
+ * @base: The MMIO base address of the fw_cfg device in the guest.<br>
+ *<br>
+ * Returns a newly allocated QFWCFG object which must be released<br>
+ * with a call to g_free() when no longer required.<br>
+ */<br>
=C2=A0QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);<br>
-void mm_fw_cfg_uninit(QFWCFG *fw_cfg);<br>
+<br>
=C2=A0/**<br>
=C2=A0 * io_fw_cfg_init():<br>
=C2=A0 * @qts: The #QTestState that will be referred to by the QFWCFG objec=
t.<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>

--000000000000f1484205946385d8--

