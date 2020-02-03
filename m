Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469CDC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C3720658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOvhkWgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C3720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iya85-0002Kd-AE
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iya73-0001WY-1F
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iya70-0004kj-EX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:41:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54948
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iya70-0004hw-AV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580730113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkHfITY4ccQkBDMatQb4eb1mEgjrx5vE0fp3gT98XZs=;
 b=eOvhkWgzEUkmDkRt2nxqwr3Z3hJi9N34N2SXPcP7MRelJbBVhWn1uwvJ/4xOivv4kNEsXf
 dNrNbQpTE46M5qJzIfRm5BQdP5kkqbdcDWeU8xmndHrZRtB55FrvUnUpnUUmmQXD8iHhIg
 uQJ1NbugunQxN48rndUTuVbGAYsggKA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-uV6ATWKmOlSwVCWB9wtv8Q-1; Mon, 03 Feb 2020 06:41:52 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so8070317wrp.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B5mJUXDurjQ3BREFZr7hFRsbwSwNBCTB/1sD2hAtB0A=;
 b=tA4lwv8Ey+Jo4Rw26YKBtiYcU8Gc67KZapVRSkZQg83YckL482J9ZjJgjO50E8Qv5c
 ZxhYhs/DHFDe8GLAHnxpbpCatRWhNa1UyMaivLos0gpMvNcSlU8DVK5ccvIQ4C2Zoc53
 UpyC94HUatZfuiIIN1HfC4s/tlkBCnB8HYrrF5JE02geLy5TBw3cfOsCV5fKzRVHx5lv
 r7D2r25bA7ijnDqaw8KvxTKo9ylQPWnsPR7chziEQvd6Qe0I1e19lBEi787LxBDRZAQ1
 XfzKoSHBbJnHfj2pnD3vux8ji8e3ywXUMmONoHqWhvhxcZoKuFPRl23XR9c1NB6hoCfl
 dYyA==
X-Gm-Message-State: APjAAAXsBdKq2xH/spD+Km6PUrPiSuY/3Kfeu2rMwpabUEaffmsrZd/P
 XWX26oBCEwHMDnBwvHd+6yMF3NqcOizcgChYQyFIq/3+YGr1YoY34tB2Lj2t+d/Dd2pDiou2Swz
 r+sZn6QYFVxOvSeE=
X-Received: by 2002:adf:a141:: with SMTP id r1mr13859870wrr.285.1580730110772; 
 Mon, 03 Feb 2020 03:41:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiqhqsj0OgmXKd5XpR6SENDB/u3aNU0JHh8b+4x/zKPoHZ5nF3DDzcRGaW2B1sqSPqsI2dMA==
X-Received: by 2002:adf:a141:: with SMTP id r1mr13859848wrr.285.1580730110506; 
 Mon, 03 Feb 2020 03:41:50 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id d16sm27292516wrg.27.2020.02.03.03.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 03:41:49 -0800 (PST)
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
To: Kamil Rytarowski <n54@gmx.com>, rth@twiddle.net, ehabkost@redhat.com,
 slp@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-3-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
Date: Mon, 3 Feb 2020 12:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128140945.929-3-n54@gmx.com>
Content-Language: en-US
X-MC-Unique: uV6ATWKmOlSwVCWB9wtv8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/28/20 3:09 PM, Kamil Rytarowski wrote:
> From: Maxime Villard <max@m00nbsd.net>
>=20
> Introduces the configure support for the new NetBSD Virtual Machine Monit=
or that
> allows for hypervisor acceleration from usermode components on the NetBSD
> platform.
>=20
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> ---
>   configure       | 36 ++++++++++++++++++++++++++++++++++++
>   qemu-options.hx | 16 ++++++++--------
>   2 files changed, 44 insertions(+), 8 deletions(-)
>=20
> diff --git a/configure b/configure
> index 0ce2c0354a..eb456a271e 100755
> --- a/configure
> +++ b/configure
> @@ -241,6 +241,17 @@ supported_whpx_target() {
>       return 1
>   }
>=20
> +supported_nvmm_target() {
> +    test "$nvmm" =3D "yes" || return 1
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}" in
> +        i386|x86_64)
> +            return 0
> +        ;;
> +    esac
> +    return 1
> +}
> +
>   supported_target() {
>       case "$1" in
>           *-softmmu)
> @@ -268,6 +279,7 @@ supported_target() {
>       supported_hax_target "$1" && return 0
>       supported_hvf_target "$1" && return 0
>       supported_whpx_target "$1" && return 0
> +    supported_nvmm_target "$1" && return 0
>       print_error "TCG disabled, but hardware accelerator not available f=
or '$target'"
>       return 1
>   }
> @@ -387,6 +399,7 @@ kvm=3D"no"
>   hax=3D"no"
>   hvf=3D"no"
>   whpx=3D"no"
> +nvmm=3D"no"
>   rdma=3D""
>   pvrdma=3D""
>   gprof=3D"no"
> @@ -1168,6 +1181,10 @@ for opt do
>     ;;
>     --enable-whpx) whpx=3D"yes"
>     ;;
> +  --disable-nvmm) nvmm=3D"no"
> +  ;;
> +  --enable-nvmm) nvmm=3D"yes"
> +  ;;
>     --disable-tcg-interpreter) tcg_interpreter=3D"no"
>     ;;
>     --enable-tcg-interpreter) tcg_interpreter=3D"yes"
> @@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
>     hax             HAX acceleration support
>     hvf             Hypervisor.framework acceleration support
>     whpx            Windows Hypervisor Platform acceleration support
> +  nvmm            NetBSD Virtual Machine Monitor acceleration support
>     rdma            Enable RDMA-based migration
>     pvrdma          Enable PVRDMA support
>     vde             support for vde network
> @@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
>       fi
>   fi
>=20

