Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9129C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4FD2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgqPJcqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4FD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWou-0004fj-Pa
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihWoB-0004HD-6k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihWo9-0000NS-L5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:43:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihWo9-0000Ho-G1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576665836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=HA1nhzlK9GnvT03m4vQ++27EhKQxqFmL9SmAuUUrDX0=;
 b=JgqPJcqX9yh6oYcPLjSGaVGahqLve5TxZsrd9L1bsrF+O70Yj0eHE5BWp6frY5duo60KsO
 6eOgLrueNFnRUC9Niet7SuBq81G16hCGLGXqsUX5RnmtIpUQnMx6LEbmh2bF2DrdvLnWSb
 xZzlgAbOCXupj18SH8CjBhsluK7xc+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-cqhE7AdYMG2WgWyNIcEiYw-1; Wed, 18 Dec 2019 05:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5312A1809A4D
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:43:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E2895D9E2;
 Wed, 18 Dec 2019 10:43:50 +0000 (UTC)
Subject: Re: [PATCH v2 08/10] migration-test: Move -incomming handling to
 common commandline
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20191218015520.2881-1-quintela@redhat.com>
 <20191218015520.2881-9-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <52ef2ea6-1af7-5e9c-42c9-5bb1b41fa0d7@redhat.com>
Date: Wed, 18 Dec 2019 11:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218015520.2881-9-quintela@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cqhE7AdYMG2WgWyNIcEiYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You've got a typo in the subject: Please replace "incomming" with
"incoming".

 Thanks,
  Thomas


