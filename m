Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C85320724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgwueSQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C85320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLm2-0006R0-Q2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsLlJ-0005mR-IM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:42:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsLlH-00070Z-51
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594021317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPclBdxcEAnChhlbJZsDBWI14QCfYuM438hdr/HHVjs=;
 b=PgwueSQOuyP2kiygGxMkitsV5RaPqCtwbI3cu1AYwl8nb8MIvQ4vjxXg78QUAHrZgvhpiY
 r4wMS/v+oqWSoHqvlMTlpcL31CMRzeOYuePWb6t5H9op3ob9Q2G99/dfMec9MVTOvaidHb
 fauGQDs9W0K3ZKUiePuCHAqyUeqoGGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-GXwXvf9pPU6o06QHFW7HIA-1; Mon, 06 Jul 2020 03:41:56 -0400
X-MC-Unique: GXwXvf9pPU6o06QHFW7HIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6529A801E6A;
 Mon,  6 Jul 2020 07:41:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 369D110013C2;
 Mon,  6 Jul 2020 07:41:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9139B1138648; Mon,  6 Jul 2020 09:41:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v11 8/8] xen: introduce ERRP_AUTO_PROPAGATE
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
 <20200703090816.3295-9-vsementsov@virtuozzo.com>
 <e2b4f10a-162c-ebb8-3232-381c4d820f9f@redhat.com>
Date: Mon, 06 Jul 2020 09:41:49 +0200
In-Reply-To: <e2b4f10a-162c-ebb8-3232-381c4d820f9f@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 4 Jul 2020 18:36:07
 +0200")
Message-ID: <878sfxgkea.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org, groug@kaod.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/3/20 11:08 AM, Vladimir Sementsov-Ogievskiy wrote:
>> If we want to add some info to errp (by error_prepend() or
>> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
>> Otherwise, this info will not be added when errp =3D=3D &error_fatal
>> (the program will exit prior to the error_append_hint() or
>> error_prepend() call).  Fix such cases.
>>=20
>> If we want to check error after errp-function call, we need to
>> introduce local_err and then propagate it to errp. Instead, use
>> ERRP_AUTO_PROPAGATE macro, benefits are:
>> 1. No need of explicit error_propagate call
>> 2. No need of explicit local_err variable: use errp directly
>> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>>    &error_fatal, this means that we don't break error_abort
>>    (we'll abort on error_set, not on error_propagate)
>>=20
>> This commit is generated by command
>>=20
>>     sed -n '/^X86 Xen CPUs$/,/^$/{s/^F: //p}' MAINTAINERS | \
>>     xargs git ls-files | grep '\.[hc]$' | \
>>     xargs spatch \
>>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>         --macro-file scripts/cocci-macro-file.h \
>>         --in-place --no-show-diff --max-width 80
>>=20
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Reported-by: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  hw/block/dataplane/xen-block.c |  17 +++---
>>  hw/block/xen-block.c           | 102 ++++++++++++++-------------------
>>  hw/pci-host/xen_igd_pt.c       |   7 +--
>>  hw/xen/xen-backend.c           |   7 +--
>>  hw/xen/xen-bus.c               |  92 +++++++++++++----------------
>>  hw/xen/xen-host-pci-device.c   |  27 +++++----
>>  hw/xen/xen_pt.c                |  25 ++++----
>>  hw/xen/xen_pt_config_init.c    |  17 +++---
>>  8 files changed, 128 insertions(+), 166 deletions(-)
>
> Without the description, this patch has 800 lines of diff...
> It killed me, I don't have the energy to review patch #7 of this
> series after that, sorry.
> Consider splitting such mechanical patches next time. Here it
> could have been hw/block, hw/pci-host, hw/xen.

Probably my fault; I asked for less fine-grained splitting.

Finding a split of a tree-wide transformation that pleases everyone is
basically impossible.

The conversion to ERRP_AUTO_PROPAGATE() could be one patch per function,
but that would be excessive.

Vladimir chose to split along maintenance boundaries, so he can cc: the
right people on the right code.  I agree with the idea.  The difficulty
is which boundaries.  Our code is not partitioned into maintenance
domains.  Instead, we have overlapping sets.  Makes sense, because it
mirrors how we actually maintain it.

Because of that, a blind split guided by MAINTAINERS won't work well.  A
split that makes sense needs a bit of human judgement, too.

This part makes perfect sense to me from the cc: point of view: it's
Xen, the whole of Xen, and nothing but Xen.

I acknowledge that its size made it exhausting for you to review.  I
didn't expect that, probably because after having spent hours on
reviewing and improving the macro and the Coccinelle script, I know
exactly what to look for, and also consider the script trustworthy[*].

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thank you, much appreciated!


[*] I've learned not to trust Coccinelle 100%, ever.


