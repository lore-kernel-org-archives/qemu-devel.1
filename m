Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B952BC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74621214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFYlu5vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74621214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k11-0008QI-Mo
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jzm-0007M3-E9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jzj-00019D-W2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:16:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jzi-000193-R6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:16:23 -0500
Received: by mail-wm1-x344.google.com with SMTP id i10so13790768wmd.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=u2nS5r39oZhQzCCf8/w3l+c1/+mXjRf1FfnRBEbNu44=;
 b=LFYlu5vgI68WcBk6ZSghMBko7kvfXRnqQIzOMbOlaBWcmSQX8zrumgjtdW6UoyisWQ
 japI7YjaOTTAdi+4dRbR9GJyfk7jcKSsvxfsuG444nSijwPchMlzxdZZELMAZ1cOoumC
 m8rvpZZc0dTAh/FT4EeeWbWR2nQu09u45nmR1xMc6ybzgtlE7wBwO5a7su8axXMwMmas
 sx/sMWH3g3FqgKdqHn5cbjUpbcmptV/JIq9W11VVToaEsSCm+xJ9MenO9vatvsB7q0+W
 UMIReZ4i5/6wQczkr0es8DCKIC+I1TFFSeSdyZWJ3g0UUJhuhB3e+Wn2K7tP0N00FdoJ
 FXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=u2nS5r39oZhQzCCf8/w3l+c1/+mXjRf1FfnRBEbNu44=;
 b=mzWXvIpf93gRs84pWapn7lwrRpQbO8vQciFXLx/lf7PAHn9uUqyRJwwSZcNW/+Wksd
 FVoz6/u/yJC6xB+4z4HhohhqInNRMELP3bh8OAVcNu2s5+H/knfWlQoQQZ1y4MEa6bfb
 hmjAnixKdZsE/T1qh9I/FdqRDe4sOlRrhy0K/T3bhJKazIOog0KYHJgCNkoxU07rbVYS
 5NCJg8I7i8vKxp7KPBRhYFGyYZKG76LfwQIXXETDQnyMeBFPchFzqeUtlsLdb5xPdAf/
 jNLaxTmbClt5kR2HErDgfeJ+UuCJ/2SKHE2fkALEVlzPg+AzH3A33TPn34mo3iCymVu8
 NXww==
X-Gm-Message-State: APjAAAXdCVk+w8Dafigw1gMFWnVE/6PQfUAjJSatIWdU6Waml0bOncn8
 DyR25uCvlbrlIByLnMPVrSt8kubE/DE=
X-Google-Smtp-Source: APXvYqxnXkC+GMI30keGc8s0ebRpb9cC3aac3se9CBwdUeSMqdtndBIsjYIeMX3OJBliKdgF7pzynw==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr19923653wme.117.1583151381062; 
 Mon, 02 Mar 2020 04:16:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm29507624wrq.63.2020.03.02.04.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:16:19 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 47A441FF87;
 Mon,  2 Mar 2020 12:16:19 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-22-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 21/33] hmp-commands-info.hx: Add rST documentation
 fragments
In-reply-to: <20200228153619.9906-22-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:16:19 +0000
Message-ID: <87sgir9cks.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

