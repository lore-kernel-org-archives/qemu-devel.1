Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9599AC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6146A208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL9cpSHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6146A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopaQ-0004vi-Av
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ioo4q-0005v1-Bn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ioo4p-00051U-3m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:35:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ioo4o-00051M-Ve
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578400514;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfAFBSh93+JejU0xgyl2HdSWxhJF4n51sjpXFhyPifc=;
 b=FL9cpSHbb7jUL4NDV6wxYnNCL/QgBeKj+ygWw74JYfLmOfBWoMr6F49NSP1Ea4+zR1nJq0
 iptwqAJ33gGEvU9i+UCGgAbkxphzOt9yuabPuiQ9/3EK6xaqsOm9XE84VvlZGACFWU2ew2
 l6rb/tWrft9UoO/CQhdOIBa6AL1t4Y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-cKPO4ZsQPGGhoHijBDuN-Q-1; Tue, 07 Jan 2020 07:35:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39117911F0
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 12:35:12 +0000 (UTC)
Received: from redhat.com (ovpn-116-141.ams2.redhat.com [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 914C15D9CA;
 Tue,  7 Jan 2020 12:35:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 04/10] migration: Make multifd_save_setup() get an
 Error parameter
In-Reply-To: <20200103164643.GL3804@work-vm> (David Alan Gilbert's message of
 "Fri, 3 Jan 2020 16:46:43 +0000")
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-5-quintela@redhat.com>
 <20200103164643.GL3804@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 07 Jan 2020 13:35:07 +0100
Message-ID: <877e23qwas.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cKPO4ZsQPGGhoHijBDuN-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration.c | 2 +-
>>  migration/ram.c       | 2 +-
>>  migration/ram.h       | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index e7f707e033..5a56bd0c91 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3400,7 +3400,7 @@ void migrate_fd_connect(MigrationState *s, Error *=
error_in)
>>          return;
>>      }
>> =20
>> -    if (multifd_save_setup() !=3D 0) {
>> +    if (multifd_save_setup(&error_in) !=3D 0) {
>
> I'm not sure that's right.  I think the *error passed into
> migration_channel_connect, and then onto migrate_fd_connect is an
> indication that an error has happened, not a place you can put
> an error pointer.   Note how migration_channel_connect
> frees it after the migrate_fd_connect call, it doesn't report it.


changed this to:

    if (multifd_save_setup(&local_err) !=3D 0) {
       error_report_err(local_err);

Thanks, Juan.


