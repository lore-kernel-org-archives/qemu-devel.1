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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB2CC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C826206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgOWLGCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C826206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHmjr-0003sm-F9
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHmj0-0003PR-B5
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHmiy-0002K2-HW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:28:14 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHmiy-0002Jw-Bq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:28:12 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so14320668oib.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bUDVL4aLRms8fkfeT+dk0x6CPYiksxUyZwfEvCOvBG8=;
 b=YgOWLGCP1bt+DI94MLc5UW5F6nN7YaWinZlQy9Gz98o0LkEOgMXqvgOFhBIQjdTLBq
 WCDlpqCH5qhTtEsdLeDQAR9mfvXEJrFZdXCQoDCUZliEAKqDp4oplV4t2nlyI1olAz1+
 uzEIRsiZ/s3Kjovbt4NfiUs/hcJBrMssy1X6HIL7VvmQ5qr91X+SuHtbVvR+UYwvVO0S
 OT5EerbagEjxM6hw5iprg8tosDFCzSjXGB8WdWWywE07mtvc7g8Hkr0oZOP8pY+CsBTZ
 9UfLr8eY/MaRta6PZrnKMCJXzNQz6euwYy3ezJ25H7+/OVJ8LHo0X32XILpM6HNE+In+
 R5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bUDVL4aLRms8fkfeT+dk0x6CPYiksxUyZwfEvCOvBG8=;
 b=b8V6Sg4P0eLWjSzpcnx5UsX5HWRse04mEhJ4LuHArpPwnSk36OHsjSSWtkblTarf0R
 1Cl3BEK2XV1tYyOUexCiODaI/kaABL1SmkLd0ZE+9eaPjgscFE+pEmSKYHmPzshyErJE
 ujANib5fzzumwlWmYHWkf1sZioXVkaOiqgb5tMoUgdw4s1ZAyWglO5zXwdx0121WUVj9
 91uKN9TDgk2Mz9lXCCKfkVF357baumocQT71sdgvO88AiNuH29z+R/ydtgFemHkdNVTK
 WSWhXfyXuMrxwXBDcsXB72cMx7JcA93F1uc/47+vjtAa513bvyr8AtV3ZP+ZeBhtIuuR
 qxWQ==
X-Gm-Message-State: APjAAAX1UMGpnlHBZjfeWwI2W1ttnxdizSzMp8PU2ACSrVFauS5sntTI
 o/HUyeej1HE2pb5QhU/RG6bmYGUcVqJGbfaQExA=
X-Google-Smtp-Source: APXvYqy4Zfr59R6wwvsenQtAZYLe5If9rcVqHj1PLrRppL0br/gXqk0xORp2uYrOaQn5klgz8qWrGuuRRai8JSWDKOY=
X-Received: by 2002:a54:4084:: with SMTP id i4mr3315951oii.129.1570530491510; 
 Tue, 08 Oct 2019 03:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-4-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-4-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 18:27:34 +0800
Message-ID: <CAKXe6S+nWLBNG4zCa5T06WiRMFRajn6XnAMT0Po_GmG8CEQZXg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] tests/libqos/fw_cfg: Document pc_fw_cfg_init to
 drop pc_fw_cfg_uninit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000e3632059463a08f"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000e3632059463a08f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:19=E5=86=99=E9=81=
=93=EF=BC=9A

> Document pc_fw_cfg_init() return value must be released
> with g_free(). Directly calling g_free() we don't really
> need pc_fw_cfg_uninit(): remove it.
>
> This reverts commit 65461d124363:
> "tests/libqos: Add pc_fw_cfg_uninit() and use it"
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  tests/fw_cfg-test.c      | 22 +++++++++++-----------
>  tests/libqos/fw_cfg.h    | 14 +++++++++-----
>  tests/libqos/malloc-pc.c |  2 +-
>  3 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1d3147f821..53ae82f7c8 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -36,7 +36,7 @@ static void test_fw_cfg_signature(void)
>      buf[4] =3D 0;
>
>      g_assert_cmpstr(buf, =3D=3D, "QEMU");
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -52,7 +52,7 @@ static void test_fw_cfg_id(void)
>      id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
>      g_assert((id =3D=3D 1) ||
>               (id =3D=3D 3));
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -73,7 +73,7 @@ static void test_fw_cfg_uuid(void)
>      qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
>      g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);
>
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>
>  }
> @@ -88,7 +88,7 @@ static void test_fw_cfg_ram_size(void)
>
>      g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =3D=3D,
> ram_size);
>
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -102,7 +102,7 @@ static void test_fw_cfg_nographic(void)
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D, 0=
);
>
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -116,7 +116,7 @@ static void test_fw_cfg_nb_cpus(void)
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=3D, nb_=
cpus);
>
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -129,7 +129,7 @@ static void test_fw_cfg_max_cpus(void)
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =3D=3D,
> max_cpus);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -158,7 +158,7 @@ static void test_fw_cfg_numa(void)
>
>      g_free(node_mask);
>      g_free(cpu_mask);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -171,7 +171,7 @@ static void test_fw_cfg_boot_menu(void)
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D,
> boot_menu);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -190,7 +190,7 @@ static void test_fw_cfg_reboot_timeout(void)
>      g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
>      reboot_timeout =3D le32_to_cpu(reboot_timeout);
>      g_assert_cmpint(reboot_timeout, =3D=3D, 15);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> @@ -209,7 +209,7 @@ static void test_fw_cfg_splash_time(void)
>      g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));
>      splash_time =3D le16_to_cpu(splash_time);
>      g_assert_cmpint(splash_time, =3D=3D, 12);
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 3247fd4000..6316f4c354 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -54,14 +54,18 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base=
);
>   */
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
>
> +/**
> + * pc_fw_cfg_init():
> + * @qts: The #QTestState that will be referred to by the QFWCFG object.
> + *
> + * This function is specific to the PC machine (X86).
> + *
> + * Returns a newly allocated QFWCFG object which must be released
> + * with a call to g_free() when no longer required.
> + */
>  static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>  {
>      return io_fw_cfg_init(qts, 0x510);
>  }
>
> -static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
> -{
> -    g_free(fw_cfg);
> -}
> -
>  #endif
> diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
> index 6f92ce4135..949a99361d 100644
> --- a/tests/libqos/malloc-pc.c
> +++ b/tests/libqos/malloc-pc.c
> @@ -29,5 +29,5 @@ void pc_alloc_init(QGuestAllocator *s, QTestState *qts,
> QAllocOpts flags)
>      alloc_init(s, flags, 1 << 20, MIN(ram_size, 0xE0000000), PAGE_SIZE);
>
>      /* clean-up */
> -    pc_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>  }
> --
> 2.21.0
>
>