Maybe you can add something like:

if test "$targetos" =3D "NetBSD"; then
     nvmm=3D"check"
fi

to build by default with NVMM if available.

> +##########################################
> +# NetBSD Virtual Machine Monitor (NVMM) accelerator check
> +if test "$nvmm" !=3D "no" ; then
> +    if check_include "nvmm.h" ; then
> +        nvmm=3D"yes"
> +=09LIBS=3D"-lnvmm $LIBS"
> +    else
> +        if test "$nvmm" =3D "yes"; then
> +            feature_not_found "NVMM" "NVMM is not available"
> +        fi
> +        nvmm=3D"no"
> +    fi
> +fi
> +
>   ##########################################
>   # Sparse probe
>   if test "$sparse" !=3D "no" ; then
> @@ -6495,6 +6527,7 @@ echo "KVM support       $kvm"
>   echo "HAX support       $hax"
>   echo "HVF support       $hvf"
>   echo "WHPX support      $whpx"
> +echo "NVMM support      $nvmm"
>   echo "TCG support       $tcg"
>   if test "$tcg" =3D "yes" ; then
>       echo "TCG debug enabled $debug_tcg"
> @@ -7771,6 +7804,9 @@ fi
>   if test "$target_aligned_only" =3D "yes" ; then
>     echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
>   fi
> +if supported_nvmm_target $target; then
> +    echo "CONFIG_NVMM=3Dy" >> $config_target_mak
> +fi
>   if test "$target_bigendian" =3D "yes" ; then
>     echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
>   fi
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e9d6231438..4ddf7c91a0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>       "-machine [type=3D]name[,prop[=3Dvalue][,...]]\n"
>       "                selects emulated machine ('-machine help' for list=
)\n"
>       "                property accel=3Daccel1[:accel2[:...]] selects acc=
elerator\n"
> -    "                supported accelerators are kvm, xen, hax, hvf, whpx=
 or tcg (default: tcg)\n"
> +    "                supported accelerators are kvm, xen, hax, hvf, nvmm=
, whpx or tcg (default: tcg)\n"
>       "                vmport=3Don|off|auto controls emulation of vmport =
(default: auto)\n"
>       "                dump-guest-core=3Don|off include guest memory in a=
 core dump (default=3Don)\n"
>       "                mem-merge=3Don|off controls memory merge support (=
default: on)\n"
> @@ -63,9 +63,9 @@ Supported machine properties are:
>   @table @option
>   @item accel=3D@var{accels1}[:@var{accels2}[:...]]
>   This is used to enable an accelerator. Depending on the target architec=
ture,
> -kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is use=
d. If there is
> -more than one accelerator specified, the next one is used if the previou=
s one
> -fails to initialize.
> +kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg =
is used.
> +If there is more than one accelerator specified, the next one is used if=
 the
> +previous one fails to initialize.
>   @item vmport=3Don|off|auto
>   Enables emulation of VMWare IO port, for vmmouse etc. auto says to sele=
ct the
>   value based on accel. For accel=3Dxen the default is off otherwise the =
default
> @@ -110,7 +110,7 @@ ETEXI
>=20
>   DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>       "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
> -    "                select accelerator (kvm, xen, hax, hvf, whpx or tcg=
; use 'help' for a list)\n"
> +    "                select accelerator (kvm, xen, hax, hvf, nvmm, whpx =
or tcg; use 'help' for a list)\n"
>       "                igd-passthru=3Don|off (enable Xen integrated Intel=
 graphics passthrough, default=3Doff)\n"
>       "                kernel-irqchip=3Don|off|split controls accelerated=
 irqchip support (default=3Don)\n"
>       "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n=
"
> @@ -120,9 +120,9 @@ STEXI
>   @item -accel @var{name}[,prop=3D@var{value}[,...]]
>   @findex -accel
>   This is used to enable an accelerator. Depending on the target architec=
ture,
> -kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is use=
d. If there is
> -more than one accelerator specified, the next one is used if the previou=
s one
> -fails to initialize.
> +kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg =
is used.
> +If there is more than one accelerator specified, the next one is used if=
 the
> +previous one fails to initialize.
>   @table @option
>   @item igd-passthru=3Don|off
>   When Xen is in use, this option controls whether Intel integrated graph=
ics
> --
> 2.24.1
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


