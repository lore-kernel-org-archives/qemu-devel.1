Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D802EC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A36120684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrhf12wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A36120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZrXL-0003Mv-Ol
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 02:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZrWO-0002rP-3C
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZrWM-0007uE-C1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:13:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZrWM-0007tu-83
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574838833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CH1ZYOivGBJq9AMQW9W0MGR+KJlTxS2IO9hcY3iK0P4=;
 b=Vrhf12wzuyvAtt9EV1b2vLghVh/1oUdyhwPG513Yhcl58zhunhpQdEs5XxsbJryYs8lYD0
 8+O31hfzQttY/F+u0xIx33aQSCkqNC1ebZG6IBPiI3vr4VurWBnwBQiQNDSsrKo1zN0D98
 1VKYJrQeJQMPWaxV7zVpp1JI8OrlM+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-tdnIuyS6M--sqe37WZXQ_Q-1; Wed, 27 Nov 2019 02:13:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48841B0C60;
 Wed, 27 Nov 2019 07:13:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7F0260BEC;
 Wed, 27 Nov 2019 07:13:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A7D51138606; Wed, 27 Nov 2019 08:13:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/9] monitor: uninline add_init_drive
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-2-mlevitsk@redhat.com>
Date: Wed, 27 Nov 2019 08:13:47 +0100
In-Reply-To: <20191120185850.18986-2-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Wed, 20 Nov 2019 20:58:42 +0200")
Message-ID: <87zhghkd04.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tdnIuyS6M--sqe37WZXQ_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> This is only used by hmp_drive_add.
> The code is just a bit shorter this way.
>
> No functional changes
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  device-hotplug.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/device-hotplug.c b/device-hotplug.c
> index f01d53774b..5ce73f0cff 100644
> --- a/device-hotplug.c
> +++ b/device-hotplug.c
> @@ -34,42 +34,35 @@
>  #include "monitor/monitor.h"
>  #include "block/block_int.h"
> =20
> -static DriveInfo *add_init_drive(const char *optstr)
> +
> +void hmp_drive_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> -    DriveInfo *dinfo;
> +    DriveInfo *dinfo =3D NULL;

Superfluous initializer.

>      QemuOpts *opts;
>      MachineClass *mc;
> +    const char *optstr =3D qdict_get_str(qdict, "opts");
> +    bool node =3D qdict_get_try_bool(qdict, "node", false);
> +
> +    if (node) {
> +        hmp_drive_add_node(mon, optstr);
> +        return;
> +    }
> =20
>      opts =3D drive_def(optstr);
>      if (!opts)
> -        return NULL;
> +        return;
> =20
>      mc =3D MACHINE_GET_CLASS(current_machine);
>      dinfo =3D drive_new(opts, mc->block_default_type, &err);
>      if (err) {
>          error_report_err(err);
>          qemu_opts_del(opts);
> -        return NULL;
> -    }
> -
> -    return dinfo;
> -}
> -
> -void hmp_drive_add(Monitor *mon, const QDict *qdict)
> -{
> -    DriveInfo *dinfo =3D NULL;
> -    const char *opts =3D qdict_get_str(qdict, "opts");
> -    bool node =3D qdict_get_try_bool(qdict, "node", false);
> -
> -    if (node) {
> -        hmp_drive_add_node(mon, opts);
> -        return;
> +        goto err;
>      }
> =20
> -    dinfo =3D add_init_drive(opts);
>      if (!dinfo) {
> -        goto err;
> +        return;
>      }
> =20
>      switch (dinfo->type) {

Reviewed-by: Markus Armbruster <armbru@redhat.com>


