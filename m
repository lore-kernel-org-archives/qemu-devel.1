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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF2C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769CD205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+5xPcl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769CD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqql-0005f6-BE
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHqjx-00010Z-3W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHqjs-0002H4-Fy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:45:28 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:43711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHqjs-0002GV-7F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:45:24 -0400
Received: by mail-ot1-x32b.google.com with SMTP id o44so14216144ota.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LFf3wuugZlg6Ij3rRncf+MyCbQZbYrIEIYAgS/u4NC8=;
 b=k+5xPcl5KBt4SkT+U9dPiPwEVkjIWdSjpgsNiIh+cOIX7UpTu0117goYnJqAAQsbJd
 G4lRO+0ME2UE36uLdy59fx3NX0+ixDheowCA7pibqiRlZNmFK1vbzgPIDEwuyPaehmEW
 Pif6VXjwg/bPb9u8U3Bz8iOoj8vGOq9ZupPqM+NI4SR4RSI+rUGgVWf/aO7UufL7nlun
 3da138yETgnQibXIqj3Naa7OEbjC29HMQCGzscbCjWX3IZBIEn+t7ZdLZhsCnDOEeZu1
 ix6HYQToHIrOT7PxfjB/htoi4AHyUXudz0yNlyoTe/JnyjID15xGBYdUJYviNm2gLrDH
 wZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LFf3wuugZlg6Ij3rRncf+MyCbQZbYrIEIYAgS/u4NC8=;
 b=OjFywsWn8o0b6q/D3il5jrDpEUdaiFlxQ0gXMJ26BFFvideXEYZ0zy2O+y1fDI8ARw
 ev5uSKj7uRtbqULLNR8Su1jKgEg9MjMGlOlIFmzgk+IH5Ldh0lvUvmUK+3mSBwfbosAW
 HE+ygCCFnH4zmIDwimz1n0+Awa72+RJd3mKoOdJn4KC20pF138flKcvubFky5MY6Rhqt
 EoISfxUXNoE4MhSXYHem8SoBRjN/tDSG5AJ25B2Jq+YGHunRMrnq0IzhogRI+sqvhVxK
 iQM+Z3kQnL5vsMUKK3xUzleEwUm+0FFVIaOmQ6xE+JV8PIvZR40dB069RFVEyi9mj3rh
 zt/g==
X-Gm-Message-State: APjAAAXLn+vItE3h7KR+Nr2+zjQGlGGPaJYSn08xiUS5WK1g/V1IqupH
 XtRroivX5cd/pgtrlqrfRutaqetEk9ns1nA0ckQ=
X-Google-Smtp-Source: APXvYqyV8M7xQS9/9SjezeVZ94+fsy8vpwJONDEHwX0AJuWuaZ3DTuhzElEl1WR2fGtnuP41VO4Y9VtIabnDRWcPWVA=
X-Received: by 2002:a9d:67cb:: with SMTP id c11mr14439778otn.149.1570545922829; 
 Tue, 08 Oct 2019 07:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-6-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-6-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 22:44:46 +0800
Message-ID: <CAKXe6SLA7p0qg-eFzGDV9QgwZpifOb9kE9UmJUxfEGkncouhYg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] tests/libqos/fw_cfg: Pass QTestState as argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d574cb059467377b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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

--000000000000d574cb059467377b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=99=E9=81=
=93=EF=BC=9A

