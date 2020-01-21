Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EACC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22062253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIB7cP3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22062253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrUd-0008Tf-Sm
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itrQL-0002ob-P9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itrQH-0005wz-4d
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:10:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itrQG-0005wj-RB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579605016;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dlx2r4Lt9OwxlG7hdFBMuPSB6sH7+RtiZEcvmhgHU+U=;
 b=PIB7cP3oJpsk8wbBPq97q4um2lBIHfdvMT3XHHPSFP5GiZh2ey+iuR8GmhYZ+gwl43BYoA
 KvbUMke57yBY86SWeFpdMLtLj0p9kj4DjOjm8+oom9/zIFqMJ3C6qKIkZlvVE7tBzq/u7b
 ZiDRktLUxeJTaCBAmog/FzuOmX/ViBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-p51x5Ld-NleVafUuIC0Ezw-1; Tue, 21 Jan 2020 06:10:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD9218A6EC1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 11:10:14 +0000 (UTC)
Received: from redhat.com (ovpn-116-23.ams2.redhat.com [10.36.116.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D525360BE0;
 Tue, 21 Jan 2020 11:10:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 3/5] migration: Don't wait in semaphore for thread we
 know has finished
In-Reply-To: <20200117164556.GO3209@work-vm> (David Alan Gilbert's message of
 "Fri, 17 Jan 2020 16:45:56 +0000")
References: <20200116154616.11569-1-quintela@redhat.com>
 <20200116154616.11569-4-quintela@redhat.com>
 <20200117164556.GO3209@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 21 Jan 2020 12:10:11 +0100
Message-ID: <87sgk9gj58.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: p51x5Ld-NleVafUuIC0Ezw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
>> If p->quit is true for any channel, we know that it has finished for
>> any reason.  So don't wait for it, just continue.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20
>> ---
>>=20
>> I could be convinced that the right thing to do in that case is to
>> just do a break instead of a continue.  Each option has its own
>> advantages/disadvantanges.
>> ---
>>  migration/ram.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 44ca56e1ea..bc918ef28d 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1118,6 +1118,12 @@ static void multifd_send_sync_main(RAMState *rs)
>>          MultiFDSendParams *p =3D &multifd_send_state->params[i];
>> =20
>>          trace_multifd_send_sync_main_wait(p->id);
>> +        qemu_mutex_lock(&p->mutex);
>> +        if (p->quit) {
>> +            qemu_mutex_unlock(&p->mutex);
>> +            continue;
>> +        }
>> +        qemu_mutex_unlock(&p->mutex);
>
> Why is this needed/helps?
> You can't depend on the p->quit happening before the=20
> sem_wait, so the main thread still has to do a post on sem_sync before
> the join, even with the addition of the check for p->quit.

if we have asked the thread to quit, it is inside posibility that it has
already quit, so it is not going to be able to do the ->post() for this
sem.

if ->quit =3D=3D true, then we know that we are exiting.  On _normal_ exit,
we know that everything is ok.  On cancel/error, we don't really know,
it deppends how lucky we are.

Later, Juan.


