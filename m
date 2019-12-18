Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B528FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA0621582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c026CSMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA0621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUzi-0005Bv-O8
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUyw-0004gL-LC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUyu-0006eH-F0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:46:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUyu-0006bj-5Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576658815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ee5gUjBENRaG/tHQKTptNVk3k88PEC2471tSsxGrdCI=;
 b=c026CSMKGuvl0SStxfa8nEJBnFCtOkolITYeU6bP0D2b4BC1THwRqmTSi774dhRGcXrhdU
 SxTUx2/AuVv8QePDztoGJArx0F0dLPiGyxilX950U43KOyYeMZHpgz84t8mx2fkU5+SndK
 xkpQwHluc3LexS/l+NNp9uPio608MW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-TUlf4UHGPj-yHRhBW_YuDg-1; Wed, 18 Dec 2019 03:46:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80D9C10054E3;
 Wed, 18 Dec 2019 08:46:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D4B11001902;
 Wed, 18 Dec 2019 08:46:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D3D6211386A7; Wed, 18 Dec 2019 09:46:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 34/34] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
References: <20191217062651.9687-1-armbru@redhat.com>
 <20191217062651.9687-35-armbru@redhat.com>
 <4135813b-af52-b743-858c-a86dbd3ebce3@redhat.com>
 <87imme84ya.fsf@dusky.pond.sub.org>
Date: Wed, 18 Dec 2019 09:46:50 +0100
In-Reply-To: <87imme84ya.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 18 Dec 2019 08:31:57 +0100")
Message-ID: <87sgli3ts5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TUlf4UHGPj-yHRhBW_YuDg-1
X-Mimecast-Spam-Score: 0
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 12/17/19 12:26 AM, Markus Armbruster wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> All callers of nbd_iter_channel_error() pass the address of a
>>> local_err variable, and only call this function if an error has
>>> already occurred, using this function to propagate that error.
>>> This is already implied by its name (local_err instead of the classic
>>> errp), but it is worth additionally stressing this by adding an
>>> assertion to make it part of the function contract.
>>>
>>> The local_err parameter is not here to return information about
>>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>>> passed to the function. This is already stressed by its name
>>> (local_err, instead of classic errp). Stress it additionally by
>>> assertion.
>>
>> Redundant paragraph, but probably too late to worry about it now that
>> we have a pull request.
>
> I'll have to respin anyway.  I'll drop the second paragraph.

Rats, I forgot.


