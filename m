Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41204C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE482078D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdtT6T6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE482078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISB8-00043a-NF
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kISAL-0003Tr-Aq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:47:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kISAJ-0000lq-An
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600242462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I799qrTSp6Ypp7xlaREdUBgt6i7VsXuScWSe7r/tSxk=;
 b=LdtT6T6/C1lLbEGU2ws/u5Ro7mf1n1bXDefWA3LIN7mTawjk+/2/atuvK1yYOaW5gQZ+kb
 YeJh9CpKq+njLAOleE8shKkYErTg2+sn8Tux+B2UHcukBWaDZonkYOAX79iPGWfXmVcB/d
 grPYn72xBXl5tCm4hFVcp7YMk1gEOb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-i-T12Hs8POGkAEy7fnbGBw-1; Wed, 16 Sep 2020 03:47:39 -0400
X-MC-Unique: i-T12Hs8POGkAEy7fnbGBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFBEA80733A;
 Wed, 16 Sep 2020 07:47:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BAE35DF57;
 Wed, 16 Sep 2020 07:47:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 285E0113864A; Wed, 16 Sep 2020 09:47:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 5/9] migration: control whether snapshots are ovewritten
References: <20200915113523.2520317-1-berrange@redhat.com>
 <20200915113523.2520317-6-berrange@redhat.com>
Date: Wed, 16 Sep 2020 09:47:32 +0200
In-Reply-To: <20200915113523.2520317-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 15 Sep 2020 12:35:19
 +0100")
Message-ID: <871rj2uprf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The traditional HMP "savevm" command will overwrite an existing snapshot
> if it already exists with the requested name. This new flag allows this
> to be controlled allowing for safer behaviour with a future QMP command.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/migration/snapshot.h | 2 +-
>  migration/savevm.c           | 4 ++--
>  monitor/hmp-cmds.c           | 2 +-
>  replay/replay-snapshot.c     | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
> index c85b6ec75b..d7db1174ef 100644
> --- a/include/migration/snapshot.h
> +++ b/include/migration/snapshot.h
> @@ -15,7 +15,7 @@
>  #ifndef QEMU_MIGRATION_SNAPSHOT_H
>  #define QEMU_MIGRATION_SNAPSHOT_H
> =20
> -int save_snapshot(const char *name, Error **errp);
> +int save_snapshot(const char *name, bool overwrite, Error **errp);
>  int load_snapshot(const char *name, Error **errp);
> =20
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 76972d69b0..2025e3e579 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2658,7 +2658,7 @@ int qemu_load_device_state(QEMUFile *f)
>      return 0;
>  }
> =20
> -int save_snapshot(const char *name, Error **errp)
> +int save_snapshot(const char *name, bool overwrite, Error **errp)
>  {
>      BlockDriverState *bs;
>      QEMUSnapshotInfo sn1, *sn =3D &sn1, old_sn1, *old_sn =3D &old_sn1;
> @@ -2685,7 +2685,7 @@ int save_snapshot(const char *name, Error **errp)
>      }
> =20
>      /* Delete old snapshots of the same name */
> -    if (name) {
> +    if (name && overwrite) {
>          if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
>              return ret;
>          }

Are you sure this is sane?

To see what happens, I set a breakpoint on this function, set overwrite
to false.  I got a *second* snapshot with the same ID.

> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 98c98ae182..c1b8533d0c 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1131,7 +1131,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> =20
> -    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
> +    save_snapshot(qdict_get_try_str(qdict, "name"), true, &err);
>      hmp_handle_error(mon, err);
>  }
> =20
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index e26fa4c892..8e7ff97d11 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -77,7 +77,7 @@ void replay_vmstate_init(void)
> =20
>      if (replay_snapshot) {
>          if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
> -            if (save_snapshot(replay_snapshot, &err) !=3D 0) {
> +            if (save_snapshot(replay_snapshot, true, &err) !=3D 0) {
>                  error_report_err(err);
>                  error_report("Could not create snapshot for icount recor=
d");
>                  exit(1);