> Since a QFWCFG object is not tied to a particular test, we can
> call *_fw_cfg_init() once before creating QTests and use the same
> for all the tests, then release the object with g_free() once all
> the tests are run.
>
> Refactor the qfw_cfg* API to take QTestState as argument.
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  tests/boot-order-test.c  | 12 ++++----
>  tests/fw_cfg-test.c      | 49 ++++++++++++++++----------------
>  tests/libqos/fw_cfg.c    | 61 ++++++++++++++++++++--------------------
>  tests/libqos/fw_cfg.h    | 31 +++++++++-----------
>  tests/libqos/malloc-pc.c |  4 +--
>  5 files changed, 78 insertions(+), 79 deletions(-)
>
> diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
> index a725bce729..e2d1b7940f 100644
> --- a/tests/boot-order-test.c
> +++ b/tests/boot-order-test.c
> @@ -134,9 +134,9 @@ static void test_prep_boot_order(void)
>
>  static uint64_t read_boot_order_pmac(QTestState *qts)
>  {
> -    QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xf0000510);
> +    QFWCFG *fw_cfg =3D mm_fw_cfg_init(0xf0000510);
>
> -    return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
> +    return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);
>  }
>
>  static const boot_order_test test_cases_fw_cfg[] =3D {
> @@ -159,9 +159,9 @@ static void test_pmac_newworld_boot_order(void)
>
>  static uint64_t read_boot_order_sun4m(QTestState *qts)
>  {
> -    QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xd00000510ULL);
> +    QFWCFG *fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);
>
> -    return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
> +    return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);
>  }
>
>  static void test_sun4m_boot_order(void)
> @@ -171,9 +171,9 @@ static void test_sun4m_boot_order(void)
>
>  static uint64_t read_boot_order_sun4u(QTestState *qts)
>  {
> -    QFWCFG *fw_cfg =3D io_fw_cfg_init(qts, 0x510);
> +    QFWCFG *fw_cfg =3D io_fw_cfg_init(0x510);
>
> -    return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
> +    return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);
>  }
>
>  static void test_sun4u_boot_order(void)
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 65785bca73..dda9a9fb07 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -35,9 +35,9 @@ static void test_fw_cfg_signature(const void *opaque)
>      char buf[5];
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
> +    qfw_cfg_get(s, fw_cfg, FW_CFG_SIGNATURE, buf, 4);
>      buf[4] =3D 0;
>
>      g_assert_cmpstr(buf, =3D=3D, "QEMU");
> @@ -53,9 +53,9 @@ static void test_fw_cfg_id(const void *opaque)
>      uint32_t id;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    id =3D qfw_cfg_get_u32(s, fw_cfg, FW_CFG_ID);
>      g_assert((id =3D=3D 1) ||
>               (id =3D=3D 3));
>      g_free(fw_cfg);
> @@ -76,9 +76,9 @@ static void test_fw_cfg_uuid(const void *opaque)
>
>      s =3D qtest_initf("-M %s -uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"=
,
>                      ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
> +    qfw_cfg_get(s, fw_cfg, FW_CFG_UUID, buf, 16);
>      g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);
>
>      g_free(fw_cfg);
> @@ -93,9 +93,9 @@ static void test_fw_cfg_ram_size(const void *opaque)
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =3D=3D,
> ram_size);
> +    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_RAM_SIZE), =3D=3D,
> ram_size);
>
>      g_free(fw_cfg);
>      qtest_quit(s);
> @@ -108,9 +108,9 @@ static void test_fw_cfg_nographic(const void *opaque)
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D, 0=
);
> +    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D=
, 0);
>
>      g_free(fw_cfg);
>      qtest_quit(s);
> @@ -123,9 +123,9 @@ static void test_fw_cfg_nb_cpus(const void *opaque)
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=3D, nb_=
cpus);
> +    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NB_CPUS), =3D=3D,
> nb_cpus);
>
>      g_free(fw_cfg);
>      qtest_quit(s);
> @@ -138,9 +138,9 @@ static void test_fw_cfg_max_cpus(const void *opaque)
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =3D=3D,
> max_cpus);
> +    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_MAX_CPUS), =3D=3D,
> max_cpus);
>      g_free(fw_cfg);
>      qtest_quit(s);
>  }
> @@ -154,15 +154,15 @@ static void test_fw_cfg_numa(const void *opaque)
>      uint64_t *node_mask;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D, nb_nod=
es);
> +    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_NUMA), =3D=3D,
> nb_nodes);
>
>      cpu_mask =3D g_new0(uint64_t, max_cpus);
>      node_mask =3D g_new0(uint64_t, nb_nodes);
>
> -    qfw_cfg_read_data(fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
> -    qfw_cfg_read_data(fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes);
> +    qfw_cfg_read_data(s, fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
> +    qfw_cfg_read_data(s, fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes)=
;
>
>      if (nb_nodes) {
>          g_assert(cpu_mask[0] & 0x01);
> @@ -182,9 +182,10 @@ static void test_fw_cfg_boot_menu(const void *opaque=
)
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D,
> boot_menu);
> +    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_BOOT_MENU),
> +                    =3D=3D, boot_menu);
>      g_free(fw_cfg);
>      qtest_quit(s);
>  }
> @@ -198,9 +199,9 @@ static void test_fw_cfg_reboot_timeout(const void
> *opaque)
>      size_t filesize;
>
>      s =3D qtest_initf("-M %s -boot reboot-timeout=3D15", ctx->machine_na=
me);
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-fail-wait",
>                                  &reboot_timeout, sizeof(reboot_timeout))=
;
>      g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
>      reboot_timeout =3D le32_to_cpu(reboot_timeout);
> @@ -218,9 +219,9 @@ static void test_fw_cfg_splash_time(const void *opaqu=
e)
>      size_t filesize;
>
>      s =3D qtest_initf("-M %s -boot splash-time=3D12", ctx->machine_name)=
;
> -    fw_cfg =3D pc_fw_cfg_init(s);
> +    fw_cfg =3D pc_fw_cfg_init();
>
> -    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
> +    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-menu-wait",
>                                  &splash_time, sizeof(splash_time));
>      g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));
>      splash_time =3D le16_to_cpu(splash_time);
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index ddeec821db..d25a367194 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -18,46 +18,47 @@
>  #include "qemu/bswap.h"
>  #include "hw/nvram/fw_cfg.h"
>
> -void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> +void qfw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
>  {
> -    fw_cfg->select(fw_cfg, key);
> +    fw_cfg->select(qts, fw_cfg, key);
>  }
>
> -void qfw_cfg_read_data(QFWCFG *fw_cfg, void *data, size_t len)
> +void qfw_cfg_read_data(QTestState *qts, QFWCFG *fw_cfg, void *data,
> size_t len)
>  {
> -    fw_cfg->read(fw_cfg, data, len);
> +    fw_cfg->read(qts, fw_cfg, data, len);
>  }
>
> -void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len)
> +void qfw_cfg_get(QTestState *qts, QFWCFG *fw_cfg, uint16_t key,
> +                 void *data, size_t len)
>  {
> -    qfw_cfg_select(fw_cfg, key);
> -    qfw_cfg_read_data(fw_cfg, data, len);
> +    qfw_cfg_select(qts, fw_cfg, key);
> +    qfw_cfg_read_data(qts, fw_cfg, data, len);
>  }
>
> -uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key)
> +uint16_t qfw_cfg_get_u16(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
>  {
>      uint16_t value;
> -    qfw_cfg_get(fw_cfg, key, &value, sizeof(value));
> +    qfw_cfg_get(qts, fw_cfg, key, &value, sizeof(value));
>      return le16_to_cpu(value);
>  }
>
> -uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key)
> +uint32_t qfw_cfg_get_u32(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
>  {
>      uint32_t value;
> -    qfw_cfg_get(fw_cfg, key, &value, sizeof(value));
> +    qfw_cfg_get(qts, fw_cfg, key, &value, sizeof(value));
>      return le32_to_cpu(value);
>  }
>
> -uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)
> +uint64_t qfw_cfg_get_u64(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
>  {
>      uint64_t value;
> -    qfw_cfg_get(fw_cfg, key, &value, sizeof(value));
> +    qfw_cfg_get(qts, fw_cfg, key, &value, sizeof(value));
>      return le64_to_cpu(value);
>  }
>
> -static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> +static void mm_fw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t
> key)
>  {
> -    qtest_writew(fw_cfg->qts, fw_cfg->base, key);
> +    qtest_writew(qts, fw_cfg->base, key);
>  }
>
>  /*
> @@ -72,8 +73,8 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t
> key)
>   * necessary in total. And, while the caller's buffer has been fully
>   * populated, it has received only a starting slice of the fw_cfg file.
>   */
> -size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> -                      void *data, size_t buflen)
> +size_t qfw_cfg_get_file(QTestState *qts, QFWCFG *fw_cfg, const char
> *filename,
> +                        void *data, size_t buflen)
>  {
>      uint32_t count;
>      uint32_t i;
> @@ -82,11 +83,11 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char
> *filename,
>      FWCfgFile *pdir_entry;
>      size_t filesize =3D 0;
>
> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> +    qfw_cfg_get(qts, fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
>      count =3D be32_to_cpu(count);
>      dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
>      filesbuf =3D g_malloc(dsize);
> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    qfw_cfg_get(qts, fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
>      pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
>      for (i =3D 0; i < count; ++i, ++pdir_entry) {
>          if (!strcmp(pdir_entry->name, filename)) {
> @@ -96,7 +97,7 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char
> *filename,
>              if (len > buflen) {
>                  len =3D buflen;
>              }
> -            qfw_cfg_get(fw_cfg, sel, data, len);
> +            qfw_cfg_get(qts, fw_cfg, sel, data, len);
>              break;
>          }
>      }
> @@ -104,49 +105,49 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char
> *filename,
>      return filesize;
>  }
>
> -static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
> +static void mm_fw_cfg_read(QTestState *qts, QFWCFG *fw_cfg,
> +                           void *data, size_t len)
>  {
>      uint8_t *ptr =3D data;
>      int i;
>
>      for (i =3D 0; i < len; i++) {
> -        ptr[i] =3D qtest_readb(fw_cfg->qts, fw_cfg->base + 2);
> +        ptr[i] =3D qtest_readb(qts, fw_cfg->base + 2);
>      }
>  }
>
> -QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)
> +QFWCFG *mm_fw_cfg_init(uint64_t base)
>  {
>      QFWCFG *fw_cfg =3D g_malloc0(sizeof(*fw_cfg));
>
>      fw_cfg->base =3D base;
> -    fw_cfg->qts =3D qts;
>      fw_cfg->select =3D mm_fw_cfg_select;
>      fw_cfg->read =3D mm_fw_cfg_read;
>
>      return fw_cfg;
>  }
>
> -static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> +static void io_fw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t
> key)
>  {
> -    qtest_outw(fw_cfg->qts, fw_cfg->base, key);
> +    qtest_outw(qts, fw_cfg->base, key);
>  }
>
> -static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
> +static void io_fw_cfg_read(QTestState *qts, QFWCFG *fw_cfg,
> +                           void *data, size_t len)
>  {
>      uint8_t *ptr =3D data;
>      int i;
>
>      for (i =3D 0; i < len; i++) {
> -        ptr[i] =3D qtest_inb(fw_cfg->qts, fw_cfg->base + 1);
> +        ptr[i] =3D qtest_inb(qts, fw_cfg->base + 1);
>      }
>  }
>
> -QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base)
> +QFWCFG *io_fw_cfg_init(uint16_t base)
>  {
>      QFWCFG *fw_cfg =3D g_malloc0(sizeof(*fw_cfg));
>
>      fw_cfg->base =3D base;
> -    fw_cfg->qts =3D qts;
>      fw_cfg->select =3D io_fw_cfg_select;
>      fw_cfg->read =3D io_fw_cfg_read;
>
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 6316f4c354..f9e69be450 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -20,52 +20,49 @@ typedef struct QFWCFG QFWCFG;
>  struct QFWCFG
>  {
>      uint64_t base;
> -    QTestState *qts;
> -    void (*select)(QFWCFG *fw_cfg, uint16_t key);
> -    void (*read)(QFWCFG *fw_cfg, void *data, size_t len);
> +    void (*select)(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
> +    void (*read)(QTestState *qts, QFWCFG *fw_cfg, void *data, size_t len=
);
>  };
>
> -void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key);
> -void qfw_cfg_read_data(QFWCFG *fw_cfg, void *data, size_t len);
> -void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len);
> -uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
> -uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
> -uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> -size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> +void qfw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
> +void qfw_cfg_read_data(QTestState *qts, QFWCFG *fw_cfg, void *data,
> size_t len);
> +void qfw_cfg_get(QTestState *qts, QFWCFG *fw_cfg, uint16_t key,
> +                 void *data, size_t len);
> +uint16_t qfw_cfg_get_u16(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
> +uint32_t qfw_cfg_get_u32(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
> +uint64_t qfw_cfg_get_u64(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
> +size_t qfw_cfg_get_file(QTestState *qts, QFWCFG *fw_cfg, const char
> *filename,
>                          void *data, size_t buflen);
>
>  /**
>   * mm_fw_cfg_init():
> - * @qts: The #QTestState that will be referred to by the QFWCFG object.
>   * @base: The MMIO base address of the fw_cfg device in the guest.
>   *
>   * Returns a newly allocated QFWCFG object which must be released
>   * with a call to g_free() when no longer required.
>   */
> -QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
> +QFWCFG *mm_fw_cfg_init(uint64_t base);
>
>  /**
>   * io_fw_cfg_init():
> - * @qts: The #QTestState that will be referred to by the QFWCFG object.
>   * @base: The I/O address of the fw_cfg device in the guest.
>   *
>   * Returns a newly allocated QFWCFG object which must be released
>   * with a call to g_free() when no longer required.
>   */
> -QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> +QFWCFG *io_fw_cfg_init(uint16_t base);
>
>  /**
>   * pc_fw_cfg_init():
> - * @qts: The #QTestState that will be referred to by the QFWCFG object.
>   *
>   * This function is specific to the PC machine (X86).
>   *
>   * Returns a newly allocated QFWCFG object which must be released
>   * with a call to g_free() when no longer required.
>   */
> -static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
> +static inline QFWCFG *pc_fw_cfg_init(void)
>  {
> -    return io_fw_cfg_init(qts, 0x510);
> +    return io_fw_cfg_init(0x510);
>  }
>
>  #endif
> diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
> index 949a99361d..4932ae092d 100644
> --- a/tests/libqos/malloc-pc.c
> +++ b/tests/libqos/malloc-pc.c
> @@ -23,9 +23,9 @@
>  void pc_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts flags=
)
>  {
>      uint64_t ram_size;
> -    QFWCFG *fw_cfg =3D pc_fw_cfg_init(qts);
> +    QFWCFG *fw_cfg =3D pc_fw_cfg_init();
>
> -    ram_size =3D qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE);
> +    ram_size =3D qfw_cfg_get_u64(qts, fw_cfg, FW_CFG_RAM_SIZE);
>      alloc_init(s, flags, 1 << 20, MIN(ram_size, 0xE0000000), PAGE_SIZE);
>
>      /* clean-up */
> --
> 2.21.0
>
>

--000000000000d574cb059467377b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Since a QFWCFG object is not tied to a particular test, we can<br>
call *_fw_cfg_init() once before creating QTests and use the same<br>
for all the tests, then release the object with g_free() once all<br>
the tests are run.<br>
<br>
Refactor the qfw_cfg* API to take QTestState as argument.<br>
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
=C2=A0tests/boot-order-test.c=C2=A0 | 12 ++++----<br>
=C2=A0tests/fw_cfg-test.c=C2=A0 =C2=A0 =C2=A0 | 49 ++++++++++++++++--------=
--------<br>
=C2=A0tests/libqos/fw_cfg.c=C2=A0 =C2=A0 | 61 ++++++++++++++++++++---------=
-----------<br>
=C2=A0tests/libqos/fw_cfg.h=C2=A0 =C2=A0 | 31 +++++++++-----------<br>
=C2=A0tests/libqos/malloc-pc.c |=C2=A0 4 +--<br>
=C2=A05 files changed, 78 insertions(+), 79 deletions(-)<br>
<br>
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c<br>
index a725bce729..e2d1b7940f 100644<br>
--- a/tests/boot-order-test.c<br>
+++ b/tests/boot-order-test.c<br>
@@ -134,9 +134,9 @@ static void test_prep_boot_order(void)<br>
<br>
=C2=A0static uint64_t read_boot_order_pmac(QTestState *qts)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xf0000510);<br>
+=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D mm_fw_cfg_init(0xf0000510);<br>
<br>
-=C2=A0 =C2=A0 return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);<br>
+=C2=A0 =C2=A0 return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);<br>
=C2=A0}<br>
<br>
=C2=A0static const boot_order_test test_cases_fw_cfg[] =3D {<br>
@@ -159,9 +159,9 @@ static void test_pmac_newworld_boot_order(void)<br>
<br>
=C2=A0static uint64_t read_boot_order_sun4m(QTestState *qts)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xd00000510ULL);<br>
+=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);<br>
<br>
-=C2=A0 =C2=A0 return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);<br>
+=C2=A0 =C2=A0 return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_sun4m_boot_order(void)<br>
@@ -171,9 +171,9 @@ static void test_sun4m_boot_order(void)<br>
<br>
=C2=A0static uint64_t read_boot_order_sun4u(QTestState *qts)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D io_fw_cfg_init(qts, 0x510);<br>
+=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D io_fw_cfg_init(0x510);<br>
<br>
-=C2=A0 =C2=A0 return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);<br>
+=C2=A0 =C2=A0 return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_sun4u_boot_order(void)<br>
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c<br>
index 65785bca73..dda9a9fb07 100644<br>
--- a/tests/fw_cfg-test.c<br>
+++ b/tests/fw_cfg-test.c<br>
@@ -35,9 +35,9 @@ static void test_fw_cfg_signature(const void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0char buf[5];<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);<br>
+=C2=A0 =C2=A0 qfw_cfg_get(s, fw_cfg, FW_CFG_SIGNATURE, buf, 4);<br>
=C2=A0 =C2=A0 =C2=A0buf[4] =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpstr(buf, =3D=3D, &quot;QEMU&quot;);<br>
@@ -53,9 +53,9 @@ static void test_fw_cfg_id(const void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t id;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);<br>
+=C2=A0 =C2=A0 id =3D qfw_cfg_get_u32(s, fw_cfg, FW_CFG_ID);<br>
=C2=A0 =C2=A0 =C2=A0g_assert((id =3D=3D 1) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (id =3D=3D 3));<br>
=C2=A0 =C2=A0 =C2=A0g_free(fw_cfg);<br>
@@ -76,9 +76,9 @@ static void test_fw_cfg_uuid(const void *opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s -uuid 4600cb32-38ec-4b2f-=
8acb-81c6ea54f2d8&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ctx-&gt;machine_name);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);<br>
+=C2=A0 =C2=A0 qfw_cfg_get(s, fw_cfg, FW_CFG_UUID, buf, 16);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(fw_cfg);<br>
@@ -93,9 +93,9 @@ static void test_fw_cfg_ram_size(const void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =
=3D=3D, ram_size);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_RAM_SIZE),=
 =3D=3D, ram_size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
