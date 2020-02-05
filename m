Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F4AC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D52F20730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfqXo0JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D52F20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izMmL-0000D5-Nl
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izMli-00084F-Kl
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izMlg-0006C6-OO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:39:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izMlg-0005zj-GE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580917147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OL6O1YdpQB8bkIPY414fF3F9yVByHiJv3Yz0944MGM=;
 b=SfqXo0JEXOKfiocavGOQBqzQO63lZGZW4qstLZYdCo0MxxOax1RV6zTrrBFB+KK8M6BbDH
 aywUwGU3uH3kpy2mXSDX1pxRg9/TIsDJ6HyJohYFjKQlYwlfPGJae/plbAdlPa86wZGlaD
 tfw8PTeHxOc3MVLx8BfP3GJsuetdttI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-d6WxjyM2MBm4RGBDzo7iwA-1; Wed, 05 Feb 2020 10:39:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A51D1005513;
 Wed,  5 Feb 2020 15:39:02 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA395DA7B;
 Wed,  5 Feb 2020 15:39:00 +0000 (UTC)
Date: Wed, 5 Feb 2020 16:38:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
Message-ID: <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200130214431.333510-10-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: d6WxjyM2MBm4RGBDzo7iwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
> We will need this to verify that Quorum can let one of its children be
> replaced without breaking anything else.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/quorum.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/block/quorum.c b/block/quorum.c
> index 59cd524502..6a7224c9e4 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
> =20
>  typedef struct QuorumChild {
>      BdrvChild *child;
> +
> +    /*
> +     * If set, check whether this node can be replaced without any
> +     * other parent noticing: Unshare CONSISTENT_READ, and take the
> +     * WRITE permission.
> +     */
> +    bool to_be_replaced;

I don't understand these permission changes. How does (preparing for)
detaching a node from quorum make its content invalid? And why do we
suddenly need WRITE permissions even if the quorum node is only used
read-only?

The comment is a bit unclear, too. "check whether" implies that both
outcomes could be true, but it doesn't say what happens in either case.
Is this really "make sure that"?

Kevin


