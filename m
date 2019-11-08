Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D8FC6195
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5712178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXCNatoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5712178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6m4-0007o6-EW
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT6iz-0004SN-4f
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT6iu-0002Za-5i
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:03:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT6iu-0002ZS-2f
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573228975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPl74jSsHHnor/9PyYpATr/XgH3EZA6JV3s4vr3E1dY=;
 b=WXCNatoq+Jg367jgU0lu2bNMeKHpTTqrJoOkQjsXRaIiCvPxwOIV5Bs4edFK5vymAmzC87
 BsYD2WK+vqOFUAm03Da5kDJzN2XoYqA/dKgaDawzXEUv2ZNoJqShkwoz+dBR8buZABGajx
 Tv1wCLu57kxx17Xmu5qBnhsK80mcGdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-PPrmn_w9O7OBG-B0HUPPcQ-1; Fri, 08 Nov 2019 11:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F29F477;
 Fri,  8 Nov 2019 16:02:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A2AD5C1BB;
 Fri,  8 Nov 2019 16:02:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A0D811385C9; Fri,  8 Nov 2019 17:02:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 09/18] qemu-storage-daemon: Add main loop
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-10-kwolf@redhat.com>
Date: Fri, 08 Nov 2019 17:02:47 +0100
In-Reply-To: <20191017130204.16131-10-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:01:55 +0200")
Message-ID: <8736ey73vc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: PPrmn_w9O7OBG-B0HUPPcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Instead of exiting after processing all command line options, start a
> main loop and keep processing events until exit is requested with a
> signal (e.g. SIGINT).
>
> Now qemu-storage-daemon can be used as an alternative for qemu-nbd that
> provides a few features that were previously only available from QMP,
> such as access to options only available with -blockdev and the socket
> types 'vsock' and 'fd'.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-storage-daemon.c | 13 +++++++++++++
>  Makefile.objs         |  2 ++
>  2 files changed, 15 insertions(+)
>
> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> index 9e5f474fd0..099388f645 100644
> --- a/qemu-storage-daemon.c
> +++ b/qemu-storage-daemon.c
> @@ -45,10 +45,18 @@
>  #include "qemu/option.h"
>  #include "qom/object_interfaces.h"
> =20
> +#include "sysemu/runstate.h"
>  #include "trace/control.h"
> =20
>  #include <getopt.h>
> =20
> +static bool exit_requested =3D false;
> +
> +void qemu_system_killed(int signal, pid_t pid)
> +{
> +    exit_requested =3D true;
> +}
> +

This runs within a signal handler, so better make @exit_requested
volatile.  Hmm, vl.c gets it wrong, too.

>  static void help(void)
>  {
>      printf(
> @@ -238,6 +246,7 @@ int main(int argc, char *argv[])
> =20
>      error_init(argv[0]);
>      qemu_init_exec_dir(argv[0]);
> +    os_setup_signal_handling();
> =20
>      module_call_init(MODULE_INIT_QOM);
>      module_call_init(MODULE_INIT_TRACE);
> @@ -256,5 +265,9 @@ int main(int argc, char *argv[])
>          return EXIT_FAILURE;
>      }
> =20
> +    while (!exit_requested) {
> +        main_loop_wait(false);
> +    }
> +
>      return EXIT_SUCCESS;
>  }
> diff --git a/Makefile.objs b/Makefile.objs
> index cc262e445f..b667d3f07b 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -43,6 +43,8 @@ io-obj-y =3D io/
> =20
>  storage-daemon-obj-y =3D block/
>  storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
> +storage-daemon-obj-$(CONFIG_WIN32) +=3D os-win32.o
> +storage-daemon-obj-$(CONFIG_POSIX) +=3D os-posix.o
> =20
>  ######################################################################
>  # Target independent part of system emulation. The long term path is to


