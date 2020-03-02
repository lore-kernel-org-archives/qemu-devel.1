Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09995C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55732080C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAcB6fqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55732080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8iuK-0001dM-VR
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8itX-0000hT-UF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8itW-0005M2-Bd
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:05:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8itW-0005Ki-44
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:05:54 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a5so10652224wmb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CShl/Zpjrh5QdR4ihGYF2qZpgU3kLd7BG2NdFA5f2p0=;
 b=DAcB6fqbW8/rvl/nI+hDPH35UuD3LEy426RgOvo16eHDydZN3g8ndVWr1+Q5ocPIlY
 rUzjFrpWRZOrZamEuobyp3gil92wM4hj+MHV6NsgRoYClea4nTfzs8bYPrPeZklaUYYQ
 oxyJQ1Q+XBu6G0TyAkz/jzjL8kNHW9/xgyWKmP9Ibhg7AMZqFSS6dQSNzu9+x8GB7TAa
 kdqj+ofzvA+TrBySG6pgbPBkbgXRZ2jq9exVCHvafXNc/cysFpR4tF5D2eecmt1ToXo6
 /XpD81BcElc8Y7MB7pQDXmHnfkL+pmd+P3aay5Yr2D31+C59xeEo+dwbW8Trriwe3puT
 FMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CShl/Zpjrh5QdR4ihGYF2qZpgU3kLd7BG2NdFA5f2p0=;
 b=P95o32TNA2TnfstnK5IHXFw9MpbHPNk6vdeeNHP/pW6/Afv8a00qecEz/w0ICw2r49
 gGXoLN6Z4pEBUfq3BFNZ4lfHE/bEhZl/ds1lr3XGRkVitXjSlvSYIcuxZBxRg/7ju3El
 4fABwvn4DNXAzN/WJbb9QYJZ8xfVSKj5EPRpNCPCdylHh6EjZBqut8d0s3/lEEpfXOd/
 FbVqevC1FcbZLKpgH6AHqtqxfldNxbY/Eue+Lj+xtoIQO7bGDrchqPAeBl0Eet+WEhM/
 EmAAMWt/4Kd7c2A7ZJ1KvsEx/+wgGbaR7wOjolDoVitJ7CDcrwDlBmQil1wsSJvHirb5
 kocA==
X-Gm-Message-State: APjAAAXUOYMr6+ocPqJZuBU7QhKDsrqZYAxDMtpKqWMuwhZv85w40/Yu
 AXIe7ekevpyKebVE1EQd3elxJw==
X-Google-Smtp-Source: APXvYqy06Wvzl8IbLMiPCIBPaiAJqJvqdDRR/LKBb4Lti24LZhzeYRGRymeHsGFLJFD+gF0C19kTcg==
X-Received: by 2002:a05:600c:114d:: with SMTP id
 z13mr19037896wmz.105.1583147152853; 
 Mon, 02 Mar 2020 03:05:52 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a184sm15589593wmf.29.2020.03.02.03.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:05:51 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D7811FF87;
 Mon,  2 Mar 2020 11:05:51 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 02/33] qemu-doc: remove target OS documentation
In-reply-to: <20200228153619.9906-3-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:05:51 +0000
Message-ID: <875zfnc8z4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
> This section covers OSes up to Windows 2000, and as such it is mostly
> obsolete.  Zap it.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-3-pbonzini@redhat.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  qemu-doc.texi | 96 ---------------------------------------------------
>  1 file changed, 96 deletions(-)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 6636816b85f..e555dea4ef6 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -148,7 +148,6 @@ accelerator is required to use more than one host CPU=
 for emulation.
