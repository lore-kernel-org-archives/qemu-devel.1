Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA6C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721E72173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKLH9kF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721E72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k5G-000755-Lw
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k46-0005fG-5d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k3v-0002IV-ND
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:20:54 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8k3u-0002I5-Qg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:20:43 -0500
Received: by mail-wm1-x341.google.com with SMTP id a132so940126wme.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rf+I0rjEhYdd2LDbFlWFdhFoeclg1t1Ov3PbcB4mWi4=;
 b=JKLH9kF+CQzw2x1sTgmj6EKa6cslBeMy8Ub95fotJTkTmweqaAVNBGjyjC0wC+/pxw
 Esz7S5/x/CTsP1d1Nxufp3I9n5XgmJ1YcyV2cO3plibELyw74CI+d+jbId9Fiaaj5Apn
 PKBQmKy+KbVX7Z/4d+OkJonw4yEh0x/oYdfiOpITEEFl7htPecQXGwczFDiiS6VSPSFo
 mmgQzJ+goZbPfZr0oRZO3N0X+ReFi/b8HXr0zQtd2jdLUpD4J9Cep84/ZDksatbMuXqn
 xXq6iwbE/R3cmNRR5MMrBTOBvLOvbKtrgRIlLJsoYrx8y3Q2OKx5cJnkz8t7lQXokeGR
 6cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rf+I0rjEhYdd2LDbFlWFdhFoeclg1t1Ov3PbcB4mWi4=;
 b=lj59HA4hAhwhmUEEvtKi4I9pKrn4cD2aPn2k3zPGswtSc6lRNa1cgsK2IOrwBjTUeP
 /H2agRi+f7nMlPLTiEZnlhD4PqSsf+GSe7JTh4dXSsYHSI7eLddfxIC/sZ/arGGuNzhA
 CG65Q3b/9d9OZXTaZ6y7ruCN3IrJ94RvLabJYGsSCfWvsMPc4StjF8tnQNASCNhL4xFC
 fTWHg7HBof3RbyosLe7Qfit40bMcpshfCxYHOJqNkb8gyf3bE/w2PFVlEjanh2qKfvdI
 5S3WIubtLVBYIFVYrU/Icnqagy5oo2sNduIdZX5hAcImKAtu47D/izVWdNSTfBhA7nFT
 FvWQ==
X-Gm-Message-State: APjAAAVi2XrSqTRtijK+hZqw+DHt3AUnE65PDaD6bWWSfIHixOQIYABL
 x+JXOjEsT3Y9yQ4Jb/0QgAPXVA==
X-Google-Smtp-Source: APXvYqw5MN7kUlasCDDLQVZe6jMMJs92RnoBkTQ1eA2v2BdiFLyNzAghuDUj6c8cY7ugB3nmX9toaA==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr18589995wme.23.1583151638717; 
 Mon, 02 Mar 2020 04:20:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q125sm17443988wme.19.2020.03.02.04.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:20:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A8D41FF87;
 Mon,  2 Mar 2020 12:20:36 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-27-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 26/33] qemu-options.hx: Add rST documentation fragments
In-reply-to: <20200228153619.9906-27-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:20:35 +0000
Message-ID: <87eeub9cdo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add the rST versions of the documentation fragments to qemu-options.hx.
>
> This is entirely autogenerated using scripts/hxtool-conv.pl.
> The result is not quite valid rST in all places; the following
> commit will have the manual adjustments needed.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  qemu-options.hx | 3999 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 3999 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3b230a17164..043e425b61e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -18,6 +18,10 @@ STEXI
>  @findex -h
>  Display help and exit
>  ETEXI
> +SRST
> +``-h``
> +    Display help and exit
> +ERST
>=20=20
>  DEF("version", 0, QEMU_OPTION_version,
>      "-version        display version information and exit\n", QEMU_ARCH_=
ALL)
> @@ -26,6 +30,10 @@ STEXI
>  @findex -version
>  Display version information and exit
>  ETEXI
> +SRST
> +``-version``
> +    Display version information and exit
> +ERST
>=20=20
>  DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "-machine [type=3D]name[,prop[=3Dvalue][,...]]\n"
> @@ -100,6 +108,73 @@ Enables or disables ACPI Heterogeneous Memory Attrib=
ute Table (HMAT) support.
>  The default is off.
>  @end table
>  ETEXI
> +SRST
> +``-machine [type=3D]name[,prop=3Dvalue[,...]]``
> +    Select the emulated machine by name. Use ``-machine help`` to list
> +    available machines.
> +
> +    For architectures which aim to support live migration compatibility
> +    across releases, each release will introduce a new versioned machine
> +    type. For example, the 2.8.0 release introduced machine types
> +    "pc-i440fx-2.8" and "pc-q35-2.8" for the x86\_64/i686 architectures.
> +
> +    To allow live migration of guests from QEMU version 2.8.0, to QEMU
> +    version 2.9.0, the 2.9.0 version must support the "pc-i440fx-2.8"
> +    and "pc-q35-2.8" machines too. To allow users live migrating VMs to
> +    skip multiple intermediate releases when upgrading, new releases of
> +    QEMU will support machine types from many previous versions.
> +
> +    Supported machine properties are:
> +
> +    ``accel=3Daccels1[:accels2[:...]]``
> +        This is used to enable an accelerator. Depending on the target
> +        architecture, kvm, xen, hax, hvf, whpx or tcg can be available.
> +        By default, tcg is used. If there is more than one accelerator
> +        specified, the next one is used if the previous one fails to
> +        initialize.
> +
> +    ``vmport=3Don|off|auto``
> +        Enables emulation of VMWare IO port, for vmmouse etc. auto says
> +        to select the value based on accel. For accel=3Dxen the default =
is
> +        off otherwise the default is on.
> +
> +    ``dump-guest-core=3Don|off``
> +        Include guest memory in a core dump. The default is on.
> +
> +    ``mem-merge=3Don|off``
> +        Enables or disables memory merge support. This feature, when
> +        supported by the host, de-duplicates identical memory pages
> +        among VMs instances (enabled by default).
> +
> +    ``aes-key-wrap=3Don|off``
> +        Enables or disables AES key wrapping support on s390-ccw hosts.
> +        This feature controls whether AES wrapping keys will be created
> +        to allow execution of AES cryptographic functions. The default
> +        is on.
> +
> +    ``dea-key-wrap=3Don|off``
> +        Enables or disables DEA key wrapping support on s390-ccw hosts.
> +        This feature controls whether DEA wrapping keys will be created
> +        to allow execution of DEA cryptographic functions. The default
> +        is on.
> +
> +    ``nvdimm=3Don|off``
> +        Enables or disables NVDIMM support. The default is off.
> +
> +    ``enforce-config-section=3Don|off``
> +        If ``enforce-config-section`` is set to on, force migration code
> +        to send configuration section even if the machine-type sets the
> +        ``migration.send-configuration`` property to off. NOTE: this
> +        parameter is deprecated. Please use ``-global``
> +        ``migration.send-configuration``\ =3Don\|off instead.
> +
> +    ``memory-encryption=3D``
> +        Memory encryption object to use. The default is none.
> +
> +    ``hmat=3Don|off``
> +        Enables or disables ACPI Heterogeneous Memory Attribute Table
> +        (HMAT) support. The default is off.
> +ERST
>=20=20
>  HXCOMM Deprecated by -machine
>  DEF("M", HAS_ARG, QEMU_OPTION_M, "", QEMU_ARCH_ALL)
> @@ -111,6 +186,11 @@ STEXI
>  @findex -cpu
>  Select CPU model (@code{-cpu help} for list and additional feature selec=
tion)
>  ETEXI
> +SRST
> +``-cpu model``
> +    Select CPU model (``-cpu help`` for list and additional feature
> +    selection)
> +ERST
>=20=20
>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>      "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
> @@ -147,6 +227,40 @@ is to enable multi-threading where both the back-end=
 and front-ends support it a
>  no incompatible TCG features have been enabled (e.g. icount/replay).
>  @end table
>  ETEXI
> +SRST
> +``-accel name[,prop=3Dvalue[,...]]``
> +    This is used to enable an accelerator. Depending on the target
> +    architecture, kvm, xen, hax, hvf, whpx or tcg can be available. By
> +    default, tcg is used. If there is more than one accelerator
> +    specified, the next one is used if the previous one fails to
> +    initialize.
> +
> +    ``igd-passthru=3Don|off``
> +        When Xen is in use, this option controls whether Intel
> +        integrated graphics devices can be passed through to the guest
> +        (default=3Doff)
> +
> +    ``kernel-irqchip=3Don|off|split``
> +        Controls KVM in-kernel irqchip support. The default is full
> +        acceleration of the interrupt controllers. On x86, split irqchip
> +        reduces the kernel attack surface, at a performance cost for
> +        non-MSI interrupts. Disabling the in-kernel irqchip completely
> +        is not recommended except for debugging purposes.
> +
> +    ``kvm-shadow-mem=3Dsize``
> +        Defines the size of the KVM shadow MMU.
> +
> +    ``tb-size=3Dn``
> +        Controls the size (in MiB) of the TCG translation block cache.
> +
> +    ``thread=3Dsingle|multi``
> +        Controls number of TCG threads. When the TCG is multi-threaded
> +        there will be one thread per vCPU therefor taking advantage of
> +        additional host cores. The default is to enable multi-threading
> +        where both the back-end and front-ends support it and no
> +        incompatible TCG features have been enabled (e.g.
> +        icount/replay).
> +ERST
>=20=20
>  DEF("smp", HAS_ARG, QEMU_OPTION_smp,
>      "-smp [cpus=3D]n[,maxcpus=3Dcpus][,cores=3Dcores][,threads=3Dthreads=
][,dies=3Ddies][,sockets=3Dsockets]\n"
> @@ -170,6 +284,17 @@ per cores, the number of @var{dies} per packages and=
 the total number of
