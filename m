Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2668AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08B220637
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeuT7vhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08B220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY409-00052Q-3R
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iY3xM-0001ft-3J
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iY3xK-0003Ha-KR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:06:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iY3xK-0003HA-Ei
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574409977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6dJ0C509wToZGP7p4MNmO/tcMzllleaMvzJ6Bf+648=;
 b=GeuT7vhluBrA2jKIVsYMSvWSPYPR4s8fMLoCppa2AEBdHD5wFOqblL+EMJy/12lSr772S6
 6Tq9qXlgsHtEjYsx73HS+XfVCC47M7+pyluIRY31t5l/eSgmdenUx1ABTLwFjiDaeoPLAs
 GoDmtYGIob4ud3uWqODy5TNQ9Qot/aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-LrbtbpbHPra8RY8MX08WXQ-1; Fri, 22 Nov 2019 03:06:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 732BC1883521;
 Fri, 22 Nov 2019 08:06:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C06B5DDB2;
 Fri, 22 Nov 2019 08:06:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B52981138606; Fri, 22 Nov 2019 09:06:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fangrui Song <i@maskray.me>
Subject: Re: [PATCH v2] Fix incorrect integer->float conversions caught by
 clang -Wimplicit-int-float-conversion
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <20191119204932.5gdzlsplijveqwju@gmail.com>
 <e456fd62-95d7-4a52-9e14-cf0dbe01f995@redhat.com>
 <20191122000045.vz3eq6s6aqkv6l6h@gmail.com>
Date: Fri, 22 Nov 2019 09:06:12 +0100
In-Reply-To: <20191122000045.vz3eq6s6aqkv6l6h@gmail.com> (Fangrui Song's
 message of "Thu, 21 Nov 2019 16:00:45 -0800")
Message-ID: <87lfs8tjwr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LrbtbpbHPra8RY8MX08WXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fangrui Song <i@maskray.me> writes:

> On 2019-11-21, Eric Blake wrote:
>>On 11/19/19 2:49 PM, Fangrui Song wrote:
>>
>>>>
>>>>Can we simply drop the offending line statement instead?
>>>
>>>Fixed in the new patch.
>>>
>>
>>>>The first val * mul above this range is 0x1p64.=C2=A0 Rejecting it is
>>>>correct, because it overflows yint64_t.
>>>
>>>I am not subscribed, so apologize that this email may be off the thread.
>>>
>>>(The binutils mailing list allows a user to download the raw email so I
>>>can still reply to a specific email, but this list does not provide such
>>>feature.)

There's <https://lists.gnu.org/archive/mbox/qemu-devel/>.

>> Actually, it's better to post a v2 patch as a new top-level thread,
>> rather than buried as an attachment to a reply to v1, because our CI
>> tooling doesn't see through the attachment (nor was it easy for me
>> to reply to the v2 patch - I had to open the attachment to paste its
>> text inline below...).
>>
>>More patch submission hints at https://wiki.qemu.org/Contribute/SubmitAPa=
tch
>
> Retitled to [PATCH v2]

Good, such versioning is essential to avoid confusion.  Next time, start
a new top-level thread for v2.  Our patch submission processing
(automated as well as human) expects that.

I just did it for you: "[PATCH v3 0/2] Fix incorrect integer->float
conversion caught by clang".

Many thanks for your fixes!


