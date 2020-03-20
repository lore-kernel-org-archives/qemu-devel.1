Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D309AC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E63F20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnUyR998"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E63F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKRP-0001kt-R1
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFKQd-0000j9-9l
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFKQc-0008NF-3l
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:23:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFKQc-0008N8-0W
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584721401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awW7pCDqmWK/KSJi6O/6BS9ZZE4mG3U1A4mlWPNdVK8=;
 b=dnUyR998gfXYZYOCqFnmsORoz9OZ+Bd/BJOYYylFtKBEq9gz9SoPCwD+GfdN+Oov5a+Nja
 VhR3XlbOtaGFl8btddRrBumE4djYr+fEW4uGLbvDPskGrtfLFFeXqGEVBbJWYiVlAkIHvH
 cKrWHLfN7+cxZRQ0ZLEzSC3tth7Rov8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-6VVNQMM0PO2NCdl0ZUJc2A-1; Fri, 20 Mar 2020 12:23:20 -0400
X-MC-Unique: 6VVNQMM0PO2NCdl0ZUJc2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30194100550D;
 Fri, 20 Mar 2020 16:23:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ED465C1D8;
 Fri, 20 Mar 2020 16:23:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4F921138404; Fri, 20 Mar 2020 17:23:10 +0100 (CET)
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
 <87r1xn2kmf.fsf@dusky.pond.sub.org>
 <28ac8e37-6b43-3755-61d7-41dc2d45ed94@virtuozzo.com>
Date: Fri, 20 Mar 2020 17:23:10 +0100
In-Reply-To: <28ac8e37-6b43-3755-61d7-41dc2d45ed94@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 20 Mar 2020 17:36:06 +0300")
Message-ID: <87sgi3xafl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 20.03.2020 16:58, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
[...]
>>> I will not be surprised, if we missed some more interesting cases :)
>>> But we should proceed. What is our plan? Will you queue v10 for 5.1?
>>
>> v10's PATCH 1+2 look ready.  The error.h comment update could perhaps
>> use some polish; I've focused my attention elsewhere.
>>
>> PATCH 8-9 are generated.  They should never be rebased, always be
>> regenerated.  We compare regenerated patches to posted ones to make sure
>> they are still sane, and the R-bys are still valid.  I can take care of
>> the comparing.
>>
>> I'd like to have a pull request ready when the tree reopens for general
>> development.  Let's use the time until then to get more generated
>> patches out for review.
>>
>> If I queue up patches in my tree, we shift the responsibility for
>> regenerating patches from you to me, and create a coordination issue:
>> you'll want to base patch submissions on the branch I use to queue this
>> work, and that's going to be awkward when I rebase / regenerate that
>> branch.  I think it's simpler to queue up in your tree until we're ready
>> for a pull request.
>>
>> When you post more patches, use
>>
>>      Based-on: <20200317151625.20797-1-vsementsov@virtuozzo.com>
>>
>> so that Patchew applies them on top of this series.  Hmm, probably won't
>> do, as PATCH 9 already conflicts.
>>
>> You could instead repost PATCH 1+2 with each batch.  I hope that's not
>> too confusing.
>>
>> I trust you'll keep providing a tag reviewers can pull.
>>
>> I suggest to ask maintainers to leave merging these patches to me, in
>> cover letters.
>>
>> Makes sense?
>>
>
> Hmm.
>
> I remember what Kevin said about freeze period: maintainers will queue
> a lot of patches in their "next" branches, and send pull requests at star=
t
> of next developing period. This highly possible will drop r-bs I can get =
now.
> And reviewers will have to review twice.
>
> And for the same reason, it's bad idea to queue in your branch a lot of p=
atches
> from different subsystems during freeze.
>
> So, just postpone this all up to next development phase?

Okay.  I hope we can process generated patches at a brisk pace then.