>  If any on the three values is given, the total number of CPUs @var{n} ca=
n be omitted.
>  @var{maxcpus} specifies the maximum number of hotpluggable CPUs.
>  ETEXI
> +SRST
> +``-smp [cpus=3D]n[,cores=3Dcores][,threads=3Dthreads][,dies=3Ddies][,soc=
kets=3Dsockets][,maxcpus=3Dmaxcpus]``
> +    Simulate an SMP system with n CPUs. On the PC target, up to 255 CPUs
> +    are supported. On Sparc32 target, Linux limits the number of usable
> +    CPUs to 4. For the PC target, the number of cores per die, the
> +    number of threads per cores, the number of dies per packages and the
> +    total number of sockets can be specified. Missing values will be
> +    computed. If any on the three values is given, the total number of
> +    CPUs n can be omitted. maxcpus specifies the maximum number of
> +    hotpluggable CPUs.
> +ERST
>=20=20
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
[,initiator=3Dnode]\n"
> @@ -322,6 +447,152 @@ cache, size is 10KB, policy is write-back, the cach=
e Line size is 8 bytes:
>  @end example
>=20=20
>  ETEXI
> +SRST
> +``-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,i=
nitiator=3Dinitiator]``; \ ``-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-las=
tcpu]][,nodeid=3Dnode][,initiator=3Dinitiator]``; \ ``-numa dist,src=3Dsour=
ce,dst=3Ddestination,val=3Ddistance``; \ ``-numa cpu,node-id=3Dnode[,socket=
-id=3Dx][,core-id=3Dy][,thread-id=3Dz]``; \ ``-numa hmat-lb,initiator=3Dnod=
e,target=3Dnode,hierarchy=3Dhierarchy,data-type=3Dtpye[,latency=3Dlat][,ban=
dwidth=3Dbw]``; \ ``-numa hmat-cache,node-id=3Dnode,size=3Dsize,level=3Dlev=
el[,associativity=3Dstr][,policy=3Dstr][,line=3Dsize]``
> +    Define a NUMA node and assign RAM and VCPUs to it. Set the NUMA
> +    distance from a source node to a destination node. Set the ACPI
> +    Heterogeneous Memory Attributes for the given nodes.
> +
> +    Legacy VCPU assignment uses '\ ``cpus``\ ' option where firstcpu and
> +    lastcpu are CPU indexes. Each '\ ``cpus``\ ' option represent a
> +    contiguous range of CPU indexes (or a single VCPU if lastcpu is
> +    omitted). A non-contiguous set of VCPUs can be represented by
> +    providing multiple '\ ``cpus``\ ' options. If '\ ``cpus``\ ' is
> +    omitted on all nodes, VCPUs are automatically split between them.
> +
> +    For example, the following option assigns VCPUs 0, 1, 2 and 5 to a
> +    NUMA node:
> +
> +    ::
> +
> +        -numa node,cpus=3D0-2,cpus=3D5
> +
> +    '\ ``cpu``\ ' option is a new alternative to '\ ``cpus``\ ' option
> +    which uses '\ ``socket-id|core-id|thread-id``\ ' properties to
> +    assign CPU objects to a node using topology layout properties of
> +    CPU. The set of properties is machine specific, and depends on used
> +    machine type/'\ ``smp``\ ' options. It could be queried with
> +    '\ ``hotpluggable-cpus``\ ' monitor command. '\ ``node-id``\ '
> +    property specifies node to which CPU object will be assigned, it's
> +    required for node to be declared with '\ ``node``\ ' option before
> +    it's used with '\ ``cpu``\ ' option.
> +
> +    For example:
> +
> +    ::
> +
> +        -M pc \
> +        -smp 1,sockets=3D2,maxcpus=3D2 \
> +        -numa node,nodeid=3D0 -numa node,nodeid=3D1 \
> +        -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket=
-id=3D1
> +
> +    '\ ``mem``\ ' assigns a given RAM amount to a node. '\ ``memdev``\ '
> +    assigns RAM from a given memory backend device to a node. If
> +    '\ ``mem``\ ' and '\ ``memdev``\ ' are omitted in all nodes, RAM is
> +    split equally between them.
> +
> +    '\ ``mem``\ ' and '\ ``memdev``\ ' are mutually exclusive.
> +    Furthermore, if one node uses '\ ``memdev``\ ', all of them have to
> +    use it.
> +
> +    '\ ``initiator``\ ' is an additional option that points to an
> +    initiator NUMA node that has best performance (the lowest latency or
> +    largest bandwidth) to this NUMA node. Note that this option can be
> +    set only when the machine property 'hmat' is set to 'on'.
> +
> +    Following example creates a machine with 2 NUMA nodes, node 0 has
> +    CPU. node 1 has only memory, and its initiator is node 0. Note that
> +    because node 0 has CPU, by default the initiator of node 0 is itself
> +    and must be itself.
> +
> +    ::
> +
> +        -machine hmat=3Don \
> +        -m 2G,slots=3D2,maxmem=3D4G \
> +        -object memory-backend-ram,size=3D1G,id=3Dm0 \
> +        -object memory-backend-ram,size=3D1G,id=3Dm1 \
> +        -numa node,nodeid=3D0,memdev=3Dm0 \
> +        -numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
> +        -smp 2,sockets=3D2,maxcpus=3D2  \
> +        -numa cpu,node-id=3D0,socket-id=3D0 \
> +        -numa cpu,node-id=3D0,socket-id=3D1
> +
> +    source and destination are NUMA node IDs. distance is the NUMA
> +    distance from source to destination. The distance from a node to
> +    itself is always 10. If any pair of nodes is given a distance, then
> +    all pairs must be given distances. Although, when distances are only
> +    given in one direction for each pair of nodes, then the distances in
> +    the opposite directions are assumed to be the same. If, however, an
> +    asymmetrical pair of distances is given for even one node pair, then
> +    all node pairs must be provided distance values for both directions,
> +    even when they are symmetrical. When a node is unreachable from
> +    another node, set the pair's distance to 255.
> +
> +    Note that the -``numa`` option doesn't allocate any of the specified
> +    resources, it just assigns existing resources to NUMA nodes. This
> +    means that one still has to use the ``-m``, ``-smp`` options to
> +    allocate RAM and VCPUs respectively.
> +
> +    Use '\ ``hmat-lb``\ ' to set System Locality Latency and Bandwidth
> +    Information between initiator and target NUMA nodes in ACPI
> +    Heterogeneous Attribute Memory Table (HMAT). Initiator NUMA node can
> +    create memory requests, usually it has one or more processors.
> +    Target NUMA node contains addressable memory.
> +
> +    In '\ ``hmat-lb``\ ' option, node are NUMA node IDs. hierarchy is
> +    the memory hierarchy of the target NUMA node: if hierarchy is
> +    'memory', the structure represents the memory performance; if
> +    hierarchy is 'first-level\|second-level\|third-level', this
> +    structure represents aggregated performance of memory side caches
> +    for each domain. type of 'data-type' is type of data represented by
> +    this structure instance: if 'hierarchy' is 'memory', 'data-type' is
> +    'access\|read\|write' latency or 'access\|read\|write' bandwidth of
> +    the target memory; if 'hierarchy' is
> +    'first-level\|second-level\|third-level', 'data-type' is
> +    'access\|read\|write' hit latency or 'access\|read\|write' hit
> +    bandwidth of the target memory side cache.
> +
> +    lat is latency value in nanoseconds. bw is bandwidth value, the
> +    possible value and units are NUM[M\|G\|T], mean that the bandwidth
> +    value are NUM byte per second (or MB/s, GB/s or TB/s depending on
> +    used suffix). Note that if latency or bandwidth value is 0, means
> +    the corresponding latency or bandwidth information is not provided.
> +
> +    In '\ ``hmat-cache``\ ' option, node-id is the NUMA-id of the memory
> +    belongs. size is the size of memory side cache in bytes. level is
> +    the cache level described in this structure, note that the cache
> +    level 0 should not be used with '\ ``hmat-cache``\ ' option.
> +    associativity is the cache associativity, the possible value is
> +    'none/direct(direct-mapped)/complex(complex cache indexing)'. policy
> +    is the write policy. line is the cache Line size in bytes.
> +
> +    For example, the following options describe 2 NUMA nodes. Node 0 has
> +    2 cpus and a ram, node 1 has only a ram. The processors in node 0
> +    access memory in node 0 with access-latency 5 nanoseconds,
> +    access-bandwidth is 200 MB/s; The processors in NUMA node 0 access
> +    memory in NUMA node 1 with access-latency 10 nanoseconds,
> +    access-bandwidth is 100 MB/s. And for memory side cache information,
> +    NUMA node 0 and 1 both have 1 level memory cache, size is 10KB,
> +    policy is write-back, the cache Line size is 8 bytes:
> +
> +    ::
> +
> +        -machine hmat=3Don \
> +        -m 2G \
> +        -object memory-backend-ram,size=3D1G,id=3Dm0 \
> +        -object memory-backend-ram,size=3D1G,id=3Dm1 \
> +        -smp 2 \
> +        -numa node,nodeid=3D0,memdev=3Dm0 \
> +        -numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
> +        -numa cpu,node-id=3D0,socket-id=3D0 \
> +        -numa cpu,node-id=3D0,socket-id=3D1 \
> +        -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-t=
ype=3Daccess-latency,latency=3D5 \
> +        -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-t=
ype=3Daccess-bandwidth,bandwidth=3D200M \
> +        -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-t=
ype=3Daccess-latency,latency=3D10 \
> +        -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-t=
ype=3Daccess-bandwidth,bandwidth=3D100M \
> +        -numa hmat-cache,node-id=3D0,size=3D10K,level=3D1,associativity=
=3Ddirect,policy=3Dwrite-back,line=3D8 \
> +        -numa hmat-cache,node-id=3D1,size=3D10K,level=3D1,associativity=
=3Ddirect,policy=3Dwrite-back,line=3D8
> +ERST
>=20=20
>  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
>      "-add-fd fd=3Dfd,set=3Dset[,opaque=3Dopaque]\n"
> @@ -350,6 +621,33 @@ You can open an image using pre-opened file descript=
ors from an fd set:
>   -drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
>  @end example
>  ETEXI
> +SRST
> +``-add-fd fd=3Dfd,set=3Dset[,opaque=3Dopaque]``
> +    Add a file descriptor to an fd set. Valid options are:
> +
> +    ``fd=3Dfd``
> +        This option defines the file descriptor of which a duplicate is
> +        added to fd set. The file descriptor cannot be stdin, stdout, or
> +        stderr.
> +
> +    ``set=3Dset``
> +        This option defines the ID of the fd set to add the file
> +        descriptor to.
> +
> +    ``opaque=3Dopaque``
> +        This option defines a free-form string that can be used to
> +        describe fd.
> +
> +    You can open an image using pre-opened file descriptors from an fd
> +    set:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| \
> +         -add-fd fd=3D3,set=3D2,opaque=3D"rdwr:/path/to/file" \
> +         -add-fd fd=3D4,set=3D2,opaque=3D"rdonly:/path/to/file" \
> +         -drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
> +ERST
>=20=20
>  DEF("set", HAS_ARG, QEMU_OPTION_set,
>      "-set group.id.arg=3Dvalue\n"
> @@ -360,6 +658,10 @@ STEXI
>  @findex -set
>  Set parameter @var{arg} for item @var{id} of type @var{group}
>  ETEXI
> +SRST
> +``-set group.id.arg=3Dvalue``
> +    Set parameter arg for item id of type group
> +ERST
>=20=20
>  DEF("global", HAS_ARG, QEMU_OPTION_global,
>      "-global driver.property=3Dvalue\n"
> @@ -384,6 +686,23 @@ created automatically and set properties on it, use =
-@option{device}.
>  driver=3D@var{driver},property=3D@var{prop},value=3D@var{value}.  The
>  longhand syntax works even when @var{driver} contains a dot.
>  ETEXI
> +SRST
> +``-global driver.prop=3Dvalue``; \ ``-global driver=3Ddriver,property=3D=
property,value=3Dvalue``
> +    Set default value of driver's property prop to value, e.g.:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system_x86| -global ide-hd.physical_block_size=3D4096 disk=
-image.img
> +
> +    In particular, you can use this to set driver properties for devices
> +    which are created automatically by the machine model. To create a
> +    device which is not created automatically and set properties on it,
> +    use -``device``.
> +
> +    -global driver.prop=3Dvalue is shorthand for -global
> +    driver=3Ddriver,property=3Dprop,value=3Dvalue. The longhand syntax w=
orks
> +    even when driver contains a dot.
> +ERST
>=20=20
>  DEF("boot", HAS_ARG, QEMU_OPTION_boot,
>      "-boot [order=3Ddrives][,once=3Ddrives][,menu=3Don|off]\n"
> @@ -437,6 +756,50 @@ bootindex options. The default is non-strict boot.
>  Note: The legacy format '-boot @var{drives}' is still supported but its
>  use is discouraged as it may be removed from future versions.
>  ETEXI
> +SRST
> +``-boot [order=3Ddrives][,once=3Ddrives][,menu=3Don|off][,splash=3Dsp_na=
me][,splash-time=3Dsp_time][,reboot-timeout=3Drb_timeout][,strict=3Don|off]=
``
> +    Specify boot order drives as a string of drive letters. Valid drive
> +    letters depend on the target architecture. The x86 PC uses: a, b
> +    (floppy 1 and 2), c (first hard disk), d (first CD-ROM), n-p
> +    (Etherboot from network adapter 1-4), hard disk boot is the default.
> +    To apply a particular boot order only on the first startup, specify
> +    it via ``once``. Note that the ``order`` or ``once`` parameter
> +    should not be used together with the ``bootindex`` property of
> +    devices, since the firmware implementations normally do not support
> +    both at the same time.
> +
> +    Interactive boot menus/prompts can be enabled via ``menu=3Don`` as f=
ar
> +    as firmware/BIOS supports them. The default is non-interactive boot.
> +
> +    A splash picture could be passed to bios, enabling user to show it
> +    as logo, when option splash=3Dsp\_name is given and menu=3Don, If
> +    firmware/BIOS supports them. Currently Seabios for X86 system
> +    support it. limitation: The splash file could be a jpeg file or a
> +    BMP file in 24 BPP format(true color). The resolution should be
> +    supported by the SVGA mode, so the recommended is 320x240, 640x480,
> +    800x640.
> +
> +    A timeout could be passed to bios, guest will pause for rb\_timeout
> +    ms when boot failed, then reboot. If rb\_timeout is '-1', guest will
> +    not reboot, qemu passes '-1' to bios by default. Currently Seabios
> +    for X86 system support it.
> +
> +    Do strict boot via ``strict=3Don`` as far as firmware/BIOS supports
> +    it. This only effects when boot priority is changed by bootindex
> +    options. The default is non-strict boot.
> +
> +    ::
> +
> +        # try to boot from network first, then from hard disk
> +        |qemu_system_x86| -boot order=3Dnc
> +        # boot from CD-ROM first, switch back to default order after reb=
oot
> +        |qemu_system_x86| -boot once=3Dd
> +        # boot with a splash picture for 5 seconds.
> +        |qemu_system_x86| -boot menu=3Don,splash=3D/root/boot.bmp,splash=
-time=3D5000
> +
> +    Note: The legacy format '-boot drives' is still supported but its
> +    use is discouraged as it may be removed from future versions.
> +ERST
>=20=20
>  DEF("m", HAS_ARG, QEMU_OPTION_m,
>      "-m [size=3D]megs[,slots=3Dn,maxmem=3Dsize]\n"
> @@ -466,6 +829,25 @@ memory the guest can reach to 4GB:
>  If @var{slots} and @var{maxmem} are not specified, memory hotplug won't
>  be enabled and the guest startup RAM will never increase.
>  ETEXI
> +SRST
> +``-m [size=3D]megs[,slots=3Dn,maxmem=3Dsize]``
> +    Sets guest startup RAM size to megs megabytes. Default is 128 MiB.
> +    Optionally, a suffix of "M" or "G" can be used to signify a value in
> +    megabytes or gigabytes respectively. Optional pair slots, maxmem
> +    could be used to set amount of hotpluggable memory slots and maximum
> +    amount of memory. Note that maxmem must be aligned to the page size.
> +
> +    For example, the following command-line sets the guest startup RAM
> +    size to 1GB, creates 3 slots to hotplug additional memory and sets
> +    the maximum memory the guest can reach to 4GB:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| -m 1G,slots=3D3,maxmem=3D4G
> +
> +    If slots and maxmem are not specified, memory hotplug won't be
> +    enabled and the guest startup RAM will never increase.
> +ERST
>=20=20
>  DEF("mem-path", HAS_ARG, QEMU_OPTION_mempath,
>      "-mem-path FILE  provide backing storage for guest RAM\n", QEMU_ARCH=
_ALL)
> @@ -474,6 +856,10 @@ STEXI
>  @findex -mem-path
>  Allocate guest RAM from a temporarily created file in @var{path}.
>  ETEXI
> +SRST
> +``-mem-path path``
> +    Allocate guest RAM from a temporarily created file in path.
> +ERST
>=20=20
>  DEF("mem-prealloc", 0, QEMU_OPTION_mem_prealloc,
>      "-mem-prealloc   preallocate guest memory (use with -mem-path)\n",
> @@ -483,6 +869,10 @@ STEXI
>  @findex -mem-prealloc
>  Preallocate memory when using -mem-path.
>  ETEXI
> +SRST
> +``-mem-prealloc``
> +    Preallocate memory when using -mem-path.
> +ERST
>=20=20
>  DEF("k", HAS_ARG, QEMU_OPTION_k,
>      "-k language     use keyboard layout (for example 'fr' for French)\n=
",
> @@ -505,6 +895,24 @@ de  en-us  fi  fr-be  hr     it  lv  nl-be  pt  sl  =
   tr
>=20=20
>  The default is @code{en-us}.
>  ETEXI
> +SRST
> +``-k language``
> +    Use keyboard layout language (for example ``fr`` for French). This
> +    option is only needed where it is not easy to get raw PC keycodes
> +    (e.g. on Macs, with some X11 servers or with a VNC or curses
> +    display). You don't normally need to use it on PC/Linux or
> +    PC/Windows hosts.
> +
> +    The available layouts are:
> +
> +    ::
> +
> +        ar  de-ch  es  fo     fr-ca  hu  ja  mk     no  pt-br  sv
> +        da  en-gb  et  fr     fr-ch  is  lt  nl     pl  ru     th
> +        de  en-us  fi  fr-be  hr     it  lv  nl-be  pt  sl     tr
> +
> +    The default is ``en-us``.
> +ERST
>=20=20
>=20=20
>  HXCOMM Deprecated by -audiodev
> @@ -517,6 +925,11 @@ STEXI
>  Will show the -audiodev equivalent of the currently specified
>  (deprecated) environment variables.
>  ETEXI
> +SRST
> +``-audio-help``
> +    Will show the -audiodev equivalent of the currently specified
> +    (deprecated) environment variables.
> +ERST
>=20=20
>  DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>      "-audiodev [driver=3D]driver,id=3Did[,prop[=3Dvalue][,...]]\n"
> @@ -766,6 +1179,173 @@ Write recorded audio into the specified file.  Def=
ault is
>=20=20
>  @end table
>  ETEXI
> +SRST
> +``-audiodev [driver=3D]driver,id=3Did[,prop[=3Dvalue][,...]]``
> +    Adds a new audio backend driver identified by id. There are global
> +    and driver specific properties. Some values can be set differently
> +    for input and output, they're marked with ``in|out.``. You can set
> +    the input's property with ``in.prop`` and the output's property with
> +    ``out.prop``. For example:
> +
> +    ::
> +
> +        -audiodev alsa,id=3Dexample,in.frequency=3D44110,out.frequency=
=3D8000
> +        -audiodev alsa,id=3Dexample,out.channels=3D1 # leaves in.channel=
s unspecified
> +
> +    NOTE: parameter validation is known to be incomplete, in many cases
> +    specifying an invalid option causes QEMU to print an error message
> +    and continue emulation without sound.
> +
> +    Valid global options are:
> +
> +    ``id=3Didentifier``
> +        Identifies the audio backend.
> +
> +    ``timer-period=3Dperiod``
> +        Sets the timer period used by the audio subsystem in
> +        microseconds. Default is 10000 (10 ms).
> +
> +    ``in|out.mixing-engine=3Don|off``
> +        Use QEMU's mixing engine to mix all streams inside QEMU and
> +        convert audio formats when not supported by the backend. When
> +        off, fixed-settings must be off too. Note that disabling this
> +        option means that the selected backend must support multiple
> +        streams and the audio formats used by the virtual cards,
> +        otherwise you'll get no sound. It's not recommended to disable
> +        this option unless you want to use 5.1 or 7.1 audio, as mixing
> +        engine only supports mono and stereo audio. Default is on.
> +
> +    ``in|out.fixed-settings=3Don|off``
> +        Use fixed settings for host audio. When off, it will change
> +        based on how the guest opens the sound card. In this case you
> +        must not specify frequency, channels or format. Default is on.
> +
> +    ``in|out.frequency=3Dfrequency``
> +        Specify the frequency to use when using fixed-settings. Default
> +        is 44100Hz.
> +
> +    ``in|out.channels=3Dchannels``
> +        Specify the number of channels to use when using fixed-settings.
> +        Default is 2 (stereo).
> +
> +    ``in|out.format=3Dformat``
> +        Specify the sample format to use when using fixed-settings.
> +        Valid values are: ``s8``, ``s16``, ``s32``, ``u8``, ``u16``,
> +        ``u32``. Default is ``s16``.
> +
> +    ``in|out.voices=3Dvoices``
> +        Specify the number of voices to use. Default is 1.
> +
> +    ``in|out.buffer-length=3Dusecs``
> +        Sets the size of the buffer in microseconds.
> +
> +``-audiodev none,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a dummy backend that discards all outputs. This backend has
> +    no backend specific properties.
> +
> +``-audiodev alsa,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates backend using the ALSA. This backend is only available on
> +    Linux.
> +
> +    ALSA specific options are:
> +
> +    ``in|out.dev=3Ddevice``
> +        Specify the ALSA device to use for input and/or output. Default
> +        is ``default``.
> +
> +    ``in|out.period-length=3Dusecs``
> +        Sets the period length in microseconds.
> +
> +    ``in|out.try-poll=3Don|off``
> +        Attempt to use poll mode with the device. Default is on.
> +
> +    ``threshold=3Dthreshold``
> +        Threshold (in microseconds) when playback starts. Default is 0.
> +
> +``-audiodev coreaudio,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a backend using Apple's Core Audio. This backend is only
> +    available on Mac OS and only supports playback.
> +
> +    Core Audio specific options are:
> +
> +    ``in|out.buffer-count=3Dcount``
> +        Sets the count of the buffers.
> +
> +``-audiodev dsound,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a backend using Microsoft's DirectSound. This backend is
> +    only available on Windows and only supports playback.
> +
> +    DirectSound specific options are:
> +
> +    ``latency=3Dusecs``
> +        Add extra usecs microseconds latency to playback. Default is
> +        10000 (10 ms).
> +
> +``-audiodev oss,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a backend using OSS. This backend is available on most
> +    Unix-like systems.
> +
> +    OSS specific options are:
> +
> +    ``in|out.dev=3Ddevice``
> +        Specify the file name of the OSS device to use. Default is
> +        ``/dev/dsp``.
> +
> +    ``in|out.buffer-count=3Dcount``
> +        Sets the count of the buffers.
> +
> +    ``in|out.try-poll=3Don|of``
> +        Attempt to use poll mode with the device. Default is on.
> +
> +    ``try-mmap=3Don|off``
> +        Try using memory mapped device access. Default is off.
> +
> +    ``exclusive=3Don|off``
> +        Open the device in exclusive mode (vmix won't work in this
> +        case). Default is off.
> +
> +    ``dsp-policy=3Dpolicy``
> +        Sets the timing policy (between 0 and 10, where smaller number
> +        means smaller latency but higher CPU usage). Use -1 to use
> +        buffer sizes specified by ``buffer`` and ``buffer-count``. This
> +        option is ignored if you do not have OSS 4. Default is 5.
> +
> +``-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a backend using PulseAudio. This backend is available on
> +    most systems.
> +
> +    PulseAudio specific options are:
> +
> +    ``server=3Dserver``
> +        Sets the PulseAudio server to connect to.
> +
> +    ``in|out.name=3Dsink``
> +        Use the specified source/sink for recording/playback.
> +
> +    ``in|out.latency=3Dusecs``
> +        Desired latency in microseconds. The PulseAudio server will try
> +        to honor this value but actual latencies may be lower or higher.
> +
> +``-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a backend using SDL. This backend is available on most
> +    systems, but you should use your platform's native backend if
> +    possible. This backend has no backend specific properties.
> +
> +``-audiodev spice,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a backend that sends audio through SPICE. This backend
> +    requires ``-spice`` and automatically selected in that case, so
> +    usually you can ignore this option. This backend has no backend
> +    specific properties.
> +
> +``-audiodev wav,id=3Did[,prop[=3Dvalue][,...]]``
> +    Creates a backend that writes audio to a WAV file.
> +
> +    Backend specific options are:
> +
> +    ``path=3Dpath``
> +        Write recorded audio into the specified file. Default is
> +        ``qemu.wav``.
> +ERST
>=20=20
>  DEF("soundhw", HAS_ARG, QEMU_OPTION_soundhw,
>      "-soundhw c1,... enable audio support\n"
> @@ -794,6 +1374,27 @@ require manually specifying clocking.
>  modprobe i810_audio clocking=3D48000
>  @end example
>  ETEXI
> +SRST
> +``-soundhw card1[,card2,...] or -soundhw all``
> +    Enable audio and selected sound hardware. Use 'help' to print all
> +    available sound hardware. For example:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system_x86| -soundhw sb16,adlib disk.img
> +        |qemu_system_x86| -soundhw es1370 disk.img
> +        |qemu_system_x86| -soundhw ac97 disk.img
> +        |qemu_system_x86| -soundhw hda disk.img
> +        |qemu_system_x86| -soundhw all disk.img
> +        |qemu_system_x86| -soundhw help
> +
> +    Note that Linux's i810\_audio OSS kernel (for AC97) module might
> +    require manually specifying clocking.
> +
> +    ::
> +
> +        modprobe i810_audio clocking=3D48000
> +ERST
>=20=20
>  DEF("device", HAS_ARG, QEMU_OPTION_device,
>      "-device driver[,prop[=3Dvalue][,...]]\n"
> @@ -879,6 +1480,85 @@ Like the KCS interface, but defines a BT interface.=
  The default port is
>  0xe4 and the default interrupt is 5.
>=20=20
>  ETEXI
> +SRST
> +``-device driver[,prop[=3Dvalue][,...]]``
> +    Add device driver. prop=3Dvalue sets driver properties. Valid
> +    properties depend on the driver. To get help on possible drivers and
> +    properties, use ``-device help`` and ``-device driver,help``.
> +
> +    Some drivers are:
> +
> +``-device ipmi-bmc-sim,id=3Did[,slave_addr=3Dval][,sdrfile=3Dfile][,fura=
reasize=3Dval][,furdatafile=3Dfile][,guid=3Duuid]``
> +    Add an IPMI BMC. This is a simulation of a hardware management
> +    interface processor that normally sits on a system. It provides a
> +    watchdog and the ability to reset and power control the system. You
> +    need to connect this to an IPMI interface to make it useful
> +
> +    The IPMI slave address to use for the BMC. The default is 0x20. This
> +    address is the BMC's address on the I2C network of management
> +    controllers. If you don't know what this means, it is safe to ignore
> +    it.
> +
> +    ``id=3Did``
> +        The BMC id for interfaces to use this device.
> +
> +    ``slave_addr=3Dval``
> +        Define slave address to use for the BMC. The default is 0x20.
> +
> +    ``sdrfile=3Dfile``
> +        file containing raw Sensor Data Records (SDR) data. The default
> +        is none.
> +
> +    ``fruareasize=3Dval``
> +        size of a Field Replaceable Unit (FRU) area. The default is
> +        1024.
> +
> +    ``frudatafile=3Dfile``
> +        file containing raw Field Replaceable Unit (FRU) inventory data.
> +        The default is none.
> +
> +    ``guid=3Duuid``
> +        value for the GUID for the BMC, in standard UUID format. If this
> +        is set, get "Get GUID" command to the BMC will return it.
> +        Otherwise "Get GUID" will return an error.
> +
> +``-device ipmi-bmc-extern,id=3Did,chardev=3Did[,slave_addr=3Dval]``
> +    Add a connection to an external IPMI BMC simulator. Instead of
> +    locally emulating the BMC like the above item, instead connect to an
> +    external entity that provides the IPMI services.
> +
> +    A connection is made to an external BMC simulator. If you do this,
> +    it is strongly recommended that you use the "reconnect=3D" chardev
> +    option to reconnect to the simulator if the connection is lost. Note
> +    that if this is not used carefully, it can be a security issue, as
> +    the interface has the ability to send resets, NMIs, and power off
> +    the VM. It's best if QEMU makes a connection to an external
> +    simulator running on a secure port on localhost, so neither the
> +    simulator nor QEMU is exposed to any outside network.
> +
> +    See the "lanserv/README.vm" file in the OpenIPMI library for more
> +    details on the external interface.
> +
> +``-device isa-ipmi-kcs,bmc=3Did[,ioport=3Dval][,irq=3Dval]``
> +    Add a KCS IPMI interafce on the ISA bus. This also adds a
> +    corresponding ACPI and SMBIOS entries, if appropriate.
> +
> +    ``bmc=3Did``
> +        The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern
> +        above.
> +
> +    ``ioport=3Dval``
> +        Define the I/O address of the interface. The default is 0xca0
> +        for KCS.
> +
> +    ``irq=3Dval``
> +        Define the interrupt to use. The default is 5. To disable
> +        interrupts, set this to 0.
> +
> +``-device isa-ipmi-bt,bmc=3Did[,ioport=3Dval][,irq=3Dval]``
> +    Like the KCS interface, but defines a BT interface. The default port
> +    is 0xe4 and the default interrupt is 5.
> +ERST
>=20=20
>  DEF("name", HAS_ARG, QEMU_OPTION_name,
>      "-name string1[,process=3Dstring2][,debug-threads=3Don|off]\n"
> @@ -896,6 +1576,13 @@ The @var{name} will also be used for the VNC server.
>  Also optionally set the top visible process name in Linux.
>  Naming of individual threads can also be enabled on Linux to aid debuggi=
ng.
>  ETEXI
> +SRST
> +``-name name``
> +    Sets the name of the guest. This name will be displayed in the SDL
> +    window caption. The name will also be used for the VNC server. Also
> +    optionally set the top visible process name in Linux. Naming of
> +    individual threads can also be enabled on Linux to aid debugging.
> +ERST
>=20=20
>  DEF("uuid", HAS_ARG, QEMU_OPTION_uuid,
>      "-uuid %08x-%04x-%04x-%04x-%012x\n"
> @@ -905,6 +1592,10 @@ STEXI
>  @findex -uuid
>  Set system UUID.
>  ETEXI
> +SRST
> +``-uuid uuid``
> +    Set system UUID.
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -926,6 +1617,11 @@ STEXI
>  @findex -fdb
>  Use @var{file} as floppy disk 0/1 image (@pxref{disk_images}).
>  ETEXI
> +SRST
> +``-fda file``; \ ``-fdb file``
> +    Use file as floppy disk 0/1 image (see
> +    :ref:`disk_005fimages`).
> +ERST
>=20=20
>  DEF("hda", HAS_ARG, QEMU_OPTION_hda,
>      "-hda/-hdb file  use 'file' as IDE hard disk 0/1 image\n", QEMU_ARCH=
_ALL)
> @@ -944,6 +1640,11 @@ STEXI
>  @findex -hdd
>  Use @var{file} as hard disk 0, 1, 2 or 3 image (@pxref{disk_images}).
>  ETEXI
> +SRST
> +``-hda file``; \ ``-hdb file``; \ ``-hdc file``; \ ``-hdd file``
> +    Use file as hard disk 0, 1, 2 or 3 image (see
> +    :ref:`disk_005fimages`).
> +ERST
>=20=20
>  DEF("cdrom", HAS_ARG, QEMU_OPTION_cdrom,
>      "-cdrom file     use 'file' as IDE cdrom image (cdrom is ide1 master=
)\n",
> @@ -955,6 +1656,12 @@ Use @var{file} as CD-ROM image (you cannot use @opt=
ion{-hdc} and
>  @option{-cdrom} at the same time). You can use the host CD-ROM by
>  using @file{/dev/cdrom} as filename.
>  ETEXI
> +SRST
> +``-cdrom file``
> +    Use file as CD-ROM image (you cannot use ``-hdc`` and ``-cdrom`` at
> +    the same time). You can use the host CD-ROM by using ``/dev/cdrom``
> +    as filename.
> +ERST
>=20=20
>  DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
>      "-blockdev [driver=3D]driver[,node-name=3DN][,discard=3Dignore|unmap=
]\n"
> @@ -1150,6 +1857,216 @@ Please refer to the QAPI documentation of the @co=
de{blockdev-add} QMP command.
>  @end table
>=20=20
>  ETEXI
> +SRST
> +``-blockdev option[,option[,option[,...]]]``
> +    Define a new block driver node. Some of the options apply to all
> +    block drivers, other options are only accepted for a specific block
> +    driver. See below for a list of generic options and options for the
> +    most common block drivers.
> +
> +    Options that expect a reference to another node (e.g. ``file``) can
> +    be given in two ways. Either you specify the node name of an already
> +    existing node (file=3Dnode-name), or you define a new node inline,
> +    adding options for the referenced node after a dot
> +    (file.filename=3Dpath,file.aio=3Dnative).
> +
> +    A block driver node created with ``-blockdev`` can be used for a
> +    guest device by specifying its node name for the ``drive`` property
> +    in a ``-device`` argument that defines a block device.
> +
> +    ``Valid options for any block driver node:``
> +        ``driver``
> +            Specifies the block driver to use for the given node.
> +
> +        ``node-name``
> +            This defines the name of the block driver node by which it
> +            will be referenced later. The name must be unique, i.e. it
> +            must not match the name of a different block driver node, or
> +            (if you use ``-drive`` as well) the ID of a drive.
> +
> +            If no node name is specified, it is automatically generated.
> +            The generated node name is not intended to be predictable
> +            and changes between QEMU invocations. For the top level, an
> +            explicit node name must be specified.
> +
> +        ``read-only``
> +            Open the node read-only. Guest write attempts will fail.
> +
> +            Note that some block drivers support only read-only access,
> +            either generally or in certain configurations. In this case,
> +            the default value ``read-only=3Doff`` does not work and the
> +            option must be specified explicitly.
> +
> +        ``auto-read-only``
> +            If ``auto-read-only=3Don`` is set, QEMU may fall back to
> +            read-only usage even when ``read-only=3Doff`` is requested, =
or
> +            even switch between modes as needed, e.g. depending on
> +            whether the image file is writable or whether a writing user
> +            is attached to the node.
> +
> +        ``force-share``
> +            Override the image locking system of QEMU by forcing the
> +            node to utilize weaker shared access for permissions where
> +            it would normally request exclusive access. When there is
> +            the potential for multiple instances to have the same file
> +            open (whether this invocation of QEMU is the first or the
> +            second instance), both instances must permit shared access
> +            for the second instance to succeed at opening the file.
> +
> +            Enabling ``force-share=3Don`` requires ``read-only=3Don``.
> +
> +        ``cache.direct``
> +            The host page cache can be avoided with ``cache.direct=3Don`=
`.
> +            This will attempt to do disk IO directly to the guest's
> +            memory. QEMU may still perform an internal copy of the data.
> +
> +        ``cache.no-flush``
> +            In case you don't care about data integrity over host
> +            failures, you can use ``cache.no-flush=3Don``. This option
> +            tells QEMU that it never needs to write any data to the disk
> +            but can instead keep things in cache. If anything goes
> +            wrong, like your host losing power, the disk storage getting
> +            disconnected accidentally, etc. your image will most
> +            probably be rendered unusable.
> +
> +        ``discard=3Ddiscard``
> +            discard is one of "ignore" (or "off") or "unmap" (or "on")
> +            and controls whether ``discard`` (also known as ``trim`` or
> +            ``unmap``) requests are ignored or passed to the filesystem.
> +            Some machine types may not support discard requests.
> +
> +        ``detect-zeroes=3Ddetect-zeroes``
> +            detect-zeroes is "off", "on" or "unmap" and enables the
> +            automatic conversion of plain zero writes by the OS to
> +            driver specific optimized zero write commands. You may even
> +            choose "unmap" if discard is set to "unmap" to allow a zero
> +            write to be converted to an ``unmap`` operation.
> +
> +    ``Driver-specific options for file``
> +        This is the protocol-level block driver for accessing regular
> +        files.
> +
> +        ``filename``
> +            The path to the image file in the local filesystem
> +
> +        ``aio``
> +            Specifies the AIO backend (threads/native, default: threads)
> +
> +        ``locking``
> +            Specifies whether the image file is protected with Linux OFD
> +            / POSIX locks. The default is to use the Linux Open File
> +            Descriptor API if available, otherwise no lock is applied.
> +            (auto/on/off, default: auto)
> +
> +        Example:
> +
> +        ::
> +
> +            -blockdev driver=3Dfile,node-name=3Ddisk,filename=3Ddisk.img
> +
> +    ``Driver-specific options for raw``
> +        This is the image format block driver for raw images. It is
> +        usually stacked on top of a protocol level block driver such as
> +        ``file``.
> +
> +        ``file``
> +            Reference to or definition of the data source block driver
> +            node (e.g. a ``file`` driver node)
> +
> +        Example 1:
> +
> +        ::
> +
> +            -blockdev driver=3Dfile,node-name=3Ddisk_file,filename=3Ddis=
k.img
> +            -blockdev driver=3Draw,node-name=3Ddisk,file=3Ddisk_file
> +
> +        Example 2:
> +
> +        ::
> +
> +            -blockdev driver=3Draw,node-name=3Ddisk,file.driver=3Dfile,f=
ile.filename=3Ddisk.img
> +
> +    ``Driver-specific options for qcow2``
> +        This is the image format block driver for qcow2 images. It is
> +        usually stacked on top of a protocol level block driver such as
> +        ``file``.
> +
> +        ``file``
> +            Reference to or definition of the data source block driver
> +            node (e.g. a ``file`` driver node)
> +
> +        ``backing``
> +            Reference to or definition of the backing file block device
> +            (default is taken from the image file). It is allowed to
> +            pass ``null`` here in order to disable the default backing
> +            file.
> +
> +        ``lazy-refcounts``
> +            Whether to enable the lazy refcounts feature (on/off;
> +            default is taken from the image file)
> +
> +        ``cache-size``
> +            The maximum total size of the L2 table and refcount block
> +            caches in bytes (default: the sum of l2-cache-size and
> +            refcount-cache-size)
> +
> +        ``l2-cache-size``
> +            The maximum size of the L2 table cache in bytes (default: if
> +            cache-size is not specified - 32M on Linux platforms, and 8M
> +            on non-Linux platforms; otherwise, as large as possible
> +            within the cache-size, while permitting the requested or the
> +            minimal refcount cache size)
> +
> +        ``refcount-cache-size``
> +            The maximum size of the refcount block cache in bytes
> +            (default: 4 times the cluster size; or if cache-size is
> +            specified, the part of it which is not used for the L2
> +            cache)
> +
> +        ``cache-clean-interval``
> +            Clean unused entries in the L2 and refcount caches. The
> +            interval is in seconds. The default value is 600 on
> +            supporting platforms, and 0 on other platforms. Setting it
> +            to 0 disables this feature.
> +
> +        ``pass-discard-request``
> +            Whether discard requests to the qcow2 device should be
> +            forwarded to the data source (on/off; default: on if
> +            discard=3Dunmap is specified, off otherwise)
> +
> +        ``pass-discard-snapshot``
> +            Whether discard requests for the data source should be
> +            issued when a snapshot operation (e.g. deleting a snapshot)
> +            frees clusters in the qcow2 file (on/off; default: on)
> +
> +        ``pass-discard-other``
> +            Whether discard requests for the data source should be
> +            issued on other occasions where a cluster gets freed
> +            (on/off; default: off)
> +
> +        ``overlap-check``
> +            Which overlap checks to perform for writes to the image
> +            (none/constant/cached/all; default: cached). For details or
> +            finer granularity control refer to the QAPI documentation of
> +            ``blockdev-add``.
> +
> +        Example 1:
> +
> +        ::
> +
> +            -blockdev driver=3Dfile,node-name=3Dmy_file,filename=3D/tmp/=
disk.qcow2
> +            -blockdev driver=3Dqcow2,node-name=3Dhda,file=3Dmy_file,over=
lap-check=3Dnone,cache-size=3D16777216
> +
> +        Example 2:
> +
> +        ::
> +
> +            -blockdev driver=3Dqcow2,node-name=3Ddisk,file.driver=3Dhttp=
,file.filename=3Dhttp://example.com/image.qcow2
> +
> +    ``Driver-specific options for other drivers``
> +        Please refer to the QAPI documentation of the ``blockdev-add``
> +        QMP command.
> +ERST
>=20=20
>  DEF("drive", HAS_ARG, QEMU_OPTION_drive,
>      "-drive [file=3Dfile][,if=3Dtype][,bus=3Dn][,unit=3Dm][,media=3Dd][,=
index=3Di]\n"
> @@ -1329,6 +2246,197 @@ is interpreted like:
>  @value{qemu_system_x86} -hda a -hdb b
>  @end example
>  ETEXI
> +SRST
> +``-drive option[,option[,option[,...]]]``
> +    Define a new drive. This includes creating a block driver node (the
> +    backend) as well as a guest device, and is mostly a shortcut for
> +    defining the corresponding ``-blockdev`` and ``-device`` options.
> +
> +    ``-drive`` accepts all options that are accepted by ``-blockdev``.
> +    In addition, it knows the following options:
> +
> +    ``file=3Dfile``
> +        This option defines which disk image (see
> +        :ref:`disk_005fimages`) to use with this drive. If
> +        the filename contains comma, you must double it (for instance,
> +        "file=3Dmy,,file" to use file "my,file").
> +
> +        Special files such as iSCSI devices can be specified using
> +        protocol specific URLs. See the section for "Device URL Syntax"
> +        for more information.
> +
> +    ``if=3Dinterface``
> +        This option defines on which type on interface the drive is
> +        connected. Available types are: ide, scsi, sd, mtd, floppy,
> +        pflash, virtio, none.
> +
> +    ``bus=3Dbus,unit=3Dunit``
> +        These options define where is connected the drive by defining
> +        the bus number and the unit id.
> +
> +    ``index=3Dindex``
> +        This option defines where is connected the drive by using an
> +        index in the list of available connectors of a given interface
> +        type.
> +
> +    ``media=3Dmedia``
> +        This option defines the type of the media: disk or cdrom.
> +
> +    ``snapshot=3Dsnapshot``
> +        snapshot is "on" or "off" and controls snapshot mode for the
> +        given drive (see ``-snapshot``).
> +
> +    ``cache=3Dcache``
> +        cache is "none", "writeback", "unsafe", "directsync" or
> +        "writethrough" and controls how the host cache is used to access
> +        block data. This is a shortcut that sets the ``cache.direct``
> +        and ``cache.no-flush`` options (as in ``-blockdev``), and
> +        additionally ``cache.writeback``, which provides a default for
> +        the ``write-cache`` option of block guest devices (as in
> +        ``-device``). The modes correspond to the following settings:
> +
> +        ::
> +
> +                         =C3=A2=C2=94=C2=82 cache.writeback   cache.dire=
ct   cache.no-flush
> +            =C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=
=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=
=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=
=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C5=92=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=
=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=
=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=
=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=
=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=
=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=
=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=
=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=
=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=
=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=
=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=
=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=C2=80=C3=A2=C2=94=
=C2=80=C3=A2=C2=94=C2=80
> +            writeback    =C3=A2=C2=94=C2=82 on                off       =
     off
> +            none         =C3=A2=C2=94=C2=82 on                on        =
     off
> +            writethrough =C3=A2=C2=94=C2=82 off               off       =
     off
> +            directsync   =C3=A2=C2=94=C2=82 off               on        =
     off
> +            unsafe       =C3=A2=C2=94=C2=82 on                off       =
     on
> +
> +        The default mode is ``cache=3Dwriteback``.
> +
> +    ``aio=3Daio``
> +        aio is "threads", or "native" and selects between pthread based
> +        disk I/O and native Linux AIO.
> +
> +    ``format=3Dformat``
> +        Specify which disk format will be used rather than detecting the
> +        format. Can be used to specify format=3Draw to avoid interpreting
> +        an untrusted format header.
> +
> +    ``werror=3Daction,rerror=3Daction``
> +        Specify which action to take on write and read errors. Valid
> +        actions are: "ignore" (ignore the error and try to continue),
> +        "stop" (pause QEMU), "report" (report the error to the guest),
> +        "enospc" (pause QEMU only if the host disk is full; report the
> +        error to the guest otherwise). The default setting is
> +        ``werror=3Denospc`` and ``rerror=3Dreport``.
> +
> +    ``copy-on-read=3Dcopy-on-read``
> +        copy-on-read is "on" or "off" and enables whether to copy read
> +        backing file sectors into the image file.
> +
> +    ``bps=3Db,bps_rd=3Dr,bps_wr=3Dw``
> +        Specify bandwidth throttling limits in bytes per second, either
> +        for all request types or for reads or writes only. Small values
> +        can lead to timeouts or hangs inside the guest. A safe minimum
> +        for disks is 2 MB/s.
> +
> +    ``bps_max=3Dbm,bps_rd_max=3Drm,bps_wr_max=3Dwm``
> +        Specify bursts in bytes per second, either for all request types
> +        or for reads or writes only. Bursts allow the guest I/O to spike
> +        above the limit temporarily.
> +
> +    ``iops=3Di,iops_rd=3Dr,iops_wr=3Dw``
> +        Specify request rate limits in requests per second, either for
> +        all request types or for reads or writes only.
> +
> +    ``iops_max=3Dbm,iops_rd_max=3Drm,iops_wr_max=3Dwm``
> +        Specify bursts in requests per second, either for all request
> +        types or for reads or writes only. Bursts allow the guest I/O to
> +        spike above the limit temporarily.
> +
> +    ``iops_size=3Dis``
> +        Let every is bytes of a request count as a new request for iops
> +        throttling purposes. Use this option to prevent guests from
> +        circumventing iops limits by sending fewer but larger requests.
> +
> +    ``group=3Dg``
> +        Join a throttling quota group with given name g. All drives that
> +        are members of the same group are accounted for together. Use
> +        this option to prevent guests from circumventing throttling
> +        limits by using many small disks instead of a single larger
> +        disk.
> +
> +    By default, the ``cache.writeback=3Don`` mode is used. It will report
> +    data writes as completed as soon as the data is present in the host
> +    page cache. This is safe as long as your guest OS makes sure to
> +    correctly flush disk caches where needed. If your guest OS does not
> +    handle volatile disk write caches correctly and your host crashes or
> +    loses power, then the guest may experience data corruption.
> +
> +    For such guests, you should consider using ``cache.writeback=3Doff``.
> +    This means that the host page cache will be used to read and write
> +    data, but write notification will be sent to the guest only after
> +    QEMU has made sure to flush each write to the disk. Be aware that
> +    this has a major impact on performance.
> +
> +    When using the ``-snapshot`` option, unsafe caching is always used.
> +
> +    Copy-on-read avoids accessing the same backing file sectors
> +    repeatedly and is useful when the backing file is over a slow
> +    network. By default copy-on-read is off.
> +
> +    Instead of ``-cdrom`` you can use:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| -drive file=3Dfile,index=3D2,media=3Dcdrom
> +
> +    Instead of ``-hda``, ``-hdb``, ``-hdc``, ``-hdd``, you can use:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| -drive file=3Dfile,index=3D0,media=3Ddisk
> +        |qemu_system| -drive file=3Dfile,index=3D1,media=3Ddisk
> +        |qemu_system| -drive file=3Dfile,index=3D2,media=3Ddisk
> +        |qemu_system| -drive file=3Dfile,index=3D3,media=3Ddisk
> +
> +    You can open an image using pre-opened file descriptors from an fd
> +    set:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| \
> +         -add-fd fd=3D3,set=3D2,opaque=3D"rdwr:/path/to/file" \
> +         -add-fd fd=3D4,set=3D2,opaque=3D"rdonly:/path/to/file" \
> +         -drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
> +
> +    You can connect a CDROM to the slave of ide0:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system_x86| -drive file=3Dfile,if=3Dide,index=3D1,media=3D=
cdrom
> +
> +    If you don't specify the "file=3D" argument, you define an empty
> +    drive:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system_x86| -drive if=3Dide,index=3D1,media=3Dcdrom
> +
> +    Instead of ``-fda``, ``-fdb``, you can use:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system_x86| -drive file=3Dfile,index=3D0,if=3Dfloppy
> +        |qemu_system_x86| -drive file=3Dfile,index=3D1,if=3Dfloppy
> +
> +    By default, interface is "ide" and index is automatically
> +    incremented:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system_x86| -drive file=3Da -drive file=3Db"
> +
> +    is interpreted like:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system_x86| -hda a -hdb b
> +ERST
>=20=20
>  DEF("mtdblock", HAS_ARG, QEMU_OPTION_mtdblock,
>      "-mtdblock file  use 'file' as on-board Flash memory image\n",
> @@ -1338,6 +2446,10 @@ STEXI
>  @findex -mtdblock
>  Use @var{file} as on-board Flash memory image.
>  ETEXI
> +SRST
> +``-mtdblock file``
> +    Use file as on-board Flash memory image.
> +ERST
>=20=20
>  DEF("sd", HAS_ARG, QEMU_OPTION_sd,
>      "-sd file        use 'file' as SecureDigital card image\n", QEMU_ARC=
H_ALL)
> @@ -1346,6 +2458,10 @@ STEXI
>  @findex -sd
>  Use @var{file} as SecureDigital card image.
>  ETEXI
> +SRST
> +``-sd file``
> +    Use file as SecureDigital card image.
> +ERST
>=20=20
>  DEF("pflash", HAS_ARG, QEMU_OPTION_pflash,
>      "-pflash file    use 'file' as a parallel flash image\n", QEMU_ARCH_=
ALL)
> @@ -1354,6 +2470,10 @@ STEXI
>  @findex -pflash
>  Use @var{file} as a parallel flash image.
>  ETEXI
> +SRST
> +``-pflash file``
> +    Use file as a parallel flash image.
> +ERST
>=20=20
>  DEF("snapshot", 0, QEMU_OPTION_snapshot,
>      "-snapshot       write to temporary files instead of disk image file=
s\n",
> @@ -1365,6 +2485,13 @@ Write to temporary files instead of disk image fil=
es. In this case,
>  the raw disk image you use is not written back. You can however force
>  the write back by pressing @key{C-a s} (@pxref{disk_images}).
>  ETEXI
> +SRST
> +``-snapshot``
> +    Write to temporary files instead of disk image files. In this case,
> +    the raw disk image you use is not written back. You can however
> +    force the write back by pressing C-a s (see
> +    :ref:`disk_005fimages`).
> +ERST
>=20=20
>  DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
>      "-fsdev local,id=3Did,path=3Dpath,security_model=3Dmapped-xattr|mapp=
ed-file|passthrough|none\n"
> @@ -1466,6 +2593,112 @@ Specifies the tag name to be used by the guest to=
 mount this export point.
>  @end table
>=20=20
>  ETEXI
> +SRST
> +``-fsdev local,id=3Did,path=3Dpath,security_model=3Dsecurity_model [,wri=
teout=3Dwriteout][,readonly][,fmode=3Dfmode][,dmode=3Ddmode] [,throttling.o=
ption=3Dvalue[,throttling.option=3Dvalue[,...]]]``; \ ``-fsdev proxy,id=3Di=
d,socket=3Dsocket[,writeout=3Dwriteout][,readonly]``; \ ``-fsdev proxy,id=
=3Did,sock_fd=3Dsock_fd[,writeout=3Dwriteout][,readonly]``; \ ``-fsdev synt=
h,id=3Did[,readonly]``
> +    Define a new file system device. Valid options are:
> +
> +    ``local``
> +        Accesses to the filesystem are done by QEMU.
> +
> +    ``proxy``
> +        Accesses to the filesystem are done by virtfs-proxy-helper(1).
> +
> +    ``synth``
> +        Synthetic filesystem, only used by QTests.
> +
> +    ``id=3Did``
> +        Specifies identifier for this device.
> +
> +    ``path=3Dpath``
> +        Specifies the export path for the file system device. Files
> +        under this path will be available to the 9p client on the guest.
> +
> +    ``security_model=3Dsecurity_model``
> +        Specifies the security model to be used for this export path.
> +        Supported security models are "passthrough", "mapped-xattr",
> +        "mapped-file" and "none". In "passthrough" security model, files
> +        are stored using the same credentials as they are created on the
> +        guest. This requires QEMU to run as root. In "mapped-xattr"
> +        security model, some of the file attributes like uid, gid, mode
> +        bits and link target are stored as file attributes. For
> +        "mapped-file" these attributes are stored in the hidden
> +        .virtfs\_metadata directory. Directories exported by this
> +        security model cannot interact with other unix tools. "none"
> +        security model is same as passthrough except the sever won't
> +        report failures if it fails to set file attributes like
> +        ownership. Security model is mandatory only for local fsdriver.
> +        Other fsdrivers (like proxy) don't take security model as a
> +        parameter.
> +
> +    ``writeout=3Dwriteout``
> +        This is an optional argument. The only supported value is
> +        "immediate". This means that host page cache will be used to
> +        read and write data but write notification will be sent to the
> +        guest only when the data has been reported as written by the
> +        storage subsystem.
> +
> +    ``readonly``
> +        Enables exporting 9p share as a readonly mount for guests. By
> +        default read-write access is given.
> +
> +    ``socket=3Dsocket``
> +        Enables proxy filesystem driver to use passed socket file for
> +        communicating with virtfs-proxy-helper(1).
> +
> +    ``sock_fd=3Dsock_fd``
> +        Enables proxy filesystem driver to use passed socket descriptor
> +        for communicating with virtfs-proxy-helper(1). Usually a helper
> +        like libvirt will create socketpair and pass one of the fds as
> +        sock\_fd.
> +
> +    ``fmode=3Dfmode``
> +        Specifies the default mode for newly created files on the host.
> +        Works only with security models "mapped-xattr" and
> +        "mapped-file".
> +
> +    ``dmode=3Ddmode``
> +        Specifies the default mode for newly created directories on the
> +        host. Works only with security models "mapped-xattr" and
> +        "mapped-file".
> +
> +    ``throttling.bps-total=3Db,throttling.bps-read=3Dr,throttling.bps-wr=
ite=3Dw``
> +        Specify bandwidth throttling limits in bytes per second, either
> +        for all request types or for reads or writes only.
> +
> +    ``throttling.bps-total-max=3Dbm,bps-read-max=3Drm,bps-write-max=3Dwm=
``
> +        Specify bursts in bytes per second, either for all request types
> +        or for reads or writes only. Bursts allow the guest I/O to spike
> +        above the limit temporarily.
> +
> +    ``throttling.iops-total=3Di,throttling.iops-read=3Dr, throttling.iop=
s-write=3Dw``
> +        Specify request rate limits in requests per second, either for
> +        all request types or for reads or writes only.
> +
> +    ``throttling.iops-total-max=3Dim,throttling.iops-read-max=3Dirm, thr=
ottling.iops-write-max=3Diwm``
> +        Specify bursts in requests per second, either for all request
> +        types or for reads or writes only. Bursts allow the guest I/O to
> +        spike above the limit temporarily.
> +
> +    ``throttling.iops-size=3Dis``
> +        Let every is bytes of a request count as a new request for iops
> +        throttling purposes.
> +
> +    -fsdev option is used along with -device driver "virtio-9p-...".
> +
> +``-device virtio-9p-type,fsdev=3Did,mount_tag=3Dmount_tag``
> +    Options for virtio-9p-... driver are:
> +
> +    ``type``
> +        Specifies the variant to be used. Supported values are "pci",
> +        "ccw" or "device", depending on the machine type.
> +
> +    ``fsdev=3Did``
> +        Specifies the id value specified along with -fsdev option.
> +
> +    ``mount_tag=3Dmount_tag``
> +        Specifies the tag name to be used by the guest to mount this
> +        export point.
> +ERST
>=20=20
>  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
>      "-virtfs local,path=3Dpath,mount_tag=3Dtag,security_model=3Dmapped-x=
attr|mapped-file|passthrough|none\n"
> @@ -1557,6 +2790,107 @@ currently not block all possible file access oper=
ations (e.g. readdir()
>  would still return entries from other devices).
>  @end table
>  ETEXI
> +SRST
> +``-virtfs local,path=3Dpath,mount_tag=3Dmount_tag ,security_model=3Dsecu=
rity_model[,writeout=3Dwriteout][,readonly] [,fmode=3Dfmode][,dmode=3Ddmode=
][,multidevs=3Dmultidevs]``; \ ``-virtfs proxy,socket=3Dsocket,mount_tag=3D=
mount_tag [,writeout=3Dwriteout][,readonly]``; \ ``-virtfs proxy,sock_fd=3D=
sock_fd,mount_tag=3Dmount_tag [,writeout=3Dwriteout][,readonly]``; \ ``-vir=
tfs synth,mount_tag=3Dmount_tag``
> +    Define a new filesystem device and expose it to the guest using a
> +    virtio-9p-device. The general form of a Virtual File system
> +    pass-through options are:
> +
> +    ``local``
> +        Accesses to the filesystem are done by QEMU.
> +
> +    ``proxy``
> +        Accesses to the filesystem are done by virtfs-proxy-helper(1).
> +
> +    ``synth``
> +        Synthetic filesystem, only used by QTests.
> +
> +    ``id=3Did``
> +        Specifies identifier for the filesystem device
> +
> +    ``path=3Dpath``
> +        Specifies the export path for the file system device. Files
> +        under this path will be available to the 9p client on the guest.
> +
> +    ``security_model=3Dsecurity_model``
> +        Specifies the security model to be used for this export path.
> +        Supported security models are "passthrough", "mapped-xattr",
> +        "mapped-file" and "none". In "passthrough" security model, files
> +        are stored using the same credentials as they are created on the
> +        guest. This requires QEMU to run as root. In "mapped-xattr"
> +        security model, some of the file attributes like uid, gid, mode
> +        bits and link target are stored as file attributes. For
> +        "mapped-file" these attributes are stored in the hidden
> +        .virtfs\_metadata directory. Directories exported by this
> +        security model cannot interact with other unix tools. "none"
> +        security model is same as passthrough except the sever won't
> +        report failures if it fails to set file attributes like
> +        ownership. Security model is mandatory only for local fsdriver.
> +        Other fsdrivers (like proxy) don't take security model as a
> +        parameter.
> +
> +    ``writeout=3Dwriteout``
> +        This is an optional argument. The only supported value is
> +        "immediate". This means that host page cache will be used to
> +        read and write data but write notification will be sent to the
> +        guest only when the data has been reported as written by the
> +        storage subsystem.
> +
> +    ``readonly``
> +        Enables exporting 9p share as a readonly mount for guests. By
> +        default read-write access is given.
> +
> +    ``socket=3Dsocket``
> +        Enables proxy filesystem driver to use passed socket file for
> +        communicating with virtfs-proxy-helper(1). Usually a helper like
> +        libvirt will create socketpair and pass one of the fds as
> +        sock\_fd.
> +
> +    ``sock_fd``
> +        Enables proxy filesystem driver to use passed 'sock\_fd' as the
> +        socket descriptor for interfacing with virtfs-proxy-helper(1).
> +
> +    ``fmode=3Dfmode``
> +        Specifies the default mode for newly created files on the host.
> +        Works only with security models "mapped-xattr" and
> +        "mapped-file".
> +
> +    ``dmode=3Ddmode``
> +        Specifies the default mode for newly created directories on the
> +        host. Works only with security models "mapped-xattr" and
> +        "mapped-file".
> +
> +    ``mount_tag=3Dmount_tag``
> +        Specifies the tag name to be used by the guest to mount this
> +        export point.
> +
> +    ``multidevs=3Dmultidevs``
> +        Specifies how to deal with multiple devices being shared with a
> +        9p export. Supported behaviours are either "remap", "forbid" or
> +        "warn". The latter is the default behaviour on which virtfs 9p
> +        expects only one device to be shared with the same export, and
> +        if more than one device is shared and accessed via the same 9p
> +        export then only a warning message is logged (once) by qemu on
> +        host side. In order to avoid file ID collisions on guest you
> +        should either create a separate virtfs export for each device to
> +        be shared with guests (recommended way) or you might use "remap"
> +        instead which allows you to share multiple devices with only one
> +        export instead, which is achieved by remapping the original
> +        inode numbers from host to guest in a way that would prevent
> +        such collisions. Remapping inodes in such use cases is required
> +        because the original device IDs from host are never passed and
> +        exposed on guest. Instead all files of an export shared with
> +        virtfs always share the same device id on guest. So two files
> +        with identical inode numbers but from actually different devices
> +        on host would otherwise cause a file ID collision and hence
> +        potential misbehaviours on guest. "forbid" on the other hand
> +        assumes like "warn" that only one device is shared by the same
> +        export, however it will not only log a warning message but also
> +        deny access to additional devices on guest. Note though that
> +        "forbid" does currently not block all possible file access
> +        operations (e.g. readdir() would still return entries from other
> +        devices).
> +ERST
>=20=20
>  DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
>      "-iscsi [user=3Duser][,password=3Dpassword]\n"
> @@ -1570,6 +2904,10 @@ STEXI
>  @findex -iscsi
>  Configure iSCSI session parameters.
>  ETEXI
> +SRST
> +``-iscsi``
> +    Configure iSCSI session parameters.
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -1592,6 +2930,13 @@ not enabled by default).  Note that on-board USB h=
ost controllers may not
>  support USB 3.0.  In this case @option{-device qemu-xhci} can be used in=
stead
>  on machines with PCI.
>  ETEXI
> +SRST
> +``-usb``
> +    Enable USB emulation on machine types with an on-board USB host
> +    controller (if not enabled by default). Note that on-board USB host
> +    controllers may not support USB 3.0. In this case
> +    ``-device qemu-xhci`` can be used instead on machines with PCI.
> +ERST
>=20=20
>  DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
>      "-usbdevice name add the host or guest USB device 'name'\n",
> @@ -1619,6 +2964,26 @@ or fake device.
>=20=20
>  @end table
>  ETEXI
> +SRST
> +``-usbdevice devname``
> +    Add the USB device devname. Note that this option is deprecated,
> +    please use ``-device usb-...`` instead. See
> +    :ref:`usb_005fdevices`.
> +
> +    ``mouse``
> +        Virtual Mouse. This will override the PS/2 mouse emulation when
> +        activated.
> +
> +    ``tablet``
> +        Pointer device that uses absolute coordinates (like a
> +        touchscreen). This means QEMU is able to report the mouse
> +        position without having to grab the mouse. Also overrides the
> +        PS/2 mouse emulation when activated.
> +
> +    ``braille``
> +        Braille device. This will use BrlAPI to display the braille
> +        output on a real or fake device.
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -1705,6 +3070,53 @@ application. The Spice server will redirect the se=
rial consoles and
>  QEMU monitors. (Since 4.0)
>  @end table
>  ETEXI
> +SRST
> +``-display type``
> +    Select type of display to use. This option is a replacement for the
> +    old style -sdl/-curses/... options. Use ``-display help`` to list
> +    the available display types. Valid values for type are
> +
> +    ``sdl``
> +        Display video output via SDL (usually in a separate graphics
> +        window; see the SDL documentation for other possibilities).
> +
> +    ``curses``
> +        Display video output via curses. For graphics device models
> +        which support a text mode, QEMU can display this output using a
> +        curses/ncurses interface. Nothing is displayed when the graphics
> +        device is in graphical mode or if the graphics device does not
> +        support a text mode. Generally only the VGA device models
> +        support text mode. The font charset used by the guest can be
> +        specified with the ``charset`` option, for example
> +        ``charset=3DCP850`` for IBM CP850 encoding. The default is
> +        ``CP437``.
> +
> +    ``none``
> +        Do not display video output. The guest will still see an
> +        emulated graphics card, but its output will not be displayed to
> +        the QEMU user. This option differs from the -nographic option in
> +        that it only affects what is done with video output; -nographic
> +        also changes the destination of the serial and parallel port
> +        data.
> +
> +    ``gtk``
> +        Display video output in a GTK window. This interface provides
> +        drop-down menus and other UI elements to configure and control
> +        the VM during runtime.
> +
> +    ``vnc``
> +        Start a VNC server on display <arg>
> +
> +    ``egl-headless``
> +        Offload all OpenGL operations to a local DRI device. For any
> +        graphical display, this display needs to be paired with either
> +        VNC or SPICE displays.
> +
> +    ``spice-app``
> +        Start QEMU as a Spice server and launch the default Spice client
> +        application. The Spice server will redirect the serial consoles
> +        and QEMU monitors. (Since 4.0)
> +ERST
>=20=20
>  DEF("nographic", 0, QEMU_OPTION_nographic,
>      "-nographic      disable graphical output and redirect serial I/Os t=
o console\n",
> @@ -1721,6 +3133,17 @@ redirected elsewhere explicitly). Therefore, you c=
an still use QEMU to
>  debug a Linux kernel with a serial console. Use @key{C-a h} for help on
>  switching between the console and monitor.
>  ETEXI
> +SRST
> +``-nographic``
> +    Normally, if QEMU is compiled with graphical window support, it
> +    displays output such as guest graphics, guest console, and the QEMU
> +    monitor in a window. With this option, you can totally disable
> +    graphical output so that QEMU is a simple command line application.
> +    The emulated serial port is redirected on the console and muxed with
> +    the monitor (unless redirected elsewhere explicitly). Therefore, you
> +    can still use QEMU to debug a Linux kernel with a serial console.
> +    Use C-a h for help on switching between the console and monitor.
> +ERST
>=20=20
>  DEF("curses", 0, QEMU_OPTION_curses,
>      "-curses         shorthand for -display curses\n",
> @@ -1734,6 +3157,14 @@ window. With this option, QEMU can display the VGA=
 output when in text
>  mode using a curses/ncurses interface. Nothing is displayed in graphical
>  mode.
>  ETEXI
> +SRST
> +``-curses``
> +    Normally, if QEMU is compiled with graphical window support, it
> +    displays output such as guest graphics, guest console, and the QEMU
> +    monitor in a window. With this option, QEMU can display the VGA
> +    output when in text mode using a curses/ncurses interface. Nothing
> +    is displayed in graphical mode.
> +ERST
>=20=20
>  DEF("alt-grab", 0, QEMU_OPTION_alt_grab,
>      "-alt-grab       use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-A=
lt)\n",
> @@ -1744,6 +3175,12 @@ STEXI
>  Use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-Alt). Note that this a=
lso
>  affects the special keys (for fullscreen, monitor-mode switching, etc).
>  ETEXI
> +SRST
> +``-alt-grab``
> +    Use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-Alt). Note that
> +    this also affects the special keys (for fullscreen, monitor-mode
> +    switching, etc).
> +ERST
>=20=20
>  DEF("ctrl-grab", 0, QEMU_OPTION_ctrl_grab,
>      "-ctrl-grab      use Right-Ctrl to grab mouse (instead of Ctrl-Alt)\=
n",
> @@ -1754,6 +3191,12 @@ STEXI
>  Use Right-Ctrl to grab mouse (instead of Ctrl-Alt). Note that this also
>  affects the special keys (for fullscreen, monitor-mode switching, etc).
>  ETEXI
> +SRST
> +``-ctrl-grab``
> +    Use Right-Ctrl to grab mouse (instead of Ctrl-Alt). Note that this
> +    also affects the special keys (for fullscreen, monitor-mode
> +    switching, etc).
> +ERST
>=20=20
>  DEF("no-quit", 0, QEMU_OPTION_no_quit,
>      "-no-quit        disable SDL window close capability\n", QEMU_ARCH_A=
LL)
> @@ -1762,6 +3205,10 @@ STEXI
>  @findex -no-quit
>  Disable SDL window close capability.
>  ETEXI
> +SRST
> +``-no-quit``
> +    Disable SDL window close capability.
> +ERST
>=20=20
>  DEF("sdl", 0, QEMU_OPTION_sdl,
>      "-sdl            shorthand for -display sdl\n", QEMU_ARCH_ALL)
> @@ -1770,6 +3217,10 @@ STEXI
>  @findex -sdl
>  Enable SDL.
>  ETEXI
> +SRST
> +``-sdl``
> +    Enable SDL.
> +ERST
>=20=20
>  DEF("spice", HAS_ARG, QEMU_OPTION_spice,
>      "-spice [port=3Dport][,tls-port=3Dsecured-port][,x509-dir=3D<dir>]\n"
> @@ -1887,6 +3338,95 @@ the first available. (Since 2.9)
>=20=20
>  @end table
>  ETEXI
> +SRST
> +``-spice option[,option[,...]]``
> +    Enable the spice remote desktop protocol. Valid options are
> +
> +    ``port=3D<nr>``
> +        Set the TCP port spice is listening on for plaintext channels.
> +
> +    ``addr=3D<addr>``
> +        Set the IP address spice is listening on. Default is any
> +        address.
> +
> +    ``ipv4``; \ ``ipv6``; \ ``unix``
> +        Force using the specified IP version.
> +
> +    ``password=3D<secret>``
> +        Set the password you need to authenticate.
> +
> +    ``sasl``
> +        Require that the client use SASL to authenticate with the spice.
> +        The exact choice of authentication method used is controlled
> +        from the system / user's SASL configuration file for the 'qemu'
> +        service. This is typically found in /etc/sasl2/qemu.conf. If
> +        running QEMU as an unprivileged user, an environment variable
> +        SASL\_CONF\_PATH can be used to make it search alternate
> +        locations for the service config. While some SASL auth methods
> +        can also provide data encryption (eg GSSAPI), it is recommended
> +        that SASL always be combined with the 'tls' and 'x509' settings
> +        to enable use of SSL and server certificates. This ensures a
> +        data encryption preventing compromise of authentication
> +        credentials.
> +
> +    ``disable-ticketing``
> +        Allow client connects without authentication.
> +
> +    ``disable-copy-paste``
> +        Disable copy paste between the client and the guest.
> +
> +    ``disable-agent-file-xfer``
> +        Disable spice-vdagent based file-xfer between the client and the
> +        guest.
> +
> +    ``tls-port=3D<nr>``
> +        Set the TCP port spice is listening on for encrypted channels.
> +
> +    ``x509-dir=3D<dir>``
> +        Set the x509 file directory. Expects same filenames as -vnc
> +        $display,x509=3D$dir
> +
> +    ``x509-key-file=3D<file>``; \ ``x509-key-password=3D<file>``; \ ``x5=
09-cert-file=3D<file>``; \ ``x509-cacert-file=3D<file>``; \ ``x509-dh-key-f=
ile=3D<file>``
> +        The x509 file names can also be configured individually.
> +
> +    ``tls-ciphers=3D<list>``
> +        Specify which ciphers to use.
> +
> +    ``tls-channel=3D[main|display|cursor|inputs|record|playback]``; \ ``=
plaintext-channel=3D[main|display|cursor|inputs|record|playback]``
> +        Force specific channel to be used with or without TLS
> +        encryption. The options can be specified multiple times to
> +        configure multiple channels. The special name "default" can be
> +        used to set the default mode. For channels which are not
> +        explicitly forced into one mode the spice client is allowed to
> +        pick tls/plaintext as he pleases.
> +
> +    ``image-compression=3D[auto_glz|auto_lz|quic|glz|lz|off]``
> +        Configure image compression (lossless). Default is auto\_glz.
> +
> +    ``jpeg-wan-compression=3D[auto|never|always]``; \ ``zlib-glz-wan-com=
pression=3D[auto|never|always]``
> +        Configure wan image compression (lossy for slow links). Default
> +        is auto.
> +
> +    ``streaming-video=3D[off|all|filter]``
> +        Configure video stream detection. Default is off.
> +
> +    ``agent-mouse=3D[on|off]``
> +        Enable/disable passing mouse events via vdagent. Default is on.
> +
> +    ``playback-compression=3D[on|off]``
> +        Enable/disable audio stream compression (using celt 0.5.1).
> +        Default is on.
> +
> +    ``seamless-migration=3D[on|off]``
> +        Enable/disable spice seamless migration. Default is off.
> +
> +    ``gl=3D[on|off]``
> +        Enable/disable OpenGL context. Default is off.
> +
> +    ``rendernode=3D<file>``
> +        DRM render node for OpenGL rendering. If not specified, it will
> +        pick the first available. (Since 2.9)
> +ERST
>=20=20
>  DEF("portrait", 0, QEMU_OPTION_portrait,
>      "-portrait       rotate graphical output 90 deg left (only PXA LCD)\=
n",
> @@ -1896,6 +3436,10 @@ STEXI
>  @findex -portrait
>  Rotate graphical output 90 deg left (only PXA LCD).
>  ETEXI
> +SRST
> +``-portrait``
> +    Rotate graphical output 90 deg left (only PXA LCD).
> +ERST
>=20=20
>  DEF("rotate", HAS_ARG, QEMU_OPTION_rotate,
>      "-rotate <deg>   rotate graphical output some deg left (only PXA LCD=
)\n",
> @@ -1905,6 +3449,10 @@ STEXI
>  @findex -rotate
>  Rotate graphical output some deg left (only PXA LCD).
>  ETEXI
> +SRST
> +``-rotate deg``
> +    Rotate graphical output some deg left (only PXA LCD).
> +ERST
>=20=20
>  DEF("vga", HAS_ARG, QEMU_OPTION_vga,
>      "-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]\n"
> @@ -1946,6 +3494,51 @@ Virtio VGA card.
>  Disable VGA card.
>  @end table
>  ETEXI
> +SRST
> +``-vga type``
> +    Select type of VGA card to emulate. Valid values for type are
> +
> +    ``cirrus``
> +        Cirrus Logic GD5446 Video card. All Windows versions starting
> +        from Windows 95 should recognize and use this graphic card. For
> +        optimal performances, use 16 bit color depth in the guest and
> +        the host OS. (This card was the default before QEMU 2.2)
> +
> +    ``std``
> +        Standard VGA card with Bochs VBE extensions. If your guest OS
> +        supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if
> +        you want to use high resolution modes (>=3D 1280x1024x16) then y=
ou
> +        should use this option. (This card is the default since QEMU
> +        2.2)
> +
> +    ``vmware``
> +        VMWare SVGA-II compatible adapter. Use it if you have
> +        sufficiently recent XFree86/XOrg server or Windows guest with a
> +        driver for this card.
> +
> +    ``qxl``
> +        QXL paravirtual graphic card. It is VGA compatible (including
> +        VESA 2.0 VBE support). Works best with qxl guest drivers
> +        installed though. Recommended choice when using the spice
> +        protocol.
> +
> +    ``tcx``
> +        (sun4m only) Sun TCX framebuffer. This is the default
> +        framebuffer for sun4m machines and offers both 8-bit and 24-bit
> +        colour depths at a fixed resolution of 1024x768.
> +
> +    ``cg3``
> +        (sun4m only) Sun cgthree framebuffer. This is a simple 8-bit
> +        framebuffer for sun4m machines available in both 1024x768
> +        (OpenBIOS) and 1152x900 (OBP) resolutions aimed at people
> +        wishing to run older Solaris versions.
> +
> +    ``virtio``
> +        Virtio VGA card.
> +
> +    ``none``
> +        Disable VGA card.
> +ERST
>=20=20
>  DEF("full-screen", 0, QEMU_OPTION_full_screen,
>      "-full-screen    start in full screen\n", QEMU_ARCH_ALL)
> @@ -1954,6 +3547,10 @@ STEXI
>  @findex -full-screen
>  Start in full screen.
>  ETEXI
> +SRST
> +``-full-screen``
> +    Start in full screen.
> +ERST
>=20=20
>  DEF("g", HAS_ARG, QEMU_OPTION_g ,
>      "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
> @@ -1970,6 +3567,17 @@ option of 1024x768x24. For cgthree, the default is=
 1024x768x8 with the option
>  of 1152x900x8 for people who wish to use OBP.
>=20=20
>  ETEXI
> +SRST
> +``-g widthxheight[xdepth]``
> +    Set the initial graphical resolution and depth (PPC, SPARC only).
> +
> +    For PPC the default is 800x600x32.
> +
> +    For SPARC with the TCX graphics device, the default is 1024x768x8
> +    with the option of 1024x768x24. For cgthree, the default is
> +    1024x768x8 with the option of 1152x900x8 for people who wish to use
> +    OBP.
> +ERST
>=20=20
>  DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
>      "-vnc <display>  shorthand for -display vnc=3D<display>\n", QEMU_ARC=
H_ALL)
> @@ -2155,6 +3763,171 @@ be omitted, otherwise is must be present and spec=
ify a valid audiodev.
>=20=20
>  @end table
>  ETEXI
> +SRST
> +``-vnc display[,option[,option[,...]]]``
> +    Normally, if QEMU is compiled with graphical window support, it
> +    displays output such as guest graphics, guest console, and the QEMU
> +    monitor in a window. With this option, you can have QEMU listen on
> +    VNC display display and redirect the VGA display over the VNC
> +    session. It is very useful to enable the usb tablet device when
> +    using this option (option ``-device usb-tablet``). When using the
> +    VNC display, you must use the ``-k`` parameter to set the keyboard
> +    layout if you are not using en-us. Valid syntax for the display is
> +
> +    ``to=3DL``
> +        With this option, QEMU will try next available VNC displays,
> +        until the number L, if the origianlly defined "-vnc display" is
> +        not available, e.g. port 5900+display is already used by another
> +        application. By default, to=3D0.
> +
> +    ``host:d``
> +        TCP connections will only be allowed from host on display d. By
> +        convention the TCP port is 5900+d. Optionally, host can be
> +        omitted in which case the server will accept connections from
> +        any host.
> +
> +    ``unix:path``
> +        Connections will be allowed over UNIX domain sockets where path
> +        is the location of a unix socket to listen for connections on.
> +
> +    ``none``
> +        VNC is initialized but not started. The monitor ``change``
> +        command can be used to later start the VNC server.
> +
> +    Following the display value there may be one or more option flags
> +    separated by commas. Valid options are
> +
> +    ``reverse``
> +        Connect to a listening VNC client via a "reverse" connection.
> +        The client is specified by the display. For reverse network
> +        connections (host:d,``reverse``), the d argument is a TCP port
> +        number, not a display number.
> +
> +    ``websocket``
> +        Opens an additional TCP listening port dedicated to VNC
> +        Websocket connections. If a bare websocket option is given, the
> +        Websocket port is 5700+display. An alternative port can be
> +        specified with the syntax ``websocket``\ =3Dport.
> +
> +        If host is specified connections will only be allowed from this
> +        host. It is possible to control the websocket listen address
> +        independently, using the syntax ``websocket``\ =3Dhost:port.
> +
> +        If no TLS credentials are provided, the websocket connection
> +        runs in unencrypted mode. If TLS credentials are provided, the
> +        websocket connection requires encrypted client connections.
> +
> +    ``password``
> +        Require that password based authentication is used for client
> +        connections.
> +
> +        The password must be set separately using the ``set_password``
> +        command in the :ref:`pcsys_005fmonitor`. The
> +        syntax to change your password is:
> +        ``set_password <protocol> <password>`` where <protocol> could be
> +        either "vnc" or "spice".
> +
> +        If you would like to change <protocol> password expiration, you
> +        should use ``expire_password <protocol> <expiration-time>``
> +        where expiration time could be one of the following options:
> +        now, never, +seconds or UNIX time of expiration, e.g. +60 to
> +        make password expire in 60 seconds, or 1335196800 to make
> +        password expire on "Mon Apr 23 12:00:00 EDT 2012" (UNIX time for
> +        this date and time).
> +
> +        You can also use keywords "now" or "never" for the expiration
> +        time to allow <protocol> password to expire immediately or never
> +        expire.
> +
> +    ``tls-creds=3DID``
> +        Provides the ID of a set of TLS credentials to use to secure the
> +        VNC server. They will apply to both the normal VNC server socket
> +        and the websocket socket (if enabled). Setting TLS credentials
> +        will cause the VNC server socket to enable the VeNCrypt auth
> +        mechanism. The credentials should have been previously created
> +        using the ``-object tls-creds`` argument.
> +
> +    ``tls-authz=3DID``
> +        Provides the ID of the QAuthZ authorization object against which
> +        the client's x509 distinguished name will validated. This object
> +        is only resolved at time of use, so can be deleted and recreated
> +        on the fly while the VNC server is active. If missing, it will
> +        default to denying access.
> +
> +    ``sasl``
> +        Require that the client use SASL to authenticate with the VNC
> +        server. The exact choice of authentication method used is
> +        controlled from the system / user's SASL configuration file for
> +        the 'qemu' service. This is typically found in
> +        /etc/sasl2/qemu.conf. If running QEMU as an unprivileged user,
> +        an environment variable SASL\_CONF\_PATH can be used to make it
> +        search alternate locations for the service config. While some
> +        SASL auth methods can also provide data encryption (eg GSSAPI),
> +        it is recommended that SASL always be combined with the 'tls'
> +        and 'x509' settings to enable use of SSL and server
> +        certificates. This ensures a data encryption preventing
> +        compromise of authentication credentials. See the
> +        :ref:`vnc_005fsecurity` section for details on
> +        using SASL authentication.
> +
> +    ``sasl-authz=3DID``
> +        Provides the ID of the QAuthZ authorization object against which
> +        the client's SASL username will validated. This object is only
> +        resolved at time of use, so can be deleted and recreated on the
> +        fly while the VNC server is active. If missing, it will default
> +        to denying access.
> +
> +    ``acl``
> +        Legacy method for enabling authorization of clients against the
> +        x509 distinguished name and SASL username. It results in the
> +        creation of two ``authz-list`` objects with IDs of
> +        ``vnc.username`` and ``vnc.x509dname``. The rules for these
> +        objects must be configured with the HMP ACL commands.
> +
> +        This option is deprecated and should no longer be used. The new
> +        ``sasl-authz`` and ``tls-authz`` options are a replacement.
> +
> +    ``lossy``
> +        Enable lossy compression methods (gradient, JPEG, ...). If this
> +        option is set, VNC client may receive lossy framebuffer updates
> +        depending on its encoding settings. Enabling this option can
> +        save a lot of bandwidth at the expense of quality.
> +
> +    ``non-adaptive``
> +        Disable adaptive encodings. Adaptive encodings are enabled by
> +        default. An adaptive encoding will try to detect frequently
> +        updated screen regions, and send updates in these regions using
> +        a lossy encoding (like JPEG). This can be really helpful to save
> +        bandwidth when playing videos. Disabling adaptive encodings
> +        restores the original static behavior of encodings like Tight.
> +
> +    ``share=3D[allow-exclusive|force-shared|ignore]``
> +        Set display sharing policy. 'allow-exclusive' allows clients to
> +        ask for exclusive access. As suggested by the rfb spec this is
> +        implemented by dropping other connections. Connecting multiple
> +        clients in parallel requires all clients asking for a shared
> +        session (vncviewer: -shared switch). This is the default.
> +        'force-shared' disables exclusive client access. Useful for
> +        shared desktop sessions, where you don't want someone forgetting
> +        specify -shared disconnect everybody else. 'ignore' completely
> +        ignores the shared flag and allows everybody connect
> +        unconditionally. Doesn't conform to the rfb spec but is
> +        traditional QEMU behavior.
> +
> +    ``key-delay-ms``
> +        Set keyboard delay, for key down and key up events, in
> +        milliseconds. Default is 10. Keyboards are low-bandwidth
> +        devices, so this slowdown can help the device and guest to keep
> +        up and not lose events in case events are arriving in bulk.
> +        Possible causes for the latter are flaky network connections, or
> +        scripts for automated testing.
> +
> +    ``audiodev=3Daudiodev``
> +        Use the specified audiodev when the VNC client requests audio
> +        transmission. When not using an -audiodev argument, this option
> +        must be omitted, otherwise is must be present and specify a
> +        valid audiodev.
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -2176,6 +3949,12 @@ Use it when installing Windows 2000 to avoid a dis=
k full bug. After
>  Windows 2000 is installed, you no longer need this option (this option
>  slows down the IDE transfers).
>  ETEXI
> +SRST
> +``-win2k-hack``
> +    Use it when installing Windows 2000 to avoid a disk full bug. After
> +    Windows 2000 is installed, you no longer need this option (this
> +    option slows down the IDE transfers).
> +ERST
>=20=20
>  DEF("no-fd-bootchk", 0, QEMU_OPTION_no_fd_bootchk,
>      "-no-fd-bootchk  disable boot signature checking for floppy disks\n",
> @@ -2186,6 +3965,11 @@ STEXI
>  Disable boot signature checking for floppy disks in BIOS. May
>  be needed to boot from old floppy disks.
>  ETEXI
> +SRST
> +``-no-fd-bootchk``
> +    Disable boot signature checking for floppy disks in BIOS. May be
> +    needed to boot from old floppy disks.
> +ERST
>=20=20
>  DEF("no-acpi", 0, QEMU_OPTION_no_acpi,
>             "-no-acpi        disable ACPI\n", QEMU_ARCH_I386 | QEMU_ARCH_=
ARM)
> @@ -2196,6 +3980,12 @@ Disable ACPI (Advanced Configuration and Power Int=
erface) support. Use
>  it if your guest OS complains about ACPI problems (PC target machine
>  only).
>  ETEXI
> +SRST
> +``-no-acpi``
> +    Disable ACPI (Advanced Configuration and Power Interface) support.
> +    Use it if your guest OS complains about ACPI problems (PC target
> +    machine only).
> +ERST
>=20=20
>  DEF("no-hpet", 0, QEMU_OPTION_no_hpet,
>      "-no-hpet        disable HPET\n", QEMU_ARCH_I386)
> @@ -2204,6 +3994,10 @@ STEXI
>  @findex -no-hpet
>  Disable HPET support.
>  ETEXI
> +SRST
> +``-no-hpet``
> +    Disable HPET support.
> +ERST
>=20=20
>  DEF("acpitable", HAS_ARG, QEMU_OPTION_acpitable,
>      "-acpitable [sig=3Dstr][,rev=3Dn][,oem_id=3Dstr][,oem_table_id=3Dstr=
][,oem_rev=3Dn][,asl_compiler_id=3Dstr][,asl_compiler_rev=3Dn][,{data|file}=
=3Dfile1[:file2]...]\n"
> @@ -2222,6 +4016,18 @@ fields will override the same in the RSDT and the =
FADT (a.k.a. FACP), in order
>  to ensure the field matches required by the Microsoft SLIC spec and the =
ACPI
>  spec.
>  ETEXI
> +SRST
> +``-acpitable [sig=3Dstr][,rev=3Dn][,oem_id=3Dstr][,oem_table_id=3Dstr][,=
oem_rev=3Dn] [,asl_compiler_id=3Dstr][,asl_compiler_rev=3Dn][,data=3Dfile1[=
:file2]...]``
> +    Add ACPI table with specified header fields and context from
> +    specified files. For file=3D, take whole ACPI table from the specifi=
ed
> +    files, including all ACPI headers (possible overridden by other
> +    options). For data=3D, only data portion of the table is used, all
> +    header information is specified in the command line. If a SLIC table
> +    is supplied to QEMU, then the SLIC's oem\_id and oem\_table\_id
> +    fields will override the same in the RSDT and the FADT (a.k.a.
> +    FACP), in order to ensure the field matches required by the
> +    Microsoft SLIC spec and the ACPI spec.
> +ERST
>=20=20
>  DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "-smbios file=3Dbinary\n"
> @@ -2268,6 +4074,28 @@ Specify SMBIOS type 4 fields
>  @item -smbios type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,manufa=
cturer=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{s=
tr}][,speed=3D@var{%d}]
>  Specify SMBIOS type 17 fields
>  ETEXI
> +SRST
> +``-smbios file=3Dbinary``
> +    Load SMBIOS entry from binary file.
> +
> +``-smbios type=3D0[,vendor=3Dstr][,version=3Dstr][,date=3Dstr][,release=
=3D%d.%d][,uefi=3Don|off]``
> +    Specify SMBIOS type 0 fields
> +
> +``-smbios type=3D1[,manufacturer=3Dstr][,product=3Dstr][,version=3Dstr][=
,serial=3Dstr][,uuid=3Duuid][,sku=3Dstr][,family=3Dstr]``
> +    Specify SMBIOS type 1 fields
> +
> +``-smbios type=3D2[,manufacturer=3Dstr][,product=3Dstr][,version=3Dstr][=
,serial=3Dstr][,asset=3Dstr][,location=3Dstr]``
> +    Specify SMBIOS type 2 fields
> +
> +``-smbios type=3D3[,manufacturer=3Dstr][,version=3Dstr][,serial=3Dstr][,=
asset=3Dstr][,sku=3Dstr]``
> +    Specify SMBIOS type 3 fields
> +
> +``-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr]=
[,serial=3Dstr][,asset=3Dstr][,part=3Dstr]``
> +    Specify SMBIOS type 4 fields
> +
> +``-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,s=
erial=3Dstr][,asset=3Dstr][,part=3Dstr][,speed=3D%d]``
> +    Specify SMBIOS type 17 fields
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -2866,6 +4694,470 @@ Configure a host network backend (with the option=
s corresponding to the same
>  @option{-netdev} option) and connect it to the emulated hub 0 (the defau=
lt
>  hub). Use @var{name} to specify the name of the hub port.
>  ETEXI
> +SRST
> +``-nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=
=3Dmacaddr][,model=3Dmn]``
> +    This option is a shortcut for configuring both the on-board
> +    (default) guest NIC hardware and the host network backend in one go.
> +    The host backend options are the same as with the corresponding
> +    ``-netdev`` options below. The guest NIC model can be set with
> +    ``model=3Dmodelname``. Use ``model=3Dhelp`` to list the available de=
vice
> +    types. The hardware MAC address can be set with ``mac=3Dmacaddr``.
> +
> +    The following two example do exactly the same, to show how ``-nic``
> +    can be used to shorten the command line length:
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| -netdev user,id=3Dn1,ipv6=3Doff -device e1000,netd=
ev=3Dn1,mac=3D52:54:98:76:54:32
> +        |qemu_system| -nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98:=
76:54:32
> +
> +``-nic none``
> +    Indicate that no network devices should be configured. It is used to
> +    override the default configuration (default NIC with "user" host
> +    network backend) which is activated if no other networking options
> +    are provided.
> +
> +``-netdev user,id=3Did[,option][,option][,...]``
> +    Configure user mode host network backend which requires no
> +    administrator privilege to run. Valid options are:
> +
> +    ``id=3Did``
> +        Assign symbolic name for use in monitor commands.
> +
> +    ``ipv4=3Don|off and ipv6=3Don|off``
> +        Specify that either IPv4 or IPv6 must be enabled. If neither is
> +        specified both protocols are enabled.
> +
> +    ``net=3Daddr[/mask]``
> +        Set IP network address the guest will see. Optionally specify
> +        the netmask, either in the form a.b.c.d or as number of valid
> +        top-most bits. Default is 10.0.2.0/24.
> +
> +    ``host=3Daddr``
> +        Specify the guest-visible address of the host. Default is the
> +        2nd IP in the guest network, i.e. x.x.x.2.
> +
> +    ``ipv6-net=3Daddr[/int]``
> +        Set IPv6 network address the guest will see (default is
> +        fec0::/64). The network prefix is given in the usual hexadecimal
> +        IPv6 address notation. The prefix size is optional, and is given
> +        as the number of valid top-most bits (default is 64).
> +
> +    ``ipv6-host=3Daddr``
> +        Specify the guest-visible IPv6 address of the host. Default is
> +        the 2nd IPv6 in the guest network, i.e. xxxx::2.
> +
> +    ``restrict=3Don|off``
> +        If this option is enabled, the guest will be isolated, i.e. it
> +        will not be able to contact the host and no guest IP packets
> +        will be routed over the host to the outside. This option does
> +        not affect any explicitly set forwarding rules.
> +
> +    ``hostname=3Dname``
> +        Specifies the client hostname reported by the built-in DHCP
> +        server.
> +
> +    ``dhcpstart=3Daddr``
> +        Specify the first of the 16 IPs the built-in DHCP server can
> +        assign. Default is the 15th to 31st IP in the guest network,
> +        i.e. x.x.x.15 to x.x.x.31.
> +
> +    ``dns=3Daddr``
> +        Specify the guest-visible address of the virtual nameserver. The
> +        address must be different from the host address. Default is the
> +        3rd IP in the guest network, i.e. x.x.x.3.
> +
> +    ``ipv6-dns=3Daddr``
> +        Specify the guest-visible address of the IPv6 virtual
> +        nameserver. The address must be different from the host address.
> +        Default is the 3rd IP in the guest network, i.e. xxxx::3.
> +
> +    ``dnssearch=3Ddomain``
> +        Provides an entry for the domain-search list sent by the
> +        built-in DHCP server. More than one domain suffix can be
> +        transmitted by specifying this option multiple times. If
> +        supported, this will cause the guest to automatically try to
> +        append the given domain suffix(es) in case a domain name can not
> +        be resolved.
> +
> +        Example:
> +
> +        .. parsed-literal::
> +
> +            |qemu_system| -nic user,dnssearch=3Dmgmt.example.org,dnssear=
ch=3Dexample.org
> +
> +    ``domainname=3Ddomain``
> +        Specifies the client domain name reported by the built-in DHCP
> +        server.
> +
> +    ``tftp=3Ddir``
> +        When using the user mode network stack, activate a built-in TFTP
> +        server. The files in dir will be exposed as the root of a TFTP
> +        server. The TFTP client on the guest must be configured in
> +        binary mode (use the command ``bin`` of the Unix TFTP client).
> +
> +    ``tftp-server-name=3Dname``
> +        In BOOTP reply, broadcast name as the "TFTP server name"
> +        (RFC2132 option 66). This can be used to advise the guest to
> +        load boot files or configurations from a different server than
> +        the host address.
> +
> +    ``bootfile=3Dfile``
> +        When using the user mode network stack, broadcast file as the
> +        BOOTP filename. In conjunction with ``tftp``, this can be used
> +        to network boot a guest from a local directory.
> +
> +        Example (using pxelinux):
> +
> +        .. parsed-literal::
> +
> +            |qemu_system| -hda linux.img -boot n -device e1000,netdev=3D=
n1 \
> +                -netdev user,id=3Dn1,tftp=3D/path/to/tftp/files,bootfile=
=3D/pxelinux.0
> +
> +    ``smb=3Ddir[,smbserver=3Daddr]``
> +        When using the user mode network stack, activate a built-in SMB
> +        server so that Windows OSes can access to the host files in
> +        ``dir`` transparently. The IP address of the SMB server can be
> +        set to addr. By default the 4th IP in the guest network is used,
> +        i.e. x.x.x.4.
> +
> +        In the guest Windows OS, the line:
> +
> +        ::
> +
> +            10.0.2.4 smbserver
> +
> +        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for windows
> +        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
> +        NT/2000).
> +
> +        Then ``dir`` can be accessed in ``\\smbserver\qemu``.
> +
> +        Note that a SAMBA server must be installed on the host OS.
> +
> +    ``hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport``
> +        Redirect incoming TCP or UDP connections to the host port
> +        hostport to the guest IP address guestaddr on guest port
> +        guestport. If guestaddr is not specified, its value is x.x.x.15
> +        (default first address given by the built-in DHCP server). By
> +        specifying hostaddr, the rule can be bound to a specific host
> +        interface. If no connection type is set, TCP is used. This
> +        option can be given multiple times.
> +
> +        For example, to redirect host X11 connection from screen 1 to
> +        guest screen 0, use the following:
> +
> +        ::
> +
> +            # on the host
> +            |qemu_system| -nic user,hostfwd=3Dtcp:127.0.0.1:6001-:6000
> +            # this host xterm should open in the guest X11 server
> +            xterm -display :1
> +
> +        To redirect telnet connections from host port 5555 to telnet
> +        port on the guest, use the following:
> +
> +        ::
> +
> +            # on the host
> +            |qemu_system| -nic user,hostfwd=3Dtcp::5555-:23
> +            telnet localhost 5555
> +
> +        Then when you use on the host ``telnet localhost 5555``, you
> +        connect to the guest telnet server.
> +
> +    ``guestfwd=3D[tcp]:server:port-dev``; \ ``guestfwd=3D[tcp]:server:po=
rt-cmd:command``
> +        Forward guest TCP connections to the IP address server on port
> +        port to the character device dev or to a program executed by
> +        cmd:command which gets spawned for each connection. This option
> +        can be given multiple times.
> +
> +        You can either use a chardev directly and have that one used
> +        throughout QEMU's lifetime, like in the following example:
> +
> +        ::
> +
> +            # open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to =
it whenever
> +            # the guest accesses it
> +            |qemu_system| -nic user,guestfwd=3Dtcp:10.0.2.100:1234-tcp:1=
0.10.1.1:4321
> +
> +        Or you can execute a command on every TCP connection established
> +        by the guest, so that QEMU behaves similar to an inetd process
> +        for that virtual server:
> +
> +        ::
> +
> +            # call "netcat 10.10.1.1 4321" on every TCP connection to 10=
.0.2.100:1234
> +            # and connect the TCP stream to its stdin/stdout
> +            |qemu_system| -nic  'user,id=3Dn1,guestfwd=3Dtcp:10.0.2.100:=
1234-cmd:netcat 10.10.1.1 4321'
> +
> +``-netdev tap,id=3Did[,fd=3Dh][,ifname=3Dname][,script=3Dfile][,downscri=
pt=3Ddfile][,br=3Dbridge][,helper=3Dhelper]``
> +    Configure a host TAP network backend with ID id.
> +
> +    Use the network script file to configure it and the network script
> +    dfile to deconfigure it. If name is not provided, the OS
> +    automatically provides one. The default network configure script is
> +    ``/etc/qemu-ifup`` and the default network deconfigure script is
> +    ``/etc/qemu-ifdown``. Use ``script=3Dno`` or ``downscript=3Dno`` to
> +    disable script execution.
> +
> +    If running QEMU as an unprivileged user, use the network helper
> +    helper to configure the TAP interface and attach it to the bridge.
> +    The default network helper executable is
> +    ``/path/to/qemu-bridge-helper`` and the default bridge device is
> +    ``br0``.
> +
> +    ``fd``\ =3Dh can be used to specify the handle of an already opened
> +    host TAP interface.
> +
> +    Examples:
> +
> +    ::
> +
> +        #launch a QEMU instance with the default network script
> +        |qemu_system| linux.img -nic tap
> +
> +    ::
> +
> +        #launch a QEMU instance with two NICs, each one connected
> +        #to a TAP device
> +        |qemu_system| linux.img \
> +                -netdev tap,id=3Dnd0,ifname=3Dtap0 -device e1000,netdev=
=3Dnd0 \
> +                -netdev tap,id=3Dnd1,ifname=3Dtap1 -device rtl8139,netde=
v=3Dnd1
> +
> +    ::
> +
> +        #launch a QEMU instance with the default network helper to
> +        #connect a TAP device to bridge br0
> +        |qemu_system| linux.img -device virtio-net-pci,netdev=3Dn1 \
> +                -netdev tap,id=3Dn1,"helper=3D/path/to/qemu-bridge-helpe=
r"
> +
> +``-netdev bridge,id=3Did[,br=3Dbridge][,helper=3Dhelper]``
> +    Connect a host TAP network interface to a host bridge device.
> +
> +    Use the network helper helper to configure the TAP interface and
> +    attach it to the bridge. The default network helper executable is
> +    ``/path/to/qemu-bridge-helper`` and the default bridge device is
> +    ``br0``.
> +
> +    Examples:
> +
> +    ::
> +
> +        #launch a QEMU instance with the default network helper to
> +        #connect a TAP device to bridge br0
> +        |qemu_system| linux.img -netdev bridge,id=3Dn1 -device virtio-ne=
t,netdev=3Dn1
> +
> +    ::
> +
> +        #launch a QEMU instance with the default network helper to
> +        #connect a TAP device to bridge qemubr0
> +        |qemu_system| linux.img -netdev bridge,br=3Dqemubr0,id=3Dn1 -dev=
ice virtio-net,netdev=3Dn1
> +
> +``-netdev socket,id=3Did[,fd=3Dh][,listen=3D[host]:port][,connect=3Dhost=
:port]``
> +    This host network backend can be used to connect the guest's network
> +    to another QEMU virtual machine using a TCP socket connection. If
> +    ``listen`` is specified, QEMU waits for incoming connections on port
> +    (host is optional). ``connect`` is used to connect to another QEMU
> +    instance using the ``listen`` option. ``fd``\ =3Dh specifies an
> +    already opened TCP socket.
> +
> +    Example:
> +
> +    ::
> +
> +        # launch a first QEMU instance
> +        |qemu_system| linux.img \
> +                         -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:=
56 \
> +                         -netdev socket,id=3Dn1,listen=3D:1234
> +        # connect the network of this instance to the network of the fir=
st instance
> +        |qemu_system| linux.img \
> +                         -device e1000,netdev=3Dn2,mac=3D52:54:00:12:34:=
57 \
> +                         -netdev socket,id=3Dn2,connect=3D127.0.0.1:1234
> +
> +``-netdev socket,id=3Did[,fd=3Dh][,mcast=3Dmaddr:port[,localaddr=3Daddr]=
]``
> +    Configure a socket host network backend to share the guest's network
> +    traffic with another QEMU virtual machines using a UDP multicast
> +    socket, effectively making a bus for every QEMU with same multicast
> +    address maddr and port. NOTES:
> +
> +    1. Several QEMU can be running on different hosts and share same bus
> +       (assuming correct multicast setup for these hosts).
> +
> +    2. mcast support is compatible with User Mode Linux (argument
> +       ``ethN=3Dmcast``), see http://user-mode-linux.sf.net.
> +
> +    3. Use ``fd=3Dh`` to specify an already opened UDP multicast socket.
> +
> +    Example:
> +
> +    ::
> +
> +        # launch one QEMU instance
> +        |qemu_system| linux.img \
> +                         -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:=
56 \
> +                         -netdev socket,id=3Dn1,mcast=3D230.0.0.1:1234
> +        # launch another QEMU instance on same "bus"
> +        |qemu_system| linux.img \
> +                         -device e1000,netdev=3Dn2,mac=3D52:54:00:12:34:=
57 \
> +                         -netdev socket,id=3Dn2,mcast=3D230.0.0.1:1234
> +        # launch yet another QEMU instance on same "bus"
> +        |qemu_system| linux.img \
> +                         -device e1000,netdev=3Dn3,mac=3D52:54:00:12:34:=
58 \
> +                         -netdev socket,id=3Dn3,mcast=3D230.0.0.1:1234
> +
> +    Example (User Mode Linux compat.):
> +
> +    ::
> +
> +        # launch QEMU instance (note mcast address selected is UML's def=
ault)
> +        |qemu_system| linux.img \
> +                         -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:=
56 \
> +                         -netdev socket,id=3Dn1,mcast=3D239.192.168.1:11=
02
> +        # launch UML
> +        /path/to/linux ubd0=3D/path/to/root_fs eth0=3Dmcast
> +
> +    Example (send packets from host's 1.2.3.4):
> +
> +    .. parsed-literal::
> +
> +        |qemu_system| linux.img \
> +                         -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:=
56 \
> +                         -netdev socket,id=3Dn1,mcast=3D239.192.168.1:11=
02,localaddr=3D1.2.3.4
> +
> +``-netdev l2tpv3,id=3Did,src=3Dsrcaddr,dst=3Ddstaddr[,srcport=3Dsrcport]=
[,dstport=3Ddstport],txsession=3Dtxsession[,rxsession=3Drxsession][,ipv6][,=
udp][,cookie64][,counter][,pincounter][,txcookie=3Dtxcookie][,rxcookie=3Drx=
cookie][,offset=3Doffset]``
> +    Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3391)
> +    is a popular protocol to transport Ethernet (and other Layer 2) data
> +    frames between two systems. It is present in routers, firewalls and
> +    the Linux kernel (from version 3.3 onwards).
> +
> +    This transport allows a VM to communicate to another VM, router or
> +    firewall directly.
> +
> +    ``src=3Dsrcaddr``
> +        source address (mandatory)
> +
> +    ``dst=3Ddstaddr``
> +        destination address (mandatory)
> +
> +    ``udp``
> +        select udp encapsulation (default is ip).
> +
> +    ``srcport=3Dsrcport``
> +        source udp port.
> +
> +    ``dstport=3Ddstport``
> +        destination udp port.
> +
> +    ``ipv6``
> +        force v6, otherwise defaults to v4.
> +
> +    ``rxcookie=3Drxcookie``; \ ``txcookie=3Dtxcookie``
> +        Cookies are a weak form of security in the l2tpv3 specification.
> +        Their function is mostly to prevent misconfiguration. By default
> +        they are 32 bit.
> +
> +    ``cookie64``
> +        Set cookie size to 64 bit instead of the default 32
> +
> +    ``counter=3Doff``
> +        Force a 'cut-down' L2TPv3 with no counter as in
> +        draft-mkonstan-l2tpext-keyed-ipv6-tunnel-00
> +
> +    ``pincounter=3Don``
> +        Work around broken counter handling in peer. This may also help
> +        on networks which have packet reorder.
> +
> +    ``offset=3Doffset``
> +        Add an extra offset between header and data
> +
> +    For example, to attach a VM running on host 4.3.2.1 via L2TPv3 to
> +    the bridge br-lan on the remote Linux host 1.2.3.4:
> +
> +    ::
> +
> +        # Setup tunnel on linux host using raw ip as encapsulation
> +        # on 1.2.3.4
> +        ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer=
_tunnel_id 1 \
> +            encap udp udp_sport 16384 udp_dport 16384
> +        ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \
> +            0xFFFFFFFF peer_session_id 0xFFFFFFFF
> +        ifconfig vmtunnel0 mtu 1500
> +        ifconfig vmtunnel0 up
> +        brctl addif br-lan vmtunnel0
> +
> +
> +        # on 4.3.2.1
> +        # launch QEMU instance - if your network has reorder or is very =
lossy add ,pincounter
> +
> +        |qemu_system| linux.img -device e1000,netdev=3Dn1 \
> +            -netdev l2tpv3,id=3Dn1,src=3D4.2.3.1,dst=3D1.2.3.4,udp,srcpo=
rt=3D16384,dstport=3D16384,rxsession=3D0xffffffff,txsession=3D0xffffffff,co=
unter
> +
> +``-netdev vde,id=3Did[,sock=3Dsocketpath][,port=3Dn][,group=3Dgroupname]=
[,mode=3Doctalmode]``
> +    Configure VDE backend to connect to PORT n of a vde switch running
> +    on host and listening for incoming connections on socketpath. Use
> +    GROUP groupname and MODE octalmode to change default ownership and
> +    permissions for communication port. This option is only available if
> +    QEMU has been compiled with vde support enabled.
> +
> +    Example:
> +
> +    ::
> +
> +        # launch vde switch
> +        vde_switch -F -sock /tmp/myswitch
> +        # launch QEMU instance
> +        |qemu_system| linux.img -nic vde,sock=3D/tmp/myswitch
> +
> +``-netdev vhost-user,chardev=3Did[,vhostforce=3Don|off][,queues=3Dn]``
> +    Establish a vhost-user netdev, backed by a chardev id. The chardev
> +    should be a unix domain socket backed one. The vhost-user uses a
> +    specifically defined protocol to pass vhost ioctl replacement
> +    messages to an application on the other end of the socket. On
> +    non-MSIX guests, the feature can be forced with vhostforce. Use
> +    'queues=3Dn' to specify the number of queues to be created for
> +    multiqueue vhost-user.
> +
> +    Example:
> +
> +    ::
> +
> +        qemu -m 512 -object memory-backend-file,id=3Dmem,size=3D512M,mem=
-path=3D/hugetlbfs,share=3Don \
> +             -numa node,memdev=3Dmem \
> +             -chardev socket,id=3Dchr0,path=3D/path/to/socket \
> +             -netdev type=3Dvhost-user,id=3Dnet0,chardev=3Dchr0 \
> +             -device virtio-net-pci,netdev=3Dnet0
> +
> +``-netdev hubport,id=3Did,hubid=3Dhubid[,netdev=3Dnd]``
> +    Create a hub port on the emulated hub with ID hubid.
> +
> +    The hubport netdev lets you connect a NIC to a QEMU emulated hub
> +    instead of a single netdev. Alternatively, you can also connect the
> +    hubport to another netdev with ID nd by using the ``netdev=3Dnd``
> +    option.
> +
> +``-net nic[,netdev=3Dnd][,macaddr=3Dmac][,model=3Dtype] [,name=3Dname][,=
addr=3Daddr][,vectors=3Dv]``
> +    Legacy option to configure or create an on-board (or machine
> +    default) Network Interface Card(NIC) and connect it either to the
> +    emulated hub with ID 0 (i.e. the default hub), or to the netdev nd.
> +    If model is omitted, then the default NIC model associated with the
> +    machine type is used. Note that the default NIC model may change in
> +    future QEMU releases, so it is highly recommended to always specify
> +    a model. Optionally, the MAC address can be changed to mac, the
> +    device address set to addr (PCI cards only), and a name can be
> +    assigned for use in monitor commands. Optionally, for PCI cards, you
> +    can specify the number v of MSI-X vectors that the card should have;
> +    this option currently only affects virtio cards; set v =3D 0 to
> +    disable MSI-X. If no ``-net`` option is specified, a single NIC is
> +    created. QEMU can emulate several different models of network card.
> +    Use ``-net nic,model=3Dhelp`` for a list of available devices for yo=
ur
> +    target.
> +
> +``-net user|tap|bridge|socket|l2tpv3|vde[,...][,name=3Dname]``
> +    Configure a host network backend (with the options corresponding to
> +    the same ``-netdev`` option) and connect it to the emulated hub 0
> +    (the default hub). Use name to specify the name of the hub port.
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -3209,6 +5501,264 @@ Connect to a spice virtual machine channel, such =
as vdiport.
>  Connect to a spice port, allowing a Spice client to handle the traffic
>  identified by a name (preferably a fqdn).
>  ETEXI
> +SRST
> +The general form of a character device option is:
> +
> +``-chardev backend,id=3Did[,mux=3Don|off][,options]``
> +    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
> +    ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
> +    ``pty``, ``stdio``, ``braille``, ``tty``, ``parallel``, ``parport``,
> +    ``spicevmc``, ``spiceport``. The specific backend will determine the
> +    applicable options.
> +
> +    Use ``-chardev help`` to print all available chardev backend types.
> +
> +    All devices must have an id, which can be any string up to 127
> +    characters long. It is used to uniquely identify this device in
> +    other command line directives.
> +
> +    A character device may be used in multiplexing mode by multiple
> +    front-ends. Specify ``mux=3Don`` to enable this mode. A multiplexer =
is
> +    a "1:N" device, and here the "1" end is your specified chardev
> +    backend, and the "N" end is the various parts of QEMU that can talk
> +    to a chardev. If you create a chardev with ``id=3Dmyid`` and
> +    ``mux=3Don``, QEMU will create a multiplexer with your specified ID,
> +    and you can then configure multiple front ends to use that chardev
> +    ID for their input/output. Up to four different front ends can be
> +    connected to a single multiplexed chardev. (Without multiplexing
> +    enabled, a chardev can only be used by a single front end.) For
> +    instance you could use this to allow a single stdio chardev to be
> +    used by two serial ports and the QEMU monitor:
> +
> +    ::
> +
> +        -chardev stdio,mux=3Don,id=3Dchar0 \
> +        -mon chardev=3Dchar0,mode=3Dreadline \
> +        -serial chardev:char0 \
> +        -serial chardev:char0
> +
> +    You can have more than one multiplexer in a system configuration;
> +    for instance you could have a TCP port multiplexed between UART 0
> +    and UART 1, and stdio multiplexed between the QEMU monitor and a
> +    parallel port:
> +
> +    ::
> +
> +        -chardev stdio,mux=3Don,id=3Dchar0 \
> +        -mon chardev=3Dchar0,mode=3Dreadline \
> +        -parallel chardev:char0 \
> +        -chardev tcp,...,mux=3Don,id=3Dchar1 \
> +        -serial chardev:char1 \
> +        -serial chardev:char1
> +
> +    When you're using a multiplexed character device, some escape
> +    sequences are interpreted in the input. See :ref:`mux_005fkeys`.
> +
> +    Note that some other command line options may implicitly create
> +    multiplexed character backends; for instance ``-serial mon:stdio``
> +    creates a multiplexed stdio backend connected to the serial port and
> +    the QEMU monitor, and ``-nographic`` also multiplexes the console
> +    and the monitor to stdio.
> +
> +    There is currently no support for multiplexing in the other
> +    direction (where a single QEMU front end takes input and output from
> +    multiple chardevs).
> +
> +    Every backend supports the ``logfile`` option, which supplies the
> +    path to a file to record all data transmitted via the backend. The
> +    ``logappend`` option controls whether the log file will be truncated
> +    or appended to when opened.
> +
> +The available backends are:
> +
> +``-chardev null,id=3Did``
> +    A void device. This device will not emit any data, and will drop any
> +    data it receives. The null backend does not take any options.
> +
> +``-chardev socket,id=3Did[,TCP options or unix options][,server][,nowait=
][,telnet][,websocket][,reconnect=3Dseconds][,tls-creds=3Did][,tls-authz=3D=
id]``
> +    Create a two-way stream socket, which can be either a TCP or a unix
> +    socket. A unix socket will be created if ``path`` is specified.
> +    Behaviour is undefined if TCP options are specified for a unix
> +    socket.
> +
> +    ``server`` specifies that the socket shall be a listening socket.
> +
> +    ``nowait`` specifies that QEMU should not block waiting for a client
> +    to connect to a listening socket.
> +
> +    ``telnet`` specifies that traffic on the socket should interpret
> +    telnet escape sequences.
> +
> +    ``websocket`` specifies that the socket uses WebSocket protocol for
> +    communication.
> +
> +    ``reconnect`` sets the timeout for reconnecting on non-server
> +    sockets when the remote end goes away. qemu will delay this many
> +    seconds and then attempt to reconnect. Zero disables reconnecting,
> +    and is the default.
> +
> +    ``tls-creds`` requests enablement of the TLS protocol for
> +    encryption, and specifies the id of the TLS credentials to use for
> +    the handshake. The credentials must be previously created with the
> +    ``-object tls-creds`` argument.
> +
> +    ``tls-auth`` provides the ID of the QAuthZ authorization object
> +    against which the client's x509 distinguished name will be
> +    validated. This object is only resolved at time of use, so can be
> +    deleted and recreated on the fly while the chardev server is active.
> +    If missing, it will default to denying access.
> +
> +    TCP and unix socket options are given below:
> +
> +    ``TCP options: port=3Dport[,host=3Dhost][,to=3Dto][,ipv4][,ipv6][,no=
delay]``
> +        ``host`` for a listening socket specifies the local address to
> +        be bound. For a connecting socket species the remote host to
> +        connect to. ``host`` is optional for listening sockets. If not
> +        specified it defaults to ``0.0.0.0``.
> +
> +        ``port`` for a listening socket specifies the local port to be
> +        bound. For a connecting socket specifies the port on the remote
> +        host to connect to. ``port`` can be given as either a port
> +        number or a service name. ``port`` is required.
> +
> +        ``to`` is only relevant to listening sockets. If it is
> +        specified, and ``port`` cannot be bound, QEMU will attempt to
> +        bind to subsequent ports up to and including ``to`` until it
> +        succeeds. ``to`` must be specified as a port number.
> +
> +        ``ipv4`` and ``ipv6`` specify that either IPv4 or IPv6 must be
> +        used. If neither is specified the socket may use either
> +        protocol.
> +
> +        ``nodelay`` disables the Nagle algorithm.
> +
> +    ``unix options: path=3Dpath``
> +        ``path`` specifies the local path of the unix socket. ``path``
> +        is required.
> +
> +``-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,localaddr=3Dlocaladdr]=
[,localport=3Dlocalport][,ipv4][,ipv6]``
> +    Sends all traffic from the guest to a remote host over UDP.
> +
> +    ``host`` specifies the remote host to connect to. If not specified
> +    it defaults to ``localhost``.
> +
> +    ``port`` specifies the port on the remote host to connect to.
> +    ``port`` is required.
> +
> +    ``localaddr`` specifies the local address to bind to. If not
> +    specified it defaults to ``0.0.0.0``.
> +
> +    ``localport`` specifies the local port to bind to. If not specified
> +    any available local port will be used.
> +
> +    ``ipv4`` and ``ipv6`` specify that either IPv4 or IPv6 must be used.
> +    If neither is specified the device may use either protocol.
> +
> +``-chardev msmouse,id=3Did``
> +    Forward QEMU's emulated msmouse events to the guest. ``msmouse``
> +    does not take any options.
> +
> +``-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dcols]=
[,rows=3Drows]]``
> +    Connect to a QEMU text console. ``vc`` may optionally be given a
> +    specific size.
> +
> +    ``width`` and ``height`` specify the width and height respectively
> +    of the console, in pixels.
> +
> +    ``cols`` and ``rows`` specify that the console be sized to fit a
> +    text console with the given dimensions.
> +
> +``-chardev ringbuf,id=3Did[,size=3Dsize]``
> +    Create a ring buffer with fixed size ``size``. size must be a power
> +    of two and defaults to ``64K``.
> +
> +``-chardev file,id=3Did,path=3Dpath``
> +    Log all traffic received from the guest to a file.
> +
> +    ``path`` specifies the path of the file to be opened. This file will
> +    be created if it does not already exist, and overwritten if it does.
> +    ``path`` is required.
> +
> +``-chardev pipe,id=3Did,path=3Dpath``
> +    Create a two-way connection to the guest. The behaviour differs
> +    slightly between Windows hosts and other hosts:
> +
> +    On Windows, a single duplex pipe will be created at
> +    ``\\.pipe\path``.
> +
> +    On other hosts, 2 pipes will be created called ``path.in`` and
> +    ``path.out``. Data written to ``path.in`` will be received by the
> +    guest. Data written by the guest can be read from ``path.out``. QEMU
> +    will not create these fifos, and requires them to be present.
> +
> +    ``path`` forms part of the pipe path as described above. ``path`` is
> +    required.
> +
> +``-chardev console,id=3Did``
> +    Send traffic from the guest to QEMU's standard output. ``console``
> +    does not take any options.
> +
> +    ``console`` is only available on Windows hosts.
> +
> +``-chardev serial,id=3Did,path=3Dpath``
> +    Send traffic from the guest to a serial device on the host.
> +
> +    On Unix hosts serial will actually accept any tty device, not only
> +    serial lines.
> +
> +    ``path`` specifies the name of the serial device to open.
> +
> +``-chardev pty,id=3Did``
> +    Create a new pseudo-terminal on the host and connect to it. ``pty``
> +    does not take any options.
> +
> +    ``pty`` is not available on Windows hosts.
> +
> +``-chardev stdio,id=3Did[,signal=3Don|off]``
> +    Connect to standard input and standard output of the QEMU process.
> +
> +    ``signal`` controls if signals are enabled on the terminal, that
> +    includes exiting QEMU with the key sequence Control-c. This option
> +    is enabled by default, use ``signal=3Doff`` to disable it.
> +
> +``-chardev braille,id=3Did``
> +    Connect to a local BrlAPI server. ``braille`` does not take any
> +    options.
> +
> +``-chardev tty,id=3Did,path=3Dpath``
> +    ``tty`` is only available on Linux, Sun, FreeBSD, NetBSD, OpenBSD
> +    and DragonFlyBSD hosts. It is an alias for ``serial``.
> +
> +    ``path`` specifies the path to the tty. ``path`` is required.
> +
> +``-chardev parallel,id=3Did,path=3Dpath``; \ ``-chardev parport,id=3Did,=
path=3Dpath``
> +    ``parallel`` is only available on Linux, FreeBSD and DragonFlyBSD
> +    hosts.
> +
> +    Connect to a local parallel port.
> +
> +    ``path`` specifies the path to the parallel port device. ``path`` is
> +    required.
> +
> +``-chardev spicevmc,id=3Did,debug=3Ddebug,name=3Dname``
> +    ``spicevmc`` is only available when spice support is built in.
> +
> +    ``debug`` debug level for spicevmc
> +
> +    ``name`` name of spice channel to connect to
> +
> +    Connect to a spice virtual machine channel, such as vdiport.
> +
> +``-chardev spiceport,id=3Did,debug=3Ddebug,name=3Dname``
> +    ``spiceport`` is only available when spice support is built in.
> +
> +    ``debug`` debug level for spicevmc
> +
> +    ``name`` name of spice port to connect to
> +
> +    Connect to a spice port, allowing a Spice client to handle the
> +    traffic identified by a name (preferably a fqdn).
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -3298,6 +5848,69 @@ To create a TPM emulator backend device with chard=
ev socket backend:
>  @end example
>=20=20
>  ETEXI
> +SRST
> +The general form of a TPM device option is:
> +
> +``-tpmdev backend,id=3Did[,options]``
> +    The specific backend type will determine the applicable options. The
> +    ``-tpmdev`` option creates the TPM backend and requires a
> +    ``-device`` option that specifies the TPM frontend interface model.
> +
> +    Use ``-tpmdev help`` to print all available TPM backend types.
> +
> +The available backends are:
> +
> +``-tpmdev passthrough,id=3Did,path=3Dpath,cancel-path=3Dcancel-path``
> +    (Linux-host only) Enable access to the host's TPM using the
> +    passthrough driver.
> +
> +    ``path`` specifies the path to the host's TPM device, i.e., on a
> +    Linux host this would be ``/dev/tpm0``. ``path`` is optional and by
> +    default ``/dev/tpm0`` is used.
> +
> +    ``cancel-path`` specifies the path to the host TPM device's sysfs
> +    entry allowing for cancellation of an ongoing TPM command.
> +    ``cancel-path`` is optional and by default QEMU will search for the
> +    sysfs entry to use.
> +
> +    Some notes about using the host's TPM with the passthrough driver:
> +
> +    The TPM device accessed by the passthrough driver must not be used
> +    by any other application on the host.
> +
> +    Since the host's firmware (BIOS/UEFI) has already initialized the
> +    TPM, the VM's firmware (BIOS/UEFI) will not be able to initialize
> +    the TPM again and may therefore not show a TPM-specific menu that
> +    would otherwise allow the user to configure the TPM, e.g., allow the
> +    user to enable/disable or activate/deactivate the TPM. Further, if
> +    TPM ownership is released from within a VM then the host's TPM will
> +    get disabled and deactivated. To enable and activate the TPM again
> +    afterwards, the host has to be rebooted and the user is required to
> +    enter the firmware's menu to enable and activate the TPM. If the TPM
> +    is left disabled and/or deactivated most TPM commands will fail.
> +
> +    To create a passthrough TPM use the following two options:
> +
> +    ::
> +
> +        -tpmdev passthrough,id=3Dtpm0 -device tpm-tis,tpmdev=3Dtpm0
> +
> +    Note that the ``-tpmdev`` id is ``tpm0`` and is referenced by
> +    ``tpmdev=3Dtpm0`` in the device option.
> +
> +``-tpmdev emulator,id=3Did,chardev=3Ddev``
> +    (Linux-host only) Enable access to a TPM emulator using Unix domain
> +    socket based chardev backend.
> +
> +    ``chardev`` specifies the unique ID of a character device backend
> +    that provides connection to the software TPM server.
> +
> +    To create a TPM emulator backend device with chardev socket backend:
> +
> +    ::
> +
> +        -chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock -tpmdev emula=
tor,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -3315,6 +5928,13 @@ for easier testing of various kernels.
>=20=20
>  @table @option
>  ETEXI
> +SRST
> +When using these options, you can use a given Linux or Multiboot kernel
> +without installing it in the disk image. It can be useful for easier
> +testing of various kernels.
> +
> +
> +ERST
>=20=20
>  DEF("kernel", HAS_ARG, QEMU_OPTION_kernel, \
>      "-kernel bzImage use 'bzImage' as kernel image\n", QEMU_ARCH_ALL)
> @@ -3324,6 +5944,11 @@ STEXI
>  Use @var{bzImage} as kernel image. The kernel can be either a Linux kern=
el
>  or in multiboot format.
>  ETEXI
> +SRST
> +``-kernel bzImage``
> +    Use bzImage as kernel image. The kernel can be either a Linux kernel
> +    or in multiboot format.
> +ERST
>=20=20
>  DEF("append", HAS_ARG, QEMU_OPTION_append, \
>      "-append cmdline use 'cmdline' as kernel command line\n", QEMU_ARCH_=
ALL)
> @@ -3332,6 +5957,10 @@ STEXI
>  @findex -append
>  Use @var{cmdline} as kernel command line
>  ETEXI
> +SRST
> +``-append cmdline``
> +    Use cmdline as kernel command line
> +ERST
>=20=20
>  DEF("initrd", HAS_ARG, QEMU_OPTION_initrd, \
>             "-initrd file    use 'file' as initial ram disk\n", QEMU_ARCH=
_ALL)
> @@ -3347,6 +5976,16 @@ This syntax is only available with multiboot.
>  Use @var{file1} and @var{file2} as modules and pass arg=3Dfoo as paramet=
er to the
>  first module.
>  ETEXI
> +SRST
> +``-initrd file``
> +    Use file as initial ram disk.
> +
> +``-initrd "file1 arg=3Dfoo,file2"``
> +    This syntax is only available with multiboot.
> +
> +    Use file1 and file2 as modules and pass arg=3Dfoo as parameter to the
> +    first module.
> +ERST
>=20=20
>  DEF("dtb", HAS_ARG, QEMU_OPTION_dtb, \
>      "-dtb    file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
> @@ -3356,6 +5995,11 @@ STEXI
>  Use @var{file} as a device tree binary (dtb) image and pass it to the ke=
rnel
>  on boot.
>  ETEXI
> +SRST
> +``-dtb file``
> +    Use file as a device tree binary (dtb) image and pass it to the
> +    kernel on boot.
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -3396,6 +6040,28 @@ creates an fw_cfg entry named opt/com.mycompany/bl=
ob with contents
>  from ./my_blob.bin.
>=20=20
>  ETEXI
> +SRST
> +``-fw_cfg [name=3D]name,file=3Dfile``
> +    Add named fw\_cfg entry with contents from file file.
> +
> +``-fw_cfg [name=3D]name,string=3Dstr``
> +    Add named fw\_cfg entry with contents from string str.
> +
> +    The terminating NUL character of the contents of str will not be
> +    included as part of the fw\_cfg item data. To insert contents with
> +    embedded NUL characters, you have to use the file parameter.
> +
> +    The fw\_cfg entries are passed by QEMU through to the guest.
> +
> +    Example:
> +
> +    ::
> +
> +            -fw_cfg name=3Dopt/com.mycompany/blob,file=3D./my_blob.bin
> +
> +    creates an fw\_cfg entry named opt/com.mycompany/blob with contents
> +    from ./my\_blob.bin.
> +ERST
>=20=20
>  DEF("serial", HAS_ARG, QEMU_OPTION_serial, \
>      "-serial dev     redirect the serial port to char device 'dev'\n",
> @@ -3534,6 +6200,161 @@ or fake device.
>  Three button serial mouse. Configure the guest to use Microsoft protocol.
>  @end table
>  ETEXI
> +SRST
> +``-serial dev``
> +    Redirect the virtual serial port to host character device dev. The
> +    default device is ``vc`` in graphical mode and ``stdio`` in non
> +    graphical mode.
> +
> +    This option can be used several times to simulate up to 4 serial
> +    ports.
> +
> +    Use ``-serial none`` to disable all serial ports.
> +
> +    Available character devices are:
> +
> +    ``vc[:WxH]``
> +        Virtual console. Optionally, a width and height can be given in
> +        pixel with
> +
> +        ::
> +
> +            vc:800x600
> +
> +        It is also possible to specify width or height in characters:
> +
> +        ::
> +
> +            vc:80Cx24C
> +
> +    ``pty``
> +        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
> +
> +    ``none``
> +        No device is allocated.
> +
> +    ``null``
> +        void device
> +
> +    ``chardev:id``
> +        Use a named character device defined with the ``-chardev``
> +        option.
> +
> +    ``/dev/XXX``
> +        [Linux only] Use host tty, e.g. ``/dev/ttyS0``. The host serial
> +        port parameters are set according to the emulated ones.
> +
> +    ``/dev/parportN``
> +        [Linux only, parallel port only] Use host parallel port N.
> +        Currently SPP and EPP parallel port features can be used.
> +
> +    ``file:filename``
> +        Write output to filename. No character can be read.
> +
> +    ``stdio``
> +        [Unix only] standard input/output
> +
> +    ``pipe:filename``
> +        name pipe filename
> +
> +    ``COMn``
> +        [Windows only] Use host serial port n
> +
> +    ``udp:[remote_host]:remote_port[@[src_ip]:src_port]``
> +        This implements UDP Net Console. When remote\_host or src\_ip
> +        are not specified they default to ``0.0.0.0``. When not using a
> +        specified src\_port a random port is automatically chosen.
> +
> +        If you just want a simple readonly console you can use
> +        ``netcat`` or ``nc``, by starting QEMU with:
> +        ``-serial udp::4555`` and nc as: ``nc -u -l -p 4555``. Any time
> +        QEMU writes something to that port it will appear in the
> +        netconsole session.
> +
> +        If you plan to send characters back via netconsole or you want
> +        to stop and start QEMU a lot of times, you should have QEMU use
> +        the same source port each time by using something like ``-serial
> +        udp::4555@:4556`` to QEMU. Another approach is to use a patched
> +        version of netcat which can listen to a TCP port and send and
> +        receive characters via udp. If you have a patched version of
> +        netcat which activates telnet remote echo and single char
> +        transfer, then you can use the following options to set up a
> +        netcat redirector to allow telnet on port 5555 to access the
> +        QEMU port.
> +
> +        ``QEMU Options:``
> +            -serial udp::4555@:4556
> +
> +        ``netcat options:``
> +            -u -P 4555 -L 0.0.0.0:4556 -t -p 5555 -I -T
> +
> +        ``telnet options:``
> +            localhost 5555
> +
> +    ``tcp:[host]:port[,server][,nowait][,nodelay][,reconnect=3Dseconds]``
> +        The TCP Net Console has two modes of operation. It can send the
> +        serial I/O to a location or wait for a connection from a
> +        location. By default the TCP Net Console is sent to host at the
> +        port. If you use the server option QEMU will wait for a client
> +        socket application to connect to the port before continuing,
> +        unless the ``nowait`` option was specified. The ``nodelay``
> +        option disables the Nagle buffering algorithm. The ``reconnect``
> +        option only applies if noserver is set, if the connection goes
> +        down it will attempt to reconnect at the given interval. If host
> +        is omitted, 0.0.0.0 is assumed. Only one TCP connection at a
> +        time is accepted. You can use ``telnet`` to connect to the
> +        corresponding character device.
> +
> +        ``Example to send tcp console to 192.168.0.2 port 4444``
> +            -serial tcp:192.168.0.2:4444
> +
> +        ``Example to listen and wait on port 4444 for connection``
> +            -serial tcp::4444,server
> +
> +        ``Example to not wait and listen on ip 192.168.0.100 port 4444``
> +            -serial tcp:192.168.0.100:4444,server,nowait
> +
> +    ``telnet:host:port[,server][,nowait][,nodelay]``
> +        The telnet protocol is used instead of raw tcp sockets. The
> +        options work the same as if you had specified ``-serial tcp``.
> +        The difference is that the port acts like a telnet server or
> +        client using telnet option negotiation. This will also allow you
> +        to send the MAGIC\_SYSRQ sequence if you use a telnet that
> +        supports sending the break sequence. Typically in unix telnet
> +        you do it with Control-] and then type "send break" followed by
> +        pressing the enter key.
> +
> +    ``websocket:host:port,server[,nowait][,nodelay]``
> +        The WebSocket protocol is used instead of raw tcp socket. The
> +        port acts as a WebSocket server. Client mode is not supported.
> +
> +    ``unix:path[,server][,nowait][,reconnect=3Dseconds]``
> +        A unix domain socket is used instead of a tcp socket. The option
> +        works the same as if you had specified ``-serial tcp`` except
> +        the unix domain socket path is used for connections.
> +
> +    ``mon:dev_string``
> +        This is a special option to allow the monitor to be multiplexed
> +        onto another serial port. The monitor is accessed with key
> +        sequence of Control-a and then pressing c. dev\_string should be
> +        any one of the serial devices specified above. An example to
> +        multiplex the monitor onto a telnet server listening on port
> +        4444 would be:
> +
> +        ``-serial mon:telnet::4444,server,nowait``
> +
> +        When the monitor is multiplexed to stdio in this way, Ctrl+C
> +        will not terminate QEMU any more but will be passed to the guest
> +        instead.
> +
> +    ``braille``
> +        Braille device. This will use BrlAPI to display the braille
> +        output on a real or fake device.
> +
> +    ``msmouse``
> +        Three button serial mouse. Configure the guest to use Microsoft
> +        protocol.
> +ERST
>=20=20
>  DEF("parallel", HAS_ARG, QEMU_OPTION_parallel, \
>      "-parallel dev   redirect the parallel port to char device 'dev'\n",
> @@ -3551,6 +6372,18 @@ ports.
>=20=20
>  Use @code{-parallel none} to disable all parallel ports.
>  ETEXI
> +SRST
> +``-parallel dev``
> +    Redirect the virtual parallel port to host device dev (same devices
> +    as the serial port). On Linux hosts, ``/dev/parportN`` can be used
> +    to use hardware devices connected on the corresponding host parallel
> +    port.
> +
> +    This option can be used several times to simulate up to 3 parallel
> +    ports.
> +
> +    Use ``-parallel none`` to disable all parallel ports.
> +ERST
>=20=20
>  DEF("monitor", HAS_ARG, QEMU_OPTION_monitor, \
>      "-monitor dev    redirect the monitor to char device 'dev'\n",
> @@ -3564,6 +6397,13 @@ The default device is @code{vc} in graphical mode =
and @code{stdio} in
>  non graphical mode.
>  Use @code{-monitor none} to disable the default monitor.
>  ETEXI
> +SRST
> +``-monitor dev``
> +    Redirect the monitor to host device dev (same devices as the serial
> +    port). The default device is ``vc`` in graphical mode and ``stdio``
> +    in non graphical mode. Use ``-monitor none`` to disable the default
> +    monitor.
> +ERST
>  DEF("qmp", HAS_ARG, QEMU_OPTION_qmp, \
>      "-qmp dev        like -monitor but opens in 'control' mode\n",
>      QEMU_ARCH_ALL)
> @@ -3572,6 +6412,10 @@ STEXI
>  @findex -qmp
>  Like -monitor but opens in 'control' mode.
>  ETEXI
> +SRST
> +``-qmp dev``
> +    Like -monitor but opens in 'control' mode.
> +ERST
>  DEF("qmp-pretty", HAS_ARG, QEMU_OPTION_qmp_pretty, \
>      "-qmp-pretty dev like -qmp but uses pretty JSON formatting\n",
>      QEMU_ARCH_ALL)
> @@ -3580,6 +6424,10 @@ STEXI
>  @findex -qmp-pretty
>  Like -qmp but uses pretty JSON formatting.
>  ETEXI
> +SRST
> +``-qmp-pretty dev``
> +    Like -qmp but uses pretty JSON formatting.
> +ERST
>=20=20
>  DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
>      "-mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]]=
\n", QEMU_ARCH_ALL)
> @@ -3589,6 +6437,11 @@ STEXI
>  Setup monitor on chardev @var{name}. @code{pretty} turns on JSON pretty =
printing
>  easing human reading and debugging.
>  ETEXI
> +SRST
> +``-mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]]``
> +    Setup monitor on chardev name. ``pretty`` turns on JSON pretty
> +    printing easing human reading and debugging.
> +ERST
>=20=20
>  DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
>      "-debugcon dev   redirect the debug console to char device 'dev'\n",
> @@ -3602,6 +6455,14 @@ serial port).  The debug console is an I/O port wh=
ich is typically port
>  The default device is @code{vc} in graphical mode and @code{stdio} in
>  non graphical mode.
>  ETEXI
> +SRST
> +``-debugcon dev``
> +    Redirect the debug console to host device dev (same devices as the
> +    serial port). The debug console is an I/O port which is typically
> +    port 0xe9; writing to that I/O port sends output to this device. The
> +    default device is ``vc`` in graphical mode and ``stdio`` in non
> +    graphical mode.
> +ERST
>=20=20
>  DEF("pidfile", HAS_ARG, QEMU_OPTION_pidfile, \
>      "-pidfile file   write PID to 'file'\n", QEMU_ARCH_ALL)
> @@ -3611,6 +6472,11 @@ STEXI
>  Store the QEMU process PID in @var{file}. It is useful if you launch QEMU
>  from a script.
>  ETEXI
> +SRST
> +``-pidfile file``
> +    Store the QEMU process PID in file. It is useful if you launch QEMU
> +    from a script.
> +ERST
>=20=20
>  DEF("singlestep", 0, QEMU_OPTION_singlestep, \
>      "-singlestep     always run in singlestep mode\n", QEMU_ARCH_ALL)
> @@ -3619,6 +6485,10 @@ STEXI
>  @findex -singlestep
>  Run the emulation in single step mode.
>  ETEXI
> +SRST
> +``-singlestep``
> +    Run the emulation in single step mode.
> +ERST
>=20=20
>  DEF("preconfig", 0, QEMU_OPTION_preconfig, \
>      "--preconfig     pause QEMU before machine is initialized (experimen=
tal)\n",
> @@ -3633,6 +6503,15 @@ the preconfig state and move to the next state (i.=
e. run guest if -S
>  isn't used or pause the second time if -S is used).  This option is
>  experimental.
>  ETEXI
> +SRST
> +``--preconfig``
> +    Pause QEMU for interactive configuration before the machine is
> +    created, which allows querying and configuring properties that will
> +    affect machine initialization. Use QMP command 'x-exit-preconfig' to
> +    exit the preconfig state and move to the next state (i.e. run guest
> +    if -S isn't used or pause the second time if -S is used). This
> +    option is experimental.
> +ERST
>=20=20
>  DEF("S", 0, QEMU_OPTION_S, \
>      "-S              freeze CPU at startup (use 'c' to start execution)\=
n",
> @@ -3642,6 +6521,10 @@ STEXI
>  @findex -S
>  Do not start CPU at startup (you must type 'c' in the monitor).
>  ETEXI
> +SRST
> +``-S``
> +    Do not start CPU at startup (you must type 'c' in the monitor).
> +ERST
>=20=20
>  DEF("realtime", HAS_ARG, QEMU_OPTION_realtime,
>      "-realtime [mlock=3Don|off]\n"
> @@ -3655,6 +6538,11 @@ Run qemu with realtime features.
>  mlocking qemu and guest memory can be enabled via @option{mlock=3Don}
>  (enabled by default).
>  ETEXI
> +SRST
> +``-realtime mlock=3Don|off``
> +    Run qemu with realtime features. mlocking qemu and guest memory can
> +    be enabled via ``mlock=3Don`` (enabled by default).
> +ERST
>=20=20
>  DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
>      "-overcommit [mem-lock=3Don|off][cpu-pm=3Don|off]\n"
> @@ -3679,6 +6567,24 @@ enabled via @option{cpu-pm=3Don} (disabled by defa=
ult).  This works best when
>  host CPU is not overcommitted. When used, host estimates of CPU cycle an=
d power
>  utilization will be incorrect, not taking into account guest idle time.
>  ETEXI
> +SRST
> +``-overcommit mem-lock=3Don|off``
> +``-overcommit cpu-pm=3Don|off``
> +    Run qemu with hints about host resource overcommit. The default is
> +    to assume that host overcommits all resources.
> +
> +    Locking qemu and guest memory can be enabled via ``mem-lock=3Don``
> +    (disabled by default). This works when host memory is not
> +    overcommitted and reduces the worst-case latency for guest. This is
> +    equivalent to ``realtime``.
> +
> +    Guest ability to manage power state of host cpus (increasing latency
> +    for other processes on the same host cpu, but decreasing latency for
> +    guest) can be enabled via ``cpu-pm=3Don`` (disabled by default). This
> +    works best when host CPU is not overcommitted. When used, host
> +    estimates of CPU cycle and power utilization will be incorrect, not
> +    taking into account guest idle time.
> +ERST
>=20=20
>  DEF("gdb", HAS_ARG, QEMU_OPTION_gdb, \
>      "-gdb dev        wait for gdb connection on 'dev'\n", QEMU_ARCH_ALL)
> @@ -3693,6 +6599,18 @@ within gdb and establish the connection via a pipe:
>  (gdb) target remote | exec @value{qemu_system} -gdb stdio ...
>  @end example
>  ETEXI
> +SRST
> +``-gdb dev``
> +    Wait for gdb connection on device dev (see
> +    :ref:`gdb_005fusage`). Typical connections will likely be
> +    TCP-based, but also UDP, pseudo TTY, or even stdio are reasonable
> +    use case. The latter is allowing to start QEMU from within gdb and
> +    establish the connection via a pipe:
> +
> +    ::
> +
> +        (gdb) target remote | exec |qemu_system| -gdb stdio ...
> +ERST
>=20=20
>  DEF("s", 0, QEMU_OPTION_s, \
>      "-s              shorthand for -gdb tcp::" DEFAULT_GDBSTUB_PORT "\n",
> @@ -3703,6 +6621,11 @@ STEXI
>  Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234
>  (@pxref{gdb_usage}).
>  ETEXI
> +SRST
> +``-s``
> +    Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234
> +    (see :ref:`gdb_005fusage`).
> +ERST
>=20=20
>  DEF("d", HAS_ARG, QEMU_OPTION_d, \
>      "-d item1,...    enable logging of specified items (use '-d help' fo=
r a list of log items)\n",
> @@ -3712,6 +6635,11 @@ STEXI
>  @findex -d
>  Enable logging of specified items. Use '-d help' for a list of log items.
>  ETEXI
> +SRST
> +``-d item1[,...]``
> +    Enable logging of specified items. Use '-d help' for a list of log
> +    items.
> +ERST
>=20=20
>  DEF("D", HAS_ARG, QEMU_OPTION_D, \
>      "-D logfile      output log to logfile (default stderr)\n",
> @@ -3721,6 +6649,10 @@ STEXI
>  @findex -D
>  Output log in @var{logfile} instead of to stderr
>  ETEXI
> +SRST
> +``-D logfile``
> +    Output log in logfile instead of to stderr
> +ERST
>=20=20
>  DEF("dfilter", HAS_ARG, QEMU_OPTION_DFILTER, \
>      "-dfilter range,..  filter debug output to range of addresses (usefu=
l for -d cpu,exec,etc..)\n",
> @@ -3739,6 +6671,21 @@ Will dump output for any code in the 0x1000 sized =
block starting at 0x8000 and
>  the 0x200 sized block starting at 0xffffffc000080000 and another 0x1000 =
sized
>  block starting at 0xffffffc00005f000.
>  ETEXI
> +SRST
> +``-dfilter range1[,...]``
> +    Filter debug output to that relevant to a range of target addresses.
> +    The filter spec can be either start+size, start-size or start..end
> +    where start end and size are the addresses and sizes required. For
> +    example:
> +
> +    ::
> +
> +            -dfilter 0x8000..0x8fff,0xffffffc000080000+0x200,0xffffffc00=
0060000-0x1000
> +
> +    Will dump output for any code in the 0x1000 sized block starting at
> +    0x8000 and the 0x200 sized block starting at 0xffffffc000080000 and
> +    another 0x1000 sized block starting at 0xffffffc00005f000.
> +ERST
>=20=20
>  DEF("seed", HAS_ARG, QEMU_OPTION_seed, \
>      "-seed number       seed the pseudo-random number generator\n",
> @@ -3749,6 +6696,12 @@ STEXI
>  Force the guest to use a deterministic pseudo-random number generator, s=
eeded
>  with @var{number}.  This does not affect crypto routines within the host.
>  ETEXI
> +SRST
> +``-seed number``
> +    Force the guest to use a deterministic pseudo-random number
> +    generator, seeded with number. This does not affect crypto routines
> +    within the host.
> +ERST
>=20=20
>  DEF("L", HAS_ARG, QEMU_OPTION_L, \
>      "-L path         set the directory for the BIOS, VGA BIOS and keymap=
s\n",
> @@ -3760,6 +6713,12 @@ Set the directory for the BIOS, VGA BIOS and keyma=
ps.
>=20=20
>  To list all the data directories, use @code{-L help}.
>  ETEXI
> +SRST
> +``-L  path``
> +    Set the directory for the BIOS, VGA BIOS and keymaps.
> +
> +    To list all the data directories, use ``-L help``.
> +ERST
>=20=20
>  DEF("bios", HAS_ARG, QEMU_OPTION_bios, \
>      "-bios file      set the filename for the BIOS\n", QEMU_ARCH_ALL)
> @@ -3768,6 +6727,10 @@ STEXI
>  @findex -bios
>  Set the filename for the BIOS.
>  ETEXI
> +SRST
> +``-bios file``
> +    Set the filename for the BIOS.
> +ERST
>=20=20
>  DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
>      "-enable-kvm     enable KVM full virtualization support\n", QEMU_ARC=
H_ALL)
> @@ -3777,6 +6740,11 @@ STEXI
>  Enable KVM full virtualization support. This option is only available
>  if KVM support is enabled when compiling.
>  ETEXI
> +SRST
> +``-enable-kvm``
> +    Enable KVM full virtualization support. This option is only
> +    available if KVM support is enabled when compiling.
> +ERST
>=20=20
>  DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
>      "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
> @@ -3800,6 +6768,15 @@ libxl will use this when starting QEMU (XEN only).
>  @findex -xen-domid-restrict
>  Restrict set of available xen operations to specified domain id (XEN onl=
y).
>  ETEXI
> +SRST
> +``-xen-domid id``
> +    Specify xen guest domain id (XEN only).
> +
> +``-xen-attach``
> +    Attach to existing xen domain. libxl will use this when starting
> +    QEMU (XEN only). Restrict set of available xen operations to
> +    specified domain id (XEN only).
> +ERST
>=20=20
>  DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
>      "-no-reboot      exit instead of rebooting\n", QEMU_ARCH_ALL)
> @@ -3808,6 +6785,10 @@ STEXI
>  @findex -no-reboot
>  Exit instead of rebooting.
>  ETEXI
> +SRST
> +``-no-reboot``
> +    Exit instead of rebooting.
> +ERST
>=20=20
>  DEF("no-shutdown", 0, QEMU_OPTION_no_shutdown, \
>      "-no-shutdown    stop before shutdown\n", QEMU_ARCH_ALL)
> @@ -3818,6 +6799,12 @@ Don't exit QEMU on guest shutdown, but instead onl=
y stop the emulation.
>  This allows for instance switching to monitor to commit changes to the
>  disk image.
>  ETEXI
> +SRST
> +``-no-shutdown``
> +    Don't exit QEMU on guest shutdown, but instead only stop the
> +    emulation. This allows for instance switching to monitor to commit
> +    changes to the disk image.
> +ERST
>=20=20
>  DEF("loadvm", HAS_ARG, QEMU_OPTION_loadvm, \
>      "-loadvm [tag|id]\n" \
> @@ -3828,6 +6815,10 @@ STEXI
>  @findex -loadvm
>  Start right away with a saved state (@code{loadvm} in monitor)
>  ETEXI
> +SRST
> +``-loadvm file``
> +    Start right away with a saved state (``loadvm`` in monitor)
> +ERST
>=20=20
>  #ifndef _WIN32
>  DEF("daemonize", 0, QEMU_OPTION_daemonize, \
> @@ -3841,6 +6832,14 @@ standard IO until it is ready to receive connectio=
ns on any of its devices.
>  This option is a useful way for external programs to launch QEMU without=
 having
>  to cope with initialization race conditions.
>  ETEXI
> +SRST
> +``-daemonize``
> +    Daemonize the QEMU process after initialization. QEMU will not
> +    detach from standard IO until it is ready to receive connections on
> +    any of its devices. This option is a useful way for external
> +    programs to launch QEMU without having to cope with initialization
> +    race conditions.
> +ERST
>=20=20
>  DEF("option-rom", HAS_ARG, QEMU_OPTION_option_rom, \
>      "-option-rom rom load a file, rom, into the option ROM space\n",
> @@ -3851,6 +6850,11 @@ STEXI
>  Load the contents of @var{file} as an option ROM.
>  This option is useful to load things like EtherBoot.
>  ETEXI
> +SRST
> +``-option-rom file``
> +    Load the contents of file as an option ROM. This option is useful to
> +    load things like EtherBoot.
> +ERST
>=20=20
>  DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
>      "-rtc [base=3Dutc|localtime|<datetime>][,clock=3Dhost|rt|vm][,driftf=
ix=3Dnone|slew]\n" \
> @@ -3882,6 +6886,32 @@ specifically with Windows' ACPI HAL. This option w=
ill try to figure out how
>  many timer interrupts were not processed by the Windows guest and will
>  re-inject them.
>  ETEXI
> +SRST
> +``-rtc [base=3Dutc|localtime|datetime][,clock=3Dhost|rt|vm][,driftfix=3D=
none|slew]``
> +    Specify ``base`` as ``utc`` or ``localtime`` to let the RTC start at
> +    the current UTC or local time, respectively. ``localtime`` is
> +    required for correct date in MS-DOS or Windows. To start at a
> +    specific point in time, provide datetime in the format
> +    ``2006-06-17T16:01:21`` or ``2006-06-17``. The default base is UTC.
> +
> +    By default the RTC is driven by the host system time. This allows
> +    using of the RTC as accurate reference clock inside the guest,
> +    specifically if the host time is smoothly following an accurate
> +    external reference clock, e.g. via NTP. If you want to isolate the
> +    guest time from the host, you can set ``clock`` to ``rt`` instead,
> +    which provides a host monotonic clock if host support it. To even
> +    prevent the RTC from progressing during suspension, you can set
> +    ``clock`` to ``vm`` (virtual clock). '\ ``clock=3Dvm``\ ' is
> +    recommended especially in icount mode in order to preserve
> +    determinism; however, note that in icount mode the speed of the
> +    virtual clock is variable and can in general differ from the host
> +    clock.
> +
> +    Enable ``driftfix`` (i386 targets only) if you experience time drift
> +    problems, specifically with Windows' ACPI HAL. This option will try
> +    to figure out how many timer interrupts were not processed by the
> +    Windows guest and will re-inject them.
> +ERST
>=20=20
>  DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
>      "-icount [shift=3DN|auto][,align=3Don|off][,sleep=3Don|off,rr=3Dreco=
rd|replay,rrfile=3D<filename>,rrsnapshot=3D<snapshot>]\n" \
> @@ -3927,6 +6957,45 @@ Option rrsnapshot is used to create new vm snapsho=
t named @var{snapshot}
>  at the start of execution recording. In replay mode this option is used
>  to load the initial VM state.
>  ETEXI
> +SRST
> +``-icount [shift=3DN|auto][,rr=3Drecord|replay,rrfile=3Dfilename,rrsnaps=
hot=3Dsnapshot]``
> +    Enable virtual instruction counter. The virtual cpu will execute one
> +    instruction every 2^N ns of virtual time. If ``auto`` is specified
> +    then the virtual cpu speed will be automatically adjusted to keep
> +    virtual time within a few seconds of real time.
> +
> +    When the virtual cpu is sleeping, the virtual time will advance at
> +    default speed unless ``sleep=3Don|off`` is specified. With
> +    ``sleep=3Don|off``, the virtual time will jump to the next timer
> +    deadline instantly whenever the virtual cpu goes to sleep mode and
> +    will not advance if no timer is enabled. This behavior give
> +    deterministic execution times from the guest point of view.
> +
> +    Note that while this option can give deterministic behavior, it does
> +    not provide cycle accurate emulation. Modern CPUs contain
> +    superscalar out of order cores with complex cache hierarchies. The
> +    number of instructions executed often has little or no correlation
> +    with actual performance.
> +
> +    ``align=3Don`` will activate the delay algorithm which will try to
> +    synchronise the host clock and the virtual clock. The goal is to
> +    have a guest running at the real frequency imposed by the shift
> +    option. Whenever the guest clock is behind the host clock and if
> +    ``align=3Don`` is specified then we print a message to the user to
> +    inform about the delay. Currently this option does not work when
> +    ``shift`` is ``auto``. Note: The sync algorithm will work for those
> +    shift values for which the guest clock runs ahead of the host clock.
> +    Typically this happens when the shift value is high (how high
> +    depends on the host machine).
> +
> +    When ``rr`` option is specified deterministic record/replay is
> +    enabled. Replay log is written into filename file in record mode and
> +    read from this file in replay mode.
> +
> +    Option rrsnapshot is used to create new vm snapshot named snapshot
> +    at the start of execution recording. In replay mode this option is
> +    used to load the initial VM state.
> +ERST
>=20=20
>  DEF("watchdog", HAS_ARG, QEMU_OPTION_watchdog, \
>      "-watchdog model\n" \
> @@ -3956,6 +7025,30 @@ A virtual watchdog for s390x backed by the diagnos=
e 288 hypercall
>  (currently KVM only).
>  @end table
>  ETEXI
> +SRST
> +``-watchdog model``
> +    Create a virtual hardware watchdog device. Once enabled (by a guest
> +    action), the watchdog must be periodically polled by an agent inside
> +    the guest or else the guest will be restarted. Choose a model for
> +    which your guest has drivers.
> +
> +    The model is the model of hardware watchdog to emulate. Use
> +    ``-watchdog help`` to list available hardware models. Only one
> +    watchdog can be enabled for a guest.
> +
> +    The following models may be available:
> +
> +    ``ib700``
> +        iBASE 700 is a very simple ISA watchdog with a single timer.
> +
> +    ``i6300esb``
> +        Intel 6300ESB I/O controller hub is a much more featureful
> +        PCI-based dual-timer watchdog.
> +
> +    ``diag288``
> +        A virtual watchdog for s390x backed by the diagnose 288
> +        hypercall (currently KVM only).
> +ERST
>=20=20
>  DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
>      "-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|non=
e\n" \
> @@ -3989,6 +7082,26 @@ Examples:
>  @itemx -watchdog ib700
>  @end table
>  ETEXI
> +SRST
> +``-watchdog-action action``
> +    The action controls what QEMU will do when the watchdog timer
> +    expires. The default is ``reset`` (forcefully reset the guest).
> +    Other possible actions are: ``shutdown`` (attempt to gracefully
> +    shutdown the guest), ``poweroff`` (forcefully poweroff the guest),
> +    ``inject-nmi`` (inject a NMI into the guest), ``pause`` (pause the
> +    guest), ``debug`` (print a debug message and continue), or ``none``
> +    (do nothing).
> +
> +    Note that the ``shutdown`` action requires that the guest responds
> +    to ACPI signals, which it may not be able to do in the sort of
> +    situations where the watchdog would have expired, and thus
> +    ``-watchdog-action shutdown`` is not recommended for production use.
> +
> +    Examples:
> +
> +    ``-watchdog i6300esb -watchdog-action pause``; \ ``-watchdog ib700``
> +
> +ERST
>=20=20
>  DEF("echr", HAS_ARG, QEMU_OPTION_echr, \
>      "-echr chr       set terminal escape character instead of ctrl-a\n",
> @@ -4009,6 +7122,19 @@ character to Control-t.
>  @itemx -echr 20
>  @end table
>  ETEXI
> +SRST
> +``-echr numeric_ascii_value``
> +    Change the escape character used for switching to the monitor when
> +    using monitor and serial sharing. The default is ``0x01`` when using
> +    the ``-nographic`` option. ``0x01`` is equal to pressing
> +    ``Control-a``. You can select a different character from the ascii
> +    control keys where 1 through 26 map to Control-a through Control-z.
> +    For instance you could use the either of the following to change the
> +    escape character to Control-t.
> +
> +    ``-echr 0x14``; \ ``-echr 20``
> +
> +ERST
>=20=20
>  DEF("show-cursor", 0, QEMU_OPTION_show_cursor, \
>      "-show-cursor    show cursor\n", QEMU_ARCH_ALL)
> @@ -4017,6 +7143,10 @@ STEXI
>  @findex -show-cursor
>  Show cursor.
>  ETEXI
> +SRST
> +``-show-cursor``
> +    Show cursor.
> +ERST
>=20=20
>  DEF("tb-size", HAS_ARG, QEMU_OPTION_tb_size, \
>      "-tb-size n      set TB size\n", QEMU_ARCH_ALL)
> @@ -4026,6 +7156,11 @@ STEXI
>  Set TCG translation block cache size.  Deprecated, use @samp{-accel tcg,=
tb-size=3D@var{n}}
>  instead.
>  ETEXI
> +SRST
> +``-tb-size n``
> +    Set TCG translation block cache size. Deprecated, use
> +    '\ ``-accel tcg,tb-size=3Dn``\ ' instead.
> +ERST
>=20=20
>  DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>      "-incoming tcp:[host]:port[,to=3Dmaxport][,ipv4][,ipv6]\n" \
> @@ -4060,6 +7195,25 @@ Wait for the URI to be specified via migrate_incom=
ing.  The monitor can
>  be used to change settings (such as migration parameters) prior to issui=
ng
>  the migrate_incoming to allow the migration to begin.
>  ETEXI
> +SRST
> +``-incoming tcp:[host]:port[,to=3Dmaxport][,ipv4][,ipv6]``; \ ``-incomin=
g rdma:host:port[,ipv4][,ipv6]``
> +    Prepare for incoming migration, listen on a given tcp port.
> +
> +``-incoming unix:socketpath``
> +    Prepare for incoming migration, listen on a given unix socket.
> +
> +``-incoming fd:fd``
> +    Accept incoming migration from a given filedescriptor.
> +
> +``-incoming exec:cmdline``
> +    Accept incoming migration as an output from specified external
> +    command.
> +
> +``-incoming defer``
> +    Wait for the URI to be specified via migrate\_incoming. The monitor
> +    can be used to change settings (such as migration parameters) prior
> +    to issuing the migrate\_incoming to allow the migration to begin.
> +ERST
>=20=20
>  DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>      "-only-migratable     allow only migratable devices\n", QEMU_ARCH_AL=
L)
> @@ -4069,6 +7223,11 @@ STEXI
>  Only allow migratable devices. Devices will not be allowed to enter an
>  unmigratable state.
>  ETEXI
> +SRST
> +``-only-migratable``
> +    Only allow migratable devices. Devices will not be allowed to enter
> +    an unmigratable state.
> +ERST
>=20=20
>  DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
>      "-nodefaults     don't create default devices\n", QEMU_ARCH_ALL)
> @@ -4080,6 +7239,13 @@ port, parallel port, virtual console, monitor devi=
ce, VGA adapter, floppy and
>  CD-ROM drive and others. The @code{-nodefaults} option will disable all =
those
>  default devices.
>  ETEXI
> +SRST
> +``-nodefaults``
> +    Don't create default devices. Normally, QEMU sets the default
> +    devices like serial port, parallel port, virtual console, monitor
> +    device, VGA adapter, floppy and CD-ROM drive and others. The
> +    ``-nodefaults`` option will disable all those default devices.
> +ERST
>=20=20
>  #ifndef _WIN32
>  DEF("chroot", HAS_ARG, QEMU_OPTION_chroot, \
> @@ -4092,6 +7258,11 @@ STEXI
>  Immediately before starting guest execution, chroot to the specified
>  directory.  Especially useful in combination with -runas.
>  ETEXI
> +SRST
> +``-chroot dir``
> +    Immediately before starting guest execution, chroot to the specified
> +    directory. Especially useful in combination with -runas.
> +ERST
>=20=20
>  #ifndef _WIN32
>  DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
> @@ -4105,6 +7276,11 @@ STEXI
>  Immediately before starting guest execution, drop root privileges, switc=
hing
>  to the specified user.
>  ETEXI
> +SRST
> +``-runas user``
> +    Immediately before starting guest execution, drop root privileges,
> +    switching to the specified user.
> +ERST
>=20=20
>  DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
>      "-prom-env variable=3Dvalue\n"
> @@ -4127,6 +7303,21 @@ qemu-system-ppc -prom-env 'auto-boot?=3Dfalse' \
>  @end example
>=20=20
>  ETEXI
> +SRST
> +``-prom-env variable=3Dvalue``
> +    Set OpenBIOS nvram variable to given value (PPC, SPARC only).
> +
> +    ::
> +
> +        qemu-system-sparc -prom-env 'auto-boot?=3Dfalse' \
> +         -prom-env 'boot-device=3Dsd(0,2,0):d' -prom-env 'boot-args=3Dli=
nux single'
> +
> +    ::
> +
> +        qemu-system-ppc -prom-env 'auto-boot?=3Dfalse' \
> +         -prom-env 'boot-device=3Dhd:2,\yaboot' \
> +         -prom-env 'boot-args=3Dconf=3Dhd:2,\yaboot.conf'
> +ERST
>  DEF("semihosting", 0, QEMU_OPTION_semihosting,
>      "-semihosting    semihosting mode\n",
>      QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
> @@ -4142,6 +7333,16 @@ should only be used with a trusted guest OS.
>  See the -semihosting-config option documentation for further information
>  about the facilities this enables.
>  ETEXI
> +SRST
> +``-semihosting``
> +    Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
> +
> +    Note that this allows guest direct access to the host filesystem, so
> +    should only be used with a trusted guest OS.
> +
> +    See the -semihosting-config option documentation for further
> +    information about the facilities this enables.
> +ERST
>  DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
>      "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,c=
hardev=3Did][,arg=3Dstr[,...]]\n" \
>      "                semihosting configuration\n",
> @@ -4178,6 +7379,41 @@ command line is still supported for backward compa=
tibility. If both the
>  specified, the former is passed to semihosting as it always takes preced=
ence.
>  @end table
>  ETEXI
> +SRST
> +``-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,char=
dev=3Did][,arg=3Dstr[,...]]``
> +    Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II
> +    only).
> +
> +    Note that this allows guest direct access to the host filesystem, so
> +    should only be used with a trusted guest OS.
> +
> +    On Arm this implements the standard semihosting API, version 2.0.
> +
> +    On M68K this implements the "ColdFire GDB" interface used by
> +    libgloss.
> +
> +    Xtensa semihosting provides basic file IO calls, such as
> +    open/read/write/seek/select. Tensilica baremetal libc for ISS and
> +    linux platform "sim" use this interface.
> +
> +    ``target=3Dnative|gdb|auto``
> +        Defines where the semihosting calls will be addressed, to QEMU
> +        (``native``) or to GDB (``gdb``). The default is ``auto``, which
> +        means ``gdb`` during debug sessions and ``native`` otherwise.
> +
> +    ``chardev=3Dstr1``
> +        Send the output to a chardev backend output for native or auto
> +        output when not in gdb
> +
> +    ``arg=3Dstr1,arg=3Dstr2,...``
> +        Allows the user to pass input arguments, and can be used
> +        multiple times to build up a list. The old-style
> +        ``-kernel``/``-append`` method of passing a command line is
> +        still supported for backward compatibility. If both the
> +        ``--semihosting-config arg`` and the ``-kernel``/``-append`` are
> +        specified, the former is passed to semihosting as it always
> +        takes precedence.
> +ERST
>  DEF("old-param", 0, QEMU_OPTION_old_param,
>      "-old-param      old param mode\n", QEMU_ARCH_ARM)
>  STEXI
> @@ -4185,6 +7421,10 @@ STEXI
>  @findex -old-param (ARM)
>  Old param mode (ARM only).
>  ETEXI
> +SRST
> +``-old-param``
> +    Old param mode (ARM only).
> +ERST
>=20=20
>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
>      "-sandbox on[,obsolete=3Dallow|deny][,elevateprivileges=3Dallow|deny=
|children]\n" \
> @@ -4217,6 +7457,23 @@ Disable *fork and execve
>  Disable process affinity and schedular priority
>  @end table
>  ETEXI
> +SRST
> +``-sandbox arg[,obsolete=3Dstring][,elevateprivileges=3Dstring][,spawn=
=3Dstring][,resourcecontrol=3Dstring]``
> +    Enable Seccomp mode 2 system call filter. 'on' will enable syscall
> +    filtering and 'off' will disable it. The default is 'off'.
> +
> +    ``obsolete=3Dstring``
> +        Enable Obsolete system calls
> +
> +    ``elevateprivileges=3Dstring``
> +        Disable set\*uid\|gid system calls
> +
> +    ``spawn=3Dstring``
> +        Disable \*fork and execve
> +
> +    ``resourcecontrol=3Dstring``
> +        Disable process affinity and schedular priority
> +ERST
>=20=20
>  DEF("readconfig", HAS_ARG, QEMU_OPTION_readconfig,
>      "-readconfig <file>\n", QEMU_ARCH_ALL)
> @@ -4227,6 +7484,12 @@ Read device configuration from @var{file}. This ap=
proach is useful when you want
>  QEMU process with many command line options but you don't want to exceed=
 the command line
>  character limit.
>  ETEXI
> +SRST
> +``-readconfig file``
> +    Read device configuration from file. This approach is useful when
> +    you want to spawn QEMU process with many command line options but
> +    you don't want to exceed the command line character limit.
> +ERST
>  DEF("writeconfig", HAS_ARG, QEMU_OPTION_writeconfig,
>      "-writeconfig <file>\n"
>      "                read/write config file\n", QEMU_ARCH_ALL)
> @@ -4237,6 +7500,13 @@ Write device configuration to @var{file}. The @var=
{file} can be either filename
>  command line and device configuration into file or dash @code{-}) charac=
ter to print the
>  output to stdout. This can be later used as input file for @code{-readco=
nfig} option.
>  ETEXI
> +SRST
> +``-writeconfig file``
> +    Write device configuration to file. The file can be either filename
> +    to save command line and device configuration into file or dash
> +    ``-``) character to print the output to stdout. This can be later
> +    used as input file for ``-readconfig`` option.
> +ERST
>=20=20
>  DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
>      "-no-user-config\n"
> @@ -4248,6 +7518,11 @@ STEXI
>  The @code{-no-user-config} option makes QEMU not load any of the user-pr=
ovided
>  config files on @var{sysconfdir}.
>  ETEXI
> +SRST
> +``-no-user-config``
> +    The ``-no-user-config`` option makes QEMU not load any of the
> +    user-provided config files on sysconfdir.
> +ERST
>=20=20
>  DEF("trace", HAS_ARG, QEMU_OPTION_trace,
>      "-trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\n"
> @@ -4260,6 +7535,30 @@ HXCOMM HX does not support conditional compilation=
 of text.
>  @findex -trace
>  @include docs/system/qemu-option-trace.texi
>  ETEXI
> +SRST
> +``-trace [[enable=3D]pattern][,events=3Dfile][,file=3Dfile]``
> +    Specify tracing options.
> +
> +    ``[enable=3D]pattern``
> +        Immediately enable events matching pattern (either event name or
> +        a globbing pattern). This option is only available if QEMU has
> +        been compiled with the simple, log or ftrace tracing backend. To
> +        specify multiple events or patterns, specify the ``-trace``
> +        option multiple times.
> +
> +        Use ``-trace help`` to print a list of names of trace points.
> +
> +    ``events=3Dfile``
> +        Immediately enable events listed in file. The file must contain
> +        one event name (as listed in the ``trace-events-all`` file) per
> +        line; globbing patterns are accepted too. This option is only
> +        available if QEMU has been compiled with the simple, log or
> +        ftrace tracing backend.
> +
> +    ``file=3Dfile``
> +        Log output traces to file. This option is only available if QEMU
> +        has been compiled with the simple tracing backend.
> +ERST
>  DEF("plugin", HAS_ARG, QEMU_OPTION_plugin,
>      "-plugin [file=3D]<file>[,arg=3D<string>]\n"
>      "                load a plugin\n",
> @@ -4277,6 +7576,17 @@ Load the given plugin from a shared library file.
>  Argument string passed to the plugin. (Can be given multiple times.)
>  @end table
>  ETEXI
> +SRST
> +``-plugin file=3Dfile[,arg=3Dstring]``
> +    Load a plugin.
> +
> +    ``file=3Dfile``
> +        Load the given plugin from a shared library file.
> +
> +    ``arg=3Dstring``
> +        Argument string passed to the plugin. (Can be given multiple
> +        times.)
> +ERST
>=20=20
>  HXCOMM Internal use
>  DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
> @@ -4292,6 +7602,10 @@ STEXI
>  @findex -enable-fips
>  Enable FIPS 140-2 compliance mode.
>  ETEXI
> +SRST
> +``-enable-fips``
> +    Enable FIPS 140-2 compliance mode.
> +ERST
>=20=20
>  HXCOMM Deprecated by -accel tcg
>  DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
> @@ -4310,6 +7624,13 @@ Control error message format.
>  Prefix messages with a timestamp.  Default is off.
>  @end table
>  ETEXI
> +SRST
> +``-msg timestamp[=3Don|off]``
> +    Control error message format.
> +
> +    ``timestamp=3Don|off``
> +        Prefix messages with a timestamp. Default is off.
> +ERST
>=20=20
>  DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
>      "-dump-vmstate <file>\n"
> @@ -4324,6 +7645,11 @@ STEXI
>  Dump json-encoded vmstate information for current machine type to file
>  in @var{file}
>  ETEXI
> +SRST
> +``-dump-vmstate file``
> +    Dump json-encoded vmstate information for current machine type to
> +    file in file
> +ERST
>=20=20
>  DEF("enable-sync-profile", 0, QEMU_OPTION_enable_sync_profile,
>      "-enable-sync-profile\n"
> @@ -4334,6 +7660,10 @@ STEXI
>  @findex -enable-sync-profile
>  Enable synchronization profiling.
>  ETEXI
> +SRST
> +``-enable-sync-profile``
> +    Enable synchronization profiling.
> +ERST
>=20=20
>  STEXI
>  @end table
> @@ -5014,6 +8344,675 @@ The polling parameters can be modified at run-tim=
e using the @code{qom-set} comm
>  @end table
>=20=20
>  ETEXI
> +SRST
> +``-object typename[,prop1=3Dvalue1,...]``
> +    Create a new object of type typename setting properties in the order
> +    they are specified. Note that the 'id' property must be set. These
> +    objects are placed in the '/objects' path.
> +
> +    ``-object memory-backend-file,id=3Did,size=3Dsize,mem-path=3Ddir,sha=
re=3Don|off,discard-data=3Don|off,merge=3Don|off,dump=3Don|off,prealloc=3Do=
n|off,host-nodes=3Dhost-nodes,policy=3Ddefault|preferred|bind|interleave,al=
ign=3Dalign``
> +        Creates a memory file backend object, which can be used to back
> +        the guest RAM with huge pages.
> +
> +        The ``id`` parameter is a unique ID that will be used to
> +        reference this memory region when configuring the ``-numa``
> +        argument.
> +
> +        The ``size`` option provides the size of the memory region, and
> +        accepts common suffixes, eg ``500M``.
> +
> +        The ``mem-path`` provides the path to either a shared memory or
> +        huge page filesystem mount.
> +
> +        The ``share`` boolean option determines whether the memory
> +        region is marked as private to QEMU, or shared. The latter
> +        allows a co-operating external process to access the QEMU memory
> +        region.
> +
> +        The ``share`` is also required for pvrdma devices due to
> +        limitations in the RDMA API provided by Linux.
> +
> +        Setting share=3Don might affect the ability to configure NUMA
> +        bindings for the memory backend under some circumstances, see
> +        Documentation/vm/numa\_memory\_policy.txt on the Linux kernel
> +        source tree for additional details.
> +
> +        Setting the ``discard-data`` boolean option to on indicates that
> +        file contents can be destroyed when QEMU exits, to avoid
> +        unnecessarily flushing data to the backing file. Note that
> +        ``discard-data`` is only an optimization, and QEMU might not
> +        discard file contents if it aborts unexpectedly or is terminated
> +        using SIGKILL.
> +
> +        The ``merge`` boolean option enables memory merge, also known as
> +        MADV\_MERGEABLE, so that Kernel Samepage Merging will consider
> +        the pages for memory deduplication.
> +
> +        Setting the ``dump`` boolean option to off excludes the memory
> +        from core dumps. This feature is also known as MADV\_DONTDUMP.
> +
> +        The ``prealloc`` boolean option enables memory preallocation.
> +
> +        The ``host-nodes`` option binds the memory range to a list of
> +        NUMA host nodes.
> +
> +        The ``policy`` option sets the NUMA policy to one of the
> +        following values:
> +
> +        ``default``
> +            default host policy
> +
> +        ``preferred``
> +            prefer the given host node list for allocation
> +
> +        ``bind``
> +            restrict memory allocation to the given host node list
> +
> +        ``interleave``
> +            interleave memory allocations across the given host node
> +            list
> +
> +        The ``align`` option specifies the base address alignment when
> +        QEMU mmap(2) ``mem-path``, and accepts common suffixes, eg
> +        ``2M``. Some backend store specified by ``mem-path`` requires an
> +        alignment different than the default one used by QEMU, eg the
> +        device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
> +        such cases, users can specify the required alignment via this
> +        option.
> +
> +        The ``pmem`` option specifies whether the backing file specified
> +        by ``mem-path`` is in host persistent memory that can be
> +        accessed using the SNIA NVM programming model (e.g. Intel
> +        NVDIMM). If ``pmem`` is set to 'on', QEMU will take necessary
> +        operations to guarantee the persistence of its own writes to
> +        ``mem-path`` (e.g. in vNVDIMM label emulation and live
> +        migration). Also, we will map the backend-file with MAP\_SYNC
> +        flag, which ensures the file metadata is in sync for
> +        ``mem-path`` in case of host crash or a power failure. MAP\_SYNC
> +        requires support from both the host kernel (since Linux kernel
> +        4.15) and the filesystem of ``mem-path`` mounted with DAX
> +        option.
> +
> +    ``-object memory-backend-ram,id=3Did,merge=3Don|off,dump=3Don|off,sh=
are=3Don|off,prealloc=3Don|off,size=3Dsize,host-nodes=3Dhost-nodes,policy=
=3Ddefault|preferred|bind|interleave``
> +        Creates a memory backend object, which can be used to back the
> +        guest RAM. Memory backend objects offer more control than the
> +        ``-m`` option that is traditionally used to define guest RAM.
> +        Please refer to ``memory-backend-file`` for a description of the
> +        options.
> +
> +    ``-object memory-backend-memfd,id=3Did,merge=3Don|off,dump=3Don|off,=
share=3Don|off,prealloc=3Don|off,size=3Dsize,host-nodes=3Dhost-nodes,policy=
=3Ddefault|preferred|bind|interleave,seal=3Don|off,hugetlb=3Don|off,hugetlb=
size=3Dsize``
> +        Creates an anonymous memory file backend object, which allows
> +        QEMU to share the memory with an external process (e.g. when
> +        using vhost-user). The memory is allocated with memfd and
> +        optional sealing. (Linux only)
> +
> +        The ``seal`` option creates a sealed-file, that will block
> +        further resizing the memory ('on' by default).
> +
> +        The ``hugetlb`` option specify the file to be created resides in
> +        the hugetlbfs filesystem (since Linux 4.14). Used in conjunction
> +        with the ``hugetlb`` option, the ``hugetlbsize`` option specify
> +        the hugetlb page size on systems that support multiple hugetlb
> +        page sizes (it must be a power of 2 value supported by the
> +        system).
> +
> +        In some versions of Linux, the ``hugetlb`` option is
> +        incompatible with the ``seal`` option (requires at least Linux
> +        4.16).
> +
> +        Please refer to ``memory-backend-file`` for a description of the
> +        other options.
> +
> +        The ``share`` boolean option is on by default with memfd.
> +
> +    ``-object rng-builtin,id=3Did``
> +        Creates a random number generator backend which obtains entropy
> +        from QEMU builtin functions. The ``id`` parameter is a unique ID
> +        that will be used to reference this entropy backend from the
> +        ``virtio-rng`` device. By default, the ``virtio-rng`` device
> +        uses this RNG backend.
> +
> +    ``-object rng-random,id=3Did,filename=3D/dev/random``
> +        Creates a random number generator backend which obtains entropy
> +        from a device on the host. The ``id`` parameter is a unique ID
> +        that will be used to reference this entropy backend from the
> +        ``virtio-rng`` device. The ``filename`` parameter specifies
> +        which file to obtain entropy from and if omitted defaults to
> +        ``/dev/urandom``.
> +
> +    ``-object rng-egd,id=3Did,chardev=3Dchardevid``
> +        Creates a random number generator backend which obtains entropy
> +        from an external daemon running on the host. The ``id``
> +        parameter is a unique ID that will be used to reference this
> +        entropy backend from the ``virtio-rng`` device. The ``chardev``
> +        parameter is the unique ID of a character device backend that
> +        provides the connection to the RNG daemon.
> +
> +    ``-object tls-creds-anon,id=3Did,endpoint=3Dendpoint,dir=3D/path/to/=
cred/dir,verify-peer=3Don|off``
> +        Creates a TLS anonymous credentials object, which can be used to
> +        provide TLS support on network backends. The ``id`` parameter is
> +        a unique ID which network backends will use to access the
> +        credentials. The ``endpoint`` is either ``server`` or ``client``
> +        depending on whether the QEMU network backend that uses the
> +        credentials will be acting as a client or as a server. If
> +        ``verify-peer`` is enabled (the default) then once the handshake
> +        is completed, the peer credentials will be verified, though this
> +        is a no-op for anonymous credentials.
> +
> +        The dir parameter tells QEMU where to find the credential files.
> +        For server endpoints, this directory may contain a file
> +        dh-params.pem providing diffie-hellman parameters to use for the
> +        TLS server. If the file is missing, QEMU will generate a set of
> +        DH parameters at startup. This is a computationally expensive
> +        operation that consumes random pool entropy, so it is
> +        recommended that a persistent set of parameters be generated
> +        upfront and saved.
> +
> +    ``-object tls-creds-psk,id=3Did,endpoint=3Dendpoint,dir=3D/path/to/k=
eys/dir[,username=3Dusername]``
> +        Creates a TLS Pre-Shared Keys (PSK) credentials object, which
> +        can be used to provide TLS support on network backends. The
> +        ``id`` parameter is a unique ID which network backends will use
> +        to access the credentials. The ``endpoint`` is either ``server``
> +        or ``client`` depending on whether the QEMU network backend that
> +        uses the credentials will be acting as a client or as a server.
> +        For clients only, ``username`` is the username which will be
> +        sent to the server. If omitted it defaults to "qemu".
> +
> +        The dir parameter tells QEMU where to find the keys file. It is
> +        called "dir/keys.psk" and contains "username:key" pairs. This
> +        file can most easily be created using the GnuTLS ``psktool``
> +        program.
> +
> +        For server endpoints, dir may also contain a file dh-params.pem
> +        providing diffie-hellman parameters to use for the TLS server.
> +        If the file is missing, QEMU will generate a set of DH
> +        parameters at startup. This is a computationally expensive
> +        operation that consumes random pool entropy, so it is
> +        recommended that a persistent set of parameters be generated up
> +        front and saved.
> +
> +    ``-object tls-creds-x509,id=3Did,endpoint=3Dendpoint,dir=3D/path/to/=
cred/dir,priority=3Dpriority,verify-peer=3Don|off,passwordid=3Did``
> +        Creates a TLS anonymous credentials object, which can be used to
> +        provide TLS support on network backends. The ``id`` parameter is
> +        a unique ID which network backends will use to access the
> +        credentials. The ``endpoint`` is either ``server`` or ``client``
> +        depending on whether the QEMU network backend that uses the
> +        credentials will be acting as a client or as a server. If
> +        ``verify-peer`` is enabled (the default) then once the handshake
> +        is completed, the peer credentials will be verified. With x509
> +        certificates, this implies that the clients must be provided
> +        with valid client certificates too.
> +
> +        The dir parameter tells QEMU where to find the credential files.
> +        For server endpoints, this directory may contain a file
> +        dh-params.pem providing diffie-hellman parameters to use for the
> +        TLS server. If the file is missing, QEMU will generate a set of
> +        DH parameters at startup. This is a computationally expensive
> +        operation that consumes random pool entropy, so it is
> +        recommended that a persistent set of parameters be generated
> +        upfront and saved.
> +
> +        For x509 certificate credentials the directory will contain
> +        further files providing the x509 certificates. The certificates
> +        must be stored in PEM format, in filenames ca-cert.pem,
> +        ca-crl.pem (optional), server-cert.pem (only servers),
> +        server-key.pem (only servers), client-cert.pem (only clients),
> +        and client-key.pem (only clients).
> +
> +        For the server-key.pem and client-key.pem files which contain
> +        sensitive private keys, it is possible to use an encrypted
> +        version by providing the passwordid parameter. This provides the
> +        ID of a previously created ``secret`` object containing the
> +        password for decryption.
> +
> +        The priority parameter allows to override the global default
> +        priority used by gnutls. This can be useful if the system
> +        administrator needs to use a weaker set of crypto priorities for
> +        QEMU without potentially forcing the weakness onto all
> +        applications. Or conversely if one wants wants a stronger
> +        default for QEMU than for all other applications, they can do
> +        this through this parameter. Its format is a gnutls priority
> +        string as described at
> +        https://gnutls.org/manual/html_node/Priority-Strings.html.
> +
> +    ``-object filter-buffer,id=3Did,netdev=3Dnetdevid,interval=3Dt[,queu=
e=3Dall|rx|tx][,status=3Don|off]``
> +        Interval t can't be 0, this filter batches the packet delivery:
> +        all packets arriving in a given interval on netdev netdevid are
> +        delayed until the end of the interval. Interval is in
> +        microseconds. ``status`` is optional that indicate whether the
> +        netfilter is on (enabled) or off (disabled), the default status
> +        for netfilter will be 'on'.
> +
> +        queue all\|rx\|tx is an option that can be applied to any
> +        netfilter.
> +
> +        ``all``: the filter is attached both to the receive and the
> +        transmit queue of the netdev (default).
> +
> +        ``rx``: the filter is attached to the receive queue of the
> +        netdev, where it will receive packets sent to the netdev.
> +
> +        ``tx``: the filter is attached to the transmit queue of the
> +        netdev, where it will receive packets sent by the netdev.
> +
> +    ``-object filter-mirror,id=3Did,netdev=3Dnetdevid,outdev=3Dchardevid=
,queue=3Dall|rx|tx[,vnet_hdr_support]``
> +        filter-mirror on netdev netdevid,mirror net packet to
> +        chardevchardevid, if it has the vnet\_hdr\_support flag,
> +        filter-mirror will mirror packet with vnet\_hdr\_len.
> +
> +    ``-object filter-redirector,id=3Did,netdev=3Dnetdevid,indev=3Dcharde=
vid,outdev=3Dchardevid,queue=3Dall|rx|tx[,vnet_hdr_support]``
> +        filter-redirector on netdev netdevid,redirect filter's net
> +        packet to chardev chardevid,and redirect indev's packet to
> +        filter.if it has the vnet\_hdr\_support flag, filter-redirector
> +        will redirect packet with vnet\_hdr\_len. Create a
> +        filter-redirector we need to differ outdev id from indev id, id
> +        can not be the same. we can just use indev or outdev, but at
> +        least one of indev or outdev need to be specified.
> +
> +    ``-object filter-rewriter,id=3Did,netdev=3Dnetdevid,queue=3Dall|rx|t=
x,[vnet_hdr_support]``
> +        Filter-rewriter is a part of COLO project.It will rewrite tcp
> +        packet to secondary from primary to keep secondary tcp
> +        connection,and rewrite tcp packet to primary from secondary make
> +        tcp packet can be handled by client.if it has the
> +        vnet\_hdr\_support flag, we can parse packet with vnet header.
> +
> +        usage: colo secondary: -object
> +        filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 -=
object
> +        filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 =
-object
> +        filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall
> +
> +    ``-object filter-dump,id=3Did,netdev=3Ddev[,file=3Dfilename][,maxlen=
=3Dlen]``
> +        Dump the network traffic on netdev dev to the file specified by
> +        filename. At most len bytes (64k by default) per packet are
> +        stored. The file format is libpcap, so it can be analyzed with
> +        tools such as tcpdump or Wireshark.
> +
> +    ``-object colo-compare,id=3Did,primary_in=3Dchardevid,secondary_in=
=3Dchardevid,outdev=3Dchardevid,iothread=3Did[,vnet_hdr_support][,notify_de=
v=3Did]``
> +        Colo-compare gets packet from primary\_inchardevid and
> +        secondary\_inchardevid, than compare primary packet with
> +        secondary packet. If the packets are same, we will output
> +        primary packet to outdevchardevid, else we will notify
> +        colo-frame do checkpoint and send primary packet to
> +        outdevchardevid. In order to improve efficiency, we need to put
> +        the task of comparison in another thread. If it has the
> +        vnet\_hdr\_support flag, colo compare will send/recv packet with
> +        vnet\_hdr\_len. If you want to use Xen COLO, will need the
> +        notify\_dev to notify Xen colo-frame to do checkpoint.
> +
> +        we must use it with the help of filter-mirror and
> +        filter-redirector.
> +
> +        ::
> +
> +            KVM COLO
> +
> +            primary:
> +            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,dow=
nscript=3D/etc/qemu-ifdown
> +            -device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
> +            -chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,serv=
er,nowait
> +            -chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,ser=
ver,nowait
> +            -chardev socket,id=3Dcompare0,host=3D3.3.3.3,port=3D9001,ser=
ver,nowait
> +            -chardev socket,id=3Dcompare0-0,host=3D3.3.3.3,port=3D9001
> +            -chardev socket,id=3Dcompare_out,host=3D3.3.3.3,port=3D9005,=
server,nowait
> +            -chardev socket,id=3Dcompare_out0,host=3D3.3.3.3,port=3D9005
> +            -object iothread,id=3Diothread1
> +            -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=
=3Dmirror0
> +            -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3D=
rx,indev=3Dcompare_out
> +            -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3D=
rx,outdev=3Dcompare0
> +            -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,seco=
ndary_in=3Dcompare1,outdev=3Dcompare_out0,iothread=3Diothread1
> +
> +            secondary:
> +            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,dow=
n script=3D/etc/qemu-ifdown
> +            -device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
> +            -chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
> +            -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
> +            -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,in=
dev=3Dred0
> +            -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,ou=
tdev=3Dred1
> +
> +
> +            Xen COLO
> +
> +            primary:
> +            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,dow=
nscript=3D/etc/qemu-ifdown
> +            -device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
> +            -chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,serv=
er,nowait
> +            -chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,ser=
ver,nowait
> +            -chardev socket,id=3Dcompare0,host=3D3.3.3.3,port=3D9001,ser=
ver,nowait
> +            -chardev socket,id=3Dcompare0-0,host=3D3.3.3.3,port=3D9001
> +            -chardev socket,id=3Dcompare_out,host=3D3.3.3.3,port=3D9005,=
server,nowait
> +            -chardev socket,id=3Dcompare_out0,host=3D3.3.3.3,port=3D9005
> +            -chardev socket,id=3Dnotify_way,host=3D3.3.3.3,port=3D9009,s=
erver,nowait
> +            -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=
=3Dmirror0
> +            -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3D=
rx,indev=3Dcompare_out
> +            -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3D=
rx,outdev=3Dcompare0
> +            -object iothread,id=3Diothread1
> +            -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,seco=
ndary_in=3Dcompare1,outdev=3Dcompare_out0,notify_dev=3Dnofity_way,iothread=
=3Diothread1
> +
> +            secondary:
> +            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,dow=
n script=3D/etc/qemu-ifdown
> +            -device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
> +            -chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
> +            -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
> +            -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,in=
dev=3Dred0
> +            -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,ou=
tdev=3Dred1
> +
> +        If you want to know the detail of above command line, you can
> +        read the colo-compare git log.
> +
> +    ``-object cryptodev-backend-builtin,id=3Did[,queues=3Dqueues]``
> +        Creates a cryptodev backend which executes crypto opreation from
> +        the QEMU cipher APIS. The id parameter is a unique ID that will
> +        be used to reference this cryptodev backend from the
> +        ``virtio-crypto`` device. The queues parameter is optional,
> +        which specify the queue number of cryptodev backend, the default
> +        of queues is 1.
> +
> +        ::
> +
> +             # |qemu_system| \
> +               [...] \
> +                   -object cryptodev-backend-builtin,id=3Dcryptodev0 \
> +                   -device virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcr=
yptodev0 \
> +               [...]
> +
> +    ``-object cryptodev-vhost-user,id=3Did,chardev=3Dchardevid[,queues=
=3Dqueues]``
> +        Creates a vhost-user cryptodev backend, backed by a chardev
> +        chardevid. The id parameter is a unique ID that will be used to
> +        reference this cryptodev backend from the ``virtio-crypto``
> +        device. The chardev should be a unix domain socket backed one.
> +        The vhost-user uses a specifically defined protocol to pass
> +        vhost ioctl replacement messages to an application on the other
> +        end of the socket. The queues parameter is optional, which
> +        specify the queue number of cryptodev backend for multiqueue
> +        vhost-user, the default of queues is 1.
> +
> +        ::
> +
> +             # |qemu_system| \
> +               [...] \
> +                   -chardev socket,id=3Dchardev0,path=3D/path/to/socket \
> +                   -object cryptodev-vhost-user,id=3Dcryptodev0,chardev=
=3Dchardev0 \
> +                   -device virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcr=
yptodev0 \
> +               [...]
> +
> +    ``-object secret,id=3Did,data=3Dstring,format=3Draw|base64[,keyid=3D=
secretid,iv=3Dstring]``
> +    ``-object secret,id=3Did,file=3Dfilename,format=3Draw|base64[,keyid=
=3Dsecretid,iv=3Dstring]``
> +        Defines a secret to store a password, encryption key, or some
> +        other sensitive data. The sensitive data can either be passed
> +        directly via the data parameter, or indirectly via the file
> +        parameter. Using the data parameter is insecure unless the
> +        sensitive data is encrypted.
> +
> +        The sensitive data can be provided in raw format (the default),
> +        or base64. When encoded as JSON, the raw format only supports
> +        valid UTF-8 characters, so base64 is recommended for sending
> +        binary data. QEMU will convert from which ever format is
> +        provided to the format it needs internally. eg, an RBD password
> +        can be provided in raw format, even though it will be base64
> +        encoded when passed onto the RBD sever.
> +
> +        For added protection, it is possible to encrypt the data
> +        associated with a secret using the AES-256-CBC cipher. Use of
> +        encryption is indicated by providing the keyid and iv
> +        parameters. The keyid parameter provides the ID of a previously
> +        defined secret that contains the AES-256 decryption key. This
> +        key should be 32-bytes long and be base64 encoded. The iv
> +        parameter provides the random initialization vector used for
> +        encryption of this particular secret and should be a base64
> +        encrypted string of the 16-byte IV.
> +
> +        The simplest (insecure) usage is to provide the secret inline
> +
> +        ::
> +
> +             # |qemu_system| -object secret,id=3Dsec0,data=3Dletmein,for=
mat=3Draw
> +
> +        The simplest secure usage is to provide the secret via a file
> +
> +        # printf "letmein" > mypasswd.txt # QEMU\_SYSTEM\_MACRO -object
> +        secret,id=3Dsec0,file=3Dmypasswd.txt,format=3Draw
> +
> +        For greater security, AES-256-CBC should be used. To illustrate
> +        usage, consider the openssl command line tool which can encrypt
> +        the data. Note that when encrypting, the plaintext must be
> +        padded to the cipher block size (32 bytes) using the standard
> +        PKCS#5/6 compatible padding algorithm.
> +
> +        First a master key needs to be created in base64 encoding:
> +
> +        ::
> +
> +             # openssl rand -base64 32 > key.b64
> +             # KEY=3D$(base64 -d key.b64 | hexdump  -v -e '/1 "%02X"')
> +
> +        Each secret to be encrypted needs to have a random
> +        initialization vector generated. These do not need to be kept
> +        secret
> +
> +        ::
> +
> +             # openssl rand -base64 16 > iv.b64
> +             # IV=3D$(base64 -d iv.b64 | hexdump  -v -e '/1 "%02X"')
> +
> +        The secret to be defined can now be encrypted, in this case
> +        we're telling openssl to base64 encode the result, but it could
> +        be left as raw bytes if desired.
> +
> +        ::
> +
> +             # SECRET=3D$(printf "letmein" |
> +                        openssl enc -aes-256-cbc -a -K $KEY -iv $IV)
> +
> +        When launching QEMU, create a master secret pointing to
> +        ``key.b64`` and specify that to be used to decrypt the user
> +        password. Pass the contents of ``iv.b64`` to the second secret
> +
> +        ::
> +
> +             # |qemu_system| \
> +                 -object secret,id=3Dsecmaster0,format=3Dbase64,file=3Dk=
ey.b64 \
> +                 -object secret,id=3Dsec0,keyid=3Dsecmaster0,format=3Dba=
se64,\
> +                     data=3D$SECRET,iv=3D$(<iv.b64)
> +
> +    ``-object sev-guest,id=3Did,cbitpos=3Dcbitpos,reduced-phys-bits=3Dva=
l,[sev-device=3Dstring,policy=3Dpolicy,handle=3Dhandle,dh-cert-file=3Dfile,=
session-file=3Dfile]``
> +        Create a Secure Encrypted Virtualization (SEV) guest object,
> +        which can be used to provide the guest memory encryption support
> +        on AMD processors.
> +
> +        When memory encryption is enabled, one of the physical address
> +        bit (aka the C-bit) is utilized to mark if a memory page is
> +        protected. The ``cbitpos`` is used to provide the C-bit
> +        position. The C-bit position is Host family dependent hence user
> +        must provide this value. On EPYC, the value should be 47.
> +
> +        When memory encryption is enabled, we loose certain bits in
> +        physical address space. The ``reduced-phys-bits`` is used to
> +        provide the number of bits we loose in physical address space.
> +        Similar to C-bit, the value is Host family dependent. On EPYC,
> +        the value should be 5.
> +
> +        The ``sev-device`` provides the device file to use for
> +        communicating with the SEV firmware running inside AMD Secure
> +        Processor. The default device is '/dev/sev'. If hardware
> +        supports memory encryption then /dev/sev devices are created by
> +        CCP driver.
> +
> +        The ``policy`` provides the guest policy to be enforced by the
> +        SEV firmware and restrict what configuration and operational
> +        commands can be performed on this guest by the hypervisor. The
> +        policy should be provided by the guest owner and is bound to the
> +        guest and cannot be changed throughout the lifetime of the
> +        guest. The default is 0.
> +
> +        If guest ``policy`` allows sharing the key with another SEV
> +        guest then ``handle`` can be use to provide handle of the guest
> +        from which to share the key.
> +
> +        The ``dh-cert-file`` and ``session-file`` provides the guest
> +        owner's Public Diffie-Hillman key defined in SEV spec. The PDH
> +        and session parameters are used for establishing a cryptographic
> +        session with the guest owner to negotiate keys used for
> +        attestation. The file must be encoded in base64.
> +
> +        e.g to launch a SEV guest
> +
> +        ::
> +
> +             # |qemu_system_x86| \
> +                 ......
> +                 -object sev-guest,id=3Dsev0,cbitpos=3D47,reduced-phys-b=
its=3D5 \
> +                 -machine ...,memory-encryption=3Dsev0
> +                 .....
> +
> +    ``-object authz-simple,id=3Did,identity=3Dstring``
> +        Create an authorization object that will control access to
> +        network services.
> +
> +        The ``identity`` parameter is identifies the user and its format
> +        depends on the network service that authorization object is
> +        associated with. For authorizing based on TLS x509 certificates,
> +        the identity must be the x509 distinguished name. Note that care
> +        must be taken to escape any commas in the distinguished name.
> +
> +        An example authorization object to validate a x509 distinguished
> +        name would look like:
> +
> +        ::
> +
> +             # |qemu_system| \
> +                 ...
> +                 -object 'authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop=
.example.com,,O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB' \
> +                 ...
> +
> +        Note the use of quotes due to the x509 distinguished name
> +        containing whitespace, and escaping of ','.
> +
> +    ``-object authz-listfile,id=3Did,filename=3Dpath,refresh=3Dyes|no``
> +        Create an authorization object that will control access to
> +        network services.
> +
> +        The ``filename`` parameter is the fully qualified path to a file
> +        containing the access control list rules in JSON format.
> +
> +        An example set of rules that match against SASL usernames might
> +        look like:
> +
> +        ::
> +
> +              {
> +                "rules": [
> +                   { "match": "fred", "policy": "allow", "format": "exac=
t" },
> +                   { "match": "bob", "policy": "allow", "format": "exact=
" },
> +                   { "match": "danb", "policy": "deny", "format": "glob"=
 },
> +                   { "match": "dan*", "policy": "allow", "format": "exac=
t" },
> +                ],
> +                "policy": "deny"
> +              }
> +
> +        When checking access the object will iterate over all the rules
> +        and the first rule to match will have its ``policy`` value
> +        returned as the result. If no rules match, then the default
> +        ``policy`` value is returned.
> +
> +        The rules can either be an exact string match, or they can use
> +        the simple UNIX glob pattern matching to allow wildcards to be
> +        used.
> +
> +        If ``refresh`` is set to true the file will be monitored and
> +        automatically reloaded whenever its content changes.
> +
> +        As with the ``authz-simple`` object, the format of the identity
> +        strings being matched depends on the network service, but is
> +        usually a TLS x509 distinguished name, or a SASL username.
> +
> +        An example authorization object to validate a SASL username
> +        would look like:
> +
> +        ::
> +
> +             # |qemu_system| \
> +                 ...
> +                 -object authz-simple,id=3Dauth0,filename=3D/etc/qemu/vn=
c-sasl.acl,refresh=3Dyes
> +                 ...
> +
> +    ``-object authz-pam,id=3Did,service=3Dstring``
> +        Create an authorization object that will control access to
> +        network services.
> +
> +        The ``service`` parameter provides the name of a PAM service to
> +        use for authorization. It requires that a file
> +        ``/etc/pam.d/service`` exist to provide the configuration for
> +        the ``account`` subsystem.
> +
> +        An example authorization object to validate a TLS x509
> +        distinguished name would look like:
> +
> +        ::
> +
> +             # |qemu_system| \
> +                 ...
> +                 -object authz-pam,id=3Dauth0,service=3Dqemu-vnc
> +                 ...
> +
> +        There would then be a corresponding config file for PAM at
> +        ``/etc/pam.d/qemu-vnc`` that contains:
> +
> +        ::
> +
> +            account requisite  pam_listfile.so item=3Duser sense=3Dallow=
 \
> +                       file=3D/etc/qemu/vnc.allow
> +
> +        Finally the ``/etc/qemu/vnc.allow`` file would contain the list
> +        of x509 distingished names that are permitted access
> +
> +        ::
> +
> +            CN=3Dlaptop.example.com,O=3DExample Home,L=3DLondon,ST=3DLon=
don,C=3DGB
> +
> +    ``-object iothread,id=3Did,poll-max-ns=3Dpoll-max-ns,poll-grow=3Dpol=
l-grow,poll-shrink=3Dpoll-shrink``
> +        Creates a dedicated event loop thread that devices can be
> +        assigned to. This is known as an IOThread. By default device
> +        emulation happens in vCPU threads or the main event loop thread.
> +        This can become a scalability bottleneck. IOThreads allow device
> +        emulation and I/O to run on other host CPUs.
> +
> +        The ``id`` parameter is a unique ID that will be used to
> +        reference this IOThread from ``-device ...,iothread=3Did``.
> +        Multiple devices can be assigned to an IOThread. Note that not
> +        all devices support an ``iothread`` parameter.
> +
> +        The ``query-iothreads`` QMP command lists IOThreads and reports
> +        their thread IDs so that the user can configure host CPU
> +        pinning/affinity.
> +
> +        IOThreads use an adaptive polling algorithm to reduce event loop
> +        latency. Instead of entering a blocking system call to monitor
> +        file descriptors and then pay the cost of being woken up when an
> +        event occurs, the polling algorithm spins waiting for events for
> +        a short time. The algorithm's default parameters are suitable
> +        for many cases but can be adjusted based on knowledge of the
> +        workload and/or host device latency.
> +
> +        The ``poll-max-ns`` parameter is the maximum number of
> +        nanoseconds to busy wait for events. Polling can be disabled by
> +        setting this value to 0.
> +
> +        The ``poll-grow`` parameter is the multiplier used to increase
> +        the polling time when the algorithm detects it is missing events
> +        due to not polling long enough.
> +
> +        The ``poll-shrink`` parameter is the divisor used to decrease
> +        the polling time when the algorithm detects it is spending too
> +        long polling without encountering events.
> +
> +        The polling parameters can be modified at run-time using the
> +        ``qom-set`` command (where ``iothread1`` is the IOThread's
> +        ``id``):
> +
> +        ::
> +
> +            (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> +ERST
>=20=20
>=20=20
>  HXCOMM This is the last statement. Insert new options before this line!


--=20
Alex Benn=C3=A9e

