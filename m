Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D74EC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E944D206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUICkqN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E944D206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igouA-0003cw-5q
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igoZ1-0000RF-I5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igoZ0-0001lC-CP
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:29:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igoZ0-0001kw-9C
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576495761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkS0ir68nO3ZHJjNBRRWqbKDAZvrsiWoXKxJzEcVovs=;
 b=PUICkqN2ixRL7XtUd81qfZsnH6fY08s9lrMIs1qEApQcs7Mm5Lf6TJcnQu26zAFtMppSWp
 nL9FjrYQWnwgbb31xQAfgZQyr/+h05OBAysrNN4JuRbYtL/Tz21V7MY5lu8GT7co/o3bmy
 A6rBxLIYq2d5NkNpvrkW7DwMl21cCfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-2cGk4tw3NCCB3Cy-CWrDrA-1; Mon, 16 Dec 2019 06:29:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E07F1800D7B;
 Mon, 16 Dec 2019 11:29:19 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFFC461372;
 Mon, 16 Dec 2019 11:29:15 +0000 (UTC)
Date: Mon, 16 Dec 2019 12:29:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 4/4] blockdev: honor bdrv_try_set_aio_context()
 context requirements
Message-ID: <20191216112914.GB6610@linux.fritz.box>
References: <20191128104129.250206-1-slp@redhat.com>
 <20191128104129.250206-5-slp@redhat.com>
 <20191209160601.GB6715@linux.fritz.box>
 <7ea304ab-0a4b-8c0a-ae9f-2f6501198840@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7ea304ab-0a4b-8c0a-ae9f-2f6501198840@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2cGk4tw3NCCB3Cy-CWrDrA-1
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.12.2019 um 21:59 hat Eric Blake geschrieben:
> On 12/9/19 10:06 AM, Kevin Wolf wrote:
> > Am 28.11.2019 um 11:41 hat Sergio Lopez geschrieben:
> > > bdrv_try_set_aio_context() requires that the old context is held, and
> > > the new context is not held. Fix all the occurrences where it's not
> > > done this way.
> > >=20
> > > Suggested-by: Max Reitz <mreitz@redhat.com>
> > > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > > ---
>=20
> > Or in fact, I think you need to hold the AioContext of a bs to
> > bdrv_unref() it, so maybe 'goto out' is right, but you need to unref
> > target_bs while you still hold old_context.
>=20
> I suspect https://bugzilla.redhat.com/show_bug.cgi?id=3D1779036 is also a
> symptom of this.  The v5 patch did not fix this simple test case:

Speaking of a test case... I think this series should probably add
something to iotests.

Kevin


