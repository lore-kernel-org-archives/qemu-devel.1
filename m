Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D29C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE4C21D7E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCh+uqUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE4C21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT77r-00041c-9j
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT771-0003Ns-Ar
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT76z-0006vG-DH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:27:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT76z-0006ux-AR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573230468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rwL41JtnzkSXllU15+Eg14cZWrbIq7pBY3Dm/YikhQ=;
 b=bCh+uqUlyIPDF6VcsFtwxlvUHYDv1VOn1TUytJS9vOkDsb3VWyIiX+WmCsO73o/Ie9PBo6
 yDM7qB299qHpWysLIWiQjLFdhoGkaOWhO8uVMwVLf3W+s8LrV9ryQ1NHnLifl+KPfTovWh
 O6GSw0p1TNGcw2EMgHbmZoGtAlArA2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-3v1sSldFMQGed_blippJxA-1; Fri, 08 Nov 2019 11:27:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AFCB800C72;
 Fri,  8 Nov 2019 16:27:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D141600C9;
 Fri,  8 Nov 2019 16:27:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9842A11385C9; Fri,  8 Nov 2019 17:27:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 10/18] qemu-storage-daemon: Add --chardev option
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-11-kwolf@redhat.com>
Date: Fri, 08 Nov 2019 17:27:41 +0100
In-Reply-To: <20191017130204.16131-11-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:01:56 +0200")
Message-ID: <87sgmy5o5e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 3v1sSldFMQGed_blippJxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> This adds a --chardev option to the storage daemon that works the same
> as the -chardev option of the system emulator.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-storage-daemon.c | 19 +++++++++++++++++++
>  Makefile              |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> index 099388f645..46e0a6ea56 100644
> --- a/qemu-storage-daemon.c
> +++ b/qemu-storage-daemon.c
> @@ -26,6 +26,7 @@
> =20
>  #include "block/block.h"
>  #include "block/nbd.h"
> +#include "chardev/char.h"
>  #include "crypto/init.h"
> =20
>  #include "qapi/error.h"
> @@ -75,6 +76,9 @@ static void help(void)
>  "             [,driver specific parameters...]\n"
>  "                         configure a block backend\n"
>  "\n"
> +"  --chardev <options>    configure a character device backend\n"
> +"                         (see the qemu(1) man page for possible options=
)\n"

If pointing to the manual page was good enough for --help, we could save
ourselves a ton of trouble :)

> +"\n"
>  "  --export [type=3D]nbd,device=3D<node-name>[,name=3D<export-name>]\n"
>  "           [,writable=3Don|off][,bitmap=3D<name>]\n"
>  "                         export the specified block node over NBD\n"
> @@ -96,10 +100,13 @@ QEMU_HELP_BOTTOM "\n",
>  enum {
>      OPTION_OBJECT =3D 256,
>      OPTION_BLOCKDEV,
> +    OPTION_CHARDEV,
>      OPTION_NBD_SERVER,
>      OPTION_EXPORT,
>  };
> =20
> +extern QemuOptsList qemu_chardev_opts;
> +
>  static QemuOptsList qemu_object_opts =3D {
>      .name =3D "object",
>      .implied_opt_name =3D "qom-type",
> @@ -130,6 +137,7 @@ static int process_options(int argc, char *argv[], Er=
ror **errp)
>          {"help", no_argument, 0, 'h'},
>          {"object", required_argument, 0, OPTION_OBJECT},
>          {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
> +        {"chardev", required_argument, 0, OPTION_CHARDEV},
>          {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
>          {"export", required_argument, 0, OPTION_EXPORT},
>          {"version", no_argument, 0, 'V'},
> @@ -189,6 +197,17 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
>                  qapi_free_BlockdevOptions(options);
>                  break;
>              }
> +        case OPTION_CHARDEV:
> +            {
> +                QemuOpts *opts =3D qemu_opts_parse(&qemu_chardev_opts,
> +                                                 optarg, true, &error_fa=
tal);
> +                if (!qemu_chr_new_from_opts(opts, NULL, &error_fatal)) {
> +                    /* No error, but NULL returned means help was printe=
d */
> +                    exit(EXIT_SUCCESS);
> +                }
> +                qemu_opts_del(opts);
> +                break;
> +            }

Differs from vl.c similar to --object [PATCH 02]:

* Options are processed left to right.  Good.

* You use &qemu_chardev_opts instead of qemu_opts_find().  Good.

* You use qemu_opts_parse() instead of qemu_opts_parse_noisily().  Only
  here I can actually point to a loss of help.

  For options where the argument is essentially a tagged union, an
  option argument "help" usually lists the tags, an argument "T,help"
  shows help on the parameters that go with tag T.

  --chardev is such an option.  Consider:

    $ qemu-system-x86_64 --chardev help
    Available chardev backend types:=20
      ringbuf
    [...]
      tty
    $ qemu-storage-daemon --chardev help
    Available chardev backend types:=20
      pty
    [...]
      tty

  Works the same, only the available backend types differ.  Intentional?

  Next:

    $ qemu-system-x86_64 --chardev tty,help
    chardev options:
      append=3D<bool (on/off)>
      backend=3D<str>
      chardev=3D<str>
      cols=3D<num>
    [...]
      width=3D<num>
    [Exit 1 ]

  The second help isn't very helpful, and the exit code is wrong.  Not
  this patch's problem.

    $ qemu-storage-daemon --chardev tty,help
    qemu-storage-daemon: Invalid parameter 'help'
    [Exit 1 ]

  This patch's problem :)

Also like --object, --chardev is paired with a QMP command, namely
chardev-add, and the two differ for historical reasons.  If we want to
give the storage daemon a QAPIfied command line from the start, we'll
have to decide how to address this issue.


>          case OPTION_NBD_SERVER:
>              {
>                  Visitor *v;
> diff --git a/Makefile b/Makefile
> index b913d4d736..0e3e98582d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -561,7 +561,7 @@ qemu-img.o: qemu-img-cmds.h
>  qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> -qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(blo=
ck-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) =
$(COMMON_LDADDS)
> +qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(blo=
ck-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(stora=
ge-daemon-obj-y) $(COMMON_LDADDS)
> =20
>  qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)


