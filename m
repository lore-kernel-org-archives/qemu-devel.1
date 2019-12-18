Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742E7C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4612176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHCFhsI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4612176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcaJ-0004RD-3p
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ihcZD-0003QW-6d
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ihcZA-00021U-3C
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:52:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ihcZ8-0001yV-Ig
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576687968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9vpbT6YvgH1acpwTohzA5ljDFqLy76z/AM4YF9pzGM=;
 b=IHCFhsI/+s8Bz+Wk2BXAkMmTwA0PztBFlNCPiBuQHya0qagyEqiVNh7I7bYSwNAMvQyBNT
 K/C8CHg/niVNscqToQZDCqlL1e2MHySICNIHpe6VP579/91MYi9jilNkvWY6CetzRkt8lD
 j/URFKcCjVOaEhtVeTrKrrQeODTwxIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384--TgdsB7WO3Ohnp86_oBGTQ-1; Wed, 18 Dec 2019 11:52:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D3A18C35C4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 16:52:46 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A71260BC7;
 Wed, 18 Dec 2019 16:52:45 +0000 (UTC)
Date: Wed, 18 Dec 2019 16:52:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, quintela@redhat.com
Subject: Re: [PATCH] runstate: ignore finishmigrate -> prelaunch transition
Message-ID: <20191218165242.GL3707@work-vm>
References: <20191129115132.285988-1-lvivier@redhat.com>
 <20191206195230.GJ2878@work-vm>
 <b782071a-c522-0e50-ed49-152964fe6bd4@redhat.com>
 <e0557fa4-e5b3-3f83-e002-b22d81e7561f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e0557fa4-e5b3-3f83-e002-b22d81e7561f@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: -TgdsB7WO3Ohnp86_oBGTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> Ping?

Juan says he's doing a migration pull soon - this seems like a good one
for it.

Dave

> Thanks,
> Laurent
>=20
> On 12/12/2019 20:40, Laurent Vivier wrote:
> > On 06/12/2019 20:52, Dr. David Alan Gilbert wrote:
> >> * Laurent Vivier (lvivier@redhat.com) wrote:
> >>> Commit 1bd71dce4bf2 tries to prevent a finishmigrate -> prelaunch
> >>> transition by exiting at the beginning of the main_loop_should_exit()
> >>> function if the state is already finishmigrate.
> >>>
> >>> As the finishmigrate state is set in the migration thread it can
> >>> happen concurrently to the function. The migration thread and the
> >>> function are normally protected by the iothread mutex and thus the
> >>> state should no evolve between the start of the function and its end.
> >>>
> >>> Unfortunately during the function life the lock is released by
> >>> pause_all_vcpus() just before the point we need to be sure we are
> >>> not in finishmigrate state and if the migration thread is waiting
> >>> for the lock it will take the opportunity to change the state
> >>> to finishmigrate.
> >>
> >> Ewww.
> >> I hate those short wakeups for pause_all_vcpus; I'm sure there are loa=
ds
> >> more corners that break.
> >>
> >> Still, I _think_ this is an improvement, so:
> >>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>
> >=20
> > Who volunteers to take this in his queue?
> >=20
> > Thanks,
> > Laurent
> >=20
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


