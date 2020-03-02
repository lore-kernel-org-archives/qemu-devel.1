Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAB12173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N03klBAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAB12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jx1-0004hC-Ca
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jwB-0003sy-0m
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jw8-0000IU-8q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:12:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jw7-0000IQ-Us
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:12:40 -0500
Received: by mail-wm1-x344.google.com with SMTP id c24so2895057wml.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MOToV+Zh0LY08wCi241GowznrC3wGq3c9QoYSgZT/os=;
 b=N03klBAVOHX1VubiqhQyIy5HVG+kpBvT1ZHU68QYGMeEBPeLcTM5R8i/0/tet021Qd
 KQ42s9ri8K+KA2im1fNunE3tzqxgmbt5LgSClJUBMXwI3N8GoPLBjrf28De9+VAzp4ER
 dLkFDN/sC7Xmu5bv+EJMUdhJXPoIzbVUUiRi79qTfvRQI77y3xDaYvvSJ7zhMwCm+Q2W
 4BeJryAtyyeHWEOiV6pMPRxRIPdzCVU4gev9wtalWHwqOd4+JyDMTN/FdFjpp1Oxt8O8
 14ecTtbNaf8+2hmZ3HsAxCr/fJBlwFePEXK0xzEb7GOEEmlbIKmNdVDfKzFR3o9EEm2V
 nuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MOToV+Zh0LY08wCi241GowznrC3wGq3c9QoYSgZT/os=;
 b=NCQBz/XD9m1Vz0hpibV+pXQ4WXZNxS36B6DonumHPp9Hf4PsZmGMrPAGxxrjUpSwbl
 xSflFKEfzYZVUfdX/pQrQ8cHWFeiDzmTGZtEl4DI3fdQQVbbc5lMpEASA10wwRJvsPrA
 rXjn+S0x0XYFgbD+3BefMjLp8GJ5jTaGWchCTuvzDDDQgx2mhUiYrfhwQieeklSkLcKe
 6fnbaYqXCGvmA6Ef672Nq290cCOdgjXistkxEr38o/LiCM3NdCYoaiRAuCRtiFj+HZn8
 zJZD7+s5m15dTM2Br5MGsQrg7djbY1AejubjdM882b3CdmH31XnMAteD0FTX1xJUY8T5
 qkKw==
X-Gm-Message-State: APjAAAXw5o6QOA/aXG44mgyihaVMLQ41xyMyOkiTKL0hyyzXKByHDzhj
 951+s4zb1MAaRatk8sj/RXu0mw==
X-Google-Smtp-Source: APXvYqxMojWyhYwaV+9DVPJ08G55hwVnrQcfIetY0QRK5WGLojCJE9Vd5JFCO8ty4FAyse+WBoPK1g==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr19295330wme.90.1583151157610; 
 Mon, 02 Mar 2020 04:12:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f207sm15843959wme.9.2020.03.02.04.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:12:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89F1D1FF87;
 Mon,  2 Mar 2020 12:12:35 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-19-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 18/33] docs/system: convert the documentation of
 deprecated features to rST.
In-reply-to: <20200228153619.9906-19-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:12:35 +0000
Message-ID: <871rqbarbg.fsf@linaro.org>
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