> Add the rST versions of the documentation fragments.  Once we've
> converted fully from Texinfo to rST we can remove the ETEXI
> fragments; for the moment we need both.
>
> Note that most of the SRST fragments are 2-space indented so that the
> 'info foo' documentation entries appear as a sublist under the 'info'
> entry in the top level list.
>
> Again, all we need to do to put the documentation in the Sphinx manual
> is a one-line hxtool-doc invocation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile                |   2 +-
>  docs/system/monitor.rst |   4 +-
>  hmp-commands-info.hx    | 271 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 22427376b48..98ef06ab8e8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1071,7 +1071,7 @@ $(MANUAL_BUILDDIR)/interop/index.html: $(call manua=
l-deps,interop)
>  $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
>  	$(call build-manual,specs,html)
>=20=20
> -$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system) $(SRC_P=
ATH)/hmp-commands.hx
> +$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system) $(SRC_P=
ATH)/hmp-commands.hx $(SRC_PATH)/hmp-commands-info.hx
>  	$(call build-manual,system,html)
>=20=20
>  $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PAT=
H)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
> diff --git a/docs/system/monitor.rst b/docs/system/monitor.rst
> index 52b0f18cfec..0bcd5da2164 100644
> --- a/docs/system/monitor.rst
> +++ b/docs/system/monitor.rst
> @@ -21,9 +21,7 @@ The following commands are available:
>=20=20
>  .. hxtool-doc:: hmp-commands.hx
>=20=20
> -..
> -  TODO: convert and reference hmp-commands-info.hx
> -
> +.. hxtool-doc:: hmp-commands-info.hx
>=20=20
>  Integer expressions
>  ~~~~~~~~~~~~~~~~~~~
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 257ee7d7a3f..1730f866cde 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -4,6 +4,12 @@ HXCOMM discarded from C version
>  HXCOMM DEF(command, args, callback, arg_string, help) is used to constru=
ct
>  HXCOMM monitor info commands
>  HXCOMM HXCOMM can be used for comments, discarded from both texi and C
> +HXCOMM
> +HXCOMM In this file, generally SRST fragments should have two extra
> +HXCOMM spaces of indent, so that the documentation list item for "info f=
oo"
> +HXCOMM appears inside the documentation list item for the top level
> +HXCOMM "info" documentation entry. The exception is the first SRST
> +HXCOMM fragment that defines that top level entry.
>=20=20
>  STEXI
>  @table @option
> @@ -12,6 +18,11 @@ STEXI
>  Show various information about the system state.
>  @table @option
>  ETEXI
> +SRST
> +``info`` *subcommand*
> +  Show various information about the system state.
> +
> +ERST
>=20=20
>      {
>          .name       =3D "version",
> @@ -27,6 +38,10 @@ STEXI
>  @findex info version
>  Show the version of QEMU.
>  ETEXI
> +SRST
> +  ``info version``
> +    Show the version of QEMU.
> +ERST
>=20=20
>      {
>          .name       =3D "network",
> @@ -41,6 +56,10 @@ STEXI
>  @findex info network
>  Show the network state.
>  ETEXI
> +SRST
> +  ``info network``
> +    Show the network state.
> +ERST
>=20=20
>      {
>          .name       =3D "chardev",
> @@ -56,6 +75,10 @@ STEXI
>  @findex info chardev
>  Show the character devices.
>  ETEXI
> +SRST
> +  ``info chardev``
> +    Show the character devices.
> +ERST
>=20=20
>      {
>          .name       =3D "block",
> @@ -71,6 +94,10 @@ STEXI
>  @findex info block
>  Show info of one block device or all block devices.
>  ETEXI
> +SRST
> +  ``info block``
> +    Show info of one block device or all block devices.
> +ERST
>=20=20
>      {
>          .name       =3D "blockstats",
> @@ -85,6 +112,10 @@ STEXI
>  @findex info blockstats
>  Show block device statistics.
>  ETEXI
> +SRST
> +  ``info blockstats``
> +    Show block device statistics.
> +ERST
>=20=20
>      {
>          .name       =3D "block-jobs",
> @@ -99,6 +130,10 @@ STEXI
>  @findex info block-jobs
>  Show progress of ongoing block device operations.
>  ETEXI
> +SRST
> +  ``info block-jobs``
> +    Show progress of ongoing block device operations.
> +ERST
>=20=20
>      {
>          .name       =3D "registers",
> @@ -113,6 +148,10 @@ STEXI
>  @findex info registers
>  Show the cpu registers.
>  ETEXI
> +SRST
> +  ``info registers``
> +    Show the cpu registers.
> +ERST
>=20=20
>  #if defined(TARGET_I386)
>      {
> @@ -130,6 +169,10 @@ STEXI
>  @findex info lapic
>  Show local APIC state
>  ETEXI
> +SRST
> +  ``info lapic``
> +    Show local APIC state
> +ERST
>=20=20
>  #if defined(TARGET_I386)
>      {
> @@ -146,6 +189,10 @@ STEXI
>  @findex info ioapic
>  Show io APIC state
>  ETEXI
> +SRST
> +  ``info ioapic``
> +    Show io APIC state
> +ERST
>=20=20
>      {
>          .name       =3D "cpus",
> @@ -160,6 +207,10 @@ STEXI
>  @findex info cpus
>  Show infos for each CPU.
>  ETEXI
> +SRST
> +  ``info cpus``
> +    Show infos for each CPU.
> +ERST
>=20=20
>      {
>          .name       =3D "history",
> @@ -175,6 +226,10 @@ STEXI
>  @findex info history
>  Show the command line history.
>  ETEXI
> +SRST
> +  ``info history``
> +    Show the command line history.
> +ERST
>=20=20
>      {
>          .name       =3D "irq",
> @@ -189,6 +244,10 @@ STEXI
>  @findex info irq
>  Show the interrupts statistics (if available).
>  ETEXI
> +SRST
> +  ``info irq``
> +    Show the interrupts statistics (if available).
> +ERST
>=20=20
>      {
>          .name       =3D "pic",
> @@ -203,6 +262,10 @@ STEXI
>  @findex info pic
>  Show PIC state.
>  ETEXI
> +SRST
> +  ``info pic``
> +    Show PIC state.
> +ERST
>=20=20
>      {
>          .name       =3D "rdma",
> @@ -217,6 +280,10 @@ STEXI
>  @findex info rdma
>  Show RDMA state.
>  ETEXI
> +SRST
> +  ``info rdma``
> +    Show RDMA state.
> +ERST
>=20=20
>      {
>          .name       =3D "pci",
> @@ -231,6 +298,10 @@ STEXI
>  @findex info pci
>  Show PCI information.
>  ETEXI
> +SRST
> +  ``info pci``
> +    Show PCI information.
> +ERST
>=20=20
>  #if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC)=
 || \
>      defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
> @@ -248,6 +319,10 @@ STEXI
>  @findex info tlb
>  Show virtual to physical memory mappings.
>  ETEXI
> +SRST
> +  ``info tlb``
> +    Show virtual to physical memory mappings.
> +ERST
>=20=20
>  #if defined(TARGET_I386) || defined(TARGET_RISCV)
>      {
> @@ -264,6 +339,10 @@ STEXI
>  @findex info mem
>  Show the active virtual memory mappings.
>  ETEXI
> +SRST
> +  ``info mem``
> +    Show the active virtual memory mappings.
> +ERST
>=20=20
>      {
>          .name       =3D "mtree",
> @@ -280,6 +359,10 @@ STEXI
>  @findex info mtree
>  Show memory tree.
>  ETEXI
> +SRST
> +  ``info mtree``
> +    Show memory tree.
> +ERST
>=20=20
>  #if defined(CONFIG_TCG)
>      {
> @@ -296,6 +379,10 @@ STEXI
>  @findex info jit
>  Show dynamic compiler info.
>  ETEXI
> +SRST
> +  ``info jit``
> +    Show dynamic compiler info.
> +ERST
>=20=20
>  #if defined(CONFIG_TCG)
>      {
> @@ -312,6 +399,10 @@ STEXI
>  @findex info opcount
>  Show dynamic compiler opcode counters
>  ETEXI
> +SRST
> +  ``info opcount``
> +    Show dynamic compiler opcode counters
> +ERST
>=20=20
>      {
>          .name       =3D "sync-profile",
> @@ -334,6 +425,20 @@ sorted by total wait time.
>  When different objects that share the same call site are coalesced, the =
"Object"
>  field shows---enclosed in brackets---the number of objects being coalesc=
ed.
>  ETEXI
> +SRST
> +  ``info sync-profile [-m|-n]`` [*max*]
> +    Show synchronization profiling info, up to *max* entries (default: 1=
0),
> +    sorted by total wait time.
> +
> +    ``-m``
> +      sort by mean wait time
> +    ``-n``
> +      do not coalesce objects with the same call site
> +
> +    When different objects that share the same call site are coalesced,
> +    the "Object" field shows---enclosed in brackets---the number of obje=
cts
> +    being coalesced.
> +ERST
>=20=20
>      {
>          .name       =3D "kvm",
> @@ -348,6 +453,10 @@ STEXI
>  @findex info kvm
>  Show KVM information.
>  ETEXI
> +SRST
> +  ``info kvm``
> +    Show KVM information.
> +ERST
>=20=20
>      {
>          .name       =3D "numa",
> @@ -362,6 +471,10 @@ STEXI
>  @findex info numa
>  Show NUMA information.
>  ETEXI
> +SRST
> +  ``info numa``
> +    Show NUMA information.
> +ERST
>=20=20
>      {
>          .name       =3D "usb",
> @@ -376,6 +489,10 @@ STEXI
>  @findex info usb
>  Show guest USB devices.
>  ETEXI
> +SRST
> +  ``info usb``
> +    Show guest USB devices.
> +ERST
>=20=20
>      {
>          .name       =3D "usbhost",
> @@ -390,6 +507,10 @@ STEXI
>  @findex info usbhost
>  Show host USB devices.
>  ETEXI
> +SRST
> +  ``info usbhost``
> +    Show host USB devices.
> +ERST
>=20=20
>      {
>          .name       =3D "profile",
> @@ -404,6 +525,10 @@ STEXI
>  @findex info profile
>  Show profiling information.
>  ETEXI
> +SRST
> +  ``info profile``
> +    Show profiling information.
> +ERST
>=20=20
>      {
>          .name       =3D "capture",
> @@ -418,6 +543,10 @@ STEXI
>  @findex info capture
>  Show capture information.
>  ETEXI
> +SRST
> +  ``info capture``
> +    Show capture information.
> +ERST
>=20=20
>      {
>          .name       =3D "snapshots",
> @@ -432,6 +561,10 @@ STEXI
>  @findex info snapshots
>  Show the currently saved VM snapshots.
>  ETEXI
> +SRST
> +  ``info snapshots``
> +    Show the currently saved VM snapshots.
> +ERST
>=20=20
>      {
>          .name       =3D "status",
> @@ -447,6 +580,10 @@ STEXI
>  @findex info status
>  Show the current VM status (running|paused).
>  ETEXI
> +SRST
> +  ``info status``
> +    Show the current VM status (running|paused).
> +ERST
>=20=20
>      {
>          .name       =3D "mice",
> @@ -461,6 +598,10 @@ STEXI
>  @findex info mice
>  Show which guest mouse is receiving events.
>  ETEXI
> +SRST
> +  ``info mice``
> +    Show which guest mouse is receiving events.
> +ERST
>=20=20
>  #if defined(CONFIG_VNC)
>      {
> @@ -477,6 +618,10 @@ STEXI
>  @findex info vnc
>  Show the vnc server status.
>  ETEXI
> +SRST
> +  ``info vnc``
> +    Show the vnc server status.
> +ERST
>=20=20
>  #if defined(CONFIG_SPICE)
>      {
> @@ -493,6 +638,10 @@ STEXI
>  @findex info spice
>  Show the spice server status.
>  ETEXI
> +SRST
> +  ``info spice``
> +    Show the spice server status.
> +ERST
>=20=20
>      {
>          .name       =3D "name",
> @@ -508,6 +657,10 @@ STEXI
>  @findex info name
>  Show the current VM name.
>  ETEXI
> +SRST
> +  ``info name``
> +    Show the current VM name.
> +ERST
>=20=20
>      {
>          .name       =3D "uuid",
> @@ -523,6 +676,10 @@ STEXI
>  @findex info uuid
>  Show the current VM UUID.
>  ETEXI
> +SRST
> +  ``info uuid``
> +    Show the current VM UUID.
> +ERST
>=20=20
>      {
>          .name       =3D "cpustats",
> @@ -537,6 +694,10 @@ STEXI
>  @findex info cpustats
>  Show CPU statistics.
>  ETEXI
> +SRST
> +  ``info cpustats``
> +    Show CPU statistics.
> +ERST
>=20=20
>  #if defined(CONFIG_SLIRP)
>      {
> @@ -553,6 +714,10 @@ STEXI
>  @findex info usernet
>  Show user network stack connection states.
>  ETEXI
> +SRST
> +  ``info usernet``
> +    Show user network stack connection states.
> +ERST
>=20=20
>      {
>          .name       =3D "migrate",
> @@ -567,6 +732,10 @@ STEXI
>  @findex info migrate
>  Show migration status.
>  ETEXI
> +SRST
> +  ``info migrate``
> +    Show migration status.
> +ERST
>=20=20
>      {
>          .name       =3D "migrate_capabilities",
> @@ -581,6 +750,10 @@ STEXI
>  @findex info migrate_capabilities
>  Show current migration capabilities.
>  ETEXI
> +SRST
> +  ``info migrate_capabilities``
> +    Show current migration capabilities.
> +ERST
>=20=20
>      {
>          .name       =3D "migrate_parameters",
> @@ -595,6 +768,10 @@ STEXI
>  @findex info migrate_parameters
>  Show current migration parameters.
>  ETEXI
> +SRST
> +  ``info migrate_parameters``
> +    Show current migration parameters.
> +ERST
>=20=20
>      {
>          .name       =3D "migrate_cache_size",
> @@ -609,6 +786,10 @@ STEXI
>  @findex info migrate_cache_size
>  Show current migration xbzrle cache size.
>  ETEXI
> +SRST
> +  ``info migrate_cache_size``
> +    Show current migration xbzrle cache size.
> +ERST
>=20=20
>      {
>          .name       =3D "balloon",
> @@ -623,6 +804,10 @@ STEXI
>  @findex info balloon
>  Show balloon information.
>  ETEXI
> +SRST
> +  ``info balloon``
> +    Show balloon information.
> +ERST
>=20=20
>      {
>          .name       =3D "qtree",
> @@ -637,6 +822,10 @@ STEXI
>  @findex info qtree
>  Show device tree.
>  ETEXI
> +SRST
> +  ``info qtree``
> +    Show device tree.
> +ERST
>=20=20
>      {
>          .name       =3D "qdm",
> @@ -651,6 +840,10 @@ STEXI
>  @findex info qdm
>  Show qdev device model list.
>  ETEXI
> +SRST
> +  ``info qdm``
> +    Show qdev device model list.
> +ERST
>=20=20
>      {
>          .name       =3D "qom-tree",
> @@ -666,6 +859,10 @@ STEXI
>  @findex info qom-tree
>  Show QOM composition tree.
>  ETEXI
> +SRST
> +  ``info qom-tree``
> +    Show QOM composition tree.
> +ERST
>=20=20
>      {
>          .name       =3D "roms",
> @@ -680,6 +877,10 @@ STEXI
>  @findex info roms
>  Show roms.
>  ETEXI
> +SRST
> +  ``info roms``
> +    Show roms.
> +ERST
>=20=20
>      {
>          .name       =3D "trace-events",
> @@ -696,6 +897,10 @@ STEXI
>  @findex info trace-events
>  Show available trace-events & their state.
>  ETEXI
> +SRST
> +  ``info trace-events``
> +    Show available trace-events & their state.
> +ERST
>=20=20
>      {
>          .name       =3D "tpm",
> @@ -710,6 +915,10 @@ STEXI
>  @findex info tpm
>  Show the TPM device.
>  ETEXI
> +SRST
> +  ``info tpm``
> +    Show the TPM device.
> +ERST
>=20=20
>      {
>          .name       =3D "memdev",
> @@ -725,6 +934,10 @@ STEXI
>  @findex info memdev
>  Show memory backends
>  ETEXI
> +SRST
> +  ``info memdev``
> +    Show memory backends
> +ERST
>=20=20
>      {
>          .name       =3D "memory-devices",
> @@ -739,6 +952,10 @@ STEXI
>  @findex info memory-devices
>  Show memory devices.
>  ETEXI
> +SRST
> +  ``info memory-devices``
> +    Show memory devices.
> +ERST
>=20=20
>      {
>          .name       =3D "iothreads",
> @@ -754,6 +971,10 @@ STEXI
>  @findex info iothreads
>  Show iothread's identifiers.
>  ETEXI
> +SRST
> +  ``info iothreads``
> +    Show iothread's identifiers.
> +ERST
>=20=20
>      {
>          .name       =3D "rocker",
> @@ -768,6 +989,10 @@ STEXI
>  @findex info rocker
>  Show rocker switch.
>  ETEXI
> +SRST
> +  ``info rocker`` *name*
> +    Show rocker switch.
> +ERST
>=20=20
>      {
>          .name       =3D "rocker-ports",
> @@ -782,6 +1007,10 @@ STEXI
>  @findex info rocker-ports
>  Show rocker ports.
>  ETEXI
> +SRST
> +  ``info rocker-ports`` *name*-ports
> +    Show rocker ports.
> +ERST
>=20=20
>      {
>          .name       =3D "rocker-of-dpa-flows",
> @@ -796,6 +1025,10 @@ STEXI
>  @findex info rocker-of-dpa-flows
>  Show rocker OF-DPA flow tables.
>  ETEXI
> +SRST
> +  ``info rocker-of-dpa-flows`` *name* [*tbl_id*]
> +    Show rocker OF-DPA flow tables.
> +ERST
>=20=20
>      {
>          .name       =3D "rocker-of-dpa-groups",
> @@ -810,6 +1043,10 @@ STEXI
>  @findex info rocker-of-dpa-groups
>  Show rocker OF-DPA groups.
>  ETEXI
> +SRST
> +  ``info rocker-of-dpa-groups`` *name* [*type*]
> +    Show rocker OF-DPA groups.
> +ERST
>=20=20
>  #if defined(TARGET_S390X)
>      {
> @@ -826,6 +1063,10 @@ STEXI
>  @findex info skeys
>  Display the value of a storage key (s390 only)
>  ETEXI
> +SRST
> +  ``info skeys`` *address*
> +    Display the value of a storage key (s390 only)
> +ERST
>=20=20
>  #if defined(TARGET_S390X)
>      {
> @@ -842,6 +1083,11 @@ STEXI
>  @findex info cmma
>  Display the values of the CMMA storage attributes for a range of pages (=
s390 only)
>  ETEXI
> +SRST
> +  ``info cmma`` *address*
> +    Display the values of the CMMA storage attributes for a range of
> +    pages (s390 only)
> +ERST
>=20=20
>      {
>          .name       =3D "dump",
> @@ -856,6 +1102,10 @@ STEXI
>  @findex info dump
>  Display the latest dump status.
>  ETEXI
> +SRST
> +  ``info dump``
> +    Display the latest dump status.
> +ERST
>=20=20
>      {
>          .name       =3D "ramblock",
> @@ -870,6 +1120,10 @@ STEXI
>  @findex info ramblock
>  Dump all the ramblocks of the system.
>  ETEXI
> +SRST
> +  ``info ramblock``
> +    Dump all the ramblocks of the system.
> +ERST
>=20=20
>      {
>          .name       =3D "hotpluggable-cpus",
> @@ -885,6 +1139,10 @@ STEXI
>  @findex info hotpluggable-cpus
>  Show information about hotpluggable CPUs
>  ETEXI
> +SRST
> +  ``info hotpluggable-cpus``
> +    Show information about hotpluggable CPUs
> +ERST
>=20=20
>      {
>          .name       =3D "vm-generation-id",
> @@ -899,6 +1157,10 @@ STEXI
>  @findex info vm-generation-id
>  Show Virtual Machine Generation ID
>  ETEXI
> +SRST
> +  ``info vm-generation-id``
> +    Show Virtual Machine Generation ID
> +ERST
>=20=20
>      {
>          .name       =3D "memory_size_summary",
> @@ -915,6 +1177,11 @@ STEXI
>  Display the amount of initially allocated and present hotpluggable (if
>  enabled) memory in bytes.
>  ETEXI
> +SRST
> +  ``info memory_size_summary``
> +    Display the amount of initially allocated and present hotpluggable (=
if
> +    enabled) memory in bytes.
> +ERST
>=20=20
>  #if defined(TARGET_I386)
>      {
> @@ -931,6 +1198,10 @@ STEXI
>  @findex info sev
>  Show SEV information.
>  ETEXI
> +SRST
> +  ``info sev``
> +    Show SEV information.
> +ERST
>=20=20
>  STEXI
>  @end table


--=20
Alex Benn=C3=A9e

