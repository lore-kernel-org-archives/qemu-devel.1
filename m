Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECDA20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcyOqrmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECDA20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKRR-0007Ee-GA
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1jKKQp-0006gf-DJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1jKKQn-00082H-Qi
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:24:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1jKKQn-00081t-L7
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585913052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTxmKauTSIAHWX18s+OIoCPo8rBaGBebrUwIxfIyC6Q=;
 b=GcyOqrmUTEznIlhkHKWP83yFdEan8qNFiBpxu9kKTMt9AkEzh0/66YZD3cw93IhoxyQ7oA
 cj/DkxBbIlCYk0dAx2yizoqNT+hqcRZKis8cp7Th8pOD7Z9gudjTAT2OmOSfdEk8nG3e43
 sprR43gwS9BNH9Vdg7qCwcUVRI1cF4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-lj7gkpwoN1uQE0wwPCJ78g-1; Fri, 03 Apr 2020 07:24:08 -0400
X-MC-Unique: lj7gkpwoN1uQE0wwPCJ78g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE38C18A6EC0;
 Fri,  3 Apr 2020 11:24:06 +0000 (UTC)
Received: from andariel.pipo.sk (unknown [10.40.195.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A420A0A9F;
 Fri,  3 Apr 2020 11:24:00 +0000 (UTC)
Date: Fri, 3 Apr 2020 13:23:58 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
Message-ID: <20200403112358.GV578401@andariel.pipo.sk>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 03, 2020 at 14:02:47 +0300, Vladimir Sementsov-Ogievskiy wrote:
> 19.12.2019 13:36, Peter Krempa wrote:
> > On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> > > Hi all!
> > >=20
> > > It's a continuation for
> > > "bitmap migration bug with -drive while block mirror runs"
> > > <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
> > >=20
> > > The problem is that bitmaps migrated to node with same node-name or
> > > blk-parent name. And currently only the latter actually work in libvi=
rt.
> > > And with mirror-top filter it doesn't work, because
> > > bdrv_get_device_or_node_name don't go through filters.
> >=20
> > I want to point out that since libvirt-5.10 we use -blockdev to
> > configure the backend of storage devices with qemu-4.2 and later. This
> > means unfortunately that the BlockBackend of the drive does not have a
> > name any more and thus the above will not work even if you make the
> > lookup code to see through filters.
>=20
> Not that this series doesn't make things worse, as it loops through named
> block backends when trying to use their name for migration. So with these
> patches applied, qemu will just work in more possible scenarios.

Okay, if that's so it's fair enough in this case.

I'm just very firmly against baking in the assumption that
node names mean the same thing accross migration, because that will
create a precedent situation and more stuff may be baked in on top of
this in the future. It seems that it has already happened though and
it's wrong. And the worst part is that it's never mentioned that this
might occur. But again, don't do that and preferrably remove the
matching of node names for bitmaps altogether until we can control it
arbitrarily.

We've also seen this already before with the backend name of memory
devices being baked in to the migration stream which creates an unwanted
dependancy.


