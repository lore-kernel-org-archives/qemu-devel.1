Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ADEC4BA09
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6BF2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htA/zjX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6BF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6klR-0004PN-ML
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 19:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6kkn-0003wy-FQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6kkj-0002YR-1W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:40:45 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6kki-0002Pq-GK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:40:40 -0500
Received: by mail-lf1-x143.google.com with SMTP id y17so599381lfe.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 16:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W5BFp0WixJhbNFNMY1fHwZlCFzd18jhtp238PoLFyW4=;
 b=htA/zjX/XE5H2aXAh+EiBvweyJHVtOgMeRCchLxOexnSudsYJex1xI1YqP3u+5L6um
 z1Nx9qF4ykBMjSOYQFhEW7EkNLBI7po1q/F2B4+mT3Avdj7g4eQ8mGxxOjmOwyXqi0gL
 XaDXQ3X9cH3XjjwaguLpnSSMBlX078OV+JrR9+TJGHXaXQTHjUs4lX5heevrHeP02enx
 W8lSgzcyKvYAfLIHW1J1BP1Lmf9QLf0RFK1fqoSCBs0kRe39DxBmRPwlDFjIcqtk/CEh
 o01ZmGNjYJWPNFF+fuI1FH/Z/oE/ramar0zB9FzrKtB0j6+6Un3wq3xwCcJpqR9KkwMK
 qJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5BFp0WixJhbNFNMY1fHwZlCFzd18jhtp238PoLFyW4=;
 b=D1SM+GHwleOXdMLw31cB+7VtSITvbDS5wCN4WpQkQ2FykQsKrVpiT5Qdy7yLNqlaH2
 VNt6Q1j8vI1oBcB6wHXhzwenrH/Cvo0G47UxE0ZjclDIflPUf1IH+W6epprzjrj6bdq0
 xapaaiwEU4qpy4Vm6p5iF+Bw2KOnYmayoFolx1k8l3V+RLK2CRBIExi3jc3Omlfrh4C0
 KqkIBpz/sv0mP/llkr7wHa9Tt/k41Mcmz4kt6Rcl2og/klA8pbycVl+OaL4kf7TSyFvo
 zEEJStaazAwksGVnuCgShasVelVhdArmJy0bM2bDO2V5e6u7TRPmKC9p2XwfqcHu+6Wb
 mi4g==
X-Gm-Message-State: APjAAAVPv9Ny0TYVbNG3CEVxjy18adkL0XWTG8ZzYl6wUfAqY6ePa1i/
 BQyJqEncmw+zqWo6vaZDRfwDyH3KnPn6IDHnQ1E=
X-Google-Smtp-Source: APXvYqz+IuroHpNm0c+5tab9wCF4oAEfBivBFgiJbjCsdTIRn0N1yATk/r7AT0alqsqRqGEUyFBtCJLZXpJuSegiSMo=
X-Received: by 2002:a19:4a:: with SMTP id 71mr827075lfa.50.1582677637261; Tue,
 25 Feb 2020 16:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <20200225154121.21116-5-peter.maydell@linaro.org>
