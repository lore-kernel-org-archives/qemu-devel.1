Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB70C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273D42166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6oUNZax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273D42166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jL6-0005RN-CY
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jJD-0002Oj-9U
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jJA-0008Me-Ls
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:32:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jJA-0008MZ-DS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:32:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so12142203wrn.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WHDbpefAsaIvBtleQANaZgyzeSW+VdQdh1fh8ilF/Uc=;
 b=P6oUNZaxELHt2vnWMAQXQHmMGFIEMKazeSe0HcvG57m+rwR0nyRtXoD/ydh6WDtVZY
 W1FHgBd1L+WwW/quWiZ15ZKr85x8NjQeIqAalZlbPTiVi31NlNXLcsdLATd94maZ/AgB
 lZcaxCWljqH3LGcjgKmt1sRqEsnSL4gj7A4yBUSDEeOjKHKGbh69fSuSpkMyZx8xH2Sc
 6P7dGgentvM6lG8vAxunx6Cul+F4vkzizzLhzQ5Y2bYN9udGbjUl/12i3ilItf6VabY8
 7TfK7Tk0q958G8BtPPvoQu3GoI9tVVy0KfDgAQukd5ozOeoL7dKN7GLBWU5sgK0lQPjv
 wRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WHDbpefAsaIvBtleQANaZgyzeSW+VdQdh1fh8ilF/Uc=;
 b=YOLdm06Kc9c83f/gcQ4jvmZv0IdRohRAVoBfJY0+l3rtJY1kvNalOPPvNSC1XE43H9
 a/Q9gaInhQs7pbBwBF+Yte0w/O+AX3ztUQOnkylbHxJyOfQne+EDY8Zt6dp1KlS2ZLUp
 +I0yEAPE8cu1If9OarZnJARSYWB0JCaOBWUJhTm6VZetdytXZ/hnia8W7lI+EqkxMfhz
 iR+mTf+vKx/DIuD7E1/dSsadSPRK0W+rMpU+q4tI/CgezX2zgF6lg+npR7XYmKzfa6qQ
 HUfox0HYmagB4Ni7PetEQuza9yY26jmlf6TIevSxvY944drN7hs9yMLBBVS24jdg7DyB
 Cq9Q==
X-Gm-Message-State: APjAAAWWBNeDRXQs0Xsc7NLK0p4RjsIdoC77rgk5Nh1uPKLQwm5n92Ai
 +fl37aOVz+4xcyzMGun9TFqIgfi+tnM=
X-Google-Smtp-Source: APXvYqyu8dWWv8LW2s7wz6y0YqeNOacwGvtQZ5/dtu/n/mE7UFOK+IgmaXjYuX4UUMfMKisBdHoijw==
X-Received: by 2002:a5d:4dce:: with SMTP id f14mr21645131wru.65.1583148743301; 
 Mon, 02 Mar 2020 03:32:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 12sm15018837wmo.30.2020.03.02.03.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:32:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99BD31FF87;
 Mon,  2 Mar 2020 11:32:21 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-13-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 12/33] qemu-doc: remove indices other than findex
