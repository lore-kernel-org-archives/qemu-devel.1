Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF2FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 06:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409DD21D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 06:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WL87PwUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409DD21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSxya-0000zR-DG
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 01:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iSxxu-0000W0-3O
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 01:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iSxxr-0008V6-Jl
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 01:41:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iSxxr-0008UZ-Bf
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 01:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573195306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDt31jIzenRUxqbZByaHrP96/wQELmHmCZ9PYeBlI0g=;
 b=WL87PwUTfKiAa8opv7WmkjLPCYBu5BpGrc85NdTMgEbrTNLWsxSEVYuy8KT4q8nBv+ytgU
 dubZzzqKGkL3vWPK5uiELVVVqQ4i2Yw3QtpCFshOWHE7Y8TFPeiR8D4KrHvDSPy1tPJon9
 zTB79L8N+wL7PbYV+Bxn8plPqWjTOKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-1Ad_GReSPmiDzPVkMLxTCQ-1; Fri, 08 Nov 2019 01:41:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0C1D1800D9C;
 Fri,  8 Nov 2019 06:41:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B018600F4;
 Fri,  8 Nov 2019 06:41:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFA2811385C9; Fri,  8 Nov 2019 07:41:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Deprecating stuff for 4.2 (was: [Qemu-devel] Exposing feature
 deprecation to machine clients)
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <8736i2zf8e.fsf_-_@dusky.pond.sub.org>
 <423f2f82-9111-9c19-85b6-2645f66ab641@redhat.com>
 <ee0c3bf0-cb5b-835c-3981-d6f2b8af86e1@redhat.com>
 <e0448126-3371-fcf7-20ed-0d682dd8ca97@virtuozzo.com>
Date: Fri, 08 Nov 2019 07:41:29 +0100
In-Reply-To: <e0448126-3371-fcf7-20ed-0d682dd8ca97@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 7 Nov 2019 19:13:18 +0000")
Message-ID: <87eeyirht2.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1Ad_GReSPmiDzPVkMLxTCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 07.11.2019 21:52, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
>> Pre-release period, time to deprecate some stuffs :)
>>=20
>> How should we proceed? Do you have something in mind?
>>=20
>> There are older threads about this. Should we start a new thread? Gather=
 the different ideas on the Wiki?
>>=20
>> (Obviously you are not the one responsible of this topic, you just happe=
n to be the last one worried about it on the list).
>>=20
>> Regards,
>>=20
>> Phil.

4.2.0-rc0 has been tagged, i.e. we're in hard freeze already.  Only bug
fixes are accepted during hard freeze.  We've occasionally bent this
rule after -rc0 for borderline cases, e.g. to tweak a new external
interface before the release calcifies it.  Making a case for bending
the rules becomes harder with each -rc.

Ideally, we'd double-check new interfaces for gaffes before a release,
and whether old interfaces that have been replaced now should be
deprecated.  There's rarely time for that, and pretty much never for
releases right after KVM Forum.

So no, I don't have anything in mind for 4.2.

We intend to tag -rc1 next Tuesday.  To make that deadline, we'd need
patches, not just ideas.

> Hi!
>
> I wanted to resend, but faced some problems, and understand that I can't =
do it in time before soft-freeze..
> But you say, that we can deprecate something even after hard-freeze?

See above.

> Ok, the problem that I faced, is that deprecation warnings breaks some io=
tests.. What can we do?
>
> 1. Update iotests...
>    1.1 Just update iotests outputs to show warnings. Then, in next releas=
e cycle, update iotests, to not use deprecated things

Sounds workable to me, but I'm not the maintainer.

>    or
>    1.2 Update iotests to not use deprecated things.. Not appropriate for =
hard freeze.

Unnecessarily risky compared to 1.1.

> or
> 2. Commit deprecations without warnings.. But how do people find out abou=
t this?

Not nice.

We do it for QMP, but only because we still lack the means to warn
there.

> Next, what exactly to deprecate? As I understand, we can't deprecate driv=
e-mirror now?
> So I propose to:
>
> 1. deprecate drive-backup
> 2. add optional filter-node-name parameter to drive-mirror, to correspond=
 to commit and mirror
> 3. deprecate that filter-node-name is optional for commit and mirror.

To have a chance there, we need patches a.s.a.p.


