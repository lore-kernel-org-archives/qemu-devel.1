Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EBC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7ED2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMKgsWWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7ED2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8juv-0002FC-D2
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jty-0001Ob-G1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jtw-0008QZ-JA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:26 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jtw-0008QL-BF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:24 -0500
Received: by mail-wr1-x444.google.com with SMTP id r17so12266678wrj.7
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TGa5f+MQTgVTDKkkiPoWvQL+s6o65EpEUHWxhJBCcAg=;
 b=vMKgsWWhpYVXASzIUpg9B7crLmeOfeV/vx3PTHT7OdDWEseBCLKT8ELlMJuGfXfjL+
 yxYiRrD801TQc+buMdpdNXqHu/ZTvOoAP+wEEe3S25KEZzznl7oKtjMBMBfu3KQPhggh
 ytiivNKhSYJArEhWnoEFE239GmQKx72RPXdYepLB7HsvAk2RwOswsRNFzDKVpApbK8fF
 jOte0ke1rELzW9IvPU1awJQ7iB9xde+jqxkWorJRZYBLl5JkJeqIUu2vJjES4J2yVS/i
 3EEny0oUv10hK4S33wRF53/uYZa0YoIrwxLfFUXcgAuke+DtxU0a32xVDuTs4ZZw8Uzt
 dQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TGa5f+MQTgVTDKkkiPoWvQL+s6o65EpEUHWxhJBCcAg=;
 b=bxsAsPs/JAOIUKaQfL4RUCWyLajv6EOlETUf3jfA5tDpNhWkS5LiRzxcQLyUFbCM3y
 gw1th/S+guUYpsCpjK/FHN8tMlv+iGiZYxmzu4RWDxjVTsWIyQo8sUY5uifh0f6kot3m
 tOASmnSrniPgapv4or5CvnoBsK7rPWhrdJvTwfbH5zeXVDD6fWOXt+nkuQgjRPXo5PY5
 6l0cXeuwwgKgBN1gae++Q9Kukk74tIFI7hb+Re/u7iZwI5bUMERfGVsOU49pX3Luha7O
 Wp5uF4EAmhQMvQQIOewNoiEZGOszmey8stFJp/Vq8gP7k60DK3x/kOOcmdqaCDMHfxmf
 9Log==
X-Gm-Message-State: ANhLgQ392Qez4gPzvsgZHLhhSahMaKKgI4DsfUWbd/N6UDsmeU3xyG69
 NdPpINTxkZKf4mN+Vc8uYiLGSg==
X-Google-Smtp-Source: ADFU+vuUBSksr2I3E+CLnCIaCcYM3e3ApniHPQflb6Iw7pAmfAD967uEaOilf9N5Xsyxq1PfTy68zg==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr12511280wrs.267.1583151022943; 
 Mon, 02 Mar 2020 04:10:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 90sm27338643wro.79.2020.03.02.04.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:10:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBA241FF87;
 Mon,  2 Mar 2020 12:10:20 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-17-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 16/33] docs/system: Convert security.texi to rST format
In-reply-to: <20200228153619.9906-17-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:10:20 +0000
Message-ID: <877e03arf7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

> security.texi is included from qemu-doc.texi but is not used
> in the qemu.1 manpage. So we can do a straightforward conversion
> of the contents, which go into the system manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-16-pbonzini@redhat.com

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/index.rst    |   1 +
>  docs/system/security.rst | 173 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 docs/system/security.rst
>
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index fc774a18b54..5034f903407 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -14,4 +14,5 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>=20=20
> +   security
>     vfio-ap
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> new file mode 100644
> index 00000000000..f2092c8768b
> --- /dev/null
> +++ b/docs/system/security.rst
> @@ -0,0 +1,173 @@
> +Security
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +This chapter explains the security requirements that QEMU is designed to=
 meet
