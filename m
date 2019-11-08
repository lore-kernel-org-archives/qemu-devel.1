Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B57FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7132085B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7j7GHo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7132085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4La-0000ev-WE
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT4K7-0007n4-NM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT4K6-0001Ou-GW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:29:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47080
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT4K6-0001OM-Cm
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573219750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9npwAj/UByNFsX2/e0xAqWe+kQscTg4qJb4JVLwNvk=;
 b=c7j7GHo8atJguTeKN5yuuxx4dzDOOhz8Mh74wFfkyPttvCdvcabGAfa7tGKRJgkOWp328n
 lJS6iH9+V0XkDXq7d6Tg4pHPvWXlBfiR3jtFBrqH1eg+xG86MQWKdHDAGbhTpfBEMhVCto
 fUse5rJMk114tUf5wVl39Ldj3CWPwCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-TSDQMrWzOsar999WbV-YfA-1; Fri, 08 Nov 2019 08:29:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6D68017DE;
 Fri,  8 Nov 2019 13:29:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3C9C600C9;
 Fri,  8 Nov 2019 13:29:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A83111385C9; Fri,  8 Nov 2019 14:29:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 05/18] qemu-storage-daemon: Add --blockdev option
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-6-kwolf@redhat.com>
Date: Fri, 08 Nov 2019 14:29:05 +0100
In-Reply-To: <20191017130204.16131-6-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:01:51 +0200")
Message-ID: <87zhh68pjy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TSDQMrWzOsar999WbV-YfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> This adds a --blockdev option to the storage daemon that works the same
> as the -blockdev option of the system emulator.
>
> In order to be able to link with blockdev.o, we also need to change
> stream.o from common-obj to block-obj, which is where all other block
> jobs already are.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-storage-daemon.c | 29 +++++++++++++++++++++++++++++
>  Makefile              |  5 ++++-
>  Makefile.objs         |  7 +++++++
>  block/Makefile.objs   |  2 +-
>  4 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> index 48d6af43a6..904e3c3a46 100644
> --- a/qemu-storage-daemon.c
> +++ b/qemu-storage-daemon.c
> @@ -28,6 +28,10 @@
>  #include "crypto/init.h"
> =20
>  #include "qapi/error.h"
> +#include "qapi/qapi-visit-block-core.h"
> +#include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qobject-input-visitor.h"
> +
>  #include "qemu-common.h"
>  #include "qemu-version.h"
>  #include "qemu/config-file.h"
> @@ -53,6 +57,13 @@ static void help(void)
>  "                         specify tracing options\n"
>  "  -V, --version          output version information and exit\n"
>  "\n"
> +"  --blockdev [driver=3D]<driver>[,node-name=3D<N>][,discard=3Dignore|un=
map]\n"
> +"             [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
> +"             [,read-only=3Don|off][,auto-read-only=3Don|off]\n"
> +"             [,force-share=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
> +"             [,driver specific parameters...]\n"
> +"                         configure a block backend\n"
> +"\n"
>  "  --object <properties>  define a QOM object such as 'secret' for\n"
>  "                         passwords and/or encryption keys\n"
>  "\n"
> @@ -62,6 +73,7 @@ QEMU_HELP_BOTTOM "\n",
> =20
>  enum {
>      OPTION_OBJECT =3D 256,
> +    OPTION_BLOCKDEV,
>  };
> =20
>  static QemuOptsList qemu_object_opts =3D {
> @@ -82,6 +94,7 @@ static int process_options(int argc, char *argv[], Erro=
r **errp)
>      static const struct option long_options[] =3D {
>          {"help", no_argument, 0, 'h'},
>          {"object", required_argument, 0, OPTION_OBJECT},
> +        {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
>          {"version", no_argument, 0, 'V'},
>          {"trace", required_argument, NULL, 'T'},
>          {0, 0, 0, 0}
> @@ -123,6 +136,22 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
>                  qemu_opts_del(opts);
>                  break;
>              }
> +            break;
> +        case OPTION_BLOCKDEV:
> +            {
> +                Visitor *v;
> +                BlockdevOptions *options;
> +
> +                v =3D qobject_input_visitor_new_str(optarg, "driver",
> +                                                  &error_fatal);
> +
> +                visit_type_BlockdevOptions(v, NULL, &options, &error_fat=
al);
> +                visit_free(v);
> +
> +                qmp_blockdev_add(options, &error_fatal);
> +                qapi_free_BlockdevOptions(options);
> +                break;
> +            }
>          }
>      }
>      if (optind !=3D argc) {

Unlike --object, --blockdev is already QAPIfied, albeit crudely.

Similar difference to vl.c as for --object: vl.c records the option for
later processing, while here you process it right away.  Simpler and
saner.

I figure you intend to do all options this way.

Should you explain the difference in a commit message?  A comment?

[...]


