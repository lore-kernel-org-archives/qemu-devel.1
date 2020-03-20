Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5039EC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1902520739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9tGcYBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1902520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKG3-0000C9-9C
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFKEc-0007xM-Uk
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFKEb-0005zZ-PY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:10:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFKEb-0005ws-LK
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584720655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1HBJ6pY19pIcQvdExPD6Qv0fcGv6AOMucTKAfFxSlY=;
 b=Z9tGcYBUI9u3SvSwdZ1/Uku5KVCn8ShyzuYMnDtTDabZ3vqJ7GpInbasgD9eIWqQWnDsWK
 vgnNq0HjZW6PBqyZ44CtRPVtxuZRfiU2NyplYyR6ueoNICwS/qnBZ10eJx7bUxDPtf3tTQ
 op8NKSuUXp0XMlLHqiyE0eQzcwrEOQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-dgwNmEOVPYylm7_atkojHA-1; Fri, 20 Mar 2020 12:10:53 -0400
X-MC-Unique: dgwNmEOVPYylm7_atkojHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A743108C1E1;
 Fri, 20 Mar 2020 16:10:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2746F97AE0;
 Fri, 20 Mar 2020 16:10:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F0571138404; Fri, 20 Mar 2020 17:10:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PULL 08/27] ppc405_boards: Don't size flash memory
 to match backing image
References: <20190311220843.4026-1-armbru@redhat.com>
 <20190311220843.4026-9-armbru@redhat.com>
 <CAFEAcA_2pgp0yg3hd1TsT+VkMoMDKvvr=Fjz_kmUn0E-Fe6RZw@mail.gmail.com>
Date: Fri, 20 Mar 2020 17:10:43 +0100
In-Reply-To: <CAFEAcA_2pgp0yg3hd1TsT+VkMoMDKvvr=Fjz_kmUn0E-Fe6RZw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 20 Mar 2020 15:25:38 +0000")
Message-ID: <87blorypks.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 11 Mar 2019 at 22:10, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
>> Image size is rounded up to the next multiple of 64KiB.  Useless,
>> because pflash_cfi02_realize() fails with "failed to read the initial
>> flash content" unless the rounding is a no-op.
>>
>> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
>> other stuff.  No idea how that would play out, but useful outcomes
>> seem unlikely.
>>
>> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
>> regardless of image size, to match the physical hardware.
>>
>> Machine "taihu" maps its boot flash memory similarly.  The code even
>> has a comment /* XXX: should check that size is 2MB */, followed by
>> disabled code to adjust the size to 2MiB regardless of image size.
>>
>> Its code to map its application flash memory looks the same, except
>> there the XXX comment asks for 32MiB, and the code to adjust the size
>> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
>> to read the initial flash content" for images smaller than 32MiB.
>>
>> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
>> to match the physical hardware.  Delete dead code from application
>> flash mapping, and simplify some.
>>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20190308094610.21210-9-armbru@redhat.com>
>> ---
>>  hw/ppc/ppc405_boards.c | 36 ++++++++++++------------------------
>>  1 file changed, 12 insertions(+), 24 deletions(-)
>
> Hi; Coverity has just noticed a minor bug in this patch
> (CID 1421917):
[...]
> Anybody feel like sending a patch?
>
> thanks
> -- PMM

Philippe just posted the obvious fix.

[...]


