Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2251C206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqfCgsZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2251C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ief9m-0000Bi-AI
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ief4M-0002aL-Ql
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ief4L-0003DZ-8V
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:56:50 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ief4K-0003DC-Vf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:56:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so3091021wmc.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 04:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z1cl0lChdoDz7su+INEDqrXPgonF55l+o3olUMPmkOg=;
 b=hqfCgsZGqYiyWA6oVtXdw3X2fk7MWx8rNLxOij8SUa0ZVIo0DpAM9UAa/FQVjLQeQX
 70ypeI1Inpned2QQqaPEGnhBUpexOn+KnZQsBPAjHvQpPbBiQZwVO1duj/jBg+V33Qpq
 qBXEBeLoygBY20xdywKFytk6EaU43WSljn/Trh2x5pASex8cQiCldqjNuUr/e+LN9L7x
 6WqalLYL2TwoENZEZMEn3CtMz6J1FishGlXVxMT5kmI+MtrBGP1oilHHTL3RiRrfQe/V
 hp89E/8D+UOCDYojSRhgKZKDmuGOI1UnyLXF0RWAHOSrELVB/Mcx3UPn2rUIK0wir8Vt
 cjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z1cl0lChdoDz7su+INEDqrXPgonF55l+o3olUMPmkOg=;
 b=h/zYqfYElvnG7vmdWW0jsWMkwAwHx4OyoVIefWEUCdFzi+5NrQTgs7yXt8obJZD/X5
 fZ2zjXhwDD6ErUWZDNrxQTxfH94gU3Q3KUoMqeOgZjIoPMKqDCqk7PkK4deSDtXqhGGd
 n4ufqRTtrJdKiVM94sEAst2C4XdUlpwb5hxfHIfExTsKw1qMFjZC0Gpdp2f1PmMxzqCB
 Az/v1oJV+WK6zCdOwgUG9z7KMehu2Ecni4Z+Bri1HVTyoPigd0lvhPP0eqIxE8Qk+Zor
 F8Q7o+9crahopqdT/UouUqmZSbOFfORqcGowUgMLIBm6XJg+PmEiFU7cupc6K2h1ZzoE
 azGQ==
X-Gm-Message-State: APjAAAURFRRADda5s84OSzqfEbbq6a0pl8MdU1/k+QVLNC8F9iXB0k7v
 IOQAd/MFLu4zchiBlv+S+phsis23jQciu65wQuwHAR3q
X-Google-Smtp-Source: APXvYqxmlH7D5GGKM7BFvHeKHvHj3QpCftDiQqVhNp0o1sllGwg1lPq3S45RSTkGo9UGhe2CJ5uvY45iTjQaUrNwY8g=
X-Received: by 2002:a1c:750f:: with SMTP id o15mr5188716wmc.161.1575982607644; 
 Tue, 10 Dec 2019 04:56:47 -0800 (PST)
