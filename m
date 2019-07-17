Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52C7C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715B121743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="EKh4661b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715B121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnh28-0002ua-OX
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hnh1q-0002E4-4Q
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hnh1n-0007GD-Mj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:19:17 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:43606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hnh1m-0007Az-UH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:19:15 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 6B3172E147C;
 Wed, 17 Jul 2019 13:19:05 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 lu6l1PzMQW-J5UeY7Cn; Wed, 17 Jul 2019 13:19:05 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563358745; bh=COGDWfmn2ywFmZFasCPfE4PFVycRg1D14Gy1UFu1EMI=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=EKh4661b9cW6qTPSJj1E2dIJ0iZDI/7v1YAw7VJmEekXceRJI/Q5d5RpURQBrmQf1
 VxrBpNqVnPOPIEaDgvZMQMu/DB43PllfeM7/NgX8AAxgRuEHE0nc84MXLmXtcf/OCE
 /inJpcaoOBgr3Zs5ezx5SgQAwzSrz3YyfQEi50+Y=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id iYLnOh0V4u-3rxkK7TC
 for <yury-kotov@yandex-team.ru>; Wed, 17 Jul 2019 13:18:55 +0300
Received: by iva5-3ddfc71a5076.qloud-c.yandex.net with HTTP;
 Wed, 17 Jul 2019 13:18:54 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20190614163917.GI2785@work-vm>
References: <20190422103420.15686-1-yury-kotov@yandex-team.ru>
 <20190614163917.GI2785@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 17 Jul 2019 13:19:04 +0300
Message-Id: <488291563358734@iva5-3ddfc71a5076.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
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
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I'm a bit worried that this patch might have been forgotten.
Is it queued? Thanks!

