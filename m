Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797CC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E154020684
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="PPjw5fV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E154020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAmr-00036C-2e
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hZAlf-0002bb-Nj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hZAld-0004mM-4e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:02:35 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:52266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hZAlb-0004aO-13
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:02:33 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7E34A2E0B08;
 Fri,  7 Jun 2019 12:02:26 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 nUejhiT0lg-2QoqU6Bu; Fri, 07 Jun 2019 12:02:26 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1559898146; bh=xiAdkPGrN5Jcr7GG8kkptEIXi8I33XlggKnkq4HXZB4=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=PPjw5fV1LALO2AbTwEwZ3lpozEvGf1K+uslkoEAze4IH1Te6SiwgJgVDeKoz59Gxk
 P69jc92rpHtFZ0yoQ7RUK5DdFuCGe+pQFevBKYOWkHntTUN9N21/sIJqOlMVCSrzPr
 edbqUDsXCbT33ipf79zzIWyqjnOuddRCyqj5AxUc=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::162])
 by dlvcorp1p.mail.yandex.net with LMTP id F3qnKKe7r3-Y06wl6EG
 for <yury-kotov@yandex-team.ru>; Fri, 07 Jun 2019 12:02:16 +0300
Received: by iva7-0f652523820f.qloud-c.yandex.net with HTTP;
 Fri, 07 Jun 2019 12:02:16 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20190422103420.15686-1-yury-kotov@yandex-team.ru>
References: <20190422103420.15686-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 07 Jun 2019 12:02:26 +0300
Message-Id: <139431559898136@iva7-0f652523820f.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: Re: [Qemu-devel] [PATCH] migration: Add error_desc for file channel
 errors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

