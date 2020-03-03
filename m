Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18F62083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deqTI6oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18F62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99Yy-0005jp-1b
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j99YF-0004nd-Go
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j99YE-0002Er-34
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:33:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j99YD-0002Eh-TT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583249621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DT1FHsOUmSnrcACIVijkFlwFulgay3LragRHRFhd0eU=;
 b=deqTI6oVdDqdu1TN5vBszrI8nIEquFfElW4kkWzOzlOtX2ikPSRWLFJk7PkmFSRk+/ohgq
 gXbHJc2uRehd71HBSNHRoMdAmwzyEWq3/7hxHVtIN8xjwQ1lyCewYxwLFxk89H0ODiTFsM
 /jCCV1aADcPrGsSJE46Ncq+fE57EaNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-glzti14bOee_sQBKDOwbFg-1; Tue, 03 Mar 2020 10:33:39 -0500
X-MC-Unique: glzti14bOee_sQBKDOwbFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77DB9107ACCA;
 Tue,  3 Mar 2020 15:33:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27E927386B;
 Tue,  3 Mar 2020 15:33:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7F7C11386A6; Tue,  3 Mar 2020 16:33:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 0/4] qmp: Optionally run handlers in coroutines
References: <20200218154036.28562-1-kwolf@redhat.com>
Date: Tue, 03 Mar 2020 16:33:36 +0100
In-Reply-To: <20200218154036.28562-1-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 18 Feb 2020 16:40:32 +0100")
Message-ID: <87sgipwizz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks like PATCH 2 isn't necessary anymore, and PATCH 4 needs a respin.
I tentatively queued PATCH 1+3, in the hope of getting either PATCH 4 or
Marc-Andr=C3=A9's screendump patch in time for 5.0.

Pushed to branch monitor-next in git://repo.or.cz/qemu/armbru.git.
Appears to be down right now.

Thanks!


