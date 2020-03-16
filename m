Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11515C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D340420409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6TyJkj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D340420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtMg-0000YV-0s
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDquf-0004Hu-TN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDque-0003zm-Eo
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:40:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDque-0003uy-8d
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584369615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Czoi727Qg9oCZu1w42vol8KBAGSD9icfOQv3jriOJ64=;
 b=Y6TyJkj5vcCd4YTcg1Icnh6oDjGVKVfD8Uu3lqV5tdfnCV1RNbc2CihaGmZPHjila/Xulk
 X/6pV9QNqGY51DmpALFZtx41vSDq+K29E4o1gtnjUPH5QeWEp6/0+4IPc3kzNoAUYu8tgA
 2O5TyWtfK1kDDuzCcmD70IDDbSwvyuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-U2KcF7hKM_ehlnSvpGiSeA-1; Mon, 16 Mar 2020 10:40:12 -0400
X-MC-Unique: U2KcF7hKM_ehlnSvpGiSeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 591B1100550D;
 Mon, 16 Mar 2020 14:40:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4C15DA7C;
 Mon, 16 Mar 2020 14:40:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD7D11138404; Mon, 16 Mar 2020 15:40:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 00/11] error: auto propagated local_err part I
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <87y2shdg00.fsf@dusky.pond.sub.org>
 <87abeabb-c8ee-ed6f-6b3a-b3fc24d07b89@virtuozzo.com>
Date: Mon, 16 Mar 2020 15:40:02 +0100
In-Reply-To: <87abeabb-c8ee-ed6f-6b3a-b3fc24d07b89@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 3 Mar 2020 11:12:46 +0300")
Message-ID: <87r1xsfjnh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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

> 03.03.2020 11:01, Markus Armbruster wrote:
>> Hi Vladimir,
>>
>> I've come to rather like your ERRP_AUTO_PROPAGATE() idea.  What I
>> wouldn't like is a protracted conversion.
>>
>> Once we're happy with PATCH 1-3, it's a matter of running Coccinelle and
>> reviewing its output.  I'm confident we can converge on PATCH 1-3.
>>
>> It's two weeks until soft freeze.  We need to decide whether to pursue a
>> partial conversion for 5.0 (basically this series plus the two patches
>> we identified in review of PATCH 1), or delay until 5.1.  In either
>> case, I want the conversion to be finished in 5.1.
>>
>> Please do not feel pressured to make the 5.0 deadline.
>>
>> I can queue up patches for 5.1 during the freeze.
>>
>> How would you like to proceed?
>>
>
> Hi Markus! Funny coincidence: exactly now (less than 1 hour ago), I've
> started working for the next version for these series. So, I'm going to
> resend today. Of course, I'd prefer to merge something to 5.0 if at all
> possible.

That was v8, followed by v9.  We're clearly converging.  However, the
soft freeze is tomorrow already.

You've persevered with this idea for quite a while; some impatience
would be quite excusable now.  Still, I doubt part I making 5.0 matters.
The hand-written part is likely to rebase easily, and the generated part
should be regenerated instead of rebased anyway.

What actually matters is *finishing* the job.  What does that take?

* Consensus on the hand-written part.  I think we're basically there, we
  just want to work in a few more tweaks.

* Split the generated part into reviewable batches, regenerating patches
  as necessary.  Solicit review.  First batch is part of this series,
  and v9 looks ready to me.  I assume you'll prepare the remaining
  batches.

* Queue up batches as they become ready, post pull requests.  I can do
  that.

* Update the QAPI code generator to the new Error usage.  I can do that.