22.04.2019, 13:50, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Currently, there is no information about error if outgoing migration wa=
s failed
> because of file channel errors.
> Example (QMP session):
> -> { "execute": "migrate", "arguments": { "uri": "exec:head -c 1" }}
> <- { "return": {} }
> ...
> -> { "execute": "query-migrate" }
> <- { "return": { "status": "failed" }} // There is not error's descript=
ion
>
> And even in the QEMU's output there is nothing.
>
> This patch
> 1) Adds errp for the most of QEMUFileOps
> 2) Adds qemu_file_get_error_obj/qemu_file_set_error_obj
> 3) And finally using of qemu_file_get_error_obj in migration.c
>
> And now, the status for the mentioned fail will be:
> -> { "execute": "query-migrate" }
> <- { "return": { "status": "failed",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"error-desc": "Unable to write to command: =
Broken pipe" }}
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
> =C2=A0migration/migration.c | 10 ++++--
> =C2=A0migration/qemu-file-channel.c | 30 +++++++++--------
> =C2=A0migration/qemu-file.c | 63 ++++++++++++++++++++++++++++-------
> =C2=A0migration/qemu-file.h | 15 ++++++---
> =C2=A0migration/savevm.c | 6 ++--
> =C2=A05 files changed, 88 insertions(+), 36 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 609e0df5d0..7bcdc4613b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2949,6 +2949,7 @@ static MigThrError migration_detect_error(Migrati=
onState *s)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int state =3D s->state;
> + Error *local_error =3D NULL;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state =3D=3D MIGRATION_STATUS_CANCELL=
ING ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state =3D=3D MIGR=
ATION_STATUS_CANCELLED) {
> @@ -2957,13 +2958,18 @@ static MigThrError migration_detect_error(Migra=
tionState *s)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Try to detect any file errors */
> - ret =3D qemu_file_get_error(s->to_dst_file);
> -
> + ret =3D qemu_file_get_error_obj(s->to_dst_file, &local_error);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Everything is =
fine */
> + assert(!local_error);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return MIG_THR_ER=
R_NONE;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> + if (local_error) {
> + migrate_set_error(s, local_error);
> + error_free(local_error);
> + }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state =3D=3D MIGRATION_STATUS_POSTCOP=
Y_ACTIVE && ret =3D=3D -EIO) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* For postc=
opy, we allow the network to be down for a
> diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channe=
l.c
> index 8e639eb496..c382ea2d78 100644
> --- a/migration/qemu-file-channel.c
> +++ b/migration/qemu-file-channel.c
> @@ -33,7 +33,8 @@
> =C2=A0static ssize_t channel_writev_buffer(void *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0struct iovec *iov,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0int iovcnt,
> - int64_t pos)
> + int64_t pos,
> + Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t done =3D 0;
> @@ -47,7 +48,7 @@ static ssize_t channel_writev_buffer(void *opaque,
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (nlocal_iov > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t len;
> - len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, NULL);
> + len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len =3D=3D QI=
O_CHANNEL_ERR_BLOCK) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (qemu_in_coroutine()) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qio_channel_yield(ioc, G_IO_OUT);
> @@ -57,7 +58,6 @@ static ssize_t channel_writev_buffer(void *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0continue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len < 0) {
> - /* XXX handle Error objects */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0done =3D -EIO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0goto cleanup;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> @@ -75,13 +75,14 @@ static ssize_t channel_writev_buffer(void *opaque,
> =C2=A0static ssize_t channel_get_buffer(void *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint8_t *b=
uf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int64_t po=
s,
> - size_t size)
> + size_t size,
> + Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t ret;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
> - ret =3D qio_channel_read(ioc, (char *)buf, size, NULL);
> + ret =3D qio_channel_read(ioc, (char *)buf, size, errp);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (qemu_in_coroutine()) {
> @@ -90,7 +91,6 @@ static ssize_t channel_get_buffer(void *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qio_channel_wait(io=
c, G_IO_IN);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0} else {
> - /* XXX handle Error * object */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EIO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> @@ -100,18 +100,20 @@ static ssize_t channel_get_buffer(void *opaque,
> =C2=A0}
>
> -static int channel_close(void *opaque)
> +static int channel_close(void *opaque, Error **errp)
> =C2=A0{
> + int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> - qio_channel_close(ioc, NULL);
> + ret =3D qio_channel_close(ioc, errp);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_unref(OBJECT(ioc));
> - return 0;
> + return ret;
> =C2=A0}
>
> =C2=A0static int channel_shutdown(void *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0bool rd,
> - bool wr)
> + bool wr,
> + Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
>
> @@ -125,8 +127,7 @@ static int channel_shutdown(void *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0mode =3D QIO_CHANNEL_SHUTDOWN_WRITE;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> - if (qio_channel_shutdown(ioc, mode, NULL) < 0) {
> - /* XXX handler Error * object */
> + if (qio_channel_shutdown(ioc, mode, errp) < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return -EIO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> @@ -135,11 +136,12 @@ static int channel_shutdown(void *opaque,
>
> =C2=A0static int channel_set_blocking(void *opaque,
> - bool enabled)
> + bool enabled,
> + Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
>
> - if (qio_channel_set_blocking(ioc, enabled, NULL) < 0) {
> + if (qio_channel_set_blocking(ioc, enabled, errp) < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 977b9ae07c..c52160e08b 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -29,6 +29,7 @@
> =C2=A0#include "migration.h"
> =C2=A0#include "qemu-file.h"
> =C2=A0#include "trace.h"
> +#include "qapi/error.h"
>
> =C2=A0#define IO_BUF_SIZE 32768
> =C2=A0#define MAX_IOV_SIZE MIN(IOV_MAX, 64)
> @@ -52,6 +53,7 @@ struct QEMUFile {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int iovcnt;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int last_error;
> + Error *last_error_obj;
> =C2=A0};
>
> =C2=A0/*
> @@ -63,7 +65,7 @@ int qemu_file_shutdown(QEMUFile *f)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!f->ops->shut_down) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOSYS;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> - return f->ops->shut_down(f->opaque, true, true);
> + return f->ops->shut_down(f->opaque, true, true, NULL);
> =C2=A0}
>
> =C2=A0/*
> @@ -108,24 +110,55 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUF=
ileHooks *hooks)
> =C2=A0}
>
> =C2=A0/*
> - * Get last error for stream f
> + * Get last error for stream f with optional Error*
> =C2=A0=C2=A0*
> =C2=A0=C2=A0* Return negative error value if there has been an error on=
 previous
> =C2=A0=C2=A0* operations, return 0 if no error happened.
> + * Optional, it returns Error* in errp, but it may be NULL even if ret=
urn value
> + * is not 0.
> =C2=A0=C2=A0*
> =C2=A0=C2=A0*/
> -int qemu_file_get_error(QEMUFile *f)
> +int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
> =C2=A0{
> + if (errp) {
> + *errp =3D f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
> + }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return f->last_error;
> =C2=A0}
>
> -void qemu_file_set_error(QEMUFile *f, int ret)
> +/*
> + * Set the last error for stream f with optional Error*
> + */
> +void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err)
> =C2=A0{
> - if (f->last_error =3D=3D 0) {
> + if (f->last_error =3D=3D 0 && ret) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->last_error =3D=
 ret;
> + error_propagate(&f->last_error_obj, err);
> + } else if (err) {
> + error_report_err(err);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0}
>
> +/*
> + * Get last error for stream f
> + *
> + * Return negative error value if there has been an error on previous
> + * operations, return 0 if no error happened.
> + *
> + */
> +int qemu_file_get_error(QEMUFile *f)
> +{
> + return qemu_file_get_error_obj(f, NULL);
> +}
> +
> +/*
> + * Set the last error for stream f
> + */
> +void qemu_file_set_error(QEMUFile *f, int ret)
> +{
> + qemu_file_set_error_obj(f, ret, NULL);
> +}
> +
> =C2=A0bool qemu_file_is_writable(QEMUFile *f)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return f->ops->writev_buffer;
> @@ -177,6 +210,7 @@ void qemu_fflush(QEMUFile *f)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t ret =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t expect =3D 0;
> + Error *local_error =3D NULL;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!qemu_file_is_writable(f)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> @@ -184,7 +218,8 @@ void qemu_fflush(QEMUFile *f)
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->iovcnt > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0expect =3D iov_si=
ze(f->iov, f->iovcnt);
> - ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->pos);
> + ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->pos,
> + &local_error);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_iovec_releas=
e_ram(f);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> @@ -196,7 +231,7 @@ void qemu_fflush(QEMUFile *f)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* data set we requested, so sanity =
check that.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret !=3D expect) {
> - qemu_file_set_error(f, ret < 0 ? ret : -EIO);
> + qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->buf_index =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->iovcnt =3D 0;
> @@ -284,6 +319,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int len;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int pending;
> + Error *local_error =3D NULL;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(!qemu_file_is_writable(f));
>
> @@ -295,14 +331,16 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->buf_size =3D pending;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D f->ops->get_buffer(f->opaque, f->=
buf + pending, f->pos,
> - IO_BUF_SIZE - pending);
> + IO_BUF_SIZE - pending, &local_error);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->buf_size +=3D =
len;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->pos +=3D len;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (len =3D=3D 0) {
> - qemu_file_set_error(f, -EIO);
> + qemu_file_set_error_obj(f, -EIO, local_error);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (len !=3D -EAGAIN) {
> - qemu_file_set_error(f, len);
> + qemu_file_set_error_obj(f, len, local_error);
> + } else {
> + error_free(local_error);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return len;
> @@ -328,7 +366,7 @@ int qemu_fclose(QEMUFile *f)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D qemu_file_get_error(f);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->ops->close) {
> - int ret2 =3D f->ops->close(f->opaque);
> + int ret2 =3D f->ops->close(f->opaque, NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret >=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0ret =3D ret2;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> @@ -339,6 +377,7 @@ int qemu_fclose(QEMUFile *f)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->last_error) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D f->last_e=
rror;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> + error_free(f->last_error_obj);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(f);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_qemu_file_fclose();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> @@ -784,6 +823,6 @@ void qemu_put_counted_string(QEMUFile *f, const cha=
r *str)
> =C2=A0void qemu_file_set_blocking(QEMUFile *f, bool block)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->ops->set_blocking) {
> - f->ops->set_blocking(f->opaque, block);
> + f->ops->set_blocking(f->opaque, block, NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0}
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 13baf896bd..eb886db65f 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -32,7 +32,8 @@
> =C2=A0=C2=A0* bytes actually read should be returned.
> =C2=A0=C2=A0*/
> =C2=A0typedef ssize_t (QEMUFileGetBufferFunc)(void *opaque, uint8_t *bu=
f,
> - int64_t pos, size_t size);
> + int64_t pos, size_t size,
> + Error **errp);
>
> =C2=A0/* Close a file
> =C2=A0=C2=A0*
> @@ -41,7 +42,7 @@ typedef ssize_t (QEMUFileGetBufferFunc)(void *opaque,=
 uint8_t *buf,
> =C2=A0=C2=A0* The meaning of return value on success depends on the spe=
cific back-end being
> =C2=A0=C2=A0* used.
> =C2=A0=C2=A0*/
> -typedef int (QEMUFileCloseFunc)(void *opaque);
> +typedef int (QEMUFileCloseFunc)(void *opaque, Error **errp);
>
> =C2=A0/* Called to return the OS file descriptor associated to the QEMU=
File.
> =C2=A0=C2=A0*/
> @@ -49,14 +50,15 @@ typedef int (QEMUFileGetFD)(void *opaque);
>
> =C2=A0/* Called to change the blocking mode of the file
> =C2=A0=C2=A0*/
> -typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled);
> +typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled, Error **=
errp);
>
> =C2=A0/*
> =C2=A0=C2=A0* This function writes an iovec to file. The handler must w=
rite all
> =C2=A0=C2=A0* of the data or return a negative errno value.
> =C2=A0=C2=A0*/
> =C2=A0typedef ssize_t (QEMUFileWritevBufferFunc)(void *opaque, struct i=
ovec *iov,
> - int iovcnt, int64_t pos);
> + int iovcnt, int64_t pos,
> + Error **errp);
>
> =C2=A0/*
> =C2=A0=C2=A0* This function provides hooks around different
> @@ -97,7 +99,8 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaque);
> =C2=A0=C2=A0* Existing blocking reads/writes must be woken
> =C2=A0=C2=A0* Returns 0 on success, -err on error
> =C2=A0=C2=A0*/
> -typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr);
> +typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr,
> + Error **errp);
>
> =C2=A0typedef struct QEMUFileOps {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QEMUFileGetBufferFunc *get_buffer;
> @@ -149,6 +152,8 @@ void qemu_update_position(QEMUFile *f, size_t size)=
;
> =C2=A0void qemu_file_reset_rate_limit(QEMUFile *f);
> =C2=A0void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rate);
> =C2=A0int64_t qemu_file_get_rate_limit(QEMUFile *f);
> +int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
> +void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
> =C2=A0void qemu_file_set_error(QEMUFile *f, int ret);
> =C2=A0int qemu_file_shutdown(QEMUFile *f);
> =C2=A0QEMUFile *qemu_file_get_return_path(QEMUFile *f);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 34bcad3807..a619af744d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -124,7 +124,7 @@ static struct mig_cmd_args {
> =C2=A0/* savevm/loadvm support */
>
> =C2=A0static ssize_t block_writev_buffer(void *opaque, struct iovec *io=
v, int iovcnt,
> - int64_t pos)
> + int64_t pos, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QEMUIOVector qiov;
> @@ -139,12 +139,12 @@ static ssize_t block_writev_buffer(void *opaque, =
struct iovec *iov, int iovcnt,
> =C2=A0}
>
> =C2=A0static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64=
_t pos,
> - size_t size)
> + size_t size, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return bdrv_load_vmstate(opaque, buf, pos=
, size);
> =C2=A0}
>
> -static int bdrv_fclose(void *opaque)
> +static int bdrv_fclose(void *opaque, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return bdrv_flush(opaque);
> =C2=A0}
> --
> 2.21.0

