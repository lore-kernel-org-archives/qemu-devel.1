Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E946C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618D424695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJTk6OWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618D424695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7O6f-0000iS-L3
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7O62-0000GI-5R
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7O61-0007DY-62
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:41:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23782
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7O61-0007As-1d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582828876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aan4GHA4jGdZmasRoEwkI4JV8GXWa7MU/CP7Nifoz9k=;
 b=WJTk6OWj8c1U72uI7R2R4O6pPE+78hMjw8BtuwVKobmFykzopNdoAYY605L9jCXBMmQZQY
 SXZsmkHZyUyNZgRaDxuc3ebSopf6JAD6VVP2mn4ga4T7i0SWxw4SdZ0zTQ6Cn4wkvmolZz
 pJgixt8o6ePR86tlLz1hGBm3dTl9Qdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-_i2ijAlBOT-wfdoS4l80Qg-1; Thu, 27 Feb 2020 13:41:14 -0500
X-MC-Unique: _i2ijAlBOT-wfdoS4l80Qg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78A00800D50;
 Thu, 27 Feb 2020 18:41:13 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1310B101D48E;
 Thu, 27 Feb 2020 18:41:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v2 3/3] savevm: check RAM is pagesize aligned
In-Reply-To: <CAJ+F1CLgg6Yz=2V8_eCVtsJ1zPm=1-piz-Nw05KGXkSqWytLgA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 17 Feb 2020
 12:33:58 +0100")
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-4-marcandre.lureau@redhat.com>
 <8736cqi07g.fsf@secure.laptop>
 <CAJ+F1CLgg6Yz=2V8_eCVtsJ1zPm=1-piz-Nw05KGXkSqWytLgA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 27 Feb 2020 19:41:10 +0100
Message-ID: <87r1yfc1q1.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Reply-To: quintela@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> Hi Juan
>
> On Wed, Jan 8, 2020 at 2:08 PM Juan Quintela <quintela@redhat.com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>> n> Check the host pointer is correctly aligned, otherwise we may fail
>> > during migration in ram_block_discard_range().
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> queued
>>
>
> Did it get lost? thanks

I dropped it in the past, because it made "make check" for mips fail.
(I put it on my ToDo list to investigate and forgot about it)

But now it pass, go figure.

Included again.  Sorry.

Later, Juan.