@@ -108,9 +108,9 @@ static void test_fw_cfg_nographic(const void *opaque)<b=
r>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =
=3D=3D, 0);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NOGRAPHIC)=
, =3D=3D, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
@@ -123,9 +123,9 @@ static void test_fw_cfg_nb_cpus(const void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=
=3D, nb_cpus);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NB_CPUS), =
=3D=3D, nb_cpus);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
@@ -138,9 +138,9 @@ static void test_fw_cfg_max_cpus(const void *opaque)<br=
>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =
=3D=3D, max_cpus);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_MAX_CPUS),=
 =3D=3D, max_cpus);<br>
=C2=A0 =C2=A0 =C2=A0g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
@@ -154,15 +154,15 @@ static void test_fw_cfg_numa(const void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0uint64_t *node_mask;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D=
, nb_nodes);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_NUMA), =3D=
=3D, nb_nodes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0cpu_mask =3D g_new0(uint64_t, max_cpus);<br>
=C2=A0 =C2=A0 =C2=A0node_mask =3D g_new0(uint64_t, nb_nodes);<br>
<br>
-=C2=A0 =C2=A0 qfw_cfg_read_data(fw_cfg, cpu_mask, sizeof(uint64_t) * max_c=
pus);<br>
-=C2=A0 =C2=A0 qfw_cfg_read_data(fw_cfg, node_mask, sizeof(uint64_t) * nb_n=
odes);<br>
+=C2=A0 =C2=A0 qfw_cfg_read_data(s, fw_cfg, cpu_mask, sizeof(uint64_t) * ma=
x_cpus);<br>
+=C2=A0 =C2=A0 qfw_cfg_read_data(s, fw_cfg, node_mask, sizeof(uint64_t) * n=
b_nodes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (nb_nodes) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert(cpu_mask[0] &amp; 0x01);<br>
@@ -182,9 +182,10 @@ static void test_fw_cfg_boot_menu(const void *opaque)<=
br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =
=3D=3D, boot_menu);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_BOOT_MENU)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=3D, boot_menu);<br>
=C2=A0 =C2=A0 =C2=A0g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
@@ -198,9 +199,9 @@ static void test_fw_cfg_reboot_timeout(const void *opaq=
ue)<br>
=C2=A0 =C2=A0 =C2=A0size_t filesize;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s -boot reboot-timeout=3D15=
&quot;, ctx-&gt;machine_name);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(fw_cfg, &quot;etc/boot-fail-wa=
it&quot;,<br>
+=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(s, fw_cfg, &quot;etc/boot-fail=
-wait&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;reboot_timeout, sizeof(re=
boot_timeout));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout=
));<br>
=C2=A0 =C2=A0 =C2=A0reboot_timeout =3D le32_to_cpu(reboot_timeout);<br>
@@ -218,9 +219,9 @@ static void test_fw_cfg_splash_time(const void *opaque)=
<br>
=C2=A0 =C2=A0 =C2=A0size_t filesize;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s -boot splash-time=3D12&qu=
ot;, ctx-&gt;machine_name);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);<br>
+=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(fw_cfg, &quot;etc/boot-menu-wa=
it&quot;,<br>
+=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(s, fw_cfg, &quot;etc/boot-menu=
-wait&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;splash_time, sizeof(splas=
h_time));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));=
<br>
=C2=A0 =C2=A0 =C2=A0splash_time =3D le16_to_cpu(splash_time);<br>
diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c<br>
index ddeec821db..d25a367194 100644<br>
--- a/tests/libqos/fw_cfg.c<br>
+++ b/tests/libqos/fw_cfg.c<br>
@@ -18,46 +18,47 @@<br>
=C2=A0#include &quot;qemu/bswap.h&quot;<br>
=C2=A0#include &quot;hw/nvram/fw_cfg.h&quot;<br>
<br>
-void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)<br>
+void qfw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 fw_cfg-&gt;select(fw_cfg, key);<br>
+=C2=A0 =C2=A0 fw_cfg-&gt;select(qts, fw_cfg, key);<br>
=C2=A0}<br>
<br>
-void qfw_cfg_read_data(QFWCFG *fw_cfg, void *data, size_t len)<br>
+void qfw_cfg_read_data(QTestState *qts, QFWCFG *fw_cfg, void *data, size_t=
 len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 fw_cfg-&gt;read(fw_cfg, data, len);<br>
+=C2=A0 =C2=A0 fw_cfg-&gt;read(qts, fw_cfg, data, len);<br>
=C2=A0}<br>
<br>
-void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len)<br>
+void qfw_cfg_get(QTestState *qts, QFWCFG *fw_cfg, uint16_t key,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *data, =
size_t len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 qfw_cfg_select(fw_cfg, key);<br>
-=C2=A0 =C2=A0 qfw_cfg_read_data(fw_cfg, data, len);<br>
+=C2=A0 =C2=A0 qfw_cfg_select(qts, fw_cfg, key);<br>
+=C2=A0 =C2=A0 qfw_cfg_read_data(qts, fw_cfg, data, len);<br>
=C2=A0}<br>
<br>
-uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key)<br>
+uint16_t qfw_cfg_get_u16(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint16_t value;<br>
-=C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, key, &amp;value, sizeof(value));<br>
+=C2=A0 =C2=A0 qfw_cfg_get(qts, fw_cfg, key, &amp;value, sizeof(value));<br=
>
=C2=A0 =C2=A0 =C2=A0return le16_to_cpu(value);<br>
=C2=A0}<br>
<br>
-uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key)<br>
+uint32_t qfw_cfg_get_u32(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t value;<br>
-=C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, key, &amp;value, sizeof(value));<br>
+=C2=A0 =C2=A0 qfw_cfg_get(qts, fw_cfg, key, &amp;value, sizeof(value));<br=
>
=C2=A0 =C2=A0 =C2=A0return le32_to_cpu(value);<br>
=C2=A0}<br>
<br>
-uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)<br>
+uint64_t qfw_cfg_get_u64(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t value;<br>
-=C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, key, &amp;value, sizeof(value));<br>
+=C2=A0 =C2=A0 qfw_cfg_get(qts, fw_cfg, key, &amp;value, sizeof(value));<br=
>
=C2=A0 =C2=A0 =C2=A0return le64_to_cpu(value);<br>
=C2=A0}<br>
<br>
-static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)<br>
+static void mm_fw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key=
)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 qtest_writew(fw_cfg-&gt;qts, fw_cfg-&gt;base, key);<br>
+=C2=A0 =C2=A0 qtest_writew(qts, fw_cfg-&gt;base, key);<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -72,8 +73,8 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key=
)<br>
=C2=A0 * necessary in total. And, while the caller&#39;s buffer has been fu=
lly<br>
=C2=A0 * populated, it has received only a starting slice of the fw_cfg fil=
e.<br>
=C2=A0 */<br>
-size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void *data, size_t buflen)<br>
+size_t qfw_cfg_get_file(QTestState *qts, QFWCFG *fw_cfg, const char *filen=
ame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void *data, size_t buflen)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t count;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
@@ -82,11 +83,11 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *fil=
ename,<br>
=C2=A0 =C2=A0 =C2=A0FWCfgFile *pdir_entry;<br>
=C2=A0 =C2=A0 =C2=A0size_t filesize =3D 0;<br>
<br>
-=C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &amp;count, sizeof(coun=
t));<br>
+=C2=A0 =C2=A0 qfw_cfg_get(qts, fw_cfg, FW_CFG_FILE_DIR, &amp;count, sizeof=
(count));<br>
=C2=A0 =C2=A0 =C2=A0count =3D be32_to_cpu(count);<br>
=C2=A0 =C2=A0 =C2=A0dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_c=
fg_file);<br>
=C2=A0 =C2=A0 =C2=A0filesbuf =3D g_malloc(dsize);<br>
-=C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);<br>
+=C2=A0 =C2=A0 qfw_cfg_get(qts, fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);<=
br>
=C2=A0 =C2=A0 =C2=A0pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t=
));<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; count; ++i, ++pdir_entry) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(pdir_entry-&gt;name, filename=
)) {<br>
@@ -96,7 +97,7 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filen=
ame,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt; buflen) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D bufle=
n;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qfw_cfg_get(fw_cfg, sel, data, l=
en);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qfw_cfg_get(qts, fw_cfg, sel, da=
ta, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -104,49 +105,49 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *f=
ilename,<br>
=C2=A0 =C2=A0 =C2=A0return filesize;<br>
=C2=A0}<br>
<br>
-static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)<br>
+static void mm_fw_cfg_read(QTestState *qts, QFWCFG *fw_cfg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0void *data, size_t len)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *ptr =3D data;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; len; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr[i] =3D qtest_readb(fw_cfg-&gt;qts, fw_cfg-=
&gt;base + 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr[i] =3D qtest_readb(qts, fw_cfg-&gt;base + =
2);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)<br>
+QFWCFG *mm_fw_cfg_init(uint64_t base)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg =3D g_malloc0(sizeof(*fw_cfg));<br>
<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg-&gt;base =3D base;<br>
-=C2=A0 =C2=A0 fw_cfg-&gt;qts =3D qts;<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg-&gt;select =3D mm_fw_cfg_select;<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg-&gt;read =3D mm_fw_cfg_read;<br>
<br>
=C2=A0 =C2=A0 =C2=A0return fw_cfg;<br>
=C2=A0}<br>
<br>
-static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)<br>
+static void io_fw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key=
)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 qtest_outw(fw_cfg-&gt;qts, fw_cfg-&gt;base, key);<br>
+=C2=A0 =C2=A0 qtest_outw(qts, fw_cfg-&gt;base, key);<br>
=C2=A0}<br>
<br>
-static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)<br>
+static void io_fw_cfg_read(QTestState *qts, QFWCFG *fw_cfg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0void *data, size_t len)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *ptr =3D data;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; len; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr[i] =3D qtest_inb(fw_cfg-&gt;qts, fw_cfg-&g=
t;base + 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr[i] =3D qtest_inb(qts, fw_cfg-&gt;base + 1)=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base)<br>
+QFWCFG *io_fw_cfg_init(uint16_t base)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg =3D g_malloc0(sizeof(*fw_cfg));<br>
<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg-&gt;base =3D base;<br>
-=C2=A0 =C2=A0 fw_cfg-&gt;qts =3D qts;<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg-&gt;select =3D io_fw_cfg_select;<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg-&gt;read =3D io_fw_cfg_read;<br>
<br>
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h<br>
index 6316f4c354..f9e69be450 100644<br>
--- a/tests/libqos/fw_cfg.h<br>
+++ b/tests/libqos/fw_cfg.h<br>
@@ -20,52 +20,49 @@ typedef struct QFWCFG QFWCFG;<br>
=C2=A0struct QFWCFG<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t base;<br>
-=C2=A0 =C2=A0 QTestState *qts;<br>
-=C2=A0 =C2=A0 void (*select)(QFWCFG *fw_cfg, uint16_t key);<br>
-=C2=A0 =C2=A0 void (*read)(QFWCFG *fw_cfg, void *data, size_t len);<br>
+=C2=A0 =C2=A0 void (*select)(QTestState *qts, QFWCFG *fw_cfg, uint16_t key=
);<br>
+=C2=A0 =C2=A0 void (*read)(QTestState *qts, QFWCFG *fw_cfg, void *data, si=
ze_t len);<br>
=C2=A0};<br>
<br>
-void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key);<br>
-void qfw_cfg_read_data(QFWCFG *fw_cfg, void *data, size_t len);<br>
-void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len);<br=
>
-uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);<br>
-uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);<br>
-uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);<br>
-size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,<br>
+void qfw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);<br>
+void qfw_cfg_read_data(QTestState *qts, QFWCFG *fw_cfg, void *data, size_t=
 len);<br>