> +and principles for securely deploying QEMU.
> +
> +Security Requirements
> +---------------------
> +
> +QEMU supports many different use cases, some of which have stricter secu=
rity
> +requirements than others.  The community has agreed on the overall secur=
ity
> +requirements that users may depend on.  These requirements define what is
> +considered supported from a security perspective.
> +
> +Virtualization Use Case
> +'''''''''''''''''''''''
> +
> +The virtualization use case covers cloud and virtual private server (VPS)
> +hosting, as well as traditional data center and desktop virtualization. =
 These
> +use cases rely on hardware virtualization extensions to execute guest co=
de
> +safely on the physical CPU at close-to-native speed.
> +
> +The following entities are untrusted, meaning that they may be buggy or
> +malicious:
> +
> +- Guest
> +- User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> +- Network protocols (e.g. NBD, live migration)
> +- User-supplied files (e.g. disk images, kernels, device trees)
> +- Passthrough devices (e.g. PCI, USB)
> +
> +Bugs affecting these entities are evaluated on whether they can cause da=
mage in
> +real-world use cases and treated as security bugs if this is the case.
> +
> +Non-virtualization Use Case
> +'''''''''''''''''''''''''''
> +
> +The non-virtualization use case covers emulation using the Tiny Code Gen=
erator
> +(TCG).  In principle the TCG and device emulation code used in conjuncti=
on with
> +the non-virtualization use case should meet the same security requiremen=
ts as
> +the virtualization use case.  However, for historical reasons much of the
> +non-virtualization use case code was not written with these security
> +requirements in mind.
> +
> +Bugs affecting the non-virtualization use case are not considered securi=
ty
> +bugs at this time.  Users with non-virtualization use cases must not rel=
y on
> +QEMU to provide guest isolation or any security guarantees.
> +
> +Architecture
> +------------
> +
> +This section describes the design principles that ensure the security
> +requirements are met.
> +
> +Guest Isolation
> +'''''''''''''''
> +
> +Guest isolation is the confinement of guest code to the virtual machine.=
  When
> +guest code gains control of execution on the host this is called escapin=
g the
> +virtual machine.  Isolation also includes resource limits such as thrott=
ling of
> +CPU, memory, disk, or network.  Guests must be unable to exceed their re=
source
> +limits.
> +
> +QEMU presents an attack surface to the guest in the form of emulated dev=
ices.
> +The guest must not be able to gain control of QEMU.  Bugs in emulated de=
vices
> +could allow malicious guests to gain code execution in QEMU.  At this po=
int the
> +guest has escaped the virtual machine and is able to act in the context =
of the
> +QEMU process on the host.
> +
> +Guests often interact with other guests and share resources with them.  A
> +malicious guest must not gain control of other guests or access their da=
ta.
> +Disk image files and network traffic must be protected from other guests=
 unless
> +explicitly shared between them by the user.
> +
> +Principle of Least Privilege
> +''''''''''''''''''''''''''''
> +
> +The principle of least privilege states that each component only has acc=
ess to
> +the privileges necessary for its function.  In the case of QEMU this mea=
ns that
> +each process only has access to resources belonging to the guest.
> +
> +The QEMU process should not have access to any resources that are inacce=
ssible
> +to the guest.  This way the guest does not gain anything by escaping int=
o the
> +QEMU process since it already has access to those same resources from wi=
thin
> +the guest.
> +
> +Following the principle of least privilege immediately fulfills guest is=
olation
> +requirements.  For example, guest A only has access to its own disk imag=
e file
> +``a.img`` and not guest B's disk image file ``b.img``.
> +
> +In reality certain resources are inaccessible to the guest but must be
> +available to QEMU to perform its function.  For example, host system cal=
ls are
> +necessary for QEMU but are not exposed to guests.  A guest that escapes =
into
> +the QEMU process can then begin invoking host system calls.
> +
> +New features must be designed to follow the principle of least privilege.
> +Should this not be possible for technical reasons, the security risk mus=
t be
> +clearly documented so users are aware of the trade-off of enabling the f=
eature.
> +
> +Isolation mechanisms
> +''''''''''''''''''''
> +
> +Several isolation mechanisms are available to realize this architecture =
of
> +guest isolation and the principle of least privilege.  With the exceptio=
n of
> +Linux seccomp, these mechanisms are all deployed by management tools that
> +launch QEMU, such as libvirt.  They are also platform-specific so they a=
re only
> +described briefly for Linux here.
> +
> +The fundamental isolation mechanism is that QEMU processes must run as
> +unprivileged users.  Sometimes it seems more convenient to launch QEMU as
> +root to give it access to host devices (e.g. ``/dev/net/tun``) but this =
poses a
> +huge security risk.  File descriptor passing can be used to give an othe=
rwise
> +unprivileged QEMU process access to host devices without running QEMU as=
 root.
> +It is also possible to launch QEMU as a non-root user and configure UNIX=
 groups
> +for access to ``/dev/kvm``, ``/dev/net/tun``, and other device nodes.
> +Some Linux distros already ship with UNIX groups for these devices by de=
fault.
> +
> +- SELinux and AppArmor make it possible to confine processes beyond the
> +  traditional UNIX process and file permissions model.  They restrict th=
e QEMU
> +  process from accessing processes and files on the host system that are=
 not
> +  needed by QEMU.
> +
> +- Resource limits and cgroup controllers provide throughput and utilizat=
ion
> +  limits on key resources such as CPU time, memory, and I/O bandwidth.
> +
> +- Linux namespaces can be used to make process, file system, and other s=
ystem
> +  resources unavailable to QEMU.  A namespaced QEMU process is restricte=
d to only
> +  those resources that were granted to it.
> +
> +- Linux seccomp is available via the QEMU ``--sandbox`` option.  It disa=
bles
> +  system calls that are not needed by QEMU, thereby reducing the host ke=
rnel
> +  attack surface.
> +
> +Sensitive configurations
> +------------------------
> +
> +There are aspects of QEMU that can have security implications which user=
s &
> +management applications must be aware of.
> +
> +Monitor console (QMP and HMP)
> +'''''''''''''''''''''''''''''
> +
> +The monitor console (whether used with QMP or HMP) provides an interface
> +to dynamically control many aspects of QEMU's runtime operation. Many of=
 the
> +commands exposed will instruct QEMU to access content on the host file s=
ystem
> +and/or trigger spawning of external processes.
> +
> +For example, the ``migrate`` command allows for the spawning of arbitrary
> +processes for the purpose of tunnelling the migration data stream. The
> +``blockdev-add`` command instructs QEMU to open arbitrary files, exposing
> +their content to the guest as a virtual disk.
> +
> +Unless QEMU is otherwise confined using technologies such as SELinux, Ap=
pArmor,
> +or Linux namespaces, the monitor console should be considered to have pr=
ivileges
> +equivalent to those of the user account QEMU is running under.
> +
> +It is further important to consider the security of the character device=
 backend
> +over which the monitor console is exposed. It needs to have protection a=
gainst
> +malicious third parties which might try to make unauthorized connections=
, or
> +perform man-in-the-middle attacks. Many of the character device backends=
 do not
> +satisfy this requirement and so must not be used for the monitor console.
> +
> +The general recommendation is that the monitor console should be exposed=
 over
> +a UNIX domain socket backend to the local host only. Use of the TCP based
> +character device backend is inappropriate unless configured to use both =
TLS
> +encryption and authorization control policy on client connections.
> +
> +In summary, the monitor console is considered a privileged control inter=
face to
> +QEMU and as such should only be made accessible to a trusted management
> +application or user.


--=20
Alex Benn=C3=A9e

