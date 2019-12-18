Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29548C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D253C2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dqnds7AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D253C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcp5-00044A-2l
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihciY-0003tv-HJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihciW-0006KF-9y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:02:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihciW-0006GE-40
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576688551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sUIiF8RXKAmXElKXsYMz6l1XKsZ9oPBccLr2uVaaQo=;
 b=Dqnds7ASquSoIUqrPiEKh3CySCi/5nTThlnBXbsImGkfE7O21ooAlyDCM+B6LJb3Ra4Igg
 wEn8PLIipAaTfFMy1kazzsMrObGdia0n5iIise/cTfJEHrWymnM2USN1V+5l5P9sUPMOBF
 sPS32pGboJUEe+RZGTy0CydQeRSgf6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Yz28eIzmOciRrgkuJG3PVw-1; Wed, 18 Dec 2019 12:02:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11B76801E6C;
 Wed, 18 Dec 2019 17:02:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12EC568886;
 Wed, 18 Dec 2019 17:02:25 +0000 (UTC)
Date: Wed, 18 Dec 2019 18:02:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH 1/3] block: Activate recursively even for already active
 nodes
Message-ID: <20191218170224.GG4632@linux.fritz.box>
References: <20191217145939.5537-1-kwolf@redhat.com>
 <20191217145939.5537-2-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191217145939.5537-2-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Yz28eIzmOciRrgkuJG3PVw-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.12.2019 um 15:59 hat Kevin Wolf geschrieben:
> bdrv_invalidate_cache_all() assumes that all nodes in a given subtree
> are either active or inactive when it starts. Therefore, as soon as it
> arrives at an already active node, it stops.
>=20
> However, this assumption is wrong. For example, it's possible to take a
> snapshot of an inactive node, which results in an active overlay over an
> inactive backing file. The active overlay is probably also the root node
> of an inactive BlockBackend (blk->disable_perm =3D=3D true).
>=20
> In this case, bdrv_invalidate_cache_all() does not need to do anything
> to activate the overlay node, but it still needs to recurse into the
> children and the parents to make sure that after returning success,
> really everything is activated.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Actually:
Cc: qemu-stable@nongnu.org


