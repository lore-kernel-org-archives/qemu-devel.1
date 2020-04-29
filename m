Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A14C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F37206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePdIJ8bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F37206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTf7h-0000hB-IA
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 01:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTf76-000088-63
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTf6p-0002V5-Rh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:18:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTf6p-0002In-DJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588137490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuTgRWpt86WWGv650Ril27SP8hJ7unzgOpHvp2h3xx8=;
 b=ePdIJ8bqOsOGYoqLXpXxakehjqiCTnAeua7RdcdPruWphXR2fN0SDHgkxgKOaY3VsRZ+Jp
 eB1syl68KPHkjfTm4eYeu0T5Skp8Ro3Qqsbi5BXQp1yR+e1OkpgknpJeRaI5yMNERxtsBM
 92OS5vfAIlnQ5Ck0F0d+uwWBKtqPUP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-GhE7__m_OY-je3OhlgQj5Q-1; Wed, 29 Apr 2020 01:18:06 -0400
X-MC-Unique: GhE7__m_OY-je3OhlgQj5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D4E580058A;
 Wed, 29 Apr 2020 05:18:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8386A391;
 Wed, 29 Apr 2020 05:18:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D3D1311358BC; Wed, 29 Apr 2020 07:18:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 1/4] sam460ex: Revert change to SPD memory type for <= 128
 MiB
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-2-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201604130.29873@zero.eik.bme.hu>
 <87imht5rw1.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004221543560.19234@zero.eik.bme.hu>
Date: Wed, 29 Apr 2020 07:18:02 +0200
In-Reply-To: <alpine.BSF.2.22.395.2004221543560.19234@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Wed, 22 Apr 2020 15:56:46 +0200 (CEST)")
Message-ID: <87tv12x439.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 21 Apr 2020, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Mon, 20 Apr 2020, Markus Armbruster wrote:
>>>> Requesting 32 or 64 MiB of RAM with the sam460ex machine type produces
>>>> a useless warning:
>>>>
>>>>    qemu-system-ppc: warning: Memory size is too small for SDRAM type, =
adjusting type
>>>
>>> Why is it useless? It lets user know there was a change so it could
>>> help debugging for example.
>>
>> The memory type is chosen by QEMU, not the user.  Why should QEMU warn
>> the user when it chooses DDR, but not when it chooses DDR2?
>>
>>>> This is because sam460ex_init() asks spd_data_generate() for DDR2,
>>>> which is impossible, so spd_data_generate() corrects it to DDR.
>>>
>>> This is correct and intended. The idea is that the board code should
>>> not need to know about SPD data, all knowledge about that should be in
>>> spd_data_genereate().
>>
>> I challenge this idea.
>>
>> The kind of RAM module a board accepts is a property of the board.
>> Modelling that in board code is sensible and easy.  Attempting to model
>> it in a one size fits all helper function is unlikely to work for all
>> boards.
>>
>> Apparently some boards (including malta) need two banks, so your helper
>> increases the number of banks from one to two, but only when that's
>> possible without changing the type.
>>
>> What if another board needs one bank?  Four?  Two even if that requires
>> changing the type?  You'll end up with a bunch of flags to drive the
>> helper's magic.  Not yet because the helper has a grand total of *two*
>> users, and much of its magic is used by neither, as demonstrated by
>> PATCH 2.
>>
>> If you want magic, have a non-magic function that does exactly what it's
>> told, and a magic one to tell it what to do.  The non-magic one will be
>> truly reusable.  You can have any number of magic ones.  Boards with
>> sufficiently similar requirements can share a magic one.
>
> So far we have only sufficiently similar boards that can share the
> only magic function. Not many boards use SPD data (these are mostly
> needed for real board firmware so anything purely virtual don't model
> it usually). The refactoring you propose could be needed if we had
> more dissimilar boards but I think we could do that at that
> time. Until then I've tried to make it simple for board code and put

Keeping things simple and just serve the needs you actually have is
good.  We're in a much better position to figure out how to best serve
more complicated needs once we actually have them :)

> all magic in one place instead of having separate implementation of
> this in several boards. Maybe someone should try to convert the
> remaining boards (MIPS Malta and ARM integratorcp) to see if any
> refactoring is needed before doing those refactoring without checking
> first what's needed. I did not try to convert those boards because I
> cannot test them.

That's fair.

[...]


