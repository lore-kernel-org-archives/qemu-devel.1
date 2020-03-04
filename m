Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A6CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D004720866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNmyyEiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D004720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9OzY-0003xd-16
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9Oye-0002yd-Fu
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9Oyc-0002WB-Bm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:01:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41239
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9Oyc-0002Nf-52
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583308917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcP9iAnD/Comq3tqlSC0Wf7/AoV44UI5dmS8I7me+Pw=;
 b=GNmyyEiVnmmY0jNb95C9Sh/3jmCBvqDNGJrqDnVeCa/Y7cTmgUay0LQ0d+MkEEEdebhFdq
 sGBbrwvdF7+8UZB50O/3s1P2CqYRcd7kEuXHQPbyrynHKnzpi6UTtnzvSeZH247EhFIBCA
 aPBXhaKXSgauELiphH0tuq5Eey1p+pE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-YWI7xWxBMFmgaP5UlTJKeg-1; Wed, 04 Mar 2020 03:01:53 -0500
X-MC-Unique: YWI7xWxBMFmgaP5UlTJKeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D17FB8010F0;
 Wed,  4 Mar 2020 08:01:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D19A292D21;
 Wed,  4 Mar 2020 08:01:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 612E111386A6; Wed,  4 Mar 2020 09:01:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 4/4] qapi: Brush off some (py)lint
References: <20200227144531.24309-1-armbru@redhat.com>
 <20200227144531.24309-5-armbru@redhat.com>
 <6b7e0d73-6840-3a6a-9d33-0adcec0d4c84@redhat.com>
Date: Wed, 04 Mar 2020 09:01:48 +0100
In-Reply-To: <6b7e0d73-6840-3a6a-9d33-0adcec0d4c84@redhat.com> (John Snow's
 message of "Tue, 3 Mar 2020 17:03:27 -0500")
Message-ID: <87y2sgpmz7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: crosa@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 2/27/20 9:45 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> I wrote some pylint cleanup for iotests recently, too. Are you targeting
> a subset of pylint errors to clean here?
>
> (Do any files pass 100%?)

Surely you're joking, Mr. Snow!

I'm chipping away at pylint's gripes.  I ran it with the following
messages disabled:

    bad-whitespace,
    fixme,
    invalid-name,
    missing-docstring,
    too-few-public-methods,
    too-many-arguments,
    too-many-branches,
    too-many-instance-attributes,
    too-many-lines,
    too-many-locals,
    too-many-statements,
    unused-argument,
    unused-wildcard-import,

These are not all obviously useless.  They're just not what I want to
focus on right now.

Remaining:

1 x C0330: Wrong continued indentation (remove 19 spaces).

    Accident, will fix in v2.

8 x R0201: Method could be a function (no-self-use)

    Yes, but the override in a sub-class does use self.

2 x W0212: Access to a protected member _body of a client class (protected-=
access)

    Needs cleanup, but not now.

6 x W0401: Wildcard import qapi.common (wildcard-import)

    Not sure I care.  I'd prefer not to have more wildcard imports,
    though.

2 x W0603: Using the global statement (global-statement)

    Cleanup is non-trivial.  Not now.

I also ran pycodestyle-3:

1 x E127 continuation line over-indented for visual indent

    Same as pylint's C0330, will fix in v2.

3 x E261 at least two spaces before inline comment

    I blame Emacs.  Left for another day.

8 x E501 line too long

    Left for another day.

1 x E713 test for membership should be 'not in'

    I missed that one, will fix in v2.

> Consider checking in a pylintrc file that lets others run the same
> subset of pylint tests as you are doing so that we can prevent future
> regressions.

Working towards it, slowly.

> Take a peek at [PATCH v6 0/9] iotests: use python logging=E2=80=8B
>
> Thanks for this series. I had a very similar series sitting waiting to
> go out, but this goes further in a few places.

Thanks!


