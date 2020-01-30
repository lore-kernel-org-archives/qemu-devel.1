Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810FEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBF420CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmJ5c4EF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBF420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixC9n-0001QD-GE
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixC90-0000PE-7m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixC8y-0002gI-HG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:54:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixC8y-0002fC-DC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580399651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pmF6dNxafZw+7xgb2CchEmPBEhjNA9xpxJrXp5/QKE=;
 b=KmJ5c4EFSgaq6QOo2PUYBGXJ1YjqkHmZMzYBKUMo+Pj1N7MAgmR0STmc54MWXcyvlK240W
 sy5xQ7eCiZLbj4ZgZiXdqBSx+Px+8+McaETdbkACeX1lSDOypgRCZO60vcaC4mCJTSBmvQ
 eQw6P+/HYeESMPNNoiA3EIqpZWJMUjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-vcUNyIxoPWe5Hbry9S1qwA-1; Thu, 30 Jan 2020 10:54:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE578010E9;
 Thu, 30 Jan 2020 15:54:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFC271084382;
 Thu, 30 Jan 2020 15:54:04 +0000 (UTC)
Message-ID: <37f7f6514c3068873ec3c2f39d980e8ed18e1f5f.camel@redhat.com>
Subject: Re: [PATCH 04/13] block: amend: separate amend and create options
 for qemu-img
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Jan 2020 17:54:03 +0200
In-Reply-To: <20200128172343.GW1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-5-mlevitsk@redhat.com>
 <20200128172343.GW1446339@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vcUNyIxoPWe5Hbry9S1qwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 17:23 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 14, 2020 at 09:33:41PM +0200, Maxim Levitsky wrote:
> > Some options are only useful for creation
> > (or hard to be amended, like cluster size for qcow2), while some other
> > options are only useful for amend, like upcoming keyslot management
> > options for luks
> >=20
> > Since currently only qcow2 supports amend, move all its options
> > to a common macro and then include it in each action option list.
> >=20
> > In future it might be useful to remove some options which are
> > not supported anyway from amend list, which currently
> > cause an error message if amended.
>=20
> I think I would have done that in this commit. At least the
> encrypt.* options shouldn't be added to the amend_opts list,
> since they're being removed from it again a few patches later.

After taking on IRC, I understood the point.

I indeed will send another patch after this one that will
only cleanup qcow2 amend/create options and then patch that
adds luks amend to qcow2, thus 3 patches in total, this one,
the patch that cleans the create/amend separation and then
patch that adds luks amend to qcow2.




[...]

Thanks for the review,
Best regards,
=09Maxim Levitsky


