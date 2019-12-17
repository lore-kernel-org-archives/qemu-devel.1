Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40353C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC952146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFvgN6ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC952146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFAP-0008Gv-72
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihF9o-0007li-QB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihF9k-0005bm-B3
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:53:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihF9j-0005a8-SW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576597983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAd5a0IYBmeqImC7ySx90moIv1X1u/F1feAQchisnUA=;
 b=iFvgN6ny9enW4e+LGL1y9wpZBNx7+IYjVwMz+1yuiXzsXfuyRNM2NsJZv3vROC6CRWn9CP
 ofqUOrnBQSKpm3YlDHAAvEz3Z+QAcordWONqcRgFxqns72NDvJehZcfkf/9uBYaq5bQFva
 4oVTqr//EGYtpXKPojRPwPBVDF7gSd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-IhZKjhx7O1uoRlVpPCX5iw-1; Tue, 17 Dec 2019 10:53:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 173F7800D50;
 Tue, 17 Dec 2019 15:52:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-20.ams2.redhat.com [10.36.117.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C83C675BF;
 Tue, 17 Dec 2019 15:52:56 +0000 (UTC)
Date: Tue, 17 Dec 2019 16:52:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Lieven <pl@kamp.de>
Subject: Re: bdrv_co_pwritev: Assertion `!waited || !use_local_qiov' failed.
Message-ID: <20191217155255.GA6580@linux.fritz.box>
References: <16b69066-cabb-3412-0005-886055352a05@kamp.de>
MIME-Version: 1.0
In-Reply-To: <16b69066-cabb-3412-0005-886055352a05@kamp.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: IhZKjhx7O1uoRlVpPCX5iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: vsementsov@virtuozzo.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.12.2019 um 15:14 hat Peter Lieven geschrieben:
> I have a vserver running Qemu 4.0 that seems to reproducibly hit the
> following assertion:
>=20
> =A0bdrv_co_pwritev: Assertion `!waited || !use_local_qiov' failed.
>=20
> I noticed that the padding code was recently reworked in commit
> 2e2ad02f2c. In the new code I cannot find a similar assertion. Was
> the assertion wrong or why was it dropped?

No, the assertion in the old version makes sense to me. The code goes
basically like this:

    if (head unaligned) {
        /* Make sure no new conflicting request will be started */
        mark_request_serialising()

        /* Wait if a conflicting request is already in flight */
        wait_serialising_requests()

        adjust start of the request
    }

    if (tail unaligned) {
        /* Make sure no new conflicting request will be started */
        mark_request_serialising()

        /* Wait if a conflicting request is already in flight. If we
         * already had an unaligned head, we already waited for
         * conflicting requests and no new requests may have been
         * started, so in this case this must be a no-op. */
        wait_serialising_requests()

        adjust end of the request
    }

If the assertion fails, we already waited in the "head unaligned" case,
but a new request snuck in even though we marked this request as
serialising, so the other request should have waited.

This might mean that a wait_serialising_requests() is missing somewhere.

> I try to add some debugging code to find out what is exactly happing.
> Especially the requests that are in flight when the assertion is
> triggered.

You can just have a look at bs->tracked_requests in gdb (if you can
trigger the bug in a debugging environment). However, at the time of the
assertion it's too late, we have waited for the bad request to complete,
so it's gone now. You probably need to tell
bdrv_wait_serialising_requests() that it's not supposed to wait, so you
can assert the condition already there.

(In the new code, I think the situation is different because both head
and tail are handled at once, so we don't even have two instances of
mark_request_serialising() and wait_serialising_requests() any more. But
if a bug existed previously, it probably still exists.)

Kevin


