Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48063C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1331A2064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4JnjT6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1331A2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUnM-0006lo-VG
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isUlB-0004it-VC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isUl6-0003vC-C0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isUl6-0003se-1n
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579279567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dIHBVJvfd6VRHzx+otOXi4HOPzuYtCH5vAbuYTMvlg=;
 b=D4JnjT6QprWaA5sHh1jMEi9U7LK9S/iJEnhHPRkTEwYmbTZTaCE+5XfcI2bzODl6z/1G0K
 i9kgCcYZNNmYVWhyDliGllEYTIiEllxScxQbEfcV1pAkIoGIF9cpjvwRFAHS01LZSCvRTw
 z2gN+wBBj8ZEcexQng8g2ehOyHcjCCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-nqDHvuQrNyiaQ53e5lbKyg-1; Fri, 17 Jan 2020 11:46:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F570DB66
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 16:46:04 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E22619C7F;
 Fri, 17 Jan 2020 16:45:59 +0000 (UTC)
Date: Fri, 17 Jan 2020 16:45:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 3/5] migration: Don't wait in semaphore for thread we
 know has finished
Message-ID: <20200117164556.GO3209@work-vm>
References: <20200116154616.11569-1-quintela@redhat.com>
 <20200116154616.11569-4-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116154616.11569-4-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nqDHvuQrNyiaQ53e5lbKyg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> If p->quit is true for any channel, we know that it has finished for
> any reason.  So don't wait for it, just continue.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
>=20
> I could be convinced that the right thing to do in that case is to
> just do a break instead of a continue.  Each option has its own
> advantages/disadvantanges.
> ---
>  migration/ram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 44ca56e1ea..bc918ef28d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1118,6 +1118,12 @@ static void multifd_send_sync_main(RAMState *rs)
>          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> =20
>          trace_multifd_send_sync_main_wait(p->id);
> +        qemu_mutex_lock(&p->mutex);
> +        if (p->quit) {
> +            qemu_mutex_unlock(&p->mutex);
> +            continue;
> +        }
> +        qemu_mutex_unlock(&p->mutex);

Why is this needed/helps?
You can't depend on the p->quit happening before the=20
sem_wait, so the main thread still has to do a post on sem_sync before
the join, even with the addition of the check for p->quit.

Dave

>          qemu_sem_wait(&p->sem_sync);
>      }
>      trace_multifd_send_sync_main(multifd_send_state->packet_num);
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


