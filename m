Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5030EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19766218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsDrD7QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19766218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihegx-00017g-99
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihefv-0000bh-O8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iheft-0001tM-6E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:07:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihefs-0001qe-UL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576696076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5o2qtdYtceu4pKV3Y1hnXfv0yd45s9zGBvGGmUrD2gM=;
 b=gsDrD7QAHUnBLIIJ9aELMK9d5AMLOJB7lb+BbkLhjl3OSrr4a/CCzr6JdrxBCcsnmeMTDj
 PtsO3JsOezRUQQLRjSJtVvR8C8ETlixm1k8rP5rg8YCfWqfN4F/78bfsTIlZpdudWMvdYm
 ThNapwQ1qK5aFiFZzQ3nrevPqzjm3Vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-BAhX5LCCO1WH8pc9EpiJcA-1; Wed, 18 Dec 2019 14:07:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DAB98026B6;
 Wed, 18 Dec 2019 19:07:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABF237D8CA;
 Wed, 18 Dec 2019 19:07:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4054611386A7; Wed, 18 Dec 2019 20:07:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/4] monitor: Move monitor option parsing to
 monitor/monitor.c
References: <20191218161952.10202-1-kwolf@redhat.com>
 <20191218161952.10202-2-kwolf@redhat.com>
Date: Wed, 18 Dec 2019 20:07:50 +0100
In-Reply-To: <20191218161952.10202-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 18 Dec 2019 17:19:49 +0100")
Message-ID: <87r211zc3d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: BAhX5LCCO1WH8pc9EpiJcA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Both the system emulators and tools with QMP support (specifically, the
> planned storage daemon) will need to parse monitor options, so move that
> code to monitor/monitor.c, which can be linked into binaries that aren't
> a system emulator.
>
> This patch moves the monitor option parsing from vl.c and adds an
> allow_hmp parameter so that callers can support QMP without HMP.

New parameter is always true after this series.

