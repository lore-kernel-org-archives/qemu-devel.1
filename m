Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D6BCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 20:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE9B2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 20:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVWmxv32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE9B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRian-0006bg-5J
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 15:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRia0-0006BO-3f
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRiZy-0007Rr-AY
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:03:59 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRiZy-0007R3-16
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 15:03:58 -0500
Received: by mail-wm1-x341.google.com with SMTP id t26so13353089wmi.4
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=U7k7JPyUOO1ctCdkMLISXN8AE06YGCYfrqEmXn2NjJg=;
 b=SVWmxv32xl8KQaLZpYiUrmox3CGTmgeP5vW0hGhPl+9N0g0ISzHK6iSSUb+kjjOR/M
 GbtYx+qW32sH2jOwrAFiSEUC1fEXJAJDO+qZVC6LkWh1USEcY033Od4/zks8nZLcIqlJ
 jXjtCkL1JInsbrR1Sf3BOEEmW01pvVe1p2a53RPpC5POEy+nTJO4UKUeBgMPvU1we4ux
 zJZP4L0weeOaBWpAv0Tb1ZuW7aQZm1z/mDRcc76X/NpvpGd0E47mOw77n8pL1Ggig7na
 8p9RKVR4Ux5MEEtFYHIJHqwFiVRW1oODoVBPYgnUcF3/l8Bp+b6IX2baE7eWYwJI62M3
 8Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=U7k7JPyUOO1ctCdkMLISXN8AE06YGCYfrqEmXn2NjJg=;
 b=QvW3FqUn7bc+fGMHUgJWUbrJ3ZxAKpdR8HGm9uK8gn2syeSgxBdhoEmIxEdZiPBRDy
 ZLm2H2zOi0hUXtLiqg0ZBFdqgalOPz6f/APsTxZ5vZ1IFh5n9shB5YTKuwQgkjqUY7XT
 Z87O4ZxIebfbQssqh1y+BIgnxcVxSv86BOaTKZPU5Tr0IjYoaU8YFmMe9pluWV2VIuEz
 8Dr8G7uw2n0AKqyyaK1U7WgtbwglLa7piGDVVrg7fxYw8Rgr+NYhB7wGquX5MYxQgVoe
 KCr1V3Zm04i5RXYa/oacINDnsKMBu1jxSwith2omamoiYqgC8mUCa0IXNR1MkS7x5h7t
 OnoQ==
X-Gm-Message-State: APjAAAUEevO1m9gQIU/mH8Xy9frAO9tvpFQC98t/9pRd6uXBiIDaEQoL
 dbMjAqpAq5WRoaQ325AuCo0udg==
X-Google-Smtp-Source: APXvYqy+l9/o2Nw30/B6xkCqfIVLZtnhaWpW2nkzJWFi5RNNXmXr7SICsIjMciHEzYa2j41RHOef0g==
X-Received: by 2002:a05:600c:2919:: with SMTP id
 i25mr718963wmd.158.1572897836326; 
 Mon, 04 Nov 2019 12:03:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x7sm35419856wrg.63.2019.11.04.12.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 12:03:54 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 252D21FF87;
 Mon,  4 Nov 2019 20:03:54 +0000 (GMT)
References: <20191104185202.102504-1-dgilbert@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] global: Squash 'the the'
In-reply-to: <20191104185202.102504-1-dgilbert@redhat.com>
Date: Mon, 04 Nov 2019 20:03:54 +0000
Message-ID: <87imnzjtn9.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, qemu-trivial@nongnu.org,
 mjt@tls.msk.ru, laurent@vivier.eu, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> 'the' has a tendency to double up; squash them back down.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  disas/libvixl/vixl/invalset.h       | 2 +-
