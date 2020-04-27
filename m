Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F418C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 19:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68F92078C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 19:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIZp2dS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68F92078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT9If-0007fp-Vy
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 15:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT9Hn-00074G-G3
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT9Hm-00084c-1F
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:19:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jT9Hl-000832-GD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588015159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrLCLQyV/Z8rkRnxVec80PQlOErlfAUWDZ2a7lx8d4A=;
 b=cIZp2dS6GvZMecmkTofUxbuAceqCWmv7Cqmqhc8T2r4KlMCWJclETrTa2+2r+05TPsxZFj
 kxwFl8VPhXm5nxlR+0AvT4fPRCf9lyEgZkwP/Udvo1u28KkCd6j2uayxPBnJnAWqwxuVwd
 SiNtGHiowZvRERVKijUGT8h/9hdipbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-ZaIoCSD9MkaG5rvW8kVQ2A-1; Mon, 27 Apr 2020 15:19:14 -0400
X-MC-Unique: ZaIoCSD9MkaG5rvW8kVQ2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A86B01005510;
 Mon, 27 Apr 2020 19:19:12 +0000 (UTC)
Received: from work-vm (ovpn-112-96.ams2.redhat.com [10.36.112.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC1A85C1B2;
 Mon, 27 Apr 2020 19:19:10 +0000 (UTC)
Date: Mon, 27 Apr 2020 20:19:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
Message-ID: <20200427191908.GO2923@work-vm>
References: <20200407114449.482532-1-clg@kaod.org>
MIME-Version: 1.0
In-Reply-To: <20200407114449.482532-1-clg@kaod.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 13:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* C=E9dric Le Goater (clg@kaod.org) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Reimplement it based on qmp_qom_get() to avoid converting QObjects back
> to strings.

<blows dust off patch>
I'd love to see this or something similar in;  what does it's output
look like for structures - I think that was the main problem people
complained about last time, although IMHO even a version that couldn't
do structures nicely would be better than nothing.

Dave

>=20
> Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
>=20
> Slight fix for bit-rot:
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> [clg: updates for QEMU 5.0 ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  I would like to restart the discussion on qom-get command to understand
>  what was the conclusion and see if things have changed since.
>=20
>  Thanks,
>=20
>  C.
>=20
>  include/monitor/hmp.h |  1 +
>  qom/qom-hmp-cmds.c    | 23 +++++++++++++++++++++++
>  hmp-commands.hx       | 13 +++++++++++++
>  3 files changed, 37 insertions(+)
>=20
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index e33ca5a911a5..c986cfd28bc3 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -96,6 +96,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict);
>  void hmp_info_numa(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
>  void hmp_qom_list(Monitor *mon, const QDict *qdict);
> +void hmp_qom_get(Monitor *mon, const QDict *qdict);
>  void hmp_qom_set(Monitor *mon, const QDict *qdict);
>  void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
>  void object_add_completion(ReadLineState *rs, int nb_args, const char *s=
tr);
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index cd08233a4cfe..b14cf6e785f4 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -40,6 +40,29 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, err);
>  }
> =20
> +void hmp_qom_get(Monitor *mon, const QDict *qdict)
> +{
> +    const char *path =3D qdict_get_str(qdict, "path");
> +    const char *property =3D qdict_get_str(qdict, "property");
> +    Error *err =3D NULL;
> +    Object *obj;
> +    char *value;
> +
> +    obj =3D object_resolve_path(path, NULL);
> +    if (obj =3D=3D NULL) {
> +        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                  "Device '%s' not found", path);
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +    value =3D object_property_print(obj, property, true, &err);
> +    if (err =3D=3D NULL) {
> +        monitor_printf(mon, "%s\n", value);
> +        g_free(value);
> +    }
> +    hmp_handle_error(mon, err);
> +}
> +
>  void hmp_qom_set(Monitor *mon, const QDict *qdict)
>  {
>      const char *path =3D qdict_get_str(qdict, "path");
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7f0f3974ad90..4e39b9caed3e 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1790,6 +1790,19 @@ SRST
>    Print QOM properties of object at location *path*
>  ERST
> =20
> +    {
> +        .name       =3D "qom-get",
> +        .args_type  =3D "path:s,property:s",
> +        .params     =3D "path property",
> +        .help       =3D "print QOM property",
> +        .cmd        =3D hmp_qom_get,
> +    },
> +
> +SRST
> +``qom-get``  *path* *property*
> +  Print QOM property *property* of object at location *path*
> +ERST
> +
>      {
>          .name       =3D "qom-set",
>          .args_type  =3D "path:s,property:s,value:s",
> --=20
> 2.25.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


