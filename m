Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A7FC41514
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B19D22BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtXGsVOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B19D22BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzdp-0002su-K2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqzdW-0001uG-82
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqzdU-0003Py-Hz
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:47:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqzdU-0003OA-B0
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:47:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so26233002wmj.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3Kz1slM/+SRb0eQiqN6PsjiXMLsLp7e9nE3F3vkRWbs=;
 b=HtXGsVOVyJrnLRrWcRcdMrTVoan8Q2fAwF1sIMdg3NdQM5Cw++x6M00/xUebAu5vzD
 ZSYPndu+FfZS5razdIHrOvzoL2MkfZh2xaOeIA2sxAqDUFGA8EItUXFuXaKNFmwNK4I6
 gF7WCpzdNC8LuKfaGQzVGWW9l9YQswFTQi14M2PiCLFNc/b7pgpHwZy1Xw0S5Qco75gV
 nCaEOZ6HA9fUWHiUoBi5zf7Gl8BccGSLwueQB53PeQgAuhZLf3BWlVualT4v7OycTJHA
 KIz6Yhyq/yhoOIPL8DXuaI6KbgC+YuepZ+ldozv64+wJ1gPYyipJNzjSxlhtjOaA+ce3
 nuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3Kz1slM/+SRb0eQiqN6PsjiXMLsLp7e9nE3F3vkRWbs=;
 b=JjGK5mC/Amj2GrgARRCEK72ui8Pd5eTbePBB0hWi4ZDZWiMGCLmochgXTgRuQ3GV4S
 StOfXNEStAzNkPYJgituX0ii0m+8JObDOcPTneKq0rJEobORrwbf91Vf+NuPOuiafpeq
 f8LZj2PvqLF5MShud9RO0ISbbaZpLPzTn/eXuCKXYaJYWQsIRS5DotbFdDhLMfncRGZl
 r0OGRWM0wnK6mrDA62gkjsEouWk6qYgyDZ/KI8CwrCYV7Zv1SinGPBk+TdYgItIs4G25
 D43FZhbJT1USRS/2RRZZR6/C95UrrPehP4tiUK6BEWGhi+Pa4KcG5aqouyg/LnoJfcoc
 5EeA==
X-Gm-Message-State: APjAAAWH+v/1BoAl0EE80691uyis13z3Ft3Mgw/jKfJzRXpXNgXBAsy0
 xMK/WHesTB1FEA7/2ThgcqU=
X-Google-Smtp-Source: APXvYqxpoG3NS8gL2dGUpsjRXFadhtM0XfVMWEdDha4wTbNmXn47IyaxDvj4KQq6w6MEj1MFz2ge+g==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr34825490wmj.39.1564145267249; 
 Fri, 26 Jul 2019 05:47:47 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i12sm61979736wrx.61.2019.07.26.05.47.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 05:47:46 -0700 (PDT)
Date: Fri, 26 Jul 2019 13:47:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726124745.GC25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-7-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20190725032321.12721-7-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RFC 06/19] fuzz: Add ramfile for fast
 vmstate/vmload
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 03:23:49AM +0000, Oleinik, Alexander wrote:
> The ramfile allows vmstate to be saved and restored directly onto the
> heap.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/fuzz/ramfile.c | 127 +++++++++++++++++++++++++++++++++++++++++++
>  tests/fuzz/ramfile.h |  20 +++++++
>  2 files changed, 147 insertions(+)
>  create mode 100644 tests/fuzz/ramfile.c
>  create mode 100644 tests/fuzz/ramfile.h
>=20
> diff --git a/tests/fuzz/ramfile.c b/tests/fuzz/ramfile.c
> new file mode 100644
> index 0000000000..8da242e9ee
> --- /dev/null
> +++ b/tests/fuzz/ramfile.c

Please put this in migration/.  This code doesn't do fuzzing and is
general-purpose enough to be used by other parts of QEMU dealing with
live migration.

> @@ -0,0 +1,127 @@
> +/*
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + *       Filename:  ramfile.c
> + *
> + *    Description:  QEMUFile stored in dynamically allocated RAM for fas=
t VMRestore
> + *
> + *         Author:  Alexander Oleinik (), alxndr@bu.edu
> + *   Organization: =20
> + *
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + */

Please use license headers with all new files that are created.
Fine-grained filename and authorship information is already kept by git
so it's not necessary to duplicate it here.

> +#include <stdlib.h>
> +#include "qemu/osdep.h"

osdep.h already includes stdlib.h.

> +#include "qemu-common.h"
> +#include "exec/memory.h"
> +#include "migration/qemu-file.h"
> +#include "migration/migration.h"
> +#include "migration/savevm.h"
> +#include "ramfile.h"
> +
> +#define INCREMENT 10240
> +#define IO_BUF_SIZE 32768
> +#define MAX_IOV_SIZE MIN(IOV_MAX, 64)
> +
> +struct QEMUFile {
> +    const QEMUFileOps *ops;
> +    const QEMUFileHooks *hooks;
> +    void *opaque;
> +
> +    int64_t bytes_xfer;
> +    int64_t xfer_limit;
> +
> +    int64_t pos; /* start of buffer when writing, end of buffer
> +                    when reading */
> +    int buf_index;
> +    int buf_size; /* 0 when writing */
> +    uint8_t buf[IO_BUF_SIZE];
> +
> +    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
> +    struct iovec iov[MAX_IOV_SIZE];
> +    unsigned int iovcnt;
> +
> +    int last_error;
> +};

Wait, what?! :)

Please add the ram file to qemu-file.c instead of duplicating QEMUFile.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl069nEACgkQnKSrs4Gr
c8h9TQf/aGVUMv3VXnlG3c1/sMBniy1Njm2jiy8+rUCqdYkXq1IoJ8AK6GkPCI3p
aw6I+W/6H1+HRCagkCtjxC1H6QjHRUqRrWikX3BCF0UJLY47O05nJOgMxKbQ2jbr
S8sQICVmVvMzQNgvolr99q0z1pLvXqj4W1sEGvrg/IGQP8NmUjDd2qkqNXjVug45
5kaPujcHAPcp2IZPpsIhVVRrFPP5KqfRoc+bjC2gJGZcXPQh3rJT4j5Fg17lV7IB
1im2Z89ThhvKuxRXUJ6C+crMjz4IRzN0nV6UP6Iqb3u4cwUwZZsGj4CeBD0FmpBN
hUR8a/Nyee8esMZRSEOYXM0Mh0B0uQ==
=brrB
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--

