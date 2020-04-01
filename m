Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F88C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C502074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSkfNe5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C502074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJVbv-0004IT-CU
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 01:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJVb8-0003rv-1k
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJVb6-0002om-Pu
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:07:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJVb6-0002m1-Hs
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585717647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cn9kMeae/3nJ58VfDW06RQT4Td2JzJbYKqJ6E3BOz8k=;
 b=SSkfNe5X7LdQisLk8pT8Fe39/iqBPx55GjrXNA6bXBKozSKq+pd4Hu+f+KGl3fiMB7PFn6
 l+AqDEgzEGfyhgf3tlS3E80KV0flLkozPJD3Mo1dPmkLW5ZfyUk3hnzxAd41N4g/hS4JjF
 8JCCkgAJTtAyix15Ld8mrMLVh3vHZJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-FnCqUP58MsudZI0CUCbD8g-1; Wed, 01 Apr 2020 01:07:25 -0400
X-MC-Unique: FnCqUP58MsudZI0CUCbD8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A4B9107ACCC;
 Wed,  1 Apr 2020 05:07:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 197115C1B0;
 Wed,  1 Apr 2020 05:07:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E71711385E2; Wed,  1 Apr 2020 07:07:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
 <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
Date: Wed, 01 Apr 2020 07:07:19 +0200
In-Reply-To: <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
 (Peter Maydell's message of "Tue, 31 Mar 2020 19:56:34 +0100")
Message-ID: <87wo6zoku0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Denis
 V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 31 Mar 2020 at 10:01, Markus Armbruster <armbru@redhat.com> wrote=
:
>> I doubt including basic spatch instructions with every script is a good
>> idea.  Better explain it in one place, with proper maintenance.
>> scripts/coccinelle/README?  We could be a bit more verbose there,
>> e.g. to clarify required vs. suggested options.
>
> I find it useful -- you (hopefully) get the actual command line
> the original author used, rather than having to guess which
> options might be significant. (eg the last one I added uses
> --keep-comments --smpl-spacing --include-headers --dir target
> which aren't all always used but which do all matter here for
> getting the change that went in in the commit that used the script.)
> Most of us use coccinelle as an occasional tool, not an
> everyday one, so not having to look through the docs to figure
> out the right rune is a benefit, even for the options that
> we do use on pretty much every spatch run.

Generic instructions for using .cocci scripts should go into README.
Enough to get you started if you know nothing about Coccinelle.

Options that should always be used with a certain script should be
documented in that script.

Options that only affect work-flow, not the patch, I'd rather keep out
of the script.  If there are any we feel we should mention, do that in
README.  Example: --no-show-diff.

Brief instructions for how a patch was created should be included in the
commit message.  They should suffice for readers familiar with
Coccinelle.  Yes, there's a bit of redundancy with README and the
script.


