Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D8C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033CB208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzzYYsE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033CB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbYt-000476-9B
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jBbYG-0003co-0o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jBbYE-00064c-Qw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:51:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jBbYE-00060P-KA; Tue, 10 Mar 2020 05:51:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id r15so9897151wrx.6;
 Tue, 10 Mar 2020 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/UkDz8HvUKmlKSFsAIGX6Sklu3FNqsok4JOGwmhdRpc=;
 b=tzzYYsE80okTcJs3zqZGk7mIdkUpadqpHPGN3BGoHiS8sjl54QT9GadeoYMqiSYtUk
 i20EMwvMOo+0W8Gfg66h3usERGULQDWX0XDk03RYO9aFKqU6IMbK7DRJMYo8l1sHsu8a
 9JuYXa2ysPlVhGLFB4jRxLkd8EdoHEypBJb+A0Laxv6tGjIN4YYmeZ0Y3o5ZiPIfQZDt
 2MQcP6REeMryfbJDRRRR1zzb5SYITAb+jpOk9d/52gIBQuOSv00RSdic9O56eDcoVXxq
 bZYocEJXw8YtOm5Cf5eLjtWj752gnPGviR4scBUIWF7X7DSOzNmINvLXIkB6V2+5cooA
 M8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/UkDz8HvUKmlKSFsAIGX6Sklu3FNqsok4JOGwmhdRpc=;
 b=C4xyEsjsLq1Z4wDbe/9ySUGhUWQJ+YG7Z+cyIQE7B77gW0qAJgsQyOl5YMXVEgvld6
 Lc+lbyFm0L6yolTXH6qsFHcdns7vF//YNzJ7fWpmpYF8odsbZ8gGtL7cl+cthjbNsauM
 FBkWSOyltGTSjPL3f/WS+HiQPtEkXs06TBxQmVHgZUit4OVGEKsuVpSRFXEHSvVnRJhy
 1gGtrnh9YkJBfHScPGNIIwSIwmwvF3zA4yhwXF7OKpuA4+zJZrsFXWyAfUq+tf/aIUHB
 jd8KL1RzgA/0bo8XbPuNXbjx1H1RxJLeLtFGfL+5ZyRYANdwn0UXLuX2ahdzXt04E8tI
 1wOw==
X-Gm-Message-State: ANhLgQ3ojNVlS6A6PcczYV6yqXrxal+oBhqJuPaUgYo1izms75/HFavV
 r3a51Cz6ShAcBN/BYm5GSiM=
X-Google-Smtp-Source: ADFU+vv+CWRb4LeGzm/nUD6t+OdXEzpISxIPqS30iwxN7JVtFHZIZo18Vond4hL75JZi6trrbuzhpg==
X-Received: by 2002:adf:e742:: with SMTP id c2mr14546759wrn.361.1583833909218; 
 Tue, 10 Mar 2020 02:51:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z19sm3423581wma.41.2020.03.10.02.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:51:48 -0700 (PDT)
Date: Tue, 10 Mar 2020 09:51:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe
 1.4 spec
Message-ID: <20200310095147.GC140737@stefanha-x1.localdomain>
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
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
Cc: kwolf@redhat.com, haozhong.zhang@intel.com, qemu-block@nongnu.org,
 dgilbert@redhat.com, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com,
 junyan.he@intel.com, kbusch@kernel.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 03:38:53PM -0700, Andrzej Jakowski wrote:
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d28335cbf3..ff7e74d765 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -19,10 +19,14 @@
>   *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
>   *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[optio=
nal]>, \
>   *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
> + *              [pmr_file=3D<pmr_file_path>,] \
>   *              num_queues=3D<N[optional]>
>   *
>   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> + *
> + * Either cmb or pmr - due to limitation in avaialbe BAR indexes.

s/avaialbe/available/

> + * pmr_file file needs to be preallocated and power of two in size.

Why does it need to be preallocated?

>   */
> =20
>  #include "qemu/osdep.h"
> @@ -1141,6 +1145,28 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr off=
set, uint64_t data,
>          NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
>                         "invalid write to read only CMBSZ, ignored");
>          return;
> +#ifndef _WIN32

This ifdef is a hint that the layering is not right.  QEMU device models
usually only implement the "frontend" device registers, interrupts, and
request processing logic.  The platform-specific host "backend"
(mmapping files, sending network packets, audio/graphics APIs, etc) is
implemented separately.

In the previous version I asked NVDIMM folks to review this patch and
suggest how to use the same HostMemoryBackend (see
include/sysemu/hostmem.h) that is already used for NVDIMM emulation.

That seems cleaner than baking platform-specific memory mapped file I/O
into hw/block/nvme.c, and it will also add a few features that this
patch does not have.

If NVDIMM folks don't respond to this email, would you be able to
research backends/hostmem*.c and try to integrate it?  If you feel lost
I can help but it will require me to spend time investigating how that
stuff works again :).

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5nYzMACgkQnKSrs4Gr
c8gQrggAkjJ5NcIAoU0/6nBgHeXoWSpEylLO9dhK6ZZTDtsO5kP4xzsjag0g+SIs
BQjluRzleaRxSJ5YjIABaOxcoqQ2tnpfIIUgqRJ5B2CC0SUeb7iCOPWdPWodGjPT
DTHu8hm70reAMT/syqA1tdVNFJjhXpZD71BeMnbSn5qYjWCPp1Dl20UDS04h9lbt
GTs3J0oU2bG2btgUWjaua9ufkOgrkDGBlJ2C/aqvIPMasi7soH00tuvypbhIEJ3h
CuizalQpsw/8OGgiFoVvrmO5h4PmRFKjt4so73MXV4dDD8rl9ISGWScFDpPsx2Ln
7TDmyrkMFSWz8bARjPjcW+XFP6+qtg==
=OUOH
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