Please split this patch: one patch to move the code, one to add the
parameter.  Delay the second one until you have a user.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/monitor/monitor.h |  4 +++
>  include/sysemu/sysemu.h   |  1 -
>  monitor/monitor.c         | 52 +++++++++++++++++++++++++++++++++++++++
>  vl.c                      | 45 +--------------------------------
>  4 files changed, 57 insertions(+), 45 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index a81eeff5f8..d3e8da36a5 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -3,6 +3,7 @@
> =20
>  #include "block/block.h"
>  #include "qapi/qapi-types-misc.h"
> +#include "qemu/option.h"
>  #include "qemu/readline.h"
> =20
>  extern __thread Monitor *cur_mon;
> @@ -10,12 +11,15 @@ typedef struct MonitorHMP MonitorHMP;
> =20
>  #define QMP_REQ_QUEUE_LEN_MAX 8
> =20
> +extern QemuOptsList qemu_mon_opts;
> +
>  bool monitor_cur_is_qmp(void);
> =20
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
>  void monitor_init_qmp(Chardev *chr, bool pretty);
>  void monitor_init_hmp(Chardev *chr, bool use_readline);
> +int monitor_init_opts(QemuOpts *opts, bool allow_hmp, Error **errp);
>  void monitor_cleanup(void);
> =20
>  int monitor_suspend(Monitor *mon);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 80c57fdc4e..bbd02cf941 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -128,7 +128,6 @@ extern QemuOptsList qemu_netdev_opts;
>  extern QemuOptsList qemu_nic_opts;
>  extern QemuOptsList qemu_net_opts;
>  extern QemuOptsList qemu_global_opts;
> -extern QemuOptsList qemu_mon_opts;
>  extern QemuOptsList qemu_semihosting_config_opts;
> =20
>  #endif
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 12898b6448..316b71b928 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -609,6 +609,58 @@ void monitor_init_globals_core(void)
>                                     NULL);
>  }
> =20
> +int monitor_init_opts(QemuOpts *opts, bool allow_hmp, Error **errp)
> +{
> +    Chardev *chr;
> +    bool qmp;
> +    bool pretty =3D false;
> +    const char *chardev;
> +    const char *mode;
> +
> +    mode =3D qemu_opt_get(opts, "mode");
> +    if (mode =3D=3D NULL) {
> +        mode =3D allow_hmp ? "readline" : "control";
> +    }
> +    if (strcmp(mode, "readline") =3D=3D 0) {
> +        qmp =3D false;
> +    } else if (strcmp(mode, "control") =3D=3D 0) {
> +        qmp =3D true;
> +    } else {
> +        error_setg(errp, "unknown monitor mode \"%s\"", mode);
> +        return -1;
> +    }
> +    if (!allow_hmp && !qmp) {
> +        error_setg(errp, "Only QMP is supported");
> +        return -1;
> +    }

I'm not sure we should recognize "mode" when !allow_hmp.  Hard to
decide as long as allow_hmp is always true.

> +
> +    if (!qmp && qemu_opt_get(opts, "pretty")) {
> +        warn_report("'pretty' is deprecated for HMP monitors, it has no =
effect "
> +                    "and will be removed in future versions");
> +    }
> +    if (qemu_opt_get_bool(opts, "pretty", 0)) {
> +        pretty =3D true;
> +    }
> +
> +    chardev =3D qemu_opt_get(opts, "chardev");
> +    if (!chardev) {
> +        error_report("chardev is required");
> +        exit(1);
> +    }
> +    chr =3D qemu_chr_find(chardev);
> +    if (chr =3D=3D NULL) {
> +        error_setg(errp, "chardev \"%s\" not found", chardev);
> +        return -1;
> +    }
> +
> +    if (qmp) {
> +        monitor_init_qmp(chr, pretty);
> +    } else {
> +        monitor_init_hmp(chr, true);
> +    }
> +    return 0;
> +}
> +
>  QemuOptsList qemu_mon_opts =3D {
>      .name =3D "mon",
>      .implied_opt_name =3D "chardev",
> diff --git a/vl.c b/vl.c
> index 94508300c3..352c68c897 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2116,50 +2116,7 @@ static int fsdev_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
> =20
>  static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  {
> -    Chardev *chr;
> -    bool qmp;
> -    bool pretty =3D false;
> -    const char *chardev;
> -    const char *mode;
> -
> -    mode =3D qemu_opt_get(opts, "mode");
> -    if (mode =3D=3D NULL) {
> -        mode =3D "readline";
> -    }
> -    if (strcmp(mode, "readline") =3D=3D 0) {
> -        qmp =3D false;
> -    } else if (strcmp(mode, "control") =3D=3D 0) {
> -        qmp =3D true;
> -    } else {
> -        error_setg(errp, "unknown monitor mode \"%s\"", mode);
> -        return -1;
> -    }
> -
> -    if (!qmp && qemu_opt_get(opts, "pretty")) {
> -        warn_report("'pretty' is deprecated for HMP monitors, it has no =
effect "
> -                    "and will be removed in future versions");
> -    }
> -    if (qemu_opt_get_bool(opts, "pretty", 0)) {
> -        pretty =3D true;
> -    }
> -
> -    chardev =3D qemu_opt_get(opts, "chardev");
> -    if (!chardev) {
> -        error_report("chardev is required");
> -        exit(1);
> -    }
> -    chr =3D qemu_chr_find(chardev);
> -    if (chr =3D=3D NULL) {
> -        error_setg(errp, "chardev \"%s\" not found", chardev);
> -        return -1;
> -    }
> -
> -    if (qmp) {
> -        monitor_init_qmp(chr, pretty);
> -    } else {
> -        monitor_init_hmp(chr, true);
> -    }
> -    return 0;
> +    return monitor_init_opts(opts, true, errp);
>  }
> =20
>  static void monitor_parse(const char *optarg, const char *mode, bool pre=
tty)

Less the new @allow_hmp parameter:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


