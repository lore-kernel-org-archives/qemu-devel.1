Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0064C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E6820B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E6820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFWw-0001ht-Tj
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iI6cK-0002Fk-C5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iI6cJ-0005Ds-9K
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iI6cJ-0005DY-3v; Wed, 09 Oct 2019 03:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF3F86908D;
 Wed,  9 Oct 2019 07:42:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 463A6600CD;
 Wed,  9 Oct 2019 07:42:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9EBA1138619; Wed,  9 Oct 2019 09:42:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 07/31] s390: Fix error_append_hint/error_prepend usage
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-8-vsementsov@virtuozzo.com>
Date: Wed, 09 Oct 2019 09:42:33 +0200
In-Reply-To: <20191001155319.8066-8-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 1 Oct 2019 18:52:55 +0300")
Message-ID: <87muea9xg6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 09 Oct 2019 07:42:38 +0000 (UTC)
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
Cc: Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>
> This commit (together with its neighbors) was generated by
>
> git grep -l 'error_\(append_hint\|prepend\)(errp' | while read f; do \
> spatch --sp-file scripts/coccinelle/fix-error-add-info.cocci \
> --in-place $f; done

Make that:

    $ spatch --sp-file scripts/coccinelle/fix-error-add-info.cocci --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff `git grep -l 'error_\(append_hint\|prepend\)(errp' \*.[ch]`

Adding --macro-file is essential, as Eric noted.  Without it, we miss
qcow2_store_persistent_dirty_bitmaps() in PATCH 23 and
nbd_negotiate_send_rep_verr() in PATCH 29.  There should be a way to
make spatch warn when it gives up parsing, but I can't find it right
now.

Avoiding the loop is just for speed and simplicity.

--no-show-diff goes well with --in-place.

The even simpler

    $ spatch --sp-file scripts/coccinelle/fix-error-add-info.cocci --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff --use-gitgrep

misses include/block/nbd.h's nbd_read() in PATCH 23 somehow.

I recommend to add the spatch invocation to the coccinelle script's
commit message, too [PATCH 05].

[...]

