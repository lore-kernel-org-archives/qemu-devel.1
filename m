Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD2C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB25206F6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai8L9j0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB25206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHn5h-0005pS-Is
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHn4T-0004ze-LJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHn4S-0007Q5-8H
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:22:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHn4R-0007Np-NB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585308158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XtoZowUdA3nxu6vDqjVEGls4+Wsnyaw9r07gX1gC7k=;
 b=ai8L9j0G17Kr4fXUOu4W6O5vMvttHsvBglxNmWM9f4NW9hWxP2ML1kJc5rrFb8jbW6HE6t
 8oKs9eIgB5bGuKKw669smUbrjnUzmYiH0I9aAnUIp9wJyhzlevdWvuWwKaqJvr9YMyXWd8
 I1RZKl+DQMWP6yfx20198wH8grnAf3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-WsX_7PLhOZacYadkRJGAnQ-1; Fri, 27 Mar 2020 07:22:36 -0400
X-MC-Unique: WsX_7PLhOZacYadkRJGAnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D07013E2;
 Fri, 27 Mar 2020 11:22:35 +0000 (UTC)
Received: from work-vm (ovpn-113-109.ams2.redhat.com [10.36.113.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4265F19C69;
 Fri, 27 Mar 2020 11:22:30 +0000 (UTC)
Date: Fri, 27 Mar 2020 11:22:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH] monitor/hmp-cmds: don't silently output when running
 'migrate_set_downtime' fails
Message-ID: <20200327112227.GC2786@work-vm>
References: <20200327062623.191818-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200327062623.191818-1-maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
> Although 'migrate_set_downtime' has been deprecated and replaced
> with 'migrate_set_parameter downtime_limit', it has not been
> completely eliminated, possibly due to compatibility with older
> versions. I think as long as this old parameter is running, we
> should report appropriate message when something goes wrong, not
> be silent.
>=20
> before:
> (qemu) migrate_set_downtime -1
> (qemu)
>=20
> after:
> (qemu) migrate_set_downtime -1
> Error: Parameter 'downtime_limit' expects an integer in the range of 0 to=
 2000 seconds
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor/hmp-cmds.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9b94e67879..2a900a528a 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1181,8 +1181,14 @@ void hmp_migrate_pause(Monitor *mon, const QDict *=
qdict)
>  /* Kept for backwards compatibility */
>  void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict)
>  {
> +    Error *err =3D NULL;
> +
>      double value =3D qdict_get_double(qdict, "value");
> -    qmp_migrate_set_downtime(value, NULL);
> +    qmp_migrate_set_downtime(value, &err);
> +
> +    if (err) {
> +        hmp_handle_error(mon, err);
> +    }
>  }
> =20
>  void hmp_migrate_set_cache_size(Monitor *mon, const QDict *qdict)
> --=20
> 2.17.1
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


