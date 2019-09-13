Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F9C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF8320640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF8320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8liP-00026R-8F
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8le8-0007mn-7U
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8le6-00087A-Lf
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8le6-00086q-Gw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:29:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FCE4875222
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 13:29:53 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD7A5D71C;
 Fri, 13 Sep 2019 13:29:49 +0000 (UTC)
Date: Fri, 13 Sep 2019 14:29:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190913132947.GC2682@work-vm>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190912122514.22504-2-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 13 Sep 2019 13:29:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/6] migration: fix vmdesc leak on
 vmstate_save() error
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
Cc: mprivozn@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Could have put that as a separate patch.

> ---
>  migration/qjson.h  | 2 ++
>  migration/savevm.c | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/qjson.h b/migration/qjson.h
> index 41664f2d71..1786bb5864 100644
> --- a/migration/qjson.h
> +++ b/migration/qjson.h
> @@ -24,4 +24,6 @@ void json_start_object(QJSON *json, const char *name)=
;
>  const char *qjson_get_str(QJSON *json);
>  void qjson_finish(QJSON *json);
> =20
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QJSON, qjson_destroy)
> +
>  #endif /* QEMU_QJSON_H */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4a86128ac4..6caa35a679 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1290,7 +1290,7 @@ int qemu_savevm_state_complete_precopy_non_iterab=
le(QEMUFile *f,
>                                                      bool in_postcopy,
>                                                      bool inactivate_di=
sks)
>  {
> -    QJSON *vmdesc;
> +    g_autoptr(QJSON) vmdesc =3D NULL;
>      int vmdesc_len;
>      SaveStateEntry *se;
>      int ret;
> @@ -1351,7 +1351,6 @@ int qemu_savevm_state_complete_precopy_non_iterab=
le(QEMUFile *f,
>          qemu_put_be32(f, vmdesc_len);
>          qemu_put_buffer(f, (uint8_t *)qjson_get_str(vmdesc), vmdesc_le=
n);
>      }
> -    qjson_destroy(vmdesc);
> =20
>      return 0;
>  }
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