--0000000000000e3632059463a08f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:19=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Document pc_fw_cfg_init() return value must be released<br>
with g_free(). Directly calling g_free() we don&#39;t really<br>
need pc_fw_cfg_uninit(): remove it.<br>
<br>
This reverts commit 65461d124363:<br>
&quot;tests/libqos: Add pc_fw_cfg_uninit() and use it&quot;<br>
<br>
Reviewed-by: Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com" target=
=3D"_blank">lersek@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail=
.com">liq3ea@gmail.com</a>&gt;<br></div><div></div></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0tests/fw_cfg-test.c=C2=A0 =C2=A0 =C2=A0 | 22 +++++++++++-----------<b=
r>
=C2=A0tests/libqos/fw_cfg.h=C2=A0 =C2=A0 | 14 +++++++++-----<br>
=C2=A0tests/libqos/malloc-pc.c |=C2=A0 2 +-<br>
=C2=A03 files changed, 21 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c<br>
index 1d3147f821..53ae82f7c8 100644<br>
--- a/tests/fw_cfg-test.c<br>
+++ b/tests/fw_cfg-test.c<br>
@@ -36,7 +36,7 @@ static void test_fw_cfg_signature(void)<br>
=C2=A0 =C2=A0 =C2=A0buf[4] =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpstr(buf, =3D=3D, &quot;QEMU&quot;);<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -52,7 +52,7 @@ static void test_fw_cfg_id(void)<br>
=C2=A0 =C2=A0 =C2=A0id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);<br>
=C2=A0 =C2=A0 =C2=A0g_assert((id =3D=3D 1) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (id =3D=3D 3));<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -73,7 +73,7 @@ static void test_fw_cfg_uuid(void)<br>
=C2=A0 =C2=A0 =C2=A0qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);<br>
<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
<br>
=C2=A0}<br>
@@ -88,7 +88,7 @@ static void test_fw_cfg_ram_size(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE=
), =3D=3D, ram_size);<br>
<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -102,7 +102,7 @@ static void test_fw_cfg_nographic(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHI=
C), =3D=3D, 0);<br>
<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -116,7 +116,7 @@ static void test_fw_cfg_nb_cpus(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS)=
, =3D=3D, nb_cpus);<br>
<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -129,7 +129,7 @@ static void test_fw_cfg_max_cpus(void)<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS=
), =3D=3D, max_cpus);<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -158,7 +158,7 @@ static void test_fw_cfg_numa(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(node_mask);<br>
=C2=A0 =C2=A0 =C2=A0g_free(cpu_mask);<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -171,7 +171,7 @@ static void test_fw_cfg_boot_menu(void)<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MEN=
U), =3D=3D, boot_menu);<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -190,7 +190,7 @@ static void test_fw_cfg_reboot_timeout(void)<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout=
));<br>
=C2=A0 =C2=A0 =C2=A0reboot_timeout =3D le32_to_cpu(reboot_timeout);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(reboot_timeout, =3D=3D, 15);<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
@@ -209,7 +209,7 @@ static void test_fw_cfg_splash_time(void)<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));=
<br>
=C2=A0 =C2=A0 =C2=A0splash_time =3D le16_to_cpu(splash_time);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(splash_time, =3D=3D, 12);<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h<br>
index 3247fd4000..6316f4c354 100644<br>
--- a/tests/libqos/fw_cfg.h<br>
+++ b/tests/libqos/fw_cfg.h<br>
@@ -54,14 +54,18 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);=
<br>
=C2=A0 */<br>
=C2=A0QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);<br>
<br>
+/**<br>
+ * pc_fw_cfg_init():<br>
+ * @qts: The #QTestState that will be referred to by the QFWCFG object.<br=
>
+ *<br>
+ * This function is specific to the PC machine (X86).<br>
+ *<br>
+ * Returns a newly allocated QFWCFG object which must be released<br>
+ * with a call to g_free() when no longer required.<br>
+ */<br>
=C2=A0static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return io_fw_cfg_init(qts, 0x510);<br>
=C2=A0}<br>
<br>
-static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)<br>
-{<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
-}<br>
-<br>
=C2=A0#endif<br>
diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c<br>
index 6f92ce4135..949a99361d 100644<br>
--- a/tests/libqos/malloc-pc.c<br>
+++ b/tests/libqos/malloc-pc.c<br>
@@ -29,5 +29,5 @@ void pc_alloc_init(QGuestAllocator *s, QTestState *qts, Q=
AllocOpts flags)<br>
=C2=A0 =C2=A0 =C2=A0alloc_init(s, flags, 1 &lt;&lt; 20, MIN(ram_size, 0xE00=
00000), PAGE_SIZE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* clean-up */<br>
-=C2=A0 =C2=A0 pc_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0}<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>

--0000000000000e3632059463a08f--