MIME-Version: 1.0
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1575903705-12925-16-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Dec 2019 16:56:35 +0400
Message-ID: <CAJ+F1C+hZhubMWE47URc38R=2d6GEg=TK8=dKpE_1XNs4txQfA@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] xen: convert "-machine igd-passthru" to an
 accelerator property
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Dec 9, 2019 at 7:12 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The first machine property to fall is Xen's Intel integrated graphics
> passthrough.  The "-machine igd-passthru" option does not set anymore
> a property on the machine object, but desugars to a GlobalProperty on
> accelerator objects.
>
> The setter is very simple, since the value ends up in a
> global variable, so this patch also provides an example before the more
> complicated cases that follow it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/machine.c   | 20 --------------------
>  hw/xen/xen-common.c | 16 ++++++++++++++++
>  include/hw/boards.h |  1 -
>  qemu-options.hx     |  7 ++++---
>  vl.c                | 14 ++++----------
>  5 files changed, 24 insertions(+), 34 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 45ddfb6..d7a0356 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -412,20 +412,6 @@ static void machine_set_graphics(Object *obj, bool v=
alue, Error **errp)
>      ms->enable_graphics =3D value;
>  }
>
> -static bool machine_get_igd_gfx_passthru(Object *obj, Error **errp)
> -{
> -    MachineState *ms =3D MACHINE(obj);
> -
> -    return ms->igd_gfx_passthru;
> -}
> -
> -static void machine_set_igd_gfx_passthru(Object *obj, bool value, Error =
**errp)
> -{
> -    MachineState *ms =3D MACHINE(obj);
> -
> -    ms->igd_gfx_passthru =3D value;
> -}
> -
>  static char *machine_get_firmware(Object *obj, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(obj);
> @@ -862,12 +848,6 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
>      object_class_property_set_description(oc, "graphics",
>          "Set on/off to enable/disable graphics emulation", &error_abort)=
;
>
> -    object_class_property_add_bool(oc, "igd-passthru",
> -        machine_get_igd_gfx_passthru, machine_set_igd_gfx_passthru,
> -        &error_abort);
> -    object_class_property_set_description(oc, "igd-passthru",
> -        "Set on/off to enable/disable igd passthrou", &error_abort);
> -
>      object_class_property_add_str(oc, "firmware",
>          machine_get_firmware, machine_set_firmware,
>          &error_abort);
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 5284b0d..6cba30c 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -124,6 +124,16 @@ static void xen_change_state_handler(void *opaque, i=
nt running,
>      }
>  }
>
> +static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
> +{
> +    return has_igd_gfx_passthru;
> +}
> +
> +static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **er=
rp)
> +{
> +    has_igd_gfx_passthru =3D value;
> +}
> +
>  static void xen_setup_post(MachineState *ms, AccelState *accel)
>  {
>      int rc;
> @@ -177,6 +187,12 @@ static void xen_accel_class_init(ObjectClass *oc, vo=
id *data)
>      ac->compat_props =3D g_ptr_array_new();
>
>      compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
> +
> +    object_class_property_add_bool(oc, "igd-passthru",
> +        xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
> +        &error_abort);
> +    object_class_property_set_description(oc, "igd-passthru",
> +        "Set on/off to enable/disable igd passthrou", &error_abort);
>  }
>
>  #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 36fcbda..cdcf481 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -287,7 +287,6 @@ struct MachineState {
>      bool mem_merge;
>      bool usb;
>      bool usb_disabled;
> -    bool igd_gfx_passthru;
>      char *firmware;
>      bool iommu;
>      bool suppress_vmdesc;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9775258..6f12b31 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -37,7 +37,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                kvm_shadow_mem=3Dsize of KVM shadow MMU in bytes\n"
>      "                dump-guest-core=3Don|off include guest memory in a =
core dump (default=3Don)\n"
>      "                mem-merge=3Don|off controls memory merge support (d=
efault: on)\n"
> -    "                igd-passthru=3Don|off controls IGD GFX passthrough =
support (default=3Doff)\n"
>      "                aes-key-wrap=3Don|off controls support for AES key =
wrapping (default=3Don)\n"
>      "                dea-key-wrap=3Don|off controls support for DEA key =
wrapping (default=3Don)\n"
>      "                suppress-vmdesc=3Don|off disables self-describing m=
igration (default=3Doff)\n"
> @@ -71,8 +70,6 @@ more than one accelerator specified, the next one is us=
ed if the previous one
>  fails to initialize.
>  @item kernel_irqchip=3Don|off
>  Controls in-kernel irqchip support for the chosen accelerator when avail=
able.
> -@item gfx_passthru=3Don|off
> -Enables IGD GFX passthrough support for the chosen machine when availabl=
e.
>  @item vmport=3Don|off|auto
>  Enables emulation of VMWare IO port, for vmmouse etc. auto says to selec=
t the
>  value based on accel. For accel=3Dxen the default is off otherwise the d=
efault
> @@ -120,6 +117,7 @@ ETEXI
>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>      "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
>      "                select accelerator (kvm, xen, hax, hvf, whpx or tcg=
; use 'help' for a list)\n"
> +    "                igd-passthru=3Don|off (enable Xen integrated Intel =
graphics passthrough, default=3Doff)\n"
>      "                tb-size=3Dn (TCG translation block cache size)\n"
>      "                thread=3Dsingle|multi (enable multi-threaded TCG)\n=
", QEMU_ARCH_ALL)
>  STEXI
> @@ -130,6 +128,9 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By =
default, tcg is used. If th
>  more than one accelerator specified, the next one is used if the previou=
s one
>  fails to initialize.
>  @table @option
> +@item igd-passthru=3Don|off
> +When Xen is in use, this option controls whether Intel integrated graphi=
cs
> +devices can be passed through to the guest (default=3Doff)
>  @item tb-size=3D@var{n}
>  Controls the size (in MiB) of the TCG translation block cache.
>  @item thread=3Dsingle|multi
> diff --git a/vl.c b/vl.c
> index e6ff56b..ee872f2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1257,13 +1257,6 @@ static void configure_msg(QemuOpts *opts)
>  }
>
>
> -/* Now we still need this for compatibility with XEN. */
> -bool has_igd_gfx_passthru;
> -static void igd_gfx_passthru(void)
> -{
> -    has_igd_gfx_passthru =3D current_machine->igd_gfx_passthru;
> -}
> -
>  /***********************************************************/
>  /* USB devices */
>
> @@ -2642,6 +2635,10 @@ static int machine_set_property(void *opaque,
>      if (g_str_equal(qom_name, "accel")) {
>          return 0;
>      }
> +    if (g_str_equal(qom_name, "igd-passthru")) {
> +        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, va=
lue);

shouldn't it warn about deprecation?

> +        return 0;
> +    }
>
>      return object_parse_property_opt(opaque, name, value, "type", errp);
>  }
> @@ -4456,9 +4453,6 @@ int main(int argc, char **argv, char **envp)
>              exit(1);
>      }
>
> -    /* Check if IGD GFX passthrough. */
> -    igd_gfx_passthru();
> -
>      /* init generic devices */
>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
>      qemu_opts_foreach(qemu_find_opts("device"),
> --
> 1.8.3.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

