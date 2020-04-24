Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9781C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10A520776
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH4ZlZ7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10A520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRy2I-0008Ra-JG
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxyr-0005vl-Ms
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxyj-00035x-9P
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:02:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jRxyi-000314-Rx
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587733367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4BjcDj3IoACNwYNQ/YaFwY27vmgR4wkG7R5Hih9xyI=;
 b=IH4ZlZ7aHBw4/wH5OobKNC2YxPBLsKjP/URGt6GAQbLx9NStCkuZ/zcGxB+Dyela86ARdQ
 ATig/Oy6Pzsai7Rs+ZbKhtWiOjfCYePgtSu8j8jDN1tavtx9+Vl1RgHtaBmMm19ISj6/gC
 SVCpOdjHoSnZ7CbbYsVQampKk87TBOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367--ws9ioAEMxKierCQllLc4A-1; Fri, 24 Apr 2020 09:02:45 -0400
X-MC-Unique: -ws9ioAEMxKierCQllLc4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 680B4180F107;
 Fri, 24 Apr 2020 13:02:43 +0000 (UTC)
Received: from localhost (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D6E51002380;
 Fri, 24 Apr 2020 13:02:37 +0000 (UTC)
Date: Fri, 24 Apr 2020 14:02:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 05/36] multi-process: Refactor monitor
 functions out of vl.c
Message-ID: <20200424130236.GE189569@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <22a91b836f4105dc314f24536e96f883c0ad638c.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <22a91b836f4105dc314f24536e96f883c0ad638c.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:40PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Some of the initialization helper functions w.r.t monitor
> in vl.c are also used by the remote process. Therefore, these functions
> are refactored into shared files that both QEMU & remote process
> could use.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/monitor/monitor.h |  3 +++
>  monitor/monitor.c         | 37 +++++++++++++++++++++++++++++++++++++
>  softmmu/vl.c              | 35 -----------------------------------
>  3 files changed, 40 insertions(+), 35 deletions(-)

Kevin Wolf recently had to solve a similar problem when introducing
qemu-storage-daemon.

qemu-storage-daemon.c open-codes the command-line parsing instead of
trying to reuse vl.c's code.  The vl.c code is old and not very neat,
unless other code depends on it I would suggest writing modern clean
code like Kevin did instead of trying to keep using vl.c code.

>=20
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 1018d754a6..3803e904f2 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -48,4 +48,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_=
fd);
>  void monitor_fdset_dup_fd_remove(int dup_fd);
>  int64_t monitor_fdset_dup_fd_find(int dup_fd);
> =20
> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
> +void monitor_parse(const char *optarg, const char *mode, bool pretty);
> +
>  #endif /* MONITOR_H */
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 125494410a..88423b38b6 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -35,6 +35,8 @@
>  #include "sysemu/qtest.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> +#include "qemu/cutils.h"
> +#include "qemu/config-file.h"
> =20
>  /*
>   * To prevent flooding clients, events can be throttled. The
> @@ -611,6 +613,41 @@ void monitor_init_globals_core(void)
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
>  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  {
>      Chardev *chr;
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 6e35f3787d..abc746c1b5 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2045,41 +2045,6 @@ static int fsdev_init_func(void *opaque, QemuOpts =
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
> 2.25.GIT
>=20

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6i42wACgkQnKSrs4Gr
c8hwXgf8DmQzMlbnuy0nEUVal0PQvPoHGfmzLiYFObdbJA5mFpCraWsLT8QGUZef
2rdQ3+EtuvzjU3wtY0OZEgbpAO7mDP2KNIVuUWl8kavBqAz/5BlzDf7d+l26t3Wy
/VyEAcQVXUJn9Lc7dZ6w9jD/TMi3nBTVPivNGDQSdDgqbVKBSkJJ1rdVvFqkqZcB
Op4DyOeZG0k0Cx3Q/gDgWzC/dCEJs+k9EmYWREYN7n/MTvH3aAMrzEgMfPiyjVvH
Wu4kNkv/w1JQYRDzojv+DNLrO5dNGLczf2qrueSPo5V0L3VVHkxBzH7IB5ttI7YE
AHvJqJ/q8Iceqq0xRgUnekb+f3gMUA==
=2NuK
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--