14.06.2019, 19:56, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0Currently, there is no information about error if outgoing migra=
tion was failed
>> =C2=A0because of file channel errors.
>> =C2=A0Example (QMP session):
>> =C2=A0-> { "execute": "migrate", "arguments": { "uri": "exec:head -c 1=
" }}
>> =C2=A0<- { "return": {} }
>> =C2=A0...
>> =C2=A0-> { "execute": "query-migrate" }
>> =C2=A0<- { "return": { "status": "failed" }} // There is not error's d=
escription
>>
>> =C2=A0And even in the QEMU's output there is nothing.
>>
>> =C2=A0This patch
>> =C2=A01) Adds errp for the most of QEMUFileOps
>> =C2=A02) Adds qemu_file_get_error_obj/qemu_file_set_error_obj
>> =C2=A03) And finally using of qemu_file_get_error_obj in migration.c
>>
>> =C2=A0And now, the status for the mentioned fail will be:
>> =C2=A0-> { "execute": "query-migrate" }
>> =C2=A0<- { "return": { "status": "failed",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"error-desc": "Unable to write to com=
mand: Broken pipe" }}
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> =C2=A0---
>> =C2=A0=C2=A0migration/migration.c | 10 ++++--
>> =C2=A0=C2=A0migration/qemu-file-channel.c | 30 +++++++++--------
>> =C2=A0=C2=A0migration/qemu-file.c | 63 ++++++++++++++++++++++++++++---=
----
>> =C2=A0=C2=A0migration/qemu-file.h | 15 ++++++---
>> =C2=A0=C2=A0migration/savevm.c | 6 ++--
>> =C2=A0=C2=A05 files changed, 88 insertions(+), 36 deletions(-)
>>
>> =C2=A0diff --git a/migration/migration.c b/migration/migration.c
>> =C2=A0index 609e0df5d0..7bcdc4613b 100644
>> =C2=A0--- a/migration/migration.c
>> =C2=A0+++ b/migration/migration.c
>> =C2=A0@@ -2949,6 +2949,7 @@ static MigThrError migration_detect_error(=
MigrationState *s)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int state =3D s->state;
>> =C2=A0+ Error *local_error =3D NULL;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state =3D=3D MIGRATION_STATUS_=
CANCELLING ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state =3D=3D=
 MIGRATION_STATUS_CANCELLED) {
>> =C2=A0@@ -2957,13 +2958,18 @@ static MigThrError migration_detect_erro=
r(MigrationState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Try to detect any file errors *=
/
>> =C2=A0- ret =3D qemu_file_get_error(s->to_dst_file);
>> =C2=A0-
>> =C2=A0+ ret =3D qemu_file_get_error_obj(s->to_dst_file, &local_error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Everyth=
ing is fine */
>> =C2=A0+ assert(!local_error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return MIG=
_THR_ERR_NONE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0+ if (local_error) {
>> =C2=A0+ migrate_set_error(s, local_error);
>> =C2=A0+ error_free(local_error);
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state =3D=3D MIGRATION_STATUS_=
POSTCOPY_ACTIVE && ret =3D=3D -EIO) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Fo=
r postcopy, we allow the network to be down for a
>> =C2=A0diff --git a/migration/qemu-file-channel.c b/migration/qemu-file=
-channel.c
>> =C2=A0index 8e639eb496..c382ea2d78 100644
>> =C2=A0--- a/migration/qemu-file-channel.c
>> =C2=A0+++ b/migration/qemu-file-channel.c
>> =C2=A0@@ -33,7 +33,8 @@
>> =C2=A0=C2=A0static ssize_t channel_writev_buffer(void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0struct iovec *iov,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0int iovcnt,
>> =C2=A0- int64_t pos)
>> =C2=A0+ int64_t pos,
>> =C2=A0+ Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(op=
aque);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t done =3D 0;
>> =C2=A0@@ -47,7 +48,7 @@ static ssize_t channel_writev_buffer(void *opa=
que,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (nlocal_iov > 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t le=
n;
>> =C2=A0- len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, NULL);
>> =C2=A0+ len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len =3D=
=3D QIO_CHANNEL_ERR_BLOCK) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0if (qemu_in_coroutine()) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qio_channel_yield(ioc, G_IO_OUT);
>> =C2=A0@@ -57,7 +58,6 @@ static ssize_t channel_writev_buffer(void *opa=
que,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0continue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len < =
0) {
>> =C2=A0- /* XXX handle Error objects */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0done =3D -EIO;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0goto cleanup;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -75,13 +75,14 @@ static ssize_t channel_writev_buffer(void *o=
paque,
>> =C2=A0=C2=A0static ssize_t channel_get_buffer(void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint=
8_t *buf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int6=
4_t pos,
>> =C2=A0- size_t size)
>> =C2=A0+ size_t size,
>> =C2=A0+ Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(op=
aque);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t ret;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
>> =C2=A0- ret =3D qio_channel_read(ioc, (char *)buf, size, NULL);
>> =C2=A0+ ret =3D qio_channel_read(ioc, (char *)buf, size, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < =
0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (qemu_in_coroutine()) {
>> =C2=A0@@ -90,7 +91,6 @@ static ssize_t channel_get_buffer(void *opaque=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qio_channel_w=
ait(ioc, G_IO_IN);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0} else {
>> =C2=A0- /* XXX handle Error * object */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EIO;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -100,18 +100,20 @@ static ssize_t channel_get_buffer(void *op=
aque,
>> =C2=A0=C2=A0}
>>
>> =C2=A0-static int channel_close(void *opaque)
>> =C2=A0+static int channel_close(void *opaque, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0+ int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(op=
aque);
>> =C2=A0- qio_channel_close(ioc, NULL);
>> =C2=A0+ ret =3D qio_channel_close(ioc, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_unref(OBJECT(ioc));
>> =C2=A0- return 0;
>> =C2=A0+ return ret;
>> =C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0static int channel_shutdown(void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool rd,
>> =C2=A0- bool wr)
>> =C2=A0+ bool wr,
>> =C2=A0+ Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(op=
aque);
>>
>> =C2=A0@@ -125,8 +127,7 @@ static int channel_shutdown(void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0mode =3D QIO_CHANNEL_SHUTDOWN_WRITE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0- if (qio_channel_shutdown(ioc, mode, NULL) < 0) {
>> =C2=A0- /* XXX handler Error * object */
>> =C2=A0+ if (qio_channel_shutdown(ioc, mode, errp) < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return -EIO;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -135,11 +136,12 @@ static int channel_shutdown(void *opaque,
>>
>> =C2=A0=C2=A0static int channel_set_blocking(void *opaque,
>> =C2=A0- bool enabled)
>> =C2=A0+ bool enabled,
>> =C2=A0+ Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc =3D QIO_CHANNEL(op=
aque);
>>
>> =C2=A0- if (qio_channel_set_blocking(ioc, enabled, NULL) < 0) {
>> =C2=A0+ if (qio_channel_set_blocking(ioc, enabled, errp) < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> =C2=A0diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> =C2=A0index 977b9ae07c..c52160e08b 100644
>> =C2=A0--- a/migration/qemu-file.c
>> =C2=A0+++ b/migration/qemu-file.c
>> =C2=A0@@ -29,6 +29,7 @@
>> =C2=A0=C2=A0#include "migration.h"
>> =C2=A0=C2=A0#include "qemu-file.h"
>> =C2=A0=C2=A0#include "trace.h"
>> =C2=A0+#include "qapi/error.h"
>>
>> =C2=A0=C2=A0#define IO_BUF_SIZE 32768
>> =C2=A0=C2=A0#define MAX_IOV_SIZE MIN(IOV_MAX, 64)
>> =C2=A0@@ -52,6 +53,7 @@ struct QEMUFile {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int iovcnt;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int last_error;
>> =C2=A0+ Error *last_error_obj;
>> =C2=A0=C2=A0};
>>
>> =C2=A0=C2=A0/*
>> =C2=A0@@ -63,7 +65,7 @@ int qemu_file_shutdown(QEMUFile *f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!f->ops->shut_down) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EN=
OSYS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0- return f->ops->shut_down(f->opaque, true, true);
>> =C2=A0+ return f->ops->shut_down(f->opaque, true, true, NULL);
>> =C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0/*
>> =C2=A0@@ -108,24 +110,55 @@ void qemu_file_set_hooks(QEMUFile *f, cons=
t QEMUFileHooks *hooks)
>> =C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0/*
>> =C2=A0- * Get last error for stream f
>> =C2=A0+ * Get last error for stream f with optional Error*
>> =C2=A0=C2=A0=C2=A0*
>> =C2=A0=C2=A0=C2=A0* Return negative error value if there has been an e=
rror on previous
>> =C2=A0=C2=A0=C2=A0* operations, return 0 if no error happened.
>> =C2=A0+ * Optional, it returns Error* in errp, but it may be NULL even=
 if return value
>> =C2=A0+ * is not 0.
>> =C2=A0=C2=A0=C2=A0*
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0-int qemu_file_get_error(QEMUFile *f)
>> =C2=A0+int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0+ if (errp) {
>> =C2=A0+ *errp =3D f->last_error_obj ? error_copy(f->last_error_obj) : =
NULL;
>> =C2=A0+ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return f->last_error;
>> =C2=A0=C2=A0}
>>
>> =C2=A0-void qemu_file_set_error(QEMUFile *f, int ret)
>> =C2=A0+/*
>> =C2=A0+ * Set the last error for stream f with optional Error*
>> =C2=A0+ */
>> =C2=A0+void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err)
>> =C2=A0=C2=A0{
>> =C2=A0- if (f->last_error =3D=3D 0) {
>> =C2=A0+ if (f->last_error =3D=3D 0 && ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->last_er=
ror =3D ret;
>> =C2=A0+ error_propagate(&f->last_error_obj, err);
>> =C2=A0+ } else if (err) {
>> =C2=A0+ error_report_err(err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0}
>>
>> =C2=A0+/*
>> =C2=A0+ * Get last error for stream f
>> =C2=A0+ *
>> =C2=A0+ * Return negative error value if there has been an error on pr=
evious
>> =C2=A0+ * operations, return 0 if no error happened.
>> =C2=A0+ *
>> =C2=A0+ */
>> =C2=A0+int qemu_file_get_error(QEMUFile *f)
>> =C2=A0+{
>> =C2=A0+ return qemu_file_get_error_obj(f, NULL);
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+/*
>> =C2=A0+ * Set the last error for stream f
>> =C2=A0+ */
>> =C2=A0+void qemu_file_set_error(QEMUFile *f, int ret)
>> =C2=A0+{
>> =C2=A0+ qemu_file_set_error_obj(f, ret, NULL);
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0bool qemu_file_is_writable(QEMUFile *f)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return f->ops->writev_buffer;
>> =C2=A0@@ -177,6 +210,7 @@ void qemu_fflush(QEMUFile *f)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t expect =3D 0;
>> =C2=A0+ Error *local_error =3D NULL;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!qemu_file_is_writable(f)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0@@ -184,7 +218,8 @@ void qemu_fflush(QEMUFile *f)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->iovcnt > 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0expect =3D=
 iov_size(f->iov, f->iovcnt);
>> =C2=A0- ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f-=
>pos);
>> =C2=A0+ ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f-=
>pos,
>> =C2=A0+ &local_error);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_iovec=
_release_ram(f);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -196,7 +231,7 @@ void qemu_fflush(QEMUFile *f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* data set we requested, so =
sanity check that.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret !=3D expect) {
>> =C2=A0- qemu_file_set_error(f, ret < 0 ? ret : -EIO);
>> =C2=A0+ qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->buf_index =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->iovcnt =3D 0;
>> =C2=A0@@ -284,6 +319,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int pending;
>> =C2=A0+ Error *local_error =3D NULL;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(!qemu_file_is_writable(f));
>>
>> =C2=A0@@ -295,14 +331,16 @@ static ssize_t qemu_fill_buffer(QEMUFile *=
f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->buf_size =3D pending;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D f->ops->get_buffer(f->opaq=
ue, f->buf + pending, f->pos,
>> =C2=A0- IO_BUF_SIZE - pending);
>> =C2=A0+ IO_BUF_SIZE - pending, &local_error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len > 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->buf_siz=
e +=3D len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->pos +=3D=
 len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (len =3D=3D 0) {
>> =C2=A0- qemu_file_set_error(f, -EIO);
>> =C2=A0+ qemu_file_set_error_obj(f, -EIO, local_error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (len !=3D -EAGAIN) {
>> =C2=A0- qemu_file_set_error(f, len);
>> =C2=A0+ qemu_file_set_error_obj(f, len, local_error);
>> =C2=A0+ } else {
>> =C2=A0+ error_free(local_error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return len;
>> =C2=A0@@ -328,7 +366,7 @@ int qemu_fclose(QEMUFile *f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D qemu_file_get_error(f);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->ops->close) {
>> =C2=A0- int ret2 =3D f->ops->close(f->opaque);
>> =C2=A0+ int ret2 =3D f->ops->close(f->opaque, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret >=3D=
 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0ret =3D ret2;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0@@ -339,6 +377,7 @@ int qemu_fclose(QEMUFile *f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->last_error) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D f-=
>last_error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0+ error_free(f->last_error_obj);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(f);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_qemu_file_fclose();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>> =C2=A0@@ -784,6 +823,6 @@ void qemu_put_counted_string(QEMUFile *f, co=
nst char *str)
>> =C2=A0=C2=A0void qemu_file_set_blocking(QEMUFile *f, bool block)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (f->ops->set_blocking) {
>> =C2=A0- f->ops->set_blocking(f->opaque, block);
>> =C2=A0+ f->ops->set_blocking(f->opaque, block, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0}
>> =C2=A0diff --git a/migration/qemu-file.h b/migration/qemu-file.h
>> =C2=A0index 13baf896bd..eb886db65f 100644
>> =C2=A0--- a/migration/qemu-file.h
>> =C2=A0+++ b/migration/qemu-file.h
>> =C2=A0@@ -32,7 +32,8 @@
>> =C2=A0=C2=A0=C2=A0* bytes actually read should be returned.
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0typedef ssize_t (QEMUFileGetBufferFunc)(void *opaque, uint=
8_t *buf,
>> =C2=A0- int64_t pos, size_t size);
>> =C2=A0+ int64_t pos, size_t size,
>> =C2=A0+ Error **errp);
>>
>> =C2=A0=C2=A0/* Close a file
>> =C2=A0=C2=A0=C2=A0*
>> =C2=A0@@ -41,7 +42,7 @@ typedef ssize_t (QEMUFileGetBufferFunc)(void *=
opaque, uint8_t *buf,
>> =C2=A0=C2=A0=C2=A0* The meaning of return value on success depends on =
the specific back-end being
>> =C2=A0=C2=A0=C2=A0* used.
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0-typedef int (QEMUFileCloseFunc)(void *opaque);
>> =C2=A0+typedef int (QEMUFileCloseFunc)(void *opaque, Error **errp);
>>
>> =C2=A0=C2=A0/* Called to return the OS file descriptor associated to t=
he QEMUFile.
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0@@ -49,14 +50,15 @@ typedef int (QEMUFileGetFD)(void *opaque);
>>
>> =C2=A0=C2=A0/* Called to change the blocking mode of the file
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0-typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled);
>> =C2=A0+typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled, E=
rror **errp);
>>
>> =C2=A0=C2=A0/*
>> =C2=A0=C2=A0=C2=A0* This function writes an iovec to file. The handler=
 must write all
>> =C2=A0=C2=A0=C2=A0* of the data or return a negative errno value.
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0typedef ssize_t (QEMUFileWritevBufferFunc)(void *opaque, s=
truct iovec *iov,
>> =C2=A0- int iovcnt, int64_t pos);
>> =C2=A0+ int iovcnt, int64_t pos,
>> =C2=A0+ Error **errp);
>>
>> =C2=A0=C2=A0/*
>> =C2=A0=C2=A0=C2=A0* This function provides hooks around different
>> =C2=A0@@ -97,7 +99,8 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaq=
ue);
>> =C2=A0=C2=A0=C2=A0* Existing blocking reads/writes must be woken
>> =C2=A0=C2=A0=C2=A0* Returns 0 on success, -err on error
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0-typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool =
wr);
>> =C2=A0+typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool =
wr,
>> =C2=A0+ Error **errp);
>>
>> =C2=A0=C2=A0typedef struct QEMUFileOps {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QEMUFileGetBufferFunc *get_buffer;
>> =C2=A0@@ -149,6 +152,8 @@ void qemu_update_position(QEMUFile *f, size_=
t size);
>> =C2=A0=C2=A0void qemu_file_reset_rate_limit(QEMUFile *f);
>> =C2=A0=C2=A0void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rat=
e);
>> =C2=A0=C2=A0int64_t qemu_file_get_rate_limit(QEMUFile *f);
>> =C2=A0+int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
>> =C2=A0+void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
>> =C2=A0=C2=A0void qemu_file_set_error(QEMUFile *f, int ret);
>> =C2=A0=C2=A0int qemu_file_shutdown(QEMUFile *f);
>> =C2=A0=C2=A0QEMUFile *qemu_file_get_return_path(QEMUFile *f);
>> =C2=A0diff --git a/migration/savevm.c b/migration/savevm.c
>> =C2=A0index 34bcad3807..a619af744d 100644
>> =C2=A0--- a/migration/savevm.c
>> =C2=A0+++ b/migration/savevm.c
>> =C2=A0@@ -124,7 +124,7 @@ static struct mig_cmd_args {
>> =C2=A0=C2=A0/* savevm/loadvm support */
>>
>> =C2=A0=C2=A0static ssize_t block_writev_buffer(void *opaque, struct io=
vec *iov, int iovcnt,
>> =C2=A0- int64_t pos)
>> =C2=A0+ int64_t pos, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QEMUIOVector qiov;
>> =C2=A0@@ -139,12 +139,12 @@ static ssize_t block_writev_buffer(void *o=
paque, struct iovec *iov, int iovcnt,
>> =C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0static ssize_t block_get_buffer(void *opaque, uint8_t *buf=
, int64_t pos,
>> =C2=A0- size_t size)
>> =C2=A0+ size_t size, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return bdrv_load_vmstate(opaque, b=
uf, pos, size);
>> =C2=A0=C2=A0}
>>
>> =C2=A0-static int bdrv_fclose(void *opaque)
>> =C2=A0+static int bdrv_fclose(void *opaque, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return bdrv_flush(opaque);
>> =C2=A0=C2=A0}
>> =C2=A0--
>> =C2=A02.21.0
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury

