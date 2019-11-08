Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ABAFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532FC214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajq1qY70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532FC214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT08B-00036s-Hf
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT07D-0002QM-US
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT07D-0002aJ-4N
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:59:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT07D-0002aB-1E
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573203574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynOC6dYJG5SETFwcwZH6IA5eZzelUtlk+9i96fs3sjg=;
 b=ajq1qY70hQ2C6oxuLPc8AS6IUBRFCF2aA01NT84GCYlYCOH3Y2+0Sr7zvLIkRB8aKA6LUI
 4f1T9B8k7tPYp69Tobpfah5sEs0iDWl8DcRGaHA4S0qDcrW5d4ScSU22EKBo0+uASoAEL5
 AO+62WO40/aBVQJG61IxmAqntkeVLvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-U-f0ot-FMvG8uzXbYtT1VQ-1; Fri, 08 Nov 2019 03:59:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511EF1800D9C;
 Fri,  8 Nov 2019 08:59:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BB9E5D6D8;
 Fri,  8 Nov 2019 08:59:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 892DE11385C9; Fri,  8 Nov 2019 09:59:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 18/18] qemu-storage-daemon: Add --monitor option
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-19-kwolf@redhat.com>
Date: Fri, 08 Nov 2019 09:59:30 +0100
In-Reply-To: <20191017130204.16131-19-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:02:04 +0200")
Message-ID: <8736eybv65.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U-f0ot-FMvG8uzXbYtT1VQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quick observation: --help fails to mention --monitor.


