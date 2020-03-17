Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393F5C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7DA20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF6ox37N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7DA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8xp-0006Nf-4s
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jE8vU-0002i5-ER
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jE8vP-0006Uw-RX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:54:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55397)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jE8vP-0006TY-1l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438854;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsZxlCLllkrWy4cl4MLHPAx/aKbZX762nwY5C0hUfxw=;
 b=QF6ox37NL451R4SufNRfGvjEv90YrEFlDPG9evo+iJkDsSU20KpX1O/mfFE8QrrIN3cjoE
 X1FETV7O6lblo8CkJkQgiMBCRodqe3FiJrXz6yvPGqiiBYKDxMRUhIPjB4nJpaoQdkkEQ1
 YLYqvPsu/4ORV5xWK1i4YjWgr5IyG7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-K19EPyoiNoeQcMUHmd4P0Q-1; Tue, 17 Mar 2020 05:54:12 -0400
X-MC-Unique: K19EPyoiNoeQcMUHmd4P0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E7D190680F
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:54:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E7A81036B3B;
 Tue, 17 Mar 2020 09:54:09 +0000 (UTC)
Date: Tue, 17 Mar 2020 09:54:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qom-qmp-cmds: Fix another memory leak in qmp_object_add()
Message-ID: <20200317095406.GC2041016@redhat.com>
References: <20200317092241.31660-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200317092241.31660-1-armbru@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 10:22:41AM +0100, Markus Armbruster wrote:
> When user_creatable_add_type() fails, qmp_object_add() returns both
> its error and the usual empty QDict success value.  The QMP core
> handles the error, and ignores the success value, leaking it.  Exposed
> by qmp-cmd-test case /x86_64/qmp/object-add-without-props, and duly
> reported both by ASan and valgrind.
>=20
> To plug the leak, set the success value only on success.
>=20
> Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qom/qom-qmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 435193b036..6bd137ccbf 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -287,8 +287,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data,=
 Error **errp)
>      visit_free(v);
>      if (obj) {
>          object_unref(obj);
> +        *ret_data =3D QOBJECT(qdict_new());
>      }
> -    *ret_data =3D QOBJECT(qdict_new());
>  }
> =20
>  void qmp_object_del(const char *id, Error **errp)
> --=20
> 2.21.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


