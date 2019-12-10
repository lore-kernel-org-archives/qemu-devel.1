Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FD9C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C390E206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6Pa/uoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C390E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iebTd-00021f-0T
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 04:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iebSs-0001OQ-4d
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iebSr-0001Le-0m
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:05:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iebSq-0001LM-TE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575968752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HR0/O90eh/xgfPlTakWHF9FbasToob4FtmLWWPnEoVw=;
 b=W6Pa/uoAKTziwgsQudzK1kvXi8jsKth9toG/M0EHEXLU0PcGX7X8+UrFL+XuyB5Pj3emsU
 vX46lQ+A328ziVFeyJl1KVYCMBVPAouncnLs0C0mXel5ZclrA6TcP7PXvwRFfMgZ2rzymM
 dYdWiO2IYLT7uLYKD9m9GdAs3GbhmXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-hxgPu4UiM5WHqaIMzTg9wA-1; Tue, 10 Dec 2019 04:05:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11FE61800D45;
 Tue, 10 Dec 2019 09:05:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B462660BE1;
 Tue, 10 Dec 2019 09:05:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E04C11386A7; Tue, 10 Dec 2019 10:05:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-22-vsementsov@virtuozzo.com>
 <54278946-ad45-1a0d-e2b2-f96b86285c05@redhat.com>
 <8736dxcuo5.fsf@dusky.pond.sub.org>
 <6d55367c-42a3-3622-a483-d997b428796d@virtuozzo.com>
Date: Tue, 10 Dec 2019 10:05:48 +0100
In-Reply-To: <6d55367c-42a3-3622-a483-d997b428796d@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 6 Dec 2019 18:19:36 +0000")
Message-ID: <87a780mtxv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hxgPu4UiM5WHqaIMzTg9wA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 06.12.2019 18:58, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>=20
>>> On 12/5/19 11:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> The local_err parameter is not here to return information about
>>>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>>>> passed to the function. This is already stressed by its name
>>>> (local_err, instead of classic errp). Stress it additionally by
>>>> assertion.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block/nbd.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>
>>> Our timing resulted in crossed mails - I was replying to v7 when this
>>> landed, and my reply there is still relevant (namely, a better commit
>>> message is needed, but the code gets my R-b with that change).
>>=20
>> If v8 turns out to be fine except for commit message tweaks, I'll gladly
>> to these in my tree.  Just tell me what to do in a reply to this
>> message.
>>=20
>
> Yes, this would be great, thanks!
>
> The only thing is your suggestion on patch 21, but it may be applied in s=
eparate (and it's actually a separate thing)

It's closer to idea than to suggestion, and it's separate.

Commit message in my tree:

    nbd: assert that Error** is not NULL in nbd_iter_channel_error
   =20
    All callers of nbd_iter_channel_error() pass the address of a
    local_err variable, and only call this function if an error has
    already occurred, using this function to propagate that error.
    This is already implied by its name (local_err instead of the classic
    errp), but it is worth additionally stressing this by adding an
    assertion to make it part of the function contract.
   =20
    The local_err parameter is not here to return information about
    nbd_iter_channel_error failure. Instead it's assumed to be filled when
    passed to the function. This is already stressed by its name
    (local_err, instead of classic errp). Stress it additionally by
    assertion.

Also:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


