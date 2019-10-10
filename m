Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E20C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC216208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC216208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYs9-0004Zo-7r
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIYrX-0004BB-NW
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIYrW-0002tj-5j
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iIYrW-0002tP-01
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E52FE18C8934
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 13:52:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2BCD60BE1;
 Thu, 10 Oct 2019 13:52:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E77471138619; Thu, 10 Oct 2019 15:52:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v3 3/3] qapi: Allow introspecting fix for savevm's
 cooperation with blockdev
References: <cover.1570705279.git.pkrempa@redhat.com>
 <be94d24847d38cb5a1172ed22d0f86e7c0ec8562.1570705279.git.pkrempa@redhat.com>
Date: Thu, 10 Oct 2019 15:52:08 +0200
In-Reply-To: <be94d24847d38cb5a1172ed22d0f86e7c0ec8562.1570705279.git.pkrempa@redhat.com>
 (Peter Krempa's message of "Thu, 10 Oct 2019 13:05:24 +0200")
Message-ID: <87r23koghj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 10 Oct 2019 13:52:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> 'savevm' was buggy as it considered all monitor-owned block device nodes
> for snapshot. With introduction of -blockdev the common usage made all
> nodes including protocol and backing file nodes monitor-owned and thus
> considered for snapshot.
>
> This is a problem since the 'file' protocol nodes can't have internal
> snapshots and it does not make sense to take snapshot of nodes
> representing backing files.
>
> This was fixed by commit 05f4aced658a02b02 clients need to be able to
> detect whether this fix is present.

05f4aced658a02b02.  Clients

>
> Since savevm does not have an QMP alternative, add the feature for the
> 'human-monitor-command' backdoor which is used to call this command in
> modern use.
>
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>

Preferrably with the commit message tweak:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

