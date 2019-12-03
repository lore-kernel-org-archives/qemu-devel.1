Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9DC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2B920684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/ooX4Rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2B920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2dT-0004FU-72
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ic2bH-0003m0-VX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ic2bF-0007CW-Tp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:27:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ic2bE-00079J-9L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575358074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvT0AXc2SKpSSMRgNG1Jx297qYvigzCh8UTYlBvFNXs=;
 b=M/ooX4RjacljxSnhkVg70kq1KkFJ6sIoZY9wi3F5ZyN8QIbkzUBKb18UePYH7jx0sVqlmN
 npVVaL9VQCev6cQvZa8b+gksx6TcG+4l0GqOo87f+UGcbGXBWZ1ffCYaEE9RCtyiVq/q9O
 guD1Jb+eLDWCnsb5oNSmE0WRZsY8iYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-AHGohzrWPXKxaTeTKZbIQA-1; Tue, 03 Dec 2019 02:27:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C051005510;
 Tue,  3 Dec 2019 07:27:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E205D6A7;
 Tue,  3 Dec 2019 07:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0965C1138606; Tue,  3 Dec 2019 08:27:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
References: <20191130194240.10517-18-armbru@redhat.com>
 <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
 <CAL1e-=jst9hGBXy0zm-975QDvW0F0xBNJAypqM4KooWEUvJfjQ@mail.gmail.com>
 <d9eb5b70-8396-7537-aac5-24c4d872d553@redhat.com>
 <87sgm3nww5.fsf@dusky.pond.sub.org>
 <631941d9-0e30-330b-e50e-4c9d99824e73@redhat.com>
Date: Tue, 03 Dec 2019 08:27:46 +0100
In-Reply-To: <631941d9-0e30-330b-e50e-4c9d99824e73@redhat.com> (David
 Hildenbrand's message of "Mon, 2 Dec 2019 09:34:23 +0100")
Message-ID: <87a78998ct.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: AHGohzrWPXKxaTeTKZbIQA-1
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
Cc: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <dhildenb@redhat.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> [...]
>
>> First search hit.  Here's my second one:
>>=20
>>     Q: What are latent bugs?
>>=20
>>     A: These bugs do not cause problems today. However, they are lurking
>>     just waiting to reveal themselves later.  The Ariane 5 rocket
>>     failure was caused by a float->int conversion error that lay dormant
>>     when previous rockets were slower; but the faster Ariane 5 triggered
>>     the problem.  The Millennium bug is another example of a latent bug
>>     that came to light when circumstances changed.  Latent bugs are much
>>     harder to test using conventional testing techniques, and finding
>>     them requires someone with foresight to ask.
>>=20
>> http://www.geekinterview.com/question_details/36689
>
> Google search "latent software BUG"

I think this argument has run its course.  Let's agree to differ on the
finer meaning and possible uses of "latent", and craft a mutually
agreeable commit message instead.  I'll reply to Cornelia's message.

[...]


