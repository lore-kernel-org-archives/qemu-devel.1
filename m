Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F4C2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7D720719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiYdxNYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7D720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLoGo-00017Y-RG
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 09:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLoFv-0008Jk-Bh
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLoFt-00084D-P1
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:27:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLoFt-00083T-Jy
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586266024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2Uc7ewpjtppBBz87bC331tk1paBY044CtA9BzWkIjc=;
 b=aiYdxNYmE94lzd258ZgMFsVgkV1sV5LUL/0/CIgoQ1U8dV3hKDMUlTjpSimli4QdEW6VZm
 1Nwx3JvyWz/CLUa60GxCCZitXhyPdzJeVPnMaDLOVDvXMpl0sx2h5oSKNJLoL4tjZca4vn
 rWRqc6a8oxp2sKAD7rmDkfVYt0KX6bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-flHmIacPPgu0P9NMzZIyDw-1; Tue, 07 Apr 2020 09:27:02 -0400
X-MC-Unique: flHmIacPPgu0P9NMzZIyDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C741005510;
 Tue,  7 Apr 2020 13:27:00 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-253.ams2.redhat.com [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF88260BE1;
 Tue,  7 Apr 2020 13:26:49 +0000 (UTC)
Date: Tue, 7 Apr 2020 15:26:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Reiter <s.reiter@proxmox.com>
Subject: Re: [PATCH for-5.0 v5 1/3] job: take each job's lock individually in
 job_txn_apply
Message-ID: <20200407132648.GE7695@linux.fritz.box>
References: <20200407115651.69472-1-s.reiter@proxmox.com>
 <20200407115651.69472-2-s.reiter@proxmox.com>
MIME-Version: 1.0
In-Reply-To: <20200407115651.69472-2-s.reiter@proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, t.lamprecht@proxmox.com, slp@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.04.2020 um 13:56 hat Stefan Reiter geschrieben:
> All callers of job_txn_apply hold a single job's lock, but different
> jobs within a transaction can have different contexts, thus we need to
> lock each one individually before applying the callback function.
>=20
> Similar to job_completed_txn_abort this also requires releasing the
> caller's context before and reacquiring it after to avoid recursive
> locks which might break AIO_WAIT_WHILE in the callback. This is safe, sin=
ce
> existing code would already have to take this into account, lest
> job_completed_txn_abort might have broken.
>=20
> This also brings to light a different issue: When a callback function in
> job_txn_apply moves it's job to a different AIO context, callers will
> try to release the wrong lock (now that we re-acquire the lock
> correctly, previously it would just continue with the old lock, leaving
> the job unlocked for the rest of the return path). Fix this by not cachin=
g
> the job's context.
>=20
> This is only necessary for qmp_block_job_finalize, qmp_job_finalize and
> job_exit, since everyone else calls through job_exit.

job_cancel() doesn't go through job_exit(). It calls job_completed()
onyl for jobs that are not started yet, and it sets job->cancelled, so
that job_completed() takes the job_completed_txn_abort() path, which is
not changed by this patch.

I _think_ this is okay, but it shows that the whole job completion
infrastructure is becoming way too complicated. We're late for 5.0, so
let's take this patch for now, but I think we should use the 5.1 release
cycle to clean up this mess a bit.

> One test needed adapting, since it calls job_finalize directly, so it
> manually needs to acquire the correct context.
>=20
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>

Kevin