> We put the whole of this document into the system manual, though
> technically a few parts of it apply to qemu-img or qemu-nbd which are
> otherwise documented in tools/.
>
> We only make formatting fixes, except for one use of 'appendix' which
> we change to 'section' because this isn't an appendix in the Sphinx
> manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-18-pbonzini@redhat.com

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/deprecated.rst | 446 +++++++++++++++++++++++++++++++++++++
>  docs/system/index.rst      |   1 +
>  2 files changed, 447 insertions(+)
>  create mode 100644 docs/system/deprecated.rst
>
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> new file mode 100644
> index 00000000000..1eaa559079b
> --- /dev/null
> +++ b/docs/system/deprecated.rst
> @@ -0,0 +1,446 @@
> +Deprecated features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In general features are intended to be supported indefinitely once
> +introduced into QEMU. In the event that a feature needs to be removed,
> +it will be listed in this section. The feature will remain functional
> +for 2 releases prior to actual removal. Deprecated features may also
> +generate warnings on the console when QEMU starts up, or if activated
> +via a monitor command, however, this is not a mandatory requirement.
> +
> +Prior to the 2.10.0 release there was no official policy on how
> +long features would be deprecated prior to their removal, nor
> +any documented list of which features were deprecated. Thus
> +any features deprecated prior to 2.10.0 will be treated as if
> +they were first deprecated in the 2.10.0 release.
> +
> +What follows is a list of all features currently marked as
> +deprecated.
> +
> +System emulator command line arguments
> +--------------------------------------
> +
> +``-machine enforce-config-section=3Don|off`` (since 3.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``enforce-config-section`` parameter is replaced by the
> +``-global migration.send-configuration=3D{on|off}`` option.
> +
> +``-no-kvm`` (since 1.3.0)
> +'''''''''''''''''''''''''
> +
> +The ``-no-kvm`` argument is now a synonym for setting ``-accel tcg``.
> +
> +``-usbdevice`` (since 2.10.0)
> +'''''''''''''''''''''''''''''
> +
> +The ``-usbdevice DEV`` argument is now a synonym for setting
> +the ``-device usb-DEV`` argument instead. The deprecated syntax
> +would automatically enable USB support on the machine type.
> +If using the new syntax, USB support must be explicitly
> +enabled via the ``-machine usb=3Don`` argument.
> +
> +``-drive file=3Djson:{...{'driver':'file'}}`` (since 3.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The 'file' driver for drives is no longer appropriate for character or h=
ost
> +devices and will only accept regular files (S_IFREG). The correct driver
> +for these file types is 'host_cdrom' or 'host_device' as appropriate.
> +
> +``-net ...,name=3D``\ *name* (since 3.1)
> +''''''''''''''''''''''''''''''''''''''
> +
> +The ``name`` parameter of the ``-net`` option is a synonym
> +for the ``id`` parameter, which should now be used instead.
> +
> +``-smp`` (invalid topologies) (since 3.1)
> +'''''''''''''''''''''''''''''''''''''''''
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs.
> +
> +However, historically it was possible to start QEMU with an incorrect to=
pology
> +where *n* <=3D *sockets* * *cores* * *threads* < *maxcpus*,
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies will be removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +*sockets* * *cores* * *threads* =3D *maxcpus*.
> +
> +``-vnc acl`` (since 4.0.0)
> +''''''''''''''''''''''''''
> +
> +The ``acl`` option to the ``-vnc`` argument has been replaced
> +by the ``tls-authz`` and ``sasl-authz`` options.
> +
> +``QEMU_AUDIO_`` environment variables and ``-audio-help`` (since 4.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``-audiodev`` argument is now the preferred way to specify audio
> +backend settings instead of environment variables.  To ease migration to
> +the new format, the ``-audiodev-help`` option can be used to convert
> +the current values of the environment variables to ``-audiodev`` options.
> +
> +Creating sound card devices and vnc without ``audiodev=3D`` property (si=
nce 4.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''
> +
> +When not using the deprecated legacy audio config, each sound card
> +should specify an ``audiodev=3D`` property.  Additionally, when using
> +vnc, you should specify an ``audiodev=3D`` propery if you plan to
> +transmit audio through the VNC protocol.
> +
> +``-mon ...,control=3Dreadline,pretty=3Don|off`` (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``pretty=3Don|off`` switch has no effect for HMP monitors, but is
> +silently ignored. Using the switch with HMP monitors will become an
> +error in the future.
> +
> +``-realtime`` (since 4.1)
> +'''''''''''''''''''''''''
> +
> +The ``-realtime mlock=3Don|off`` argument has been replaced by the
> +``-overcommit mem-lock=3Don|off`` argument.
> +
> +``-numa node,mem=3D``\ *size* (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''
> +
> +The parameter ``mem`` of ``-numa node`` is used to assign a part of
> +guest RAM to a NUMA node. But when using it, it's impossible to manage s=
pecified
> +RAM chunk on the host side (like bind it to a host node, setting bind po=
licy, ...),
> +so guest end-ups with the fake NUMA configuration with suboptiomal perfo=
rmance.
> +However since 2014 there is an alternative way to assign RAM to a NUMA n=
ode
> +using parameter ``memdev``, which does the same as ``mem`` and adds
> +means to actualy manage node RAM on the host side. Use parameter ``memde=
v``
> +with *memory-backend-ram* backend as an replacement for parameter ``mem``
> +to achieve the same fake NUMA effect or a properly configured
> +*memory-backend-file* backend to actually benefit from NUMA configuratio=
n.
> +In future new machine versions will not accept the option but it will st=
ill
> +work with old machine types. User can check QAPI schema to see if the le=
gacy
> +option is supported by looking at MachineInfo::numa-mem-supported proper=
ty.
> +
> +``-numa`` node (without memory specified) (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Splitting RAM by default between NUMA nodes has the same issues as ``mem=
``
> +parameter described above with the difference that the role of the user =
plays
> +QEMU using implicit generic or board specific splitting rule.
> +Use ``memdev`` with *memory-backend-ram* backend or ``mem`` (if
> +it's supported by used machine type) to define mapping explictly instead.
> +
> +``-mem-path`` fallback to RAM (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''
> +
> +Currently if guest RAM allocation from file pointed by ``mem-path``
> +fails, QEMU falls back to allocating from RAM, which might result
> +in unpredictable behavior since the backing file specified by the user
> +is ignored. In the future, users will be responsible for making sure
> +the backing storage specified with ``-mem-path`` can actually provide
> +the guest RAM configured with ``-m`` and QEMU will fail to start up if
> +RAM allocation is unsuccessful.
> +
> +RISC-V ``-bios`` (since 4.1)
> +''''''''''''''''''''''''''''
> +
> +QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for =
the
> +RISC-V virt machine and sifive_u machine.
> +
> +QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
> +default will change in a future QEMU release, so please prepare now. All=
 users
> +of the virt or sifive_u machine must change their command line usage.
> +
> +QEMU 4.1 has three options, please migrate to one of these three:
> + 1. ``-bios none`` - This is the current default behavior if no -bios op=
tion
> +      is included. QEMU will not automatically load any firmware. It is =
up
> +      to the user to load all the images they need.
> + 2. ``-bios default`` - In a future QEMU release this will become the de=
fault
> +      behaviour if no -bios option is specified. This option will load t=
he
> +      default OpenSBI firmware automatically. The firmware is included w=
ith
> +      the QEMU release and no user interaction is required. All a user n=
eeds
> +      to do is specify the kernel they want to boot with the -kernel opt=
ion
> + 3. ``-bios <file>`` - Tells QEMU to load the specified file as the firm=
wrae.
> +
> +``-tb-size`` option (since 5.0)
> +'''''''''''''''''''''''''''''''
> +
> +QEMU 5.0 introduced an alternative syntax to specify the size of the tra=
nslation
> +block cache, ``-accel tcg,tb-size=3D``.  The new syntax deprecates the
> +previously available ``-tb-size`` option.
> +
> +``-show-cursor`` option (since 5.0)
> +'''''''''''''''''''''''''''''''''''
> +
> +Use ``-display sdl,show-cursor=3Don`` or
> + ``-display gtk,show-cursor=3Don`` instead.
> +
> +QEMU Machine Protocol (QMP) commands
> +------------------------------------
> +
> +``change`` (since 2.5.0)
> +''''''''''''''''''''''''
> +
> +Use ``blockdev-change-medium`` or ``change-vnc-password`` instead.
> +
> +``migrate_set_downtime`` and ``migrate_set_speed`` (since 2.8.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Use ``migrate-set-parameters`` instead.
> +
> +``migrate-set-cache-size`` and ``query-migrate-cache-size`` (since 2.11.=
0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''
> +
> +Use ``migrate-set-parameters`` and ``query-migrate-parameters`` instead.
> +
> +``query-block`` result field ``dirty-bitmaps[i].status`` (since 4.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``status`` field of the ``BlockDirtyInfo`` structure, returned by
> +the query-block command is deprecated. Two new boolean fields,
> +``recording`` and ``busy`` effectively replace it.
> +
> +``query-block`` result field ``dirty-bitmaps`` (Since 4.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
> +the query-block command is itself now deprecated. The ``dirty-bitmaps``
> +field of the ``BlockDeviceInfo`` struct should be used instead, which is=
 the
> +type of the ``inserted`` field in query-block replies, as well as the
> +type of array items in query-named-block-nodes.
> +
> +Since the ``dirty-bitmaps`` field is optionally present in both the old =
and
> +new locations, clients must use introspection to learn where to anticipa=
te
> +the field if/when it does appear in command output.
> +
> +``query-cpus`` (since 2.12.0)
> +'''''''''''''''''''''''''''''
> +
> +The ``query-cpus`` command is replaced by the ``query-cpus-fast`` comman=
d.
> +
> +``query-cpus-fast`` ``arch`` output member (since 3.0.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``arch`` output member of the ``query-cpus-fast`` command is
> +replaced by the ``target`` output member.
> +
> +``cpu-add`` (since 4.0)
> +'''''''''''''''''''''''
> +
> +Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
> +documentation of ``query-hotpluggable-cpus`` for additional
> +details.
> +
> +``query-events`` (since 4.0)
> +''''''''''''''''''''''''''''
> +
> +The ``query-events`` command has been superseded by the more powerful
> +and accurate ``query-qmp-schema`` command.
> +
> +chardev client socket with ``wait`` option (since 4.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Character devices creating sockets in client mode should not specify
> +the 'wait' field, which is only applicable to sockets in server mode
> +
> +Human Monitor Protocol (HMP) commands
> +-------------------------------------
> +
> +The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (since =
3.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''
> +
> +The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
> +'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
> +
> +``cpu-add`` (since 4.0)
> +'''''''''''''''''''''''
> +
> +Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
> +documentation of ``query-hotpluggable-cpus`` for additional details.
> +
> +``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, ``acl_remove``=
 (since 4.0.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''
> +
> +The ``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, and
> +``acl_remove`` commands are deprecated with no replacement. Authorization
> +for VNC should be performed using the pluggable QAuthZ objects.
> +
> +Guest Emulator ISAs
> +-------------------
> +
> +RISC-V ISA privledge specification version 1.09.1 (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The RISC-V ISA privledge specification version 1.09.1 has been deprecate=
d.
> +QEMU supports both the newer version 1.10.0 and the ratified version 1.1=
1.0, these
> +should be used instead of the 1.09.1 version.
> +
> +System emulator CPUS
> +--------------------
> +
> +RISC-V ISA CPUs (since 4.1)
> +'''''''''''''''''''''''''''
> +
> +The RISC-V cpus with the ISA version in the CPU name have been depcreate=
d. The
> +four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.=
9.1`` and
> +``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU `=
`priv_spec``
> +option when using the ``rv32`` or ``rv64`` CPUs.
> +
> +RISC-V ISA CPUs (since 4.1)
> +'''''''''''''''''''''''''''
> +
> +The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-n=
ommu`` and
> +``rv64imacu-nommu`` should no longer be used. Instead the MMU status can=
 be specified
> +via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
> +
> +System emulator devices
> +-----------------------
> +
> +``ide-drive`` (since 4.2)
> +'''''''''''''''''''''''''
> +
> +The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
> +'ide-cd' as appropriate to get an IDE hard disk or CD-ROM as needed.
> +
> +``scsi-disk`` (since 4.2)
> +'''''''''''''''''''''''''
> +
> +The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
> +'scsi-cd' as appropriate to get a SCSI hard disk or CD-ROM as needed.
> +
> +System emulator machines
> +------------------------
> +
> +mips ``r4k`` platform (since 5.0)
> +'''''''''''''''''''''''''''''''''
> +
> +This machine type is very old and unmaintained. Users should use the ``m=
alta``
> +machine type instead.
> +
> +``pc-1.0``, ``pc-1.1``, ``pc-1.2`` and ``pc-1.3`` (since 5.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +These machine types are very old and likely can not be used for live mig=
ration
> +from old QEMU versions anymore. A newer machine type should be used inst=
ead.
> +
> +``spike_v1.9.1`` and ``spike_v1.10`` (since 4.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The version specific Spike machines have been deprecated in favour of the
> +generic ``spike`` machine. If you need to specify an older version of th=
e RISC-V
> +spec you can use the ``-cpu rv64gcsu,priv_spec=3Dv1.9.1`` command line a=
rgument.
> +
> +Device options
> +--------------
> +
> +Emulated device options
> +'''''''''''''''''''''''
> +
> +``-device virtio-blk,scsi=3Don|off`` (since 5.0.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIR=
TIO 1.0
> +and later do not support it because the virtio-scsi device was introduce=
d for
> +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is req=
uired.
> +
> +Note this also applies to ``-device virtio-blk-pci,scsi=3Don|off``, whic=
h is an
> +alias.
> +
> +Block device options
> +''''''''''''''''''''
> +
> +``"backing": ""`` (since 2.12.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In order to prevent QEMU from automatically opening an image's backing
> +chain, use ``"backing": null`` instead.
> +
> +``rbd`` keyvalue pair encoded filenames: ``""`` (since 3.1.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Options for ``rbd`` should be specified according to its runtime options,
> +like other block drivers.  Legacy parsing of keyvalue pair encoded
> +filenames is useful to open images with the old format for backing files;
> +These image files should be updated to use the current format.
> +
> +Example of legacy encoding::
> +
> +  json:{"file.driver":"rbd", "file.filename":"rbd:rbd/name"}
> +
> +The above, converted to the current supported format::
> +
> +  json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
> +
> +Related binaries
> +----------------
> +
> +``qemu-img convert -n -o`` (since 4.2.0)
> +''''''''''''''''''''''''''''''''''''''''
> +
> +All options specified in ``-o`` are image creation options, so
> +they have no effect when used with ``-n`` to skip image creation.
> +Silently ignored options can be confusing, so this combination of
> +options will be made an error in future versions.
> +
> +Backwards compatibility
> +-----------------------
> +
> +Runnability guarantee of CPU models (since 4.1.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Previous versions of QEMU never changed existing CPU models in
> +ways that introduced additional host software or hardware
> +requirements to the VM.  This allowed management software to
> +safely change the machine type of an existing VM without
> +introducing new requirements ("runnability guarantee").  This
> +prevented CPU models from being updated to include CPU
> +vulnerability mitigations, leaving guests vulnerable in the
> +default configuration.
> +
> +The CPU model runnability guarantee won't apply anymore to
> +existing CPU models.  Management software that needs runnability
> +guarantees must resolve the CPU model aliases using te
> +``alias-of`` field returned by the ``query-cpu-definitions`` QMP
> +command.
> +
> +While those guarantees are kept, the return value of
> +``query-cpu-definitions`` will have existing CPU model aliases
> +point to a version that doesn't break runnability guarantees
> +(specifically, version 1 of those CPU models).  In future QEMU
> +versions, aliases will point to newer CPU model versions
> +depending on the machine type, so management software must
> +resolve CPU model aliases before starting a virtual machine.
> +
> +
> +Recently removed features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +What follows is a record of recently removed, formerly deprecated
> +features that serves as a record for users who have encountered
> +trouble after a recent upgrade.
> +
> +QEMU Machine Protocol (QMP) commands
> +------------------------------------
> +
> +``block-dirty-bitmap-add`` "autoload" parameter (since 4.2.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "autoload" parameter has been ignored since 2.12.0. All bitmaps
> +are automatically loaded from qcow2 images.
> +
> +Related binaries
> +----------------
> +
> +``qemu-nbd --partition`` (removed in 5.0.0)
> +'''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``qemu-nbd --partition $digit`` code (also spelled ``-P``)
> +could only handle MBR partitions, and never correctly handled logical
> +partitions beyond partition 5.  Exporting a partition can still be
> +done by utilizing the ``--image-opts`` option with a raw blockdev
> +using the ``offset`` and ``size`` parameters layered on top of
> +any other existing blockdev. For example, if partition 1 is 100MiB
> +long starting at 1MiB, the old command::
> +
> +  qemu-nbd -t -P 1 -f qcow2 file.qcow2
> +
> +can be rewritten as::
> +
> +  qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D100M,file.dri=
ver=3Dqcow2,file.file.driver=3Dfile,file.file.filename=3Dfile.qcow2
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index d655344fffd..f2f29fb6d2c 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -16,3 +16,4 @@ Contents:
>     managed-startup
>     security
>     vfio-ap
> +   deprecated


--=20
Alex Benn=C3=A9e

