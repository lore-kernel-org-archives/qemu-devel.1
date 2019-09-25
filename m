Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145D4C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FD0214D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FD0214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD3we-0000Fu-Ky
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 05:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iD3vM-0007C4-Bq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iD3vL-0006fV-Ay
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:49:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iD3vL-0006ek-5e
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 675E8307D844
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:49:26 +0000 (UTC)
Received: from work-vm (ovpn-117-251.ams2.redhat.com [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 178A410013D9;
 Wed, 25 Sep 2019 09:49:22 +0000 (UTC)
Date: Wed, 25 Sep 2019 10:49:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] migration: fix vmdesc leak on
 vmstate_save() error
Message-ID: <20190925094920.GA21544@work-vm>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190912122514.22504-2-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 25 Sep 2019 09:49:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

I've queued this 1/6 only.

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
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