In-reply-to: <20200228153619.9906-13-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:32:21 +0000
Message-ID: <87fterat6i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> These indices are not well-maintained, and pandoc also chokes on the
> directives.  Just nuke them.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-13-pbonzini@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/keys.texi           | 10 --------
>  docs/system/monitor.texi        |  1 -
>  docs/system/mux-chardev.texi    |  7 ------
>  docs/system/quickstart.texi     |  1 -
>  docs/system/target-arm.texi     |  1 -
>  docs/system/target-i386.texi    |  1 -
>  docs/system/target-m68k.texi    |  2 --
>  docs/system/target-mips.texi    |  2 --
>  docs/system/target-ppc.texi     |  1 -
>  docs/system/target-sparc.texi   |  1 -
>  docs/system/target-sparc64.texi |  1 -
>  docs/system/target-xtensa.texi  |  1 -
>  qemu-doc.texi                   | 44 ---------------------------------
>  13 files changed, 73 deletions(-)
>
> diff --git a/docs/system/keys.texi b/docs/system/keys.texi
> index 4c74b3bf4dd..c04daf54f23 100644
> --- a/docs/system/keys.texi
> +++ b/docs/system/keys.texi
> @@ -10,23 +10,18 @@ then the modifier is Ctrl-Alt-Shift (instead of Ctrl-=
Alt) and if you use
>=20=20
>  @table @key
>  @item Ctrl-Alt-f
> -@kindex Ctrl-Alt-f
>  Toggle full screen
>=20=20
>  @item Ctrl-Alt-+
> -@kindex Ctrl-Alt-+
>  Enlarge the screen
>=20=20
>  @item Ctrl-Alt--
> -@kindex Ctrl-Alt--
>  Shrink the screen
>=20=20
>  @item Ctrl-Alt-u
> -@kindex Ctrl-Alt-u
>  Restore the screen's un-scaled dimensions
>=20=20
>  @item Ctrl-Alt-n
> -@kindex Ctrl-Alt-n
>  Switch to virtual console 'n'. Standard console mappings are:
>  @table @emph
>  @item 1
> @@ -38,14 +33,9 @@ Serial port
>  @end table
>=20=20
>  @item Ctrl-Alt
> -@kindex Ctrl-Alt
>  Toggle mouse and keyboard grab.
>  @end table
>=20=20
> -@kindex Ctrl-Up
> -@kindex Ctrl-Down
> -@kindex Ctrl-PageUp
> -@kindex Ctrl-PageDown
>  In the virtual consoles, you can use @key{Ctrl-Up}, @key{Ctrl-Down},
>  @key{Ctrl-PageUp} and @key{Ctrl-PageDown} to move in the back log.
>=20=20
> diff --git a/docs/system/monitor.texi b/docs/system/monitor.texi
> index c5b6a9b38e4..b41b144885d 100644
> --- a/docs/system/monitor.texi
> +++ b/docs/system/monitor.texi
> @@ -1,6 +1,5 @@
>  @node pcsys_monitor
>  @section QEMU Monitor
> -@cindex QEMU monitor
>=20=20
>  The QEMU monitor is used to give complex commands to the QEMU
>  emulator. You can use it to:
> diff --git a/docs/system/mux-chardev.texi b/docs/system/mux-chardev.texi
> index c9a2d14cb88..b21c2c56540 100644
> --- a/docs/system/mux-chardev.texi
> +++ b/docs/system/mux-chardev.texi
> @@ -12,26 +12,19 @@ you're using the default.
>=20=20
>  @table @key
>  @item Ctrl-a h
> -@kindex Ctrl-a h
>  Print this help
>  @item Ctrl-a x
> -@kindex Ctrl-a x
>  Exit emulator
>  @item Ctrl-a s
> -@kindex Ctrl-a s
>  Save disk data back to file (if -snapshot)
>  @item Ctrl-a t
> -@kindex Ctrl-a t
>  Toggle console timestamps
>  @item Ctrl-a b
> -@kindex Ctrl-a b
>  Send break (magic sysrq in Linux)
>  @item Ctrl-a c
> -@kindex Ctrl-a c
>  Rotate between the frontends connected to the multiplexer (usually
>  this switches between the monitor and the console)
>  @item Ctrl-a Ctrl-a
> -@kindex Ctrl-a Ctrl-a
>  Send the escape character to the frontend
>  @end table
>  @c man end
> diff --git a/docs/system/quickstart.texi b/docs/system/quickstart.texi
> index ed7295de7a2..baceaa96eb2 100644
> --- a/docs/system/quickstart.texi
> +++ b/docs/system/quickstart.texi
> @@ -1,6 +1,5 @@
>  @node pcsys_quickstart
>  @section Quick Start
> -@cindex quick start
>=20=20
>  Download and uncompress a PC hard disk image with Linux installed (e.g.
>  @file{linux.img}) and type:
> diff --git a/docs/system/target-arm.texi b/docs/system/target-arm.texi
> index 040d77b5e05..c56b5f6ebfe 100644
> --- a/docs/system/target-arm.texi
> +++ b/docs/system/target-arm.texi
> @@ -1,6 +1,5 @@
>  @node ARM System emulator
>  @section ARM System emulator
> -@cindex system emulation (ARM)
>=20=20
>  Use the executable @file{qemu-system-arm} to simulate a ARM
>  machine. The ARM Integrator/CP board is emulated with the following
> diff --git a/docs/system/target-i386.texi b/docs/system/target-i386.texi
> index edd23fa8df5..cc352b89a84 100644
> --- a/docs/system/target-i386.texi
> +++ b/docs/system/target-i386.texi
> @@ -1,6 +1,5 @@
>  @node x86 (PC) System emulator
>  @section x86 (PC) System emulator
> -@cindex system emulation (PC)
>=20=20
>  @menu
>  * pcsys_devices::      Peripherals
> diff --git a/docs/system/target-m68k.texi b/docs/system/target-m68k.texi
> index b5bc9df40ae..a77b19ea0f1 100644
> --- a/docs/system/target-m68k.texi
> +++ b/docs/system/target-m68k.texi
> @@ -1,7 +1,5 @@
>  @node ColdFire System emulator
>  @section ColdFire System emulator
> -@cindex system emulation (ColdFire)
> -@cindex system emulation (M68K)
>=20=20
>  Use the executable @file{qemu-system-m68k} to simulate a ColdFire machin=
e.
>  The emulator is able to boot a uClinux kernel.
> diff --git a/docs/system/target-mips.texi b/docs/system/target-mips.texi
> index f722c00912a..fe12ee94c73 100644
> --- a/docs/system/target-mips.texi
> +++ b/docs/system/target-mips.texi
> @@ -1,6 +1,5 @@
>  @node MIPS System emulator
>  @section MIPS System emulator
> -@cindex system emulation (MIPS)
>=20=20
>  @menu
>  * recommendations_cpu_models_MIPS:: Supported CPU model configurations o=
n MIPS hosts
> @@ -126,7 +125,6 @@ MIPSnet network emulation
>=20=20
>  @node nanoMIPS System emulator
>  @subsection nanoMIPS System emulator
> -@cindex system emulation (nanoMIPS)
>=20=20
>  Executable @file{qemu-system-mipsel} also covers simulation of
>  32-bit nanoMIPS system in little endian mode:
> diff --git a/docs/system/target-ppc.texi b/docs/system/target-ppc.texi
> index c2c254d3d23..55f98f65b12 100644
> --- a/docs/system/target-ppc.texi
> +++ b/docs/system/target-ppc.texi
> @@ -1,6 +1,5 @@
>  @node PowerPC System emulator
>  @section PowerPC System emulator
> -@cindex system emulation (PowerPC)
>=20=20
>  Use the executable @file{qemu-system-ppc} to simulate a complete 40P (PR=
EP)
>  or PowerMac PowerPC system.
> diff --git a/docs/system/target-sparc.texi b/docs/system/target-sparc.texi
> index 7fe0aec9c39..7748001f734 100644
> --- a/docs/system/target-sparc.texi
> +++ b/docs/system/target-sparc.texi
> @@ -1,6 +1,5 @@
>  @node Sparc32 System emulator
>  @section Sparc32 System emulator
> -@cindex system emulation (Sparc32)
>=20=20
>  Use the executable @file{qemu-system-sparc} to simulate the following
>  Sun4m architecture machines:
> diff --git a/docs/system/target-sparc64.texi b/docs/system/target-sparc64=
.texi
> index 9e7a27de0ce..4db4ca3842b 100644
> --- a/docs/system/target-sparc64.texi
> +++ b/docs/system/target-sparc64.texi
> @@ -1,6 +1,5 @@
>  @node Sparc64 System emulator
>  @section Sparc64 System emulator
> -@cindex system emulation (Sparc64)
>=20=20
>  Use the executable @file{qemu-system-sparc64} to simulate a Sun4u
>  (UltraSPARC PC-like machine), Sun4v (T1 PC-like machine), or generic
> diff --git a/docs/system/target-xtensa.texi b/docs/system/target-xtensa.t=
exi
> index 08b0b362991..40327de6fa7 100644
> --- a/docs/system/target-xtensa.texi
> +++ b/docs/system/target-xtensa.texi
> @@ -1,6 +1,5 @@
>  @node Xtensa System emulator
>  @section Xtensa System emulator
> -@cindex system emulation (Xtensa)
>=20=20
>  Two executables cover simulation of both Xtensa endian options,
>  @file{qemu-system-xtensa} and @file{qemu-system-xtensaeb}.
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index d3e743719ab..c2b9c87c645 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -62,17 +62,14 @@
>  QEMU is a FAST! processor emulator using dynamic translation to
>  achieve good emulation speed.
>=20=20
> -@cindex operating modes
>  QEMU has two operating modes:
>=20=20
>  @itemize
> -@cindex system emulation
>  @item Full system emulation. In this mode, QEMU emulates a full system (=
for
>  example a PC), including one or several processors and various
>  peripherals. It can be used to launch different Operating Systems
>  without rebooting the PC or to debug system code.
>=20=20
> -@cindex user mode emulation
>  @item User mode emulation. In this mode, QEMU can launch
>  processes compiled for one CPU on another CPU. It can be used to
>  launch the Wine Windows API emulator (@url{https://www.winehq.org}) or
> @@ -127,7 +124,6 @@ accelerator is required to use more than one host CPU=
 for emulation.
>=20=20
>  @node QEMU System emulator
>  @chapter QEMU System emulator
> -@cindex system emulation
>=20=20
>  @menu
>  * pcsys_quickstart::   Quick start
> @@ -163,7 +159,6 @@ accelerator is required to use more than one host CPU=
 for emulation.
>=20=20
>  @node QEMU System emulator targets
>  @chapter QEMU System emulator targets
> -@cindex system emulation (PC)
>=20=20
>  QEMU is a generic emulator and it emulates many machines. Most of the
>  options are similar for all machines. Specific information about the
> @@ -200,46 +195,7 @@ various targets are mentioned in the following secti=
ons.
>=20=20
>  @node Index
>  @appendix Index
> -@menu
> -* Concept Index::
> -* Function Index::
> -* Keystroke Index::
> -* Program Index::
> -* Data Type Index::
> -* Variable Index::
> -@end menu
>=20=20
> -@node Concept Index
> -@section Concept Index
> -This is the main index. Should we combine all keywords in one index? TODO
> -@printindex cp
> -
> -@node Function Index
> -@section Function Index
> -This index could be used for command line options and monitor functions.
>  @printindex fn
>=20=20
> -@node Keystroke Index
> -@section Keystroke Index
> -
> -This is a list of all keystrokes which have a special function
> -in system emulation.
> -
> -@printindex ky
> -
> -@node Program Index
> -@section Program Index
> -@printindex pg
> -
> -@node Data Type Index
> -@section Data Type Index
> -
> -This index could be used for qdev device names and options.
> -
> -@printindex tp
> -
> -@node Variable Index
> -@section Variable Index
> -@printindex vr
> -
>  @bye


--=20
Alex Benn=C3=A9e

