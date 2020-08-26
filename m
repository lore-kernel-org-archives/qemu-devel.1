Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4708C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEAE2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgKDs6jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEAE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAprw-0004zo-Rv
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAprR-0004Wy-8N
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 03:28:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAprP-00089K-2U
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 03:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598426921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCXGXGq48ftvu5tfCBr1eMifT/BHp/gMxPFdc5OUEI0=;
 b=dgKDs6jDNhSZe2+TAR6xGY26gMb9xwD0Gc9ShNwWPJ/GwVkOEmarx1ea4AU6/bCY2Bq7nj
 ZOpTpeU3UjLDH8rBfSRr9hC14pPK9gFYURpthL9fORK6U0IjgVaSdOSTBxKRSLLwlDmWmR
 idsxVKoeHJtSw7N1rpzq73cZiInyQrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-HpWDsFqQNl2dt_NG7Np6AA-1; Wed, 26 Aug 2020 03:28:35 -0400
X-MC-Unique: HpWDsFqQNl2dt_NG7Np6AA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3871210ABDB9;
 Wed, 26 Aug 2020 07:28:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEE3C60C0F;
 Wed, 26 Aug 2020 07:28:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CE34112D737; Wed, 26 Aug 2020 09:28:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: luoyonggang@gmail.com
Subject: Re: [PATCH 1/4] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja SIMPLE_PATH_RE should match the full path token.
 Or the $ and : contained in path would not matched if the path are start with
 C:/ and E:/
References: <20200825144919.1217-1-luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 09:28:32 +0200
In-Reply-To: <20200825144919.1217-1-luoyonggang@gmail.com>
 (luoyonggang@gmail.com's message of "Tue, 25 Aug 2020 22:49:16 +0800")
Message-ID: <87imd5987z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please do not put all of your commit message in the subject line.

https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

https://chris.beams.io/posts/git-commit/