>  * vnc_security::       VNC security
>  * network_tls::        TLS setup for network services
>  * gdb_usage::          GDB usage
> -* pcsys_os_specific::  Target OS specific information
>  @end menu
>=20=20
>  @node pcsys_introduction
> @@ -1605,101 +1604,6 @@ received: "OK"
>  @end example
>  @end table
>=20=20
> -@node pcsys_os_specific
> -@section Target OS specific information
> -
> -@subsection Linux
> -
> -To have access to SVGA graphic modes under X11, use the @code{vesa} or
> -the @code{cirrus} X11 driver. For optimal performances, use 16 bit
> -color depth in the guest and the host OS.
> -
> -When using a 2.6 guest Linux kernel, you should add the option
> -@code{clock=3Dpit} on the kernel command line because the 2.6 Linux
> -kernels make very strict real time clock checks by default that QEMU
> -cannot simulate exactly.
> -
> -When using a 2.6 guest Linux kernel, verify that the 4G/4G patch is
> -not activated because QEMU is slower with this patch. The QEMU
> -Accelerator Module is also much slower in this case. Earlier Fedora
> -Core 3 Linux kernel (< 2.6.9-1.724_FC3) were known to incorporate this
> -patch by default. Newer kernels don't have it.
> -
> -@subsection Windows
> -
> -If you have a slow host, using Windows 95 is better as it gives the
> -best speed. Windows 2000 is also a good choice.
> -
> -@subsubsection SVGA graphic modes support
> -
> -QEMU emulates a Cirrus Logic GD5446 Video
> -card. All Windows versions starting from Windows 95 should recognize
> -and use this graphic card. For optimal performances, use 16 bit color
> -depth in the guest and the host OS.
> -
> -If you are using Windows XP as guest OS and if you want to use high
> -resolution modes which the Cirrus Logic BIOS does not support (i.e. >=3D
> -1280x1024x16), then you should use the VESA VBE virtual graphic card
> -(option @option{-std-vga}).
> -
> -@subsubsection CPU usage reduction
> -
> -Windows 9x does not correctly use the CPU HLT
> -instruction. The result is that it takes host CPU cycles even when
> -idle. You can install the utility from
> -@url{https://web.archive.org/web/20060212132151/http://www.user.cityline=
.ru/~maxamn/amnhltm.zip}
> -to solve this problem. Note that no such tool is needed for NT, 2000 or =
XP.
> -
> -@subsubsection Windows 2000 disk full problem
> -
> -Windows 2000 has a bug which gives a disk full problem during its
> -installation. When installing it, use the @option{-win2k-hack} QEMU
> -option to enable a specific workaround. After Windows 2000 is
> -installed, you no longer need this option (this option slows down the
> -IDE transfers).
> -
> -@subsubsection Windows 2000 shutdown
> -
> -Windows 2000 cannot automatically shutdown in QEMU although Windows 98
> -can. It comes from the fact that Windows 2000 does not automatically
> -use the APM driver provided by the BIOS.
> -
> -In order to correct that, do the following (thanks to Struan
> -Bartlett): go to the Control Panel =3D> Add/Remove Hardware & Next =3D>
> -Add/Troubleshoot a device =3D> Add a new device & Next =3D> No, select t=
he
> -hardware from a list & Next =3D> NT Apm/Legacy Support & Next =3D> Next
> -(again) a few times. Now the driver is installed and Windows 2000 now
> -correctly instructs QEMU to shutdown at the appropriate moment.
> -
> -@subsubsection Share a directory between Unix and Windows
> -
> -See @ref{sec_invocation} about the help of the option
> -@option{'-netdev user,smb=3D...'}.
> -
> -@subsubsection Windows XP security problem
> -
> -Some releases of Windows XP install correctly but give a security
> -error when booting:
> -@example
> -A problem is preventing Windows from accurately checking the
> -license for this computer. Error code: 0x800703e6.
> -@end example
> -
> -The workaround is to install a service pack for XP after a boot in safe
> -mode. Then reboot, and the problem should go away. Since there is no
> -network while in safe mode, its recommended to download the full
> -installation of SP1 or SP2 and transfer that via an ISO or using the
> -vvfat block device ("-hdb fat:directory_which_holds_the_SP").
> -
> -@subsection MS-DOS and FreeDOS
> -
> -@subsubsection CPU usage reduction
> -
> -DOS does not correctly use the CPU HLT instruction. The result is that
> -it takes host CPU cycles even when idle. You can install the utility from
> -@url{https://web.archive.org/web/20051222085335/http://www.vmware.com/so=
ftware/dosidle210.zip}
> -to solve this problem.
> -
>  @node QEMU System emulator for non PC targets
>  @chapter QEMU System emulator for non PC targets


--=20
Alex Benn=C3=A9e

