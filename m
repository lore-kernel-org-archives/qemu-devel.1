Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2EAC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6403E20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifuahGoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6403E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOit-0001ic-6P
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOOhe-0008I2-63
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOOhb-0000Kf-P4
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:46:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jOMBz-0001mh-B5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586873134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ny33XNjxESPXi/DyEwbluwIRZKBqMXBGbe72JOZiMw4=;
 b=ifuahGoDnQ7w1bg/aYAPIW/03mKXvX6LGDaMgWCBF84WrLSQd1BaoytR9f2U349ZAPuuCG
 6/jktLHjADFDIzF48ZgWUGp0/Vlilxm2KFM3U/JtI3mN4Hn63Q+QdWPAG1IJldkBwGoTXw
 UJLqKcetCHbKxyAjijPJ9gIXfA1oTWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-8Yoi09aANoOvLxdm3UNQow-1; Tue, 14 Apr 2020 10:05:33 -0400
X-MC-Unique: 8Yoi09aANoOvLxdm3UNQow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F57A107ACC9;
 Tue, 14 Apr 2020 14:05:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F45F60BE1;
 Tue, 14 Apr 2020 14:05:31 +0000 (UTC)
Date: Tue, 14 Apr 2020 16:05:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for-5.1 2/8] qemu-options: Factor out
 get_opt_name_value() helper
Message-ID: <20200414140529.GG7747@linux.fritz.box>
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-3-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200409153041.17576-3-armbru@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.04.2020 um 17:30 hat Markus Armbruster geschrieben:
> The next commits will put it to use.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


