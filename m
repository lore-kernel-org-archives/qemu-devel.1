Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B680FC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7857A2051A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW9Qe9Bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7857A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIBf-0005Eb-KZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 09:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFIAw-0004ZP-PV
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFIAv-0003u2-Ks
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:59:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFIAv-0003tg-Gt
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584712741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vG6jOFqL5yyGBydMNsMbILYo5yPiJ8TQta/MyKAx2Y4=;
 b=VW9Qe9BdN4KIxWnYjoepNR5sMfm7Piy/6yUa8636ZxoQJvFeDT5y19q+7G696RqC8zfx1B
 X3kWIvzFxqm++pCzDY9t0w8wSvlX3mq5hg8sXT6WfLTd/SPsnO2SrVS8xHBBXHLy45dvgH
 pYv0jSFCBmtOkRLfd/JjXOQyINKWfmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-7hf_sQkxM5aAapW4mr69cw-1; Fri, 20 Mar 2020 09:58:57 -0400
X-MC-Unique: 7hf_sQkxM5aAapW4mr69cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4617477;
 Fri, 20 Mar 2020 13:58:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 056FB1036B3B;
 Fri, 20 Mar 2020 13:58:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 660E01138404; Fri, 20 Mar 2020 14:58:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
 <f9c8de73-38d8-a14c-632a-8e57d18e00c8@virtuozzo.com>
 <87o8swk8wc.fsf@dusky.pond.sub.org>
 <db2fa8a3-48cc-51aa-a3d5-eba88fb29f66@virtuozzo.com>
 <87wo7jqn8m.fsf@dusky.pond.sub.org>
 <c944511d-0a10-0840-258f-8e0bac19eb47@virtuozzo.com>
 <87wo7gd3nb.fsf@dusky.pond.sub.org>
 <d7bc3318-2d39-ce6f-1bd0-4165084458a2@virtuozzo.com>
Date: Fri, 20 Mar 2020 14:58:48 +0100
In-Reply-To: <d7bc3318-2d39-ce6f-1bd0-4165084458a2@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 19 Mar 2020 15:12:07 +0300")
Message-ID: <87r1xn2kmf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 19.03.2020 13:45, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
[...]
>>> So, understanding that there no such cases in the whole tree, and even
>>> if your patch works faster on the whole tree, I still don't want to
>>> drop inheritance, because it's just a correct thing to do. Yes, we've
>>> added ____ helper. It helps to avoid some problems. Pair-inheritance
>>> helps to avoid another problems. I understand, that there still may
>>> other, not-covered problems, but better to be as safe as possible. And
>>> inheritance here is native and correct thing to do, even with our ____
>>> additional helper. What do you think?
>>
>> I wouldn't call it correct.  It's still unreliable, but less so than
>> without the function name constraint.  That makes it less wrong.
>
> Agree.
>
>>
>> 100% reliable would be nice, but not at any cost.  Something we're
>> reasonably confident to get right should be good enough.
>>
>> To be confident, we need to understand the script's limitations, and how
>> to compensate for them.  I figure we do now.  You too?
>>
>
> I will not be surprised, if we missed some more interesting cases :)
> But we should proceed. What is our plan? Will you queue v10 for 5.1?

v10's PATCH 1+2 look ready.  The error.h comment update could perhaps
use some polish; I've focused my attention elsewhere.

PATCH 8-9 are generated.  They should never be rebased, always be
regenerated.  We compare regenerated patches to posted ones to make sure
they are still sane, and the R-bys are still valid.  I can take care of
the comparing.

I'd like to have a pull request ready when the tree reopens for general
development.  Let's use the time until then to get more generated
patches out for review.

If I queue up patches in my tree, we shift the responsibility for
regenerating patches from you to me, and create a coordination issue:
you'll want to base patch submissions on the branch I use to queue this
work, and that's going to be awkward when I rebase / regenerate that
branch.  I think it's simpler to queue up in your tree until we're ready
for a pull request.

When you post more patches, use

    Based-on: <20200317151625.20797-1-vsementsov@virtuozzo.com>

so that Patchew applies them on top of this series.  Hmm, probably won't
do, as PATCH 9 already conflicts.

You could instead repost PATCH 1+2 with each batch.  I hope that's not
too confusing.

I trust you'll keep providing a tag reviewers can pull.

I suggest to ask maintainers to leave merging these patches to me, in
cover letters.

Makes sense?


