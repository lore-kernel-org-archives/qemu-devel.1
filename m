Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559EDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E817208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et4l8yBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E817208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9o8Z-0000Fb-5I
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9o6y-0006bV-L3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9o6x-0000tR-4k
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:52:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9o6x-0000sw-0G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583405534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vW2L0E7KeIa1at20GdY3NqNTdQ80BaeGyOOhzmu3PA=;
 b=Et4l8yBjmqTWWNPnZgs7rsuoRhLmkoQNWZLLDrWmvm3vRWIvYv/FMCHjLVDvgqcDRqfqCe
 wtqBtr0L+pDcl6akLATtUn6y69bXZ04aHrVfS2F1Uf9QMwvlaJIrID7oBCG72hyL2YZKvB
 +6lO9cCSj98pi1UuXklpe3vuDH3fCTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-c9adOtxQP4Co0Vq6S90Log-1; Thu, 05 Mar 2020 05:52:12 -0500
X-MC-Unique: c9adOtxQP4Co0Vq6S90Log-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF73E13E5;
 Thu,  5 Mar 2020 10:52:09 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6205E272A6;
 Thu,  5 Mar 2020 10:51:57 +0000 (UTC)
Date: Thu, 5 Mar 2020 10:51:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 37/50] multi-process/mon: Refactor monitor/chardev
 functions out of vl.c
Message-ID: <20200305105154.GG3130@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <67a859b87b37fa5ecab72d561e327e80941fc705.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <67a859b87b37fa5ecab72d561e327e80941fc705.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> Some of the initialization helper functions w.r.t monitor & chardev
> in vl.c are also used by the remote process. Therefore, these functions
> are refactored into shared files that both QEMU & remote process
> could use.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

This looks like another good candidate to go in a separate post that
doesn't need to wait for the rest of multi-process; you are probably
best splitting it into separate chardev and monitor chunks so they can
go via their respective maintainers.

Dave


> ---
>  chardev/char.c            | 14 ++++++++++++++
>  include/chardev/char.h    |  1 +
>  include/monitor/monitor.h |  2 ++
>  monitor/monitor.c         | 40 ++++++++++++++++++++++++++++++++++++++-
>  remote/remote-main.c      |  1 +
>  remote/remote-opts.c      |  1 +
>  softmmu/vl.c              | 48 -----------------------------------------=
------
>  7 files changed, 58 insertions(+), 49 deletions(-)
>=20
> diff --git a/chardev/char.c b/chardev/char.c
> index 8723756..1d03ea0 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1189,4 +1189,18 @@ static void register_types(void)
>      qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
>  }
> =20
> +int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +
> +    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return -1;
> +        }
> +        exit(0);
> +    }
> +    return 0;
> +}
> +
>  type_init(register_types);
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 00589a6..e370320 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -290,4 +290,5 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint =
ms,
>  /* console.c */
>  void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **=
errp);
> =20
> +int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp);
>  #endif
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index b7bdd2b..d92bf1c 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -45,5 +45,7 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags);
>  int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
>  void monitor_fdset_dup_fd_remove(int dup_fd);
>  int64_t monitor_fdset_dup_fd_find(int dup_fd);
> +void monitor_parse(const char *optarg, const char *mode, bool pretty);
> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
> =20
>  #endif /* MONITOR_H */
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index c1a6c44..5759b84 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -33,7 +33,10 @@
>  #include "sysemu/qtest.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> -
> +#include "qemu/cutils.h"
> +#include "qemu/option.h"
> +#include "qemu-options.h"
> +#include "qemu/config-file.h"
>  /*
>   * To prevent flooding clients, events can be throttled. The
>   * throttling is calculated globally, rather than per-Monitor
> @@ -609,6 +612,41 @@ void monitor_init_globals_core(void)
>                                     NULL);
>  }
> =20
> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    return monitor_init_opts(opts, errp);
> +}
> +
> +void monitor_parse(const char *optarg, const char *mode, bool pretty)
> +{
> +    static int monitor_device_index;
> +    QemuOpts *opts;
> +    const char *p;
> +    char label[32];
> +
> +    if (strstart(optarg, "chardev:", &p)) {
> +        snprintf(label, sizeof(label), "%s", p);
> +    } else {
> +        snprintf(label, sizeof(label), "compat_monitor%d",
> +                 monitor_device_index);
> +        opts =3D qemu_chr_parse_compat(label, optarg, true);
> +        if (!opts) {
> +            error_report("parse error: %s", optarg);
> +            exit(1);
> +        }
> +    }
> +
> +    opts =3D qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fa=
tal);
> +    qemu_opt_set(opts, "mode", mode, &error_abort);
> +    qemu_opt_set(opts, "chardev", label, &error_abort);
> +    if (!strcmp(mode, "control")) {
> +        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
> +    } else {
> +        assert(pretty =3D=3D false);
> +    }
> +    monitor_device_index++;
> +}
> +
>  int monitor_init_opts(QemuOpts *opts, Error **errp)
>  {
>      Chardev *chr;
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index 5284ee9..23fc0df 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -54,6 +54,7 @@
>  #include "qemu/cutils.h"
>  #include "remote-opts.h"
>  #include "monitor/monitor.h"
> +#include "chardev/char.h"
>  #include "sysemu/reset.h"
> =20
>  static MPQemuLinkState *mpqemu_link;
> diff --git a/remote/remote-opts.c b/remote/remote-opts.c
> index 7e12700..565e641 100644
> --- a/remote/remote-opts.c
> +++ b/remote/remote-opts.c
> @@ -39,6 +39,7 @@
>  #include "block/block.h"
>  #include "remote/remote-opts.h"
>  #include "include/qemu-common.h"
> +#include "monitor/monitor.h"
> =20
>  #include "vl.h"
>  /*
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index a8a6f35..4a4f52c 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2133,19 +2133,6 @@ static int device_help_func(void *opaque, QemuOpts=
 *opts, Error **errp)
>      return qdev_device_help(opts);
>  }
> =20
> -static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -
> -    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return -1;
> -        }
> -        exit(0);
> -    }
> -    return 0;
> -}
> =20
>  #ifdef CONFIG_VIRTFS
>  static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
> @@ -2154,41 +2141,6 @@ static int fsdev_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
>  }
>  #endif
> =20
> -static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
> -{
> -    return monitor_init_opts(opts, errp);
> -}
> -
> -static void monitor_parse(const char *optarg, const char *mode, bool pre=
tty)
> -{
> -    static int monitor_device_index =3D 0;
> -    QemuOpts *opts;
> -    const char *p;
> -    char label[32];
> -
> -    if (strstart(optarg, "chardev:", &p)) {
> -        snprintf(label, sizeof(label), "%s", p);
> -    } else {
> -        snprintf(label, sizeof(label), "compat_monitor%d",
> -                 monitor_device_index);
> -        opts =3D qemu_chr_parse_compat(label, optarg, true);
> -        if (!opts) {
> -            error_report("parse error: %s", optarg);
> -            exit(1);
> -        }
> -    }
> -
> -    opts =3D qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fa=
tal);
> -    qemu_opt_set(opts, "mode", mode, &error_abort);
> -    qemu_opt_set(opts, "chardev", label, &error_abort);
> -    if (!strcmp(mode, "control")) {
> -        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
> -    } else {
> -        assert(pretty =3D=3D false);
> -    }
> -    monitor_device_index++;
> -}
> -
>  struct device_config {
>      enum {
>          DEV_USB,       /* -usbdevice     */
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


