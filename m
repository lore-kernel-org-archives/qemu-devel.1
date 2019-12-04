Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF8AC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C63205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd2C8FwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C63205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXyF-0007It-Gq
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1icXkK-00008N-7s
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1icXkB-0007r4-1l
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:43:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1icXkA-0007dL-Sv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575477793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vKYcdSjvDkqMTKBCYWUeOKSdvcXhWbLbrwAnMiBPLo=;
 b=Hd2C8FwX6NOoZ+MQeuokOGNGdLNwGSAhcJhNeMXmV6gnIuKeW6kz4ZnzCFuImGtiKf8JuE
 B72ZBJYtdc6UNDBcWz0mpeKIZcuy3bDpQprjRucRZnj0j7B3dfDKf1+IpW7cht03EwCRcy
 hZ31Jp74GImJJXIpVdR44o/3rAqcoMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-kZl82JyAP6C7xYR_qab1tg-1; Wed, 04 Dec 2019 11:43:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24A10800EB8;
 Wed,  4 Dec 2019 16:43:09 +0000 (UTC)
Received: from work-vm (ovpn-117-217.ams2.redhat.com [10.36.117.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E2D85C1B2;
 Wed,  4 Dec 2019 16:43:08 +0000 (UTC)
Date: Wed, 4 Dec 2019 16:43:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] migration: add savevm_state_handler_remove()
Message-ID: <20191204164305.GK3325@work-vm>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-2-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191017205953.13122-2-cheloha@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kZl82JyAP6C7xYR_qab1tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> Create a function to abstract common logic needed when removing a
> SaveStateEntry element from the savevm_state.handlers queue.
>=20
> For now we just remove the element.  Soon it will involve additional
> cleanup.
>=20
> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 8d95e261f6..b2e3b7222a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -725,6 +725,11 @@ static void savevm_state_handler_insert(SaveStateEnt=
ry *nse)
>      }
>  }
> =20
> +static void savevm_state_handler_remove(SaveStateEntry *se)
> +{
> +    QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
> +}
> +
>  /* TODO: Individual devices generally have very little idea about the re=
st
>     of the system, so instance_id should be removed/replaced.
>     Meanwhile pass -1 as instance_id if you do not already have a clearly
> @@ -777,7 +782,7 @@ void unregister_savevm(DeviceState *dev, const char *=
idstr, void *opaque)
> =20
>      QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
>          if (strcmp(se->idstr, id) =3D=3D 0 && se->opaque =3D=3D opaque) =
{
> -            QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
> +            savevm_state_handler_remove(se);
>              g_free(se->compat);
>              g_free(se);
>          }
> @@ -841,7 +846,7 @@ void vmstate_unregister(DeviceState *dev, const VMSta=
teDescription *vmsd,
> =20
>      QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
>          if (se->vmsd =3D=3D vmsd && se->opaque =3D=3D opaque) {
> -            QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
> +            savevm_state_handler_remove(se);
>              g_free(se->compat);
>              g_free(se);
>          }
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


