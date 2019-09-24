Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C984C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F345020665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F345020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmtg-0007Bf-JC
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCm4S-0005p3-IZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCm4Q-0002UX-GQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCm4Q-0002TL-Ac
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:45:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6E9E30860D5;
 Tue, 24 Sep 2019 14:45:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E027310016EB;
 Tue, 24 Sep 2019 14:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C3D7113864E; Tue, 24 Sep 2019 16:45:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qapi/qmp-dispatch: Fix error class for
 reporting disabled commands
References: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
 <87k1accq91.fsf@dusky.pond.sub.org>
 <e57985a8-6974-e2b4-a622-3b7eca50660c@redhat.com>
 <87impw598s.fsf@dusky.pond.sub.org>
 <87d0fp7u1d.fsf@dusky.pond.sub.org>
Date: Tue, 24 Sep 2019 16:45:31 +0200
In-Reply-To: <87d0fp7u1d.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 24 Sep 2019 14:33:50 +0200")
Message-ID: <87ftklpxbo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 24 Sep 2019 14:45:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, lcapitulino@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> I tried to include the amended patch in today's pull request, but
> observed "make check" hangs with it.

False alarm: I just got a hang on master.  I intend to include this
patch in my next pull request.  Sorry for the delay.

