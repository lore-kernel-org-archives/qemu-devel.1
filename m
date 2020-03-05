Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E4EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E07820732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKAWu0BK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E07820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rT5-0001nc-BF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j9rPw-0003RJ-Rp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j9rPw-0004Z2-0B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:24:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j9rPv-0004XD-SE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fycpKbmYa2MQQ2I7T+8TZlDL2cOuDrd4KBMm76xA6i0=;
 b=aKAWu0BKD6IGkfppItfQNi7j+f24ZoJz2D32u4WyIplNNTVplV2mCJ0eEV07/zn0HBFxL1
 nAgpo9NHifa/XCpo+F318sMBG6gj3KzTks6N1YT0IjmrjALkOVRs/jt1KmGYPyO6aPby4+
 +WOFagMl9iHZrcxYmoMjkSfXN+SPOMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-4FGCqqzINVW_kSiew_vgrA-1; Thu, 05 Mar 2020 09:23:58 -0500
X-MC-Unique: 4FGCqqzINVW_kSiew_vgrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD318048F5;
 Thu,  5 Mar 2020 14:23:57 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-210.ams2.redhat.com [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BA3B5C54A;
 Thu,  5 Mar 2020 14:23:53 +0000 (UTC)
Date: Thu, 5 Mar 2020 15:23:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Florian Florensa <fflorensa@online.net>
Subject: Re: [PATCH v3 0/1] block/rbd: Add support for ceph namespaces
Message-ID: <20200305142352.GB5363@linux.fritz.box>
References: <20200110111513.321728-1-fflorensa@online.net>
MIME-Version: 1.0
In-Reply-To: <20200110111513.321728-1-fflorensa@online.net>
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
Cc: dillaman@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.01.2020 um 12:15 hat Florian Florensa geschrieben:
> Fixed the white space issue, no changes other than that.
>=20
> Florian Florensa (1):
>   block/rbd: Add support for ceph namespaces

Thanks, applied to the block branch.

Kevin