+void qfw_cfg_get(QTestState *qts, QFWCFG *fw_cfg, uint16_t key,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *data, =
size_t len);<br>
+uint16_t qfw_cfg_get_u16(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);<b=
r>
+uint32_t qfw_cfg_get_u32(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);<b=
r>
+uint64_t qfw_cfg_get_u64(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);<b=
r>
+size_t qfw_cfg_get_file(QTestState *qts, QFWCFG *fw_cfg, const char *filen=
ame,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0void *data, size_t buflen);<br>
<br>
=C2=A0/**<br>
=C2=A0 * mm_fw_cfg_init():<br>
- * @qts: The #QTestState that will be referred to by the QFWCFG object.<br=
>
=C2=A0 * @base: The MMIO base address of the fw_cfg device in the guest.<br=
>
=C2=A0 *<br>
=C2=A0 * Returns a newly allocated QFWCFG object which must be released<br>
=C2=A0 * with a call to g_free() when no longer required.<br>
=C2=A0 */<br>
-QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);<br>
+QFWCFG *mm_fw_cfg_init(uint64_t base);<br>
<br>
=C2=A0/**<br>
=C2=A0 * io_fw_cfg_init():<br>
- * @qts: The #QTestState that will be referred to by the QFWCFG object.<br=
>
=C2=A0 * @base: The I/O address of the fw_cfg device in the guest.<br>
=C2=A0 *<br>
=C2=A0 * Returns a newly allocated QFWCFG object which must be released<br>
=C2=A0 * with a call to g_free() when no longer required.<br>
=C2=A0 */<br>
-QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);<br>
+QFWCFG *io_fw_cfg_init(uint16_t base);<br>
<br>
=C2=A0/**<br>
=C2=A0 * pc_fw_cfg_init():<br>
- * @qts: The #QTestState that will be referred to by the QFWCFG object.<br=
>
=C2=A0 *<br>
=C2=A0 * This function is specific to the PC machine (X86).<br>
=C2=A0 *<br>
=C2=A0 * Returns a newly allocated QFWCFG object which must be released<br>
=C2=A0 * with a call to g_free() when no longer required.<br>
=C2=A0 */<br>
-static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)<br>
+static inline QFWCFG *pc_fw_cfg_init(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return io_fw_cfg_init(qts, 0x510);<br>
+=C2=A0 =C2=A0 return io_fw_cfg_init(0x510);<br>
=C2=A0}<br>
<br>
=C2=A0#endif<br>
diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c<br>
index 949a99361d..4932ae092d 100644<br>
--- a/tests/libqos/malloc-pc.c<br>
+++ b/tests/libqos/malloc-pc.c<br>
@@ -23,9 +23,9 @@<br>
=C2=A0void pc_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts fl=
ags)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t ram_size;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D pc_fw_cfg_init(qts);<br>
+=C2=A0 =C2=A0 QFWCFG *fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 ram_size =3D qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE);<br>
+=C2=A0 =C2=A0 ram_size =3D qfw_cfg_get_u64(qts, fw_cfg, FW_CFG_RAM_SIZE);<=
br>
=C2=A0 =C2=A0 =C2=A0alloc_init(s, flags, 1 &lt;&lt; 20, MIN(ram_size, 0xE00=
00000), PAGE_SIZE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* clean-up */<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>

--000000000000d574cb059467377b--

