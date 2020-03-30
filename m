Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A49C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B882120733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYnFmus8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B882120733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIohP-0003ui-RM
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 03:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIoge-0003PM-T7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIogc-0005O7-Ot
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:18:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIogc-0005NO-Iv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585552697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zK0nQxaVFmfonIppuHaseEGtO/9VENvsnKIbieDEfE=;
 b=EYnFmus87P7ATglc9BcOccbzxx0SRpH4p2pm2IKgf7AutZ5t0M7dYfMrUqSH4nIFrcx4Ni
 HZhXAEH/Wrdj5cyeryIhVKwsf9A7z8R3F6BtIcLyeALcqdss/kIaSca71HaPcpJfjuOR3v
 NttI3St7J5GTWO20/Bo5N7gQGLUjcAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-UDJuIzWeMX2ILyOFVFpOKw-1; Mon, 30 Mar 2020 03:18:15 -0400
X-MC-Unique: UDJuIzWeMX2ILyOFVFpOKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E71261005514;
 Mon, 30 Mar 2020 07:18:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E98019756;
 Mon, 30 Mar 2020 07:18:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87B6F11385E2; Mon, 30 Mar 2020 09:18:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2] migration: use "" instead of (null) for tls-authz
References: <0a9dc2fcb78da13eb326992384bc4e57de83d9f9.1584797648.git.maozhongyi@cmss.chinamobile.com>
 <20200324100823.GB2645@work-vm>
Date: Mon, 30 Mar 2020 09:18:08 +0200
In-Reply-To: <20200324100823.GB2645@work-vm> (David Alan Gilbert's message of
 "Tue, 24 Mar 2020 10:08:23 +0000")
Message-ID: <875zemz4y7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
>> run:
>> (qemu) info migrate_parameters
>> announce-initial: 50 ms
>> ...
>> announce-max: 550 ms
>> multifd-compression: none
>> xbzrle-cache-size: 4194304
>> max-postcopy-bandwidth: 0
>>  tls-authz: '(null)'
>>=20
>> Migration parameter 'tls-authz' is used to provide the QOM ID
>> of a QAuthZ subclass instance that provides the access control
>> check, default is NULL. But the empty string is not a valid
>> object ID, so use "" instead of the default. Although it will
>> fail when lookup an object with ID "", it is harmless, just
>> consistent with tls_creds.
>
> Yes, it's probably the best we can do given Dan's explanation that
> we can't change tls_authz to be non-null.

As I explained in Message-ID: <878sjv11xm.fsf@dusky.pond.sub.org>, this
is actually a crash bug on some systems.  The commit message neglects to
mention that.  Too late to fix now.  Next time :)

>> Also fixed the bad indentation on the last line.
>>=20
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>  migration/migration.c | 3 ++-
>>  monitor/hmp-cmds.c    | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index c1d88ace7f..b060153ef7 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -790,7 +790,8 @@ MigrationParameters *qmp_query_migrate_parameters(Er=
ror **errp)
>>      params->has_tls_hostname =3D true;
>>      params->tls_hostname =3D g_strdup(s->parameters.tls_hostname);
>>      params->has_tls_authz =3D true;
>> -    params->tls_authz =3D g_strdup(s->parameters.tls_authz);
>> +    params->tls_authz =3D s->parameters.tls_authz ? \
>> +                        g_strdup(s->parameters.tls_authz) : g_strdup(""=
);
>
> The \ is unneeded; this isn't a macro; it's also a little shorter to do
> it as:
>     params->tls_authz =3D g_strdup(s->parameters.tls_authz ?
>                                  s->parameters.tls_authz : "");

Even shorter:

      params->tls_authz =3D g_strdup(s->parameters.tls_authz ?: "");

?: is a GNU C extension.  We use it all over the place.

Just FYI.  I'm *not* asking for the code to be changed.


