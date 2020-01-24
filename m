Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04382C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45122072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlLAbCYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45122072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2bV-0000AO-TX
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2a9-0007Ld-Be
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2a7-0006d1-3y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:17:21 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iv2a6-0006bx-UD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:17:19 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so2285136otp.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WHbtYtunOdgRjOTdqhwxgP5ee0OMJ+u6/lce82RTh88=;
 b=RlLAbCYLepwOq606r+DGe06GOXroXzwRqdgFSO3XBI6uk5dkl0jztkfwaTVA2wv0Yr
 EUp/4XTZnIn5QyZxjgnfIm9e7PSizu+HhB1LM3JMsn4mBFkUPX8gkapp3PAru9dsrHVY
 dclbl4A2TCvFAfgZuF6iABrzw2dDy6JMZR2ApF73CQQx/eXtPLytv5hsbtoxjYvRBhqL
 bxF0B01sUjWGB/NQT4lVKv11WXiEFMBoGjBhcHAa7kugfHpBAzPWOgnUrSZA/2OK3NoA
 XNJwRV5rlvHmqinjTDuegY+PHsKL9s0+TB6z/KBn/p1HbsklsCgP1r9H1fhPxA0n6c7j
 jhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WHbtYtunOdgRjOTdqhwxgP5ee0OMJ+u6/lce82RTh88=;
 b=Ut1ZSmh6OngXfVZo+BzdrkAq1AfJaKEnSLXH23cniZStQdWklPd7tREoP4VQFtI8xa
 Aa6hbMa97POtPSOQ+XW+cxJcrDG6gOwYgvoy+VNPkHxVXHjbrazQoeBIAYw5o18klxM1
 FNCVCKQwXk7j4MA+G0IIvZ08T+AvwxeLL3nXVJxYKqr/HNO67yM6zn4UWQlY4UqvfzSm
 PoJ2UsAqzxP3eFdWEvWuvqTzj00MVMrVyXQEdmKHC0HmZUTBSoJ+EJCA08S6Og50qUB6
 QkMRQHWTCRfGdxAAKpcRsTbz4xQIMS7WhfDEWmT6TFowwGQco9KYzA4mkkmECSIoYse6
 +iPg==
X-Gm-Message-State: APjAAAXREEpssZpQ3wbGTgD1Uev1OKJahQYKCJk6Z4GZt1X08M1kv5i4
 vytjTNLQfaJ+QsNwtwPXtZ7jI1G2nh/PQaJnbQY=
X-Google-Smtp-Source: APXvYqx4LZR12VqqEvn9FV5Bz4rpirKsNzB4LuPex9Q7znWbw5LfweChAiUk1eO0lTggT70tepKrFyi3XJkAAIA/dpc=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr3441571otp.306.1579886237994; 
 Fri, 24 Jan 2020 09:17:17 -0800 (PST)
MIME-Version: 1.0
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-56-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-56-git-send-email-imammedo@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 Jan 2020 18:17:07 +0100
Message-ID: <CAL1e-=hYfyyCXqE5=N=yKXc89M_kf9We28kJx=hLGC_qe-Myiw@mail.gmail.com>
Subject: Re: [PATCH REPOST v3 55/80] mips/mips_mipssim: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000005493059ce5ee17"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000005493059ce5ee17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 1:22 PM Igor Mammedov <imammedo@redhat.com> wrote:

> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/mips_mipssim.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
>
Applied to MIPS queue.


> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 84c03dd..8df16d8 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -143,14 +143,12 @@ static void mipsnet_init(int base, qemu_irq irq,
> NICInfo *nd)
>  static void
>  mips_mipssim_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
>      char *filename;
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *isa =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>      MIPSCPU *cpu;
>      CPUMIPSState *env;
> @@ -167,13 +165,11 @@ mips_mipssim_init(MachineState *machine)
>      qemu_register_reset(main_cpu_reset, reset_info);
>
>      /* Allocate RAM. */
> -    memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
> -                                         ram_size);
>      memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
>                             &error_fatal);
>      memory_region_set_readonly(bios, true);
>
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>
>      /* Map the BIOS / boot exception handler. */
>      memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
> @@ -200,7 +196,7 @@ mips_mipssim_init(MachineState *machine)
>      }
>
>      if (kernel_filename) {
> -        loaderparams.ram_size =3D ram_size;
> +        loaderparams.ram_size =3D machine->ram_size;
>          loaderparams.kernel_filename =3D kernel_filename;
>          loaderparams.kernel_cmdline =3D kernel_cmdline;
>          loaderparams.initrd_filename =3D initrd_filename;
> @@ -245,6 +241,7 @@ static void mips_mipssim_machine_init(MachineClass *m=
c)
>  #else
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
>  #endif
> +    mc->default_ram_id =3D "mips_mipssim.ram";
>  }
>
>  DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
> --
> 2.7.4
>
>
>

--000000000000005493059ce5ee17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 23, 2020 at 1:22 PM Igor =
Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">memo=
ry_region_allocate_system_memory() API is going away, so<br>
replace it with memdev allocated MemoryRegion. The later is<br>
initialized by generic code, so board only needs to opt in<br>
to memdev scheme by providing<br>
=C2=A0 MachineClass::default_ram_id<br>
and using MachineState::ram instead of manually initializing<br>
RAM memory region.<br>
<br>
Signed-off-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_mipssim.c | 9 +++------<br>
=C2=A01 file changed, 3 insertions(+), 6 deletions(-)<br>
<br></blockquote><div><br></div><div>Applied to MIPS queue.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index 84c03dd..8df16d8 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -143,14 +143,12 @@ static void mipsnet_init(int base, qemu_irq irq, NICI=
nfo *nd)<br>
=C2=A0static void<br>
=C2=A0mips_mipssim_init(MachineState *machine)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ram_addr_t ram_size =3D machine-&gt;ram_size;<br>
=C2=A0 =C2=A0 =C2=A0const char *kernel_filename =3D machine-&gt;kernel_file=
name;<br>
=C2=A0 =C2=A0 =C2=A0const char *kernel_cmdline =3D machine-&gt;kernel_cmdli=
ne;<br>
=C2=A0 =C2=A0 =C2=A0const char *initrd_filename =3D machine-&gt;initrd_file=
name;<br>
=C2=A0 =C2=A0 =C2=A0char *filename;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *address_space_mem =3D get_system_memory()=
;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *isa =3D g_new(MemoryRegion, 1);<br>
-=C2=A0 =C2=A0 MemoryRegion *ram =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *bios =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0MIPSCPU *cpu;<br>
=C2=A0 =C2=A0 =C2=A0CPUMIPSState *env;<br>
@@ -167,13 +165,11 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0qemu_register_reset(main_cpu_reset, reset_info);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Allocate RAM. */<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, NULL, &quot;mips_m=
ipssim.ram&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ra=
m_size);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_ram(bios, NULL, &quot;mips_mipssim.b=
ios&quot;, BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_set_readonly(bios, true);<br>
<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(address_space_mem, 0, ram);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(address_space_mem, 0, machine-&g=
t;ram);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Map the BIOS / boot exception handler. */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(address_space_mem, 0x1fc000=
00LL, bios);<br>
@@ -200,7 +196,7 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_filename) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.ram_size =3D ram_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.ram_size =3D machine-&gt;ram_size=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loaderparams.kernel_filename =3D kernel_f=
ilename;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loaderparams.kernel_cmdline =3D kernel_cm=
dline;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loaderparams.initrd_filename =3D initrd_f=
ilename;<br>
@@ -245,6 +241,7 @@ static void mips_mipssim_machine_init(MachineClass *mc)=
<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpu_type =3D MIPS_CPU_TYPE_NAME(&quot;24=
Kf&quot;);<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;mips_mipssim.ram&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0DEFINE_MACHINE(&quot;mipssim&quot;, mips_mipssim_machine_init)<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote></div></div>

--000000000000005493059ce5ee17--

