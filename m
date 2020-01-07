Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F41C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2CB2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e32tgti+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2CB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq1S-0006IG-Hz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iooT4-0006zN-7J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iooT2-0004uV-M8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:00:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iooT2-0004tg-Hq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578402015;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eo6Au6AL9qxIDF7nfivXVIB4aPc72kysfxZ9eW992E=;
 b=e32tgti+QuMrFikKjdthxJck/gDwtUZvTxSvm21lK6SuHdVnpxp4VdeIulaRkuYBFX3GXh
 de1/4PDGmVZZOVfboKlgAwPWFsSd5bQ5GgIRXhvydqgPMbcJd3wzDNcBa/lc494K1l/JSr
 bA2j8kIM09Pj5XKrDf0ihERFvVN2Uc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-bq6Vmnb_MKK3QZaBbpY9-Q-1; Tue, 07 Jan 2020 08:00:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E0B9100551A
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:00:12 +0000 (UTC)
Received: from redhat.com (ovpn-116-141.ams2.redhat.com [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A057F383;
 Tue,  7 Jan 2020 13:00:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 05/10] migration: Make multifd_load_setup() get an
 Error parameter
In-Reply-To: <20200103172222.GP3804@work-vm> (David Alan Gilbert's message of
 "Fri, 3 Jan 2020 17:22:22 +0000")
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-6-quintela@redhat.com>
 <20200103172222.GP3804@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 07 Jan 2020 14:00:06 +0100
Message-ID: <8736crqv55.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bq6Vmnb_MKK3QZaBbpY9-Q-1
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We need to change the full chain to pass the Error parameter.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration.c | 10 +++++-----
>>  migration/migration.h |  2 +-
>>  migration/ram.c       |  2 +-
>>  migration/ram.h       |  2 +-
>>  migration/rdma.c      |  2 +-
>>  5 files changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5a56bd0c91..cf6cec5fb6 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -518,11 +518,11 @@ fail:
>>      exit(EXIT_FAILURE);
>>  }
>> =20
>> -static void migration_incoming_setup(QEMUFile *f)
>> +static void migration_incoming_setup(QEMUFile *f, Error **errp)
>>  {
>>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>> =20
>> -    if (multifd_load_setup() !=3D 0) {
>> +    if (multifd_load_setup(errp) !=3D 0) {
>>          /* We haven't been able to create multifd threads
>>             nothing better to do */
>
> But if you're taking an errp and the load fails, don't you want to
> report the error before you exit? (with an error_get_pretty or
> something?)

error_report_err() that is.

>
>>          exit(EXIT_FAILURE);
>> @@ -572,13 +572,13 @@ static bool postcopy_try_recover(QEMUFile *f)
>>      return false;
>>  }
>> =20
>> -void migration_fd_process_incoming(QEMUFile *f)
>> +void migration_fd_process_incoming(QEMUFile *f, Error **errp)
>>  {
>>      if (postcopy_try_recover(f)) {
>>          return;
>>      }
>> =20
>> -    migration_incoming_setup(f);
>> +    migration_incoming_setup(f, errp);
>>      migration_incoming_process();
>
> and if you're making incoming_setup able to fail, don't you need
> to.... hmm, skip the incoming_process?

Changing it to test for errors, thanks.

>>  }
>> =20
>> @@ -596,7 +596,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc,=
 Error **errp)
>>              return;
>>          }
>> =20
>> -        migration_incoming_setup(f);
>> +        migration_incoming_setup(f, errp);
>
> Don't you need to make that use a local_err and propagate, like in the
> other half of the if/else?

Changed the whole business.  It appears that each time that I use an
Error ** I have to relearn how to use it.  Changed all places to use a
local error and propagate/error_report_err() as apropiate.

>>      rdma->migration_started_on_destination =3D 1;
>> -    migration_fd_process_incoming(f);
>> +    migration_fd_process_incoming(f, errp);
>
> Heck, the errp handling in rdma_accept_incoming_migration is very very
> broken; I don't see how the errp ever gets reported or freed.
> (But that's an existing problem)

Leaving this for next series.

Thanks, Juan.


