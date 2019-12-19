Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E04DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0292053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LA4THsUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0292053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzM2-0008QI-40
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzI7-0003Ju-BA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzI5-0002Kr-Nx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:08:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzI5-0002Ci-Ab
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576775324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0LXfzeEeWIvWey1hnq2tO0V+bhMzEwwqYFwQaTzfL4=;
 b=LA4THsUGpLkyvbXddVVIZNZoyecnjL9/11OCIK/z0SJqhZBeqPxpbcLrIN2l/e0oM/Pq+i
 WO2ZtXZTUTScLllxtH69xl0oIR+/cS2+4IotV7/ewDHmtNUdB00JgD6uHsBGxitc9u5eFX
 jEeY/EtkpTSm4u8cwZySXpNzTVA5qn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-8paXBw0VP4K4V1Ae3v5UTw-1; Thu, 19 Dec 2019 12:08:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D058E593C3;
 Thu, 19 Dec 2019 17:08:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BF8D1001DD8;
 Thu, 19 Dec 2019 17:08:37 +0000 (UTC)
Date: Thu, 19 Dec 2019 18:08:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] iotests.py: Wait for postmigrate in wait_migration
Message-ID: <20191219170831.GP5230@linux.fritz.box>
References: <20191219155137.2431986-1-mreitz@redhat.com>
 <20191219160143.GO5230@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20191219160143.GO5230@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 8paXBw0VP4K4V1Ae3v5UTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.12.2019 um 17:01 hat Kevin Wolf geschrieben:
> Am 19.12.2019 um 16:51 hat Max Reitz geschrieben:
> > Without this patch, I see intermittent failures in the new iotest 280
> > under high system load.  I have not yet seen such failures with other
> > iotests that use VM.wait_migration() and query-status afterwards, but
> > maybe they just occur even more rarely.
> >=20
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Thanks, applied to the block branch.

...and unqueuing it again because it makes 234 and 262 hang.

Kevin


