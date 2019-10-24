Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C46CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14D921655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/9+iNCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbgi-0008IK-Qr
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNb7J-0003PX-Ad
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNb7H-00049u-Ui
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:17:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNb7H-00049I-Pf
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571915839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+RY8lFTGAdjrHRcz99VTIPSdolgM9nvlWB3O/PEDaU=;
 b=B/9+iNCyvDOmS2sXZrv0zTfbjNYFvUSNXu9SKGt2Xd9HBEt4KCblqrlA5SdgkSY08asivB
 ygKI8e9O1YOS56pjCoyAUzT6ja73l837GRt9KrR6CogL3EBloVfTEvBdTfJK9ZpBUhF2oO
 +pPW7UScI1HDM87oy+6h27/2HDD0Z08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-oH_Vn_SqOkKDblib7NSMRg-1; Thu, 24 Oct 2019 07:17:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 999E0100550E;
 Thu, 24 Oct 2019 11:17:14 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 254495D6D0;
 Thu, 24 Oct 2019 11:17:11 +0000 (UTC)
Date: Thu, 24 Oct 2019 13:17:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/3] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Message-ID: <20191024111710.GC6200@linux.fritz.box>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-4-kwolf@redhat.com>
 <3cfee2ed-cebb-44ef-82ce-77a77c1a9e6a@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <3cfee2ed-cebb-44ef-82ce-77a77c1a9e6a@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: oH_Vn_SqOkKDblib7NSMRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.10.2019 um 12:46 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 23.10.2019 18:26, Kevin Wolf wrote:
> > qcow2_detect_metadata_preallocation() calls qcow2_get_refcount() which
> > requires s->lock to be taken to protect its accesses to the refcount
> > table and refcount blocks. However, nothing in this code path actually
> > took the lock. This could cause the same cache entry to be used by two
> > requests at the same time, for different tables at different offsets,
> > resulting in image corruption.
> >=20
> > As it would be preferable to base the detection on consistent data (eve=
n
> > though it's just heuristics), let's take the lock not only around the
> > qcow2_get_refcount() calls, but around the whole function.
> >=20
> > This patch takes the lock in qcow2_co_block_status() earlier and assert=
s
> > in qcow2_detect_metadata_preallocation() that we hold the lock.
> >=20
> > Fixes: 69f47505ee66afaa513305de0c1895a224e52c45
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Michael Weiser <michael@weiser.dinsnail.net>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
> Oh, I'm very sorry. I was going to backport this patch, and found that it=
's
> fixed in our downstream long ago, even before last upstream version patch=
 sent :(

Seriously? Is your downstream QEMU so divergent from upstream that you
wouldn't notice something like this? I think you really have to improve
something there.

I mean, we have a serious data corruptor in the 4.1 release and I wasted
days to debug this, and you've been sitting on a fix for months without
telling anyone? This isn't a memory leak or something, this kills
people's images. It's eating their data.

Modifying an image format driver requires utmost care and I think I'll
try to make sure to allow only few qcow2 changes per release in the
future. Too many changes were made in too short time, and with too
little care, and there are even more qcow2 patches pending. Please check
whether these series actually match your downstream code. Anyway, we'll
tread very carefully now with the pending patches, even if it means
delaying them for another release or two. Stability is way more
important for an image format driver than new features and
optimisations.

Do whatever you need to fix your downstream process, but seriously, this
must not ever happen again.

Kevin


