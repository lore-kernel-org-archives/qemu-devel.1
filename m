Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C38C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EA120873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwAwA9Xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EA120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FVA-0004Y8-GN
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2FU4-0003WG-0Y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2FU1-0005Fe-Kh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:28:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38175
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2FU1-0005CI-DD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581604128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xz+0yKSTxmM+Lrw/gjUwuQj5qlsyEHhmfdVLJ3Oqb5E=;
 b=RwAwA9XkBlqU/LYfSt4XliyW25zQMw1rwljPwMlJwMNFMy4Jk9VZdDwJ8bNaQmJSw9qmTA
 7rauLiGz8xjfyn3T8EMMczQqColUX/zyfmZ0V+zdjVRrGavzWvfstOs5lf87N8+g7QZMQx
 NyBKgHl73nh8yyhI8LRFK6B6OgVCUVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-vSkJUSdoOXiaX2xK9VI3Pg-1; Thu, 13 Feb 2020 09:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AECB8DC463
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:28:45 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B25ED8AC2A;
 Thu, 13 Feb 2020 14:28:43 +0000 (UTC)
Date: Thu, 13 Feb 2020 14:28:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 7/8] multifd: Add multifd-zstd-level parameter
Message-ID: <20200213142841.GJ2960@work-vm>
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-8-quintela@redhat.com>
 <20200211184749.GI2751@work-vm> <87wo8q4m84.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87wo8q4m84.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vSkJUSdoOXiaX2xK9VI3Pg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>=20
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  migration/migration.c | 15 +++++++++++++++
> >>  monitor/hmp-cmds.c    |  4 ++++
> >>  qapi/migration.json   | 29 ++++++++++++++++++++++++++---
> >>  3 files changed, 45 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 3b081e8147..b690500545 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -91,6 +91,8 @@
> >>  #define DEFAULT_MIGRATE_MULTIFD_METHOD MULTIFD_METHOD_NONE
> >>  /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
> >>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
> >> +/* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
> >> +#define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
> >> =20
> >>  /* Background transfer rate for postcopy, 0 means unlimited, note
> >>   * that page requests can still exceed this limit.
> >> @@ -805,6 +807,8 @@ MigrationParameters *qmp_query_migrate_parameters(=
Error **errp)
> >>      params->multifd_method =3D s->parameters.multifd_method;
> >>      params->has_multifd_zlib_level =3D true;
> >>      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
> >> +    params->has_multifd_zstd_level =3D true;
> >> +    params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
> >
> > Do we really want different 'multifd_...._level's or just one
> > 'multifd_compress_level' - or even just reuse the existing
> > 'compress-level' parameter.
>=20
> compress-level, multifd-zlib-level, and multifd-zstd-level apply
> "normal" live migration compression, multifd zlib live migration
> compression, and multifd zstd live migration compression, respectively.
>=20
> Any live migration can only use one of the three compressions.
>=20
> Correct?

Right.

> > The only tricky thing about combining them is how to handle
> > the difference in allowed ranges;  When would the right time be
> > to check it?
> >
> > Markus/Eric: Any idea?
>=20
> To have an informed opinion, I'd have to dig through the migration
> code.

The tricky part I see is validating settings/parameters;
when someone tries to set a parameter migrate_params_check gets called
and has checks like:

    if (params->has_compress_level &&
        (params->compress_level > 9)) {
        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
                   "is invalid, it should be in the range of 0 to 9");
        return false;
    }


now that's nice because you error when you set the parameter rather
than later when you try and start a migration; the downside now
though is you get more complex interaction between parameters and
capabilities - so for example if you set the multifd-compression type
parameter to 'zstd' and *then* set the single compression level
it'll be fine taking '20' as a compresison level, but if you were
to set the compression level to 20 and then set the type to 'zstd'
it might error because with zlib you can't have 20.


> Documentation of admissible range will become a bit awkward, too.
>=20
> Too many migration parameters...

Nod; which why I was trying to make it 1.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


