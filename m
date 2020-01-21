Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2203C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB65A2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArnLmKYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB65A2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrSZ-00059P-CS
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itrOh-0000Dt-95
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itrOd-0004WW-D7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:08:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itrOd-0004WN-9U
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579604914;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwIrFTaxN9a2qTlMPBKUIWO6noCAq3KUlr8hvzIoAS8=;
 b=ArnLmKYLjALbHmj9wdYdcwBF1ALNLbRW9VAsatAiogdvjakURzpguOH3JHIlvWg54XZOsr
 bI8N/OFPg1y5D4r0UkQAqpgXw56TKmcHMXejopEfHimNP/WQ+5L48k4ir4NJJUlS8lD5Hd
 1Vp4Elskab6e0xc9tkvzSqKSPzpcLCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-Dp6j7vcnPbW7mLqkhJpJOA-1; Tue, 21 Jan 2020 06:08:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C025D800D4C
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 11:08:30 +0000 (UTC)
Received: from redhat.com (ovpn-116-23.ams2.redhat.com [10.36.116.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E7460BE0;
 Tue, 21 Jan 2020 11:08:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 2/5] migration: Create MigrationState active field
In-Reply-To: <20200117162612.GN3209@work-vm> (David Alan Gilbert's message of
 "Fri, 17 Jan 2020 16:26:12 +0000")
References: <20200116154616.11569-1-quintela@redhat.com>
 <20200116154616.11569-3-quintela@redhat.com>
 <20200117162612.GN3209@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 21 Jan 2020 12:08:27 +0100
Message-ID: <87wo9lgj84.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Dp6j7vcnPbW7mLqkhJpJOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Trying to redo this as something more reasonable.
Problem that I was trying to do is being sure that we know in what state
we are.  Real migration states are:

- NOT_STARTED: We haven't even started
- SETUP: We have started with local stuff but haven't yet transmitted
  anything
- ACTIVE: Migration is donig well, we are trasnmitting data
- FINISHED: We have finished migration (COMPLETED/FAILED/CANCELLED/CANCELLI=
NG)
- COLO: Yet a completelly different can of worms

To make things even more interesting, we export ->state, so code can do
whatever they want with that variable.

What do we need in a lot of places:
- migration_is_running() (i.e. channel is still open).

And we go left and right to be sure what is going on.

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

As said, I will try to move that to inside migrate_set_state()

thanks, Juan.