In-Reply-To: <20200225154121.21116-5-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Feb 2020 16:33:00 -0800
Message-ID: <CAKmqyKMotAQwd9xfzonUnXAyb9pFj7R-Rebeoxo7n9NfMmYKjw@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: Convert qemu-deprecated.texi to rST
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 7:41 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Convert the documentation of deprecated features to rST.
>
> We put the whole of this document into the system manual, though
> technically a few parts of it apply to qemu-img or qemu-nbd which are
> otherwise documented in tools/.
>
> We only make formatting fixes, except for one use of 'appendix' which
> we change to 'section' because this isn't an appendix in the Sphinx
> manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  Makefile                   |   2 +-
>  MAINTAINERS                |   2 +-
>  docs/system/deprecated.rst | 446 +++++++++++++++++++++++++++++++++++++
>  docs/system/index.rst      |   1 +
>  qemu-deprecated.texi       | 386 --------------------------------
>  qemu-doc.texi              |   4 -
>  6 files changed, 449 insertions(+), 392 deletions(-)
>  create mode 100644 docs/system/deprecated.rst
>  delete mode 100644 qemu-deprecated.texi
>
> diff --git a/Makefile b/Makefile
> index 28749d20401..ec4a4be8355 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1115,7 +1115,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>         qemu-options.texi \
>         qemu-option-trace.texi \
> -       qemu-deprecated.texi qemu-monitor.texi \
> +       qemu-monitor.texi \
>         qemu-monitor-info.texi \
>         docs/qemu-cpu-models.texi
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 195dd58cac1..546f2b83017 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2787,7 +2787,7 @@ F: contrib/gitdm/*
>
>  Incompatible changes
>  R: libvir-list@redhat.com
> -F: qemu-deprecated.texi
> +F: docs/system/deprecated.rst
>
>  Build System
>  ------------
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> new file mode 100644
> index 00000000000..1eaa559079b
> --- /dev/null
> +++ b/docs/system/deprecated.rst
> @@ -0,0 +1,446 @@
> +Deprecated features
> +===================
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
> +``-machine enforce-config-section=on|off`` (since 3.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``enforce-config-section`` parameter is replaced by the
> +``-global migration.send-configuration={on|off}`` option.
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
> +enabled via the ``-machine usb=on`` argument.
> +
> +``-drive file=json:{...{'driver':'file'}}`` (since 3.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The 'file' driver for drives is no longer appropriate for character or host
> +devices and will only accept regular files (S_IFREG). The correct driver
> +for these file types is 'host_cdrom' or 'host_device' as appropriate.
> +
> +``-net ...,name=``\ *name* (since 3.1)
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
> +However, historically it was possible to start QEMU with an incorrect topology
> +where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies will be removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +*sockets* * *cores* * *threads* = *maxcpus*.
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
> +Creating sound card devices and vnc without ``audiodev=`` property (since 4.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +When not using the deprecated legacy audio config, each sound card
> +should specify an ``audiodev=`` property.  Additionally, when using
> +vnc, you should specify an ``audiodev=`` propery if you plan to
> +transmit audio through the VNC protocol.
> +
> +``-mon ...,control=readline,pretty=on|off`` (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``pretty=on|off`` switch has no effect for HMP monitors, but is
> +silently ignored. Using the switch with HMP monitors will become an
> +error in the future.
> +
> +``-realtime`` (since 4.1)
> +'''''''''''''''''''''''''
> +
> +The ``-realtime mlock=on|off`` argument has been replaced by the
> +``-overcommit mem-lock=on|off`` argument.
> +
> +``-numa node,mem=``\ *size* (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''
> +
> +The parameter ``mem`` of ``-numa node`` is used to assign a part of
> +guest RAM to a NUMA node. But when using it, it's impossible to manage specified
> +RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
> +so guest end-ups with the fake NUMA configuration with suboptiomal performance.
> +However since 2014 there is an alternative way to assign RAM to a NUMA node
> +using parameter ``memdev``, which does the same as ``mem`` and adds
> +means to actualy manage node RAM on the host side. Use parameter ``memdev``
> +with *memory-backend-ram* backend as an replacement for parameter ``mem``
> +to achieve the same fake NUMA effect or a properly configured
> +*memory-backend-file* backend to actually benefit from NUMA configuration.
> +In future new machine versions will not accept the option but it will still
> +work with old machine types. User can check QAPI schema to see if the legacy
> +option is supported by looking at MachineInfo::numa-mem-supported property.
> +
> +``-numa`` node (without memory specified) (since 4.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Splitting RAM by default between NUMA nodes has the same issues as ``mem``
> +parameter described above with the difference that the role of the user plays
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
> +QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for the
> +RISC-V virt machine and sifive_u machine.
> +
> +QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
> +default will change in a future QEMU release, so please prepare now. All users
> +of the virt or sifive_u machine must change their command line usage.
> +
> +QEMU 4.1 has three options, please migrate to one of these three:
> + 1. ``-bios none`` - This is the current default behavior if no -bios option
> +      is included. QEMU will not automatically load any firmware. It is up
> +      to the user to load all the images they need.
> + 2. ``-bios default`` - In a future QEMU release this will become the default
> +      behaviour if no -bios option is specified. This option will load the
> +      default OpenSBI firmware automatically. The firmware is included with
> +      the QEMU release and no user interaction is required. All a user needs
> +      to do is specify the kernel they want to boot with the -kernel option
> + 3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
> +
> +``-tb-size`` option (since 5.0)
> +'''''''''''''''''''''''''''''''
> +
> +QEMU 5.0 introduced an alternative syntax to specify the size of the translation
> +block cache, ``-accel tcg,tb-size=``.  The new syntax deprecates the
> +previously available ``-tb-size`` option.
> +
> +``-show-cursor`` option (since 5.0)
> +'''''''''''''''''''''''''''''''''''
> +
> +Use ``-display sdl,show-cursor=on`` or
> + ``-display gtk,show-cursor=on`` instead.
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
> +``migrate-set-cache-size`` and ``query-migrate-cache-size`` (since 2.11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
> +field of the ``BlockDeviceInfo`` struct should be used instead, which is the
> +type of the ``inserted`` field in query-block replies, as well as the
> +type of array items in query-named-block-nodes.
> +
> +Since the ``dirty-bitmaps`` field is optionally present in both the old and
> +new locations, clients must use introspection to learn where to anticipate
> +the field if/when it does appear in command output.
> +
> +``query-cpus`` (since 2.12.0)
> +'''''''''''''''''''''''''''''
> +
> +The ``query-cpus`` command is replaced by the ``query-cpus-fast`` command.
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
> +The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (since 3.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
> +``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, ``acl_remove`` (since 4.0.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
> +The RISC-V ISA privledge specification version 1.09.1 has been deprecated.
> +QEMU supports both the newer version 1.10.0 and the ratified version 1.11.0, these
> +should be used instead of the 1.09.1 version.
> +
> +System emulator CPUS
> +--------------------
> +
> +RISC-V ISA CPUs (since 4.1)
> +'''''''''''''''''''''''''''
> +
> +The RISC-V cpus with the ISA version in the CPU name have been depcreated. The
> +four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
> +``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
> +option when using the ``rv32`` or ``rv64`` CPUs.
> +
> +RISC-V ISA CPUs (since 4.1)
> +'''''''''''''''''''''''''''
> +
> +The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nommu`` and
> +``rv64imacu-nommu`` should no longer be used. Instead the MMU status can be specified
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
> +This machine type is very old and unmaintained. Users should use the ``malta``
> +machine type instead.
> +
> +``pc-1.0``, ``pc-1.1``, ``pc-1.2`` and ``pc-1.3`` (since 5.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +These machine types are very old and likely can not be used for live migration
> +from old QEMU versions anymore. A newer machine type should be used instead.
> +
> +``spike_v1.9.1`` and ``spike_v1.10`` (since 4.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The version specific Spike machines have been deprecated in favour of the
> +generic ``spike`` machine. If you need to specify an older version of the RISC-V
> +spec you can use the ``-cpu rv64gcsu,priv_spec=v1.9.1`` command line argument.
> +
> +Device options
> +--------------
> +
> +Emulated device options
> +'''''''''''''''''''''''
> +
> +``-device virtio-blk,scsi=on|off`` (since 5.0.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
> +and later do not support it because the virtio-scsi device was introduced for
> +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
> +
> +Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which is an
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
> +=========================
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
> +  qemu-nbd -t --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.file.driver=file,file.file.filename=file.qcow2
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 887bef92f40..7d09abca954 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -14,6 +14,7 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>
> +   deprecated
>     managed-startup
>     qemu-block-drivers
>     security
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> deleted file mode 100644
> index 0671c26c806..00000000000
> --- a/qemu-deprecated.texi
> +++ /dev/null
> @@ -1,386 +0,0 @@
> -@node Deprecated features
> -@appendix Deprecated features
> -
> -In general features are intended to be supported indefinitely once
> -introduced into QEMU. In the event that a feature needs to be removed,
> -it will be listed in this appendix. The feature will remain functional
> -for 2 releases prior to actual removal. Deprecated features may also
> -generate warnings on the console when QEMU starts up, or if activated
> -via a monitor command, however, this is not a mandatory requirement.
> -
> -Prior to the 2.10.0 release there was no official policy on how
> -long features would be deprecated prior to their removal, nor
> -any documented list of which features were deprecated. Thus
> -any features deprecated prior to 2.10.0 will be treated as if
> -they were first deprecated in the 2.10.0 release.
> -
> -What follows is a list of all features currently marked as
> -deprecated.
> -
> -@section System emulator command line arguments
> -
> -@subsection -machine enforce-config-section=on|off (since 3.1)
> -
> -The @option{enforce-config-section} parameter is replaced by the
> -@option{-global migration.send-configuration=@var{on|off}} option.
> -
> -@subsection -no-kvm (since 1.3.0)
> -
> -The ``-no-kvm'' argument is now a synonym for setting ``-accel tcg''.
> -
> -@subsection -usbdevice (since 2.10.0)
> -
> -The ``-usbdevice DEV'' argument is now a synonym for setting
> -the ``-device usb-DEV'' argument instead. The deprecated syntax
> -would automatically enable USB support on the machine type.
> -If using the new syntax, USB support must be explicitly
> -enabled via the ``-machine usb=on'' argument.
> -
> -@subsection -drive file=json:@{...@{'driver':'file'@}@} (since 3.0)
> -
> -The 'file' driver for drives is no longer appropriate for character or host
> -devices and will only accept regular files (S_IFREG). The correct driver
> -for these file types is 'host_cdrom' or 'host_device' as appropriate.
> -
> -@subsection -net ...,name=@var{name} (since 3.1)
> -
> -The @option{name} parameter of the @option{-net} option is a synonym
> -for the @option{id} parameter, which should now be used instead.
> -
> -@subsection -smp (invalid topologies) (since 3.1)
> -
> -CPU topology properties should describe whole machine topology including
> -possible CPUs.
> -
> -However, historically it was possible to start QEMU with an incorrect topology
> -where @math{@var{n} <= @var{sockets} * @var{cores} * @var{threads} < @var{maxcpus}},
> -which could lead to an incorrect topology enumeration by the guest.
> -Support for invalid topologies will be removed, the user must ensure
> -topologies described with -smp include all possible cpus, i.e.
> -  @math{@var{sockets} * @var{cores} * @var{threads} = @var{maxcpus}}.
> -
> -@subsection -vnc acl (since 4.0.0)
> -
> -The @code{acl} option to the @code{-vnc} argument has been replaced
> -by the @code{tls-authz} and @code{sasl-authz} options.
> -
> -@subsection QEMU_AUDIO_ environment variables and -audio-help (since 4.0)
> -
> -The ``-audiodev'' argument is now the preferred way to specify audio
> -backend settings instead of environment variables.  To ease migration to
> -the new format, the ``-audiodev-help'' option can be used to convert
> -the current values of the environment variables to ``-audiodev'' options.
> -
> -@subsection Creating sound card devices and vnc without audiodev= property (since 4.2)
> -
> -When not using the deprecated legacy audio config, each sound card
> -should specify an @code{audiodev=} property.  Additionally, when using
> -vnc, you should specify an @code{audiodev=} propery if you plan to
> -transmit audio through the VNC protocol.
> -
> -@subsection -mon ...,control=readline,pretty=on|off (since 4.1)
> -
> -The @code{pretty=on|off} switch has no effect for HMP monitors, but is
> -silently ignored. Using the switch with HMP monitors will become an
> -error in the future.
> -
> -@subsection -realtime (since 4.1)
> -
> -The @code{-realtime mlock=on|off} argument has been replaced by the
> -@code{-overcommit mem-lock=on|off} argument.
> -
> -@subsection -numa node,mem=@var{size} (since 4.1)
> -
> -The parameter @option{mem} of @option{-numa node} is used to assign a part of
> -guest RAM to a NUMA node. But when using it, it's impossible to manage specified
> -RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
> -so guest end-ups with the fake NUMA configuration with suboptiomal performance.
> -However since 2014 there is an alternative way to assign RAM to a NUMA node
> -using parameter @option{memdev}, which does the same as @option{mem} and adds
> -means to actualy manage node RAM on the host side. Use parameter @option{memdev}
> -with @var{memory-backend-ram} backend as an replacement for parameter @option{mem}
> -to achieve the same fake NUMA effect or a properly configured
> -@var{memory-backend-file} backend to actually benefit from NUMA configuration.
> -In future new machine versions will not accept the option but it will still
> -work with old machine types. User can check QAPI schema to see if the legacy
> -option is supported by looking at MachineInfo::numa-mem-supported property.
> -
> -@subsection -numa node (without memory specified) (since 4.1)
> -
> -Splitting RAM by default between NUMA nodes has the same issues as @option{mem}
> -parameter described above with the difference that the role of the user plays
> -QEMU using implicit generic or board specific splitting rule.
> -Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} (if
> -it's supported by used machine type) to define mapping explictly instead.
> -
> -@subsection -mem-path fallback to RAM (since 4.1)
> -Currently if guest RAM allocation from file pointed by @option{mem-path}
> -fails, QEMU falls back to allocating from RAM, which might result
> -in unpredictable behavior since the backing file specified by the user
> -is ignored. In the future, users will be responsible for making sure
> -the backing storage specified with @option{-mem-path} can actually provide
> -the guest RAM configured with @option{-m} and QEMU will fail to start up if
> -RAM allocation is unsuccessful.
> -
> -@subsection RISC-V -bios (since 4.1)
> -
> -QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for the
> -RISC-V virt machine and sifive_u machine.
> -
> -QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
> -default will change in a future QEMU release, so please prepare now. All users
> -of the virt or sifive_u machine must change their command line usage.
> -
> -QEMU 4.1 has three options, please migrate to one of these three:
> - 1. ``-bios none`` - This is the current default behavior if no -bios option
> -      is included. QEMU will not automatically load any firmware. It is up
> -      to the user to load all the images they need.
> - 2. ``-bios default`` - In a future QEMU release this will become the default
> -      behaviour if no -bios option is specified. This option will load the
> -      default OpenSBI firmware automatically. The firmware is included with
> -      the QEMU release and no user interaction is required. All a user needs
> -      to do is specify the kernel they want to boot with the -kernel option
> - 3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
> -
> -@subsection -tb-size option (since 5.0)
> -
> -QEMU 5.0 introduced an alternative syntax to specify the size of the translation
> -block cache, @option{-accel tcg,tb-size=}.  The new syntax deprecates the
> -previously available @option{-tb-size} option.
> -
> -@subsection -show-cursor option (since 5.0)
> -
> -Use @option{-display sdl,show-cursor=on} or
> - @option{-display gtk,show-cursor=on} instead.
> -
> -@section QEMU Machine Protocol (QMP) commands
> -
> -@subsection change (since 2.5.0)
> -
> -Use ``blockdev-change-medium'' or ``change-vnc-password'' instead.
> -
> -@subsection migrate_set_downtime and migrate_set_speed (since 2.8.0)
> -
> -Use ``migrate-set-parameters'' instead.
> -
> -@subsection migrate-set-cache-size and query-migrate-cache-size (since 2.11.0)
> -
> -Use ``migrate-set-parameters'' and ``query-migrate-parameters'' instead.
> -
> -@subsection query-block result field dirty-bitmaps[i].status (since 4.0)
> -
> -The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
> -the query-block command is deprecated. Two new boolean fields,
> -``recording'' and ``busy'' effectively replace it.
> -
> -@subsection query-block result field dirty-bitmaps (Since 4.2)
> -
> -The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
> -the query-block command is itself now deprecated. The ``dirty-bitmaps``
> -field of the ``BlockDeviceInfo`` struct should be used instead, which is the
> -type of the ``inserted`` field in query-block replies, as well as the
> -type of array items in query-named-block-nodes.
> -
> -Since the ``dirty-bitmaps`` field is optionally present in both the old and
> -new locations, clients must use introspection to learn where to anticipate
> -the field if/when it does appear in command output.
> -
> -@subsection query-cpus (since 2.12.0)
> -
> -The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
> -
> -@subsection query-cpus-fast "arch" output member (since 3.0.0)
> -
> -The ``arch'' output member of the ``query-cpus-fast'' command is
> -replaced by the ``target'' output member.
> -
> -@subsection cpu-add (since 4.0)
> -
> -Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> -documentation of ``query-hotpluggable-cpus'' for additional
> -details.
> -
> -@subsection query-events (since 4.0)
> -
> -The ``query-events'' command has been superseded by the more powerful
> -and accurate ``query-qmp-schema'' command.
> -
> -@subsection chardev client socket with 'wait' option (since 4.0)
> -
> -Character devices creating sockets in client mode should not specify
> -the 'wait' field, which is only applicable to sockets in server mode
> -
> -@section Human Monitor Protocol (HMP) commands
> -
> -@subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
> -
> -The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
> -'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
> -
> -@subsection cpu-add (since 4.0)
> -
> -Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> -documentation of ``query-hotpluggable-cpus'' for additional details.
> -
> -@subsection acl_show, acl_reset, acl_policy, acl_add, acl_remove (since 4.0.0)
> -
> -The ``acl_show'', ``acl_reset'', ``acl_policy'', ``acl_add'', and
> -``acl_remove'' commands are deprecated with no replacement. Authorization
> -for VNC should be performed using the pluggable QAuthZ objects.
> -
> -@section Guest Emulator ISAs
> -
> -@subsection RISC-V ISA privledge specification version 1.09.1 (since 4.1)
> -
> -The RISC-V ISA privledge specification version 1.09.1 has been deprecated.
> -QEMU supports both the newer version 1.10.0 and the ratified version 1.11.0, these
> -should be used instead of the 1.09.1 version.
> -
> -@section System emulator CPUS
> -
> -@subsection RISC-V ISA CPUs (since 4.1)
> -
> -The RISC-V cpus with the ISA version in the CPU name have been depcreated. The
> -four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
> -``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
> -option when using the ``rv32`` or ``rv64`` CPUs.
> -
> -@subsection RISC-V ISA CPUs (since 4.1)
> -
> -The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nommu`` and
> -``rv64imacu-nommu`` should no longer be used. Instead the MMU status can be specified
> -via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
> -
> -@section System emulator devices
> -
> -@subsection ide-drive (since 4.2)
> -
> -The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
> -'ide-cd' as appropriate to get an IDE hard disk or CD-ROM as needed.
> -
> -@subsection scsi-disk (since 4.2)
> -
> -The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
> -'scsi-cd' as appropriate to get a SCSI hard disk or CD-ROM as needed.
> -
> -@section System emulator machines
> -
> -@subsection mips r4k platform (since 5.0)
> -
> -This machine type is very old and unmaintained. Users should use the 'malta'
> -machine type instead.
> -
> -@subsection pc-1.0, pc-1.1, pc-1.2 and pc-1.3 (since 5.0)
> -
> -These machine types are very old and likely can not be used for live migration
> -from old QEMU versions anymore. A newer machine type should be used instead.
> -
> -@subsection spike_v1.9.1 and spike_v1.10 (since 4.1)
> -
> -The version specific Spike machines have been deprecated in favour of the
> -generic ``spike`` machine. If you need to specify an older version of the RISC-V
> -spec you can use the ``-cpu rv64gcsu,priv_spec=v1.9.1`` command line argument.
> -
> -@section Device options
> -
> -@subsection Emulated device options
> -
> -@subsubsection -device virtio-blk,scsi=on|off (since 5.0.0)
> -
> -The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
> -and later do not support it because the virtio-scsi device was introduced for
> -full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
> -
> -Note this also applies to ``-device virtio-blk-pci,scsi=on|off'', which is an
> -alias.
> -
> -@subsection Block device options
> -
> -@subsubsection "backing": "" (since 2.12.0)
> -
> -In order to prevent QEMU from automatically opening an image's backing
> -chain, use ``"backing": null'' instead.
> -
> -@subsubsection rbd keyvalue pair encoded filenames: "" (since 3.1.0)
> -
> -Options for ``rbd'' should be specified according to its runtime options,
> -like other block drivers.  Legacy parsing of keyvalue pair encoded
> -filenames is useful to open images with the old format for backing files;
> -These image files should be updated to use the current format.
> -
> -Example of legacy encoding:
> -
> -@code{json:@{"file.driver":"rbd", "file.filename":"rbd:rbd/name"@}}
> -
> -The above, converted to the current supported format:
> -
> -@code{json:@{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"@}}
> -
> -@section Related binaries
> -
> -@subsection qemu-img convert -n -o (since 4.2.0)
> -
> -All options specified in @option{-o} are image creation options, so
> -they have no effect when used with @option{-n} to skip image creation.
> -Silently ignored options can be confusing, so this combination of
> -options will be made an error in future versions.
> -
> -@section Backwards compatibility
> -
> -@subsection Runnability guarantee of CPU models (since 4.1.0)
> -
> -Previous versions of QEMU never changed existing CPU models in
> -ways that introduced additional host software or hardware
> -requirements to the VM.  This allowed management software to
> -safely change the machine type of an existing VM without
> -introducing new requirements ("runnability guarantee").  This
> -prevented CPU models from being updated to include CPU
> -vulnerability mitigations, leaving guests vulnerable in the
> -default configuration.
> -
> -The CPU model runnability guarantee won't apply anymore to
> -existing CPU models.  Management software that needs runnability
> -guarantees must resolve the CPU model aliases using te
> -``alias-of'' field returned by the ``query-cpu-definitions'' QMP
> -command.
> -
> -While those guarantees are kept, the return value of
> -``query-cpu-definitions'' will have existing CPU model aliases
> -point to a version that doesn't break runnability guarantees
> -(specifically, version 1 of those CPU models).  In future QEMU
> -versions, aliases will point to newer CPU model versions
> -depending on the machine type, so management software must
> -resolve CPU model aliases before starting a virtual machine.
> -
> -
> -@node Recently removed features
> -@appendix Recently removed features
> -
> -What follows is a record of recently removed, formerly deprecated
> -features that serves as a record for users who have encountered
> -trouble after a recent upgrade.
> -
> -@section QEMU Machine Protocol (QMP) commands
> -
> -@subsection block-dirty-bitmap-add "autoload" parameter (since 4.2.0)
> -
> -The "autoload" parameter has been ignored since 2.12.0. All bitmaps
> -are automatically loaded from qcow2 images.
> -
> -@section Related binaries
> -
> -@subsection qemu-nbd --partition (removed in 5.0.0)
> -
> -The ``qemu-nbd --partition $digit'' code (also spelled @option{-P})
> -could only handle MBR partitions, and never correctly handled logical
> -partitions beyond partition 5.  Exporting a partition can still be
> -done by utilizing the @option{--image-opts} option with a raw blockdev
> -using the @code{offset} and @code{size} parameters layered on top of
> -any other existing blockdev. For example, if partition 1 is 100MiB
> -long starting at 1MiB, the old command:
> -
> -@code{qemu-nbd -t -P 1 -f qcow2 file.qcow2}
> -
> -can be rewritten as:
> -
> -@code{qemu-nbd -t --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.file.driver=file,file.file.filename=file.qcow2}
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 7798e072a1c..6bb1fd54c03 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -40,8 +40,6 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU User space emulator::
>  * System requirements::
> -* Deprecated features::
> -* Recently removed features::
>  * Supported build platforms::
>  * License::
>  * Index::
> @@ -2834,8 +2832,6 @@ added with Linux 4.5 which is supported by the major distros. And even
>  if RHEL7 has kernel 3.10, KVM there has the required functionality there
>  to make it close to a 4.5 or newer kernel.
>
> -@include qemu-deprecated.texi
> -
>  @node Supported build platforms
>  @appendix Supported build platforms
>
> --
> 2.20.1
>
>