>  docs/interop/pr-helper.rst          | 2 +-
>  docs/specs/ppc-spapr-hotplug.txt    | 2 +-
>  docs/specs/ppc-xive.rst             | 2 +-
>  docs/specs/tpm.txt                  | 2 +-
>  include/hw/xen/interface/io/blkif.h | 2 +-
>  scripts/dump-guest-memory.py        | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/disas/libvixl/vixl/invalset.h b/disas/libvixl/vixl/invalset.h
> index ffdc0237b4..ef5e49d6fe 100644
> --- a/disas/libvixl/vixl/invalset.h
> +++ b/disas/libvixl/vixl/invalset.h
> @@ -102,7 +102,7 @@ template<TEMPLATE_INVALSET_P_DECL> class InvalSet {
>    size_t size() const;
>
>    // Returns true if no elements are stored in the set.
> -  // Note that this does not mean the the backing storage is empty: it c=
an still
> +  // Note that this does not mean the backing storage is empty: it can s=
till
>    // contain invalid elements.
>    bool empty() const;
>
> diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
> index 9f76d5bcf9..e926f0a6c9 100644
> --- a/docs/interop/pr-helper.rst
> +++ b/docs/interop/pr-helper.rst
> @@ -10,7 +10,7 @@ can delegate implementation of persistent reservations =
to an external
>  restricting access to block devices to specific initiators in a shared
>  storage setup.
>
> -For a more detailed reference please refer the the SCSI Primary
> +For a more detailed reference please refer to the SCSI Primary
>  Commands standard, specifically the section on Reservations and the
>  "PERSISTENT RESERVE IN" and "PERSISTENT RESERVE OUT" commands.
>
> diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotp=
lug.txt
> index cc7833108e..859d52cce6 100644
> --- a/docs/specs/ppc-spapr-hotplug.txt
> +++ b/docs/specs/ppc-spapr-hotplug.txt
> @@ -385,7 +385,7 @@ Each LMB list entry consists of the following element=
s:
>    is used to retrieve the right associativity list to be used for this
>    LMB.
>  - A 32bit flags word. The bit at bit position 0x00000008 defines whether
> -  the LMB is assigned to the the partition as of boot time.
> +  the LMB is assigned to the partition as of boot time.
>
>  ibm,dynamic-memory-v2
>
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> index 148d57eb6a..83d43f658b 100644
> --- a/docs/specs/ppc-xive.rst
> +++ b/docs/specs/ppc-xive.rst
> @@ -163,7 +163,7 @@ Interrupt Priority Register (PIPR) is also updated us=
ing the IPB. This
>  register represent the priority of the most favored pending
>  notification.
>
> -The PIPR is then compared to the the Current Processor Priority
> +The PIPR is then compared to the Current Processor Priority
>  Register (CPPR). If it is more favored (numerically less than), the
>  CPU interrupt line is raised and the EO bit of the Notification Source
>  Register (NSR) is updated to notify the presence of an exception for
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 5d8c26b1ad..9c8cca042d 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -89,7 +89,7 @@ TPM upon reboot. The PPI specification defines the oper=
ation requests and the
>  actions the firmware has to take. The system administrator passes the op=
eration
>  request number to the firmware through an ACPI interface which writes th=
is
>  number to a memory location that the firmware knows. Upon reboot, the fi=
rmware
> -finds the number and sends commands to the the TPM. The firmware writes =
the TPM
> +finds the number and sends commands to the TPM. The firmware writes the =
TPM
>  result code and the operation request number to a memory location that A=
CPI can
>  read from and pass the result on to the administrator.
>
> diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interfa=
ce/io/blkif.h
> index 8b1be50ce8..d07fa1e078 100644
> --- a/include/hw/xen/interface/io/blkif.h
> +++ b/include/hw/xen/interface/io/blkif.h
> @@ -341,7 +341,7 @@
>   *      access (even when it should be read-only). If the frontend hits =
the
>   *      maximum number of allowed persistently mapped grants, it can fal=
lback
>   *      to non persistent mode. This will cause a performance degradatio=
n,
> - *      since the the backend driver will still try to map those grants
> + *      since the backend driver will still try to map those grants
>   *      persistently. Since the persistent grants protocol is compatible=
 with
>   *      the previous protocol, a frontend driver can choose to work in
>   *      persistent mode even when the backend doesn't support it.
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 2c587cbefc..9371e45813 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -170,7 +170,7 @@ class ELF(object):
>          self.ehdr.e_phnum +=3D 1
>
>      def to_file(self, elf_file):
> -        """Writes all ELF structures to the the passed file.
> +        """Writes all ELF structures to the passed file.
>
>          Structure:
>          Ehdr


--
Alex Benn=C3=A9e

