Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E681C2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFgGz1R3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E681C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzLs-0000X3-5u
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1iuzL4-00089D-Kv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1iuzL3-0000w9-GJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:49:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1iuzL3-0000u9-DT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579873770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ODA48R1gifpbXlQl8XkbKUbGO9iAnQJeMDNRIiQNQc=;
 b=bFgGz1R3JuwokvLbEpCQXap94YGt2duZnf0GnEYa9euFkHo2iRJQnxXvxpQGDxfxktMmAe
 ppfolMuH4twrp4c6pXA9MpDotfhbBgfXbL6Iv0dT1tLOiWWHWTNUVZbOyxVbl7p3xbnJv7
 b4UTlXB6MVi/jW72NgUvS/ksPMKD830=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-vurI-zbZPc2Pq_xxlwIGpg-1; Fri, 24 Jan 2020 08:49:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1422E8010CA;
 Fri, 24 Jan 2020 13:49:23 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9EB684D90;
 Fri, 24 Jan 2020 13:49:22 +0000 (UTC)
Date: Fri, 24 Jan 2020 13:49:21 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: qemu-img convert vs writing another copy tool
Message-ID: <20200124134921.GO16477@redhat.com>
References: <20200123183500.GA27166@redhat.com>
 <bbcbb67f-74ad-b491-e988-09a380ac8068@redhat.com>
 <20200124095555.GR3888@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200124095555.GR3888@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vurI-zbZPc2Pq_xxlwIGpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: berrange@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 ptoscano@redhat.com, marnold@redhat.com, mkletzan@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 24, 2020 at 09:55:55AM +0000, Richard W.M. Jones wrote:
> On Thu, Jan 23, 2020 at 01:21:28PM -0600, Eric Blake wrote:
> > Could we also teach this to parse 'qemu-img map --output=3Djson'
> > format? And/or add 'qemu-img map --output=3DXYZ' (different from the
> > current --output=3Dhuman') that gives sufficient information?  (Note:
> > --output=3Dhuman is NOT suitable for extent lists - it intentionally
> > outputs only the data portions, and in so doing coalesces 'hole' and
> > 'hole,zero' segments to be indistinguishable).
>=20
> If qemu-img doesn't have the data (we have to get it from
> another source), is the output of qemu-img map relevant?

I can see that we might use this to transfer a map from one qemu
source to another, which could be useful.  Unfortunately nbdkit
doesn't link to any libraries that can read JSON at the moment :-(
But certainly something to keep in mind for the future.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


