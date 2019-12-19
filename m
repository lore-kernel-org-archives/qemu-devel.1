Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB02AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956EA21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTfJXR5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956EA21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtBu-0002iP-L0
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1ihtB3-0002Cr-5U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1ihtB1-0004fh-Ry
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:37:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1ihtB1-0004bK-Lm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576751822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GxWRsMAGxSYQBDlubMsUyZyKi3tB62KASjv84VCzVs=;
 b=aTfJXR5ydPh4UZbtX/IpHX6M1bTAaAx9jaRJ5xoucBn/sX3u9JAEzPgb7QJPED+TAC0j/x
 h8xU0kTpQYvFAU1hxBZfMWaFmPp4Mv1HsQTgFpvqcdPzIMAWxqddIkz167NoqZrYFcM5p+
 zsfgy//NeHcfwfBgQO0CkW1lR1768Bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-CUvZJHmeOK6kORC1mHIlmQ-1; Thu, 19 Dec 2019 05:36:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 397E52EDA;
 Thu, 19 Dec 2019 10:36:47 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-205-6.brq.redhat.com [10.40.205.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FCA419C5B;
 Thu, 19 Dec 2019 10:36:41 +0000 (UTC)
Date: Thu, 19 Dec 2019 11:36:38 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
Message-ID: <20191219103638.GJ4914@andariel.pipo.sk>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191219085106.22309-1-vsementsov@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CUvZJHmeOK6kORC1mHIlmQ-1
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> It's a continuation for
> "bitmap migration bug with -drive while block mirror runs"
> <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
>=20
> The problem is that bitmaps migrated to node with same node-name or
> blk-parent name. And currently only the latter actually work in libvirt.
> And with mirror-top filter it doesn't work, because
> bdrv_get_device_or_node_name don't go through filters.

I want to point out that since libvirt-5.10 we use -blockdev to
configure the backend of storage devices with qemu-4.2 and later. This
means unfortunately that the BlockBackend of the drive does not have a
name any more and thus the above will not work even if you make the
lookup code to see through filters.

As I've pointed out separately node-names are not good idea to use for
matching either as they can be distinct on the destination of migration.

Having same node names for images during migration was not documented as
a requiremend and even if it was the case when the mirror job is used
the destination is a different image and thus having a different node
name is expected.

Since it's not documented, expect the same situation as with
autogenerated nodenames, the destination may have different node-names
and the same node-name may refer to a different image. Implicit matching
based on node-names is thus impossible.


