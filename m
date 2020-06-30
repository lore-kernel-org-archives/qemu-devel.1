Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8606C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821E12083E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmWH/F3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821E12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFoY-0003mT-RQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFnk-0002sE-In
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:55:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFni-0007s3-Na
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593521749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3mh2vFy6Q54TrvqlcnEA9lAqRvhU9vKCt9346LiLbAw=;
 b=RmWH/F3io8c2N0OwJbG7FMzxWudtTMuHgleeFVrtOCTs1uqQ2iVx4ME1GgUw25VK4naJwy
 PEfbvD/PzS7VFHPY776WemMHkYMYmvqXBHce2H8cz0ffaGTH0ARtMUE2CjJqOF+4LgAciZ
 pWM0gxy2b+1HgSnENx3nz1KW/8Y6aQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-hwHuVsX3Nc-ReetRd8NF2g-1; Tue, 30 Jun 2020 08:55:47 -0400
X-MC-Unique: hwHuVsX3Nc-ReetRd8NF2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E42771940923;
 Tue, 30 Jun 2020 12:55:45 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F657121E24;
 Tue, 30 Jun 2020 12:55:42 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:55:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 2/3] trace: Add support for recorder back-end
Message-ID: <20200630125541.GE91444@stefanha-x1.localdomain>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-3-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626162706.3304357-3-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 06:27:05PM +0200, Christophe de Dinechin wrote:

Please run scripts/checkpatch.pl if you haven't already.

> diff --git a/configure b/configure
> index ae8737d5a2..130630b98f 100755
> --- a/configure
> +++ b/configure
> @@ -7702,6 +7702,11 @@ fi
>  if have_backend "log"; then
>    echo "CONFIG_TRACE_LOG=3Dy" >> $config_host_mak
>  fi
> +if have_backend "recorder"; then
> +  echo "CONFIG_TRACE_RECORDER=3Dy" >> $config_host_mak
> +  # This is a bit brutal, but there is currently a bug in the makefiles
> +  LIBS=3D"$LIBS -lrecorder"

Outdated? Patch 1 was supposed to fix this.

> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 60f395c276..565f518d4b 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -297,6 +297,22 @@ ERST
>          .cmd        =3D hmp_trace_file,
>      },
> =20
> +SRST
> +``trace-file on|off|flush``
> +  Open, close, or flush the trace file.  If no argument is given, the
> +  status of the trace file is displayed.
> +ERST
> +#endif
> +
> +#if defined(CONFIG_TRACE_RECORDER)
> +    {
> +        .name       =3D "recorder",
> +        .args_type  =3D "op:s?,arg:F?",
> +        .params     =3D "trace|dump [arg]",
> +        .help       =3D "trace selected recorders or print recorder dump=
",
> +        .cmd        =3D hmp_recorder,
> +    },
> +
>  SRST
>  ``trace-file on|off|flush``
>    Open, close, or flush the trace file.  If no argument is given, the

This is the same trace-file command documentation that was added above.
Should this be the documentation for the recorder command?

> @@ -1120,7 +1136,7 @@ ERST
> =20
>  SRST
>  ``dump-guest-memory [-p]`` *filename* *begin* *length*
> -  \=20
> +  \
>  ``dump-guest-memory [-z|-l|-s|-w]`` *filename*
>    Dump guest memory to *protocol*. The file can be processed with crash =
or
>    gdb. Without ``-z|-l|-s|-w``, the dump format is ELF.

Spurious change. Please drop.

> @@ -1828,4 +1844,3 @@ ERST
>          .sub_table  =3D hmp_info_cmds,
>          .flags      =3D "p",
>      },
> -

Spurious change. Please drop.

> diff --git a/monitor/misc.c b/monitor/misc.c
> index 89bb970b00..0094b1860f 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -61,6 +61,9 @@
>  #ifdef CONFIG_TRACE_SIMPLE
>  #include "trace/simple.h"
>  #endif
> +#ifdef CONFIG_TRACE_RECORDER
> +#include "trace/recorder.h"
> +#endif
>  #include "exec/memory.h"
>  #include "exec/exec-all.h"
>  #include "qemu/option.h"
> @@ -227,6 +230,30 @@ static void hmp_trace_file(Monitor *mon, const QDict=
 *qdict)
>  }
>  #endif
> =20
> +#ifdef CONFIG_TRACE_RECORDER
> +static void hmp_recorder(Monitor *mon, const QDict *qdict)
> +{
> +    const char *op =3D qdict_get_try_str(qdict, "op");
> +    const char *arg =3D qdict_get_try_str(qdict, "arg");
> +
> +    if (!op) {
> +        monitor_printf(mon, "missing recorder command\"%s\"\n", op);

op is NULL, why print it?

> diff --git a/trace/recorder.c b/trace/recorder.c
> new file mode 100644
> index 0000000000..cbc22ee2d5
> --- /dev/null
> +++ b/trace/recorder.c
> @@ -0,0 +1,22 @@
> +/*
> + * Recorder-based trace backend
> + *
> + * Copyright Red Hat 2020
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "trace/recorder.h"
> +
> +RECORDER_CONSTRUCTOR
> +void recorder_trace_init(void)
> +{
> +    recorder_trace_set(getenv("RECORDER_TRACES"));
> +
> +    // Allow a dump in case we receive some unhandled signal
> +    // For example, send USR2 to a hung process to get a dump

CODING_STYLE.rst says:

  We use traditional C-style /``*`` ``*``/ comments and avoid //
  comments.

There are other instances in this patch series that I haven't pointed
out.

> +    if (getenv("RECORDER_TRACES"))
> +        recorder_dump_on_common_signals(0,0);

CODING_STYLE.rst says:

  We use traditional C-style /``*`` ``*``/ comments and avoid //
  comments.

> +}
> diff --git a/trace/recorder.h b/trace/recorder.h
> new file mode 100644
> index 0000000000..00b11a2d2f
> --- /dev/null
> +++ b/trace/recorder.h
> @@ -0,0 +1,34 @@
> +/*
> + * Recorder-based trace backend
> + *
> + * Copyright Red Hat 2020
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef TRACE_RECORDER_H
> +#define TRACE_RECORDER_H
> +
> +#include "qemu/osdep.h"

CODING_STYLE.rst says:

  Do not include "qemu/osdep.h" from header files since the .c file will
  have already included it.

Please either follow that or document the reason for the exception.

> +
> +#ifdef CONFIG_TRACE_RECORDER

Files including trace/recorder.h do this:

  #ifdef CONFIG_TRACE_RECORDER
  #include "trace/recorder.h"
  #endif

Either CONFIG_TRACE_RECORDER should be checked before including the
header or inside the header, but doing both is confusing.

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77Nk0ACgkQnKSrs4Gr
c8i4Lgf/bckDsdM4fy/7Yt0sRS3ZNZQ7PxcNb6povMuxktQ0i58FO+xlz2WU0UAD
TM3nRGinWvjTe2og6wO2mBYfZ3klpIDtyTdVXN4J3m0+TX84J5xpEA18/dPFXiDx
hLgcsSvyoxHQg8umS89P2vY10ULOx5MQqNWOL91qzOb30OoYjhVsTlEAqj/OlY5i
wByBaJpJgAfzYmO+FIUjrG9KW0+Rzlnf6xGjlXr48NMrbPmQ5NproMNR8CcR0VU3
gTTX0Xtc9l3agUV6/XQJq02rWNrWM89U+NMWk4CPooLr488jkgizRTXXsOen0HuE
eqnG8tC10Mp0vS5qkDtvFipz0fECRg==
=looA
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--


