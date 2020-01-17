Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EDC33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C998B2082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erS7hEzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C998B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWTw-0002GH-9e
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1isWT4-0001BO-3M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1isWSx-0005iL-OF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:35:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1isWSx-0005ho-Ai
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579286130;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tst/jx3I9FtPMCaVUBWMFd6eyo1esdQoo87pkOTPS/I=;
 b=erS7hEzFYCcBNsvqk0+vjAo484ewLtyXS+2JPFacb+MXd1UIvn4mwXrWUNekP9QeltK5P5
 Gcl87W7dhA5hEGQukwi15iTvWnJscHMKfrdis8LE9wfOlqkWwEQJ+RK04RqqoiE1OjkUEG
 kdH4lFymbr+ByVSW/QRcpymzGEZrkRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-WltaX3SlO66XpJdqh3sm9w-1; Fri, 17 Jan 2020 13:35:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 151A314E8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 18:35:28 +0000 (UTC)
Received: from redhat.com (ovpn-116-71.ams2.redhat.com [10.36.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85B8C1BC6D;
 Fri, 17 Jan 2020 18:35:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 2/5] migration: Create MigrationState active field
In-Reply-To: <20200117162612.GN3209@work-vm> (David Alan Gilbert's message of
 "Fri, 17 Jan 2020 16:26:12 +0000")
References: <20200116154616.11569-1-quintela@redhat.com>
 <20200116154616.11569-3-quintela@redhat.com>
 <20200117162612.GN3209@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 17 Jan 2020 19:35:25 +0100
Message-ID: <87k15q2aoi.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WltaX3SlO66XpJdqh3sm9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Right now, there is no easy way to dectect if we have already
>> cancelled/finished/failed a migration.  This field is setup to true
>> when we start a migration, and it is set to false as soon as we stop
>> it.
>>=20
>> It fixes a real bug, in ram_save_iterate() we call functions that
>> wrote to the channel even if we know that migration has stopped for
>> any reason.  This gives problems with multifd because we need to
>> synchronize various semoaphores that we don't want to take.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Why can't you use migration_is_active() in the ram.c case?
> My preference would be just to stick with something derived
> from the state rather than tacking another state bit on.

My plan was to go the other way around.
We need to use the state with atomics, I wanted a single way of deciding
if we are/or not in the middle of a migration.  Just now it is too
confusing on my opinion.

>> ---
>>  migration/migration.c | 5 +++++
>>  migration/migration.h | 5 +++++
>>  migration/ram.c       | 2 +-
>>  migration/savevm.c    | 2 ++
>>  4 files changed, 13 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 990bff00c0..60bc8710b6 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1583,6 +1583,8 @@ static void migrate_fd_cancel(MigrationState *s)
>>      QEMUFile *f =3D migrate_get_current()->to_dst_file;
>>      trace_migrate_fd_cancel();
>> =20
>> +    s->active =3D false;
>> +
>>      if (s->rp_state.from_dst_file) {
>>          /* shutdown the rp socket, so causing the rp thread to shutdown=
 */
>>          qemu_file_shutdown(s->rp_state.from_dst_file);
>> @@ -2834,6 +2836,7 @@ static void migration_completion(MigrationState *s=
)
>>      }
>> =20
>>      if (!migrate_colo_enabled()) {
>> +        s->active =3D false;
>>          migrate_set_state(&s->state, current_active_state,
>>                            MIGRATION_STATUS_COMPLETED);
>
> You've not always got these two the same way around - i.e. do you change
> the state first or do you set the active state first?  I think it needs
> to be consistent.

Ok.

Thanks, Juan.


