Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32D2C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B01D206B9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OM8egRzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B01D206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP2KS-0008TF-No
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 07:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jP2Jj-0007yL-6u
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jP2Ji-0003zl-75
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:04:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jP2Ji-0003zP-3e
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587035061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nqAwgssgXH6u6DNW3UB8QUX9NjefeiBTvfYsSgDeX0=;
 b=OM8egRzr/wuidoV2hrXqI3ZOxhq2gXy0c1qI2aBhi9FtJ+sfwMOPu8XoNs484cS5Ao8FJF
 T0RCtqSRNAZ0qgQbG5QYxlGh9gZnm7cfgJF5bb1lXspwgDGgYiV/1kPaHbNQND0alxx2YP
 0UCv1bSiLUzQveIh7MaeBKtJRhHxUn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-gy79SM7GOQ-qFG2Z-DSmLg-1; Thu, 16 Apr 2020 07:04:19 -0400
X-MC-Unique: gy79SM7GOQ-qFG2Z-DSmLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88D2D8017FE;
 Thu, 16 Apr 2020 11:04:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-109.ams2.redhat.com [10.36.113.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33AE75C1D6;
 Thu, 16 Apr 2020 11:04:09 +0000 (UTC)
Date: Thu, 16 Apr 2020 13:04:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: qemu_coroutine_yield switches thread?
Message-ID: <20200416110408.GB6014@linux.fritz.box>
References: <5dde1955-49db-2626-1fa5-332e4d7a0928@proxmox.com>
 <20200416082849.GA6014@linux.fritz.box>
 <1548825935.27.1587031774908@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <1548825935.27.1587031774908@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: vsementsov@virtuozzo.com, slp@redhat.com,
 Stefan Reiter <s.reiter@proxmox.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.04.2020 um 12:09 hat Dietmar Maurer geschrieben:
> > > quick question: Can a resume from a qemu_coroutine_yield happen in a
> > > different thread?
> > >=20
> > > Well, it can, since I'm seeing it happen, but is that okay or a bug?
> >=20
> > Yes, it can happen. At least for devices like IDE where a request is
> > started during a vmexit (MMIO or I/O port write), the coroutine will
> > usually begin its life in the vcpu thread and then move to the main loo=
p
> > thread.
> >=20
> > This is not a problem because the vcpu thread holds the BQL while
> > running the request coroutine.
>=20
> Isn't that a problem when using QemuRecMutex, for example:
>=20
> qemu_rec_mutex_lock(lock)
> ...
> qemu_coroutine_yield() // wait for something
> // we are now inside a different thread
> qemu_rec_mutex_unlock(lock) // Crash - wrong thread!!

Acquiring a lock (other than CoMutex etc.) in a coroutine would be wrong
even if the coroutine stays in the same thread because acquiring the
lock can block, and the coroutine must yield in that case instead of
blocking. Coroutines must use the the coroutine locking primitives from
qemu/coroutine.h.

Kevin


