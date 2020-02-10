Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC813C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9781A24685
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inMewh56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9781A24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1BZM-00052k-Ly
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j1BYL-0003aH-Vu
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j1BYJ-00011a-Mj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:04:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j1BYJ-0000zy-30
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581350689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2d3HFmHtNJKNW+bi1Vdd5USAIrrlYQAE6MZCWK13k0=;
 b=inMewh56/3AK66F1mRiz1cqlnLIODd9VlZMkUJ7MfXMtfE/XXBfpI2pLuOtJZwKwOcxWlj
 bHHcdN3z/PEWejQS0hyvprMqvRnLmJobWaPpehka3XV8/RtOxhVCQKikb2QtjuCHb98Wme
 BpZmJjF3RRSIX1CeNRb4+Wt2ZJHW0eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-LTOc0kdrOGCDDCLTH5GJVA-1; Mon, 10 Feb 2020 11:04:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FE10107ACC9;
 Mon, 10 Feb 2020 16:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-243.ams2.redhat.com
 [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F9D727065;
 Mon, 10 Feb 2020 16:04:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A62AA11385C9; Mon, 10 Feb 2020 17:04:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Getting whole-tree patches reviewed and merged
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org>
 <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <CAFEAcA-C5Kvp-tUZfXSeAiFAHW-YXb+ddwFqyo5Y=0ziPhFbDA@mail.gmail.com>
 <871rrs136l.fsf_-_@dusky.pond.sub.org>
 <f450e310-3614-5e03-b932-ecba95970c95@redhat.com>
 <dc1c60f7-3f88-2d86-9f03-88cca1b6d49e@redhat.com>
Date: Mon, 10 Feb 2020 17:04:39 +0100
In-Reply-To: <dc1c60f7-3f88-2d86-9f03-88cca1b6d49e@redhat.com> (Paolo
 Bonzini's message of "Mon, 10 Feb 2020 12:26:04 +0100")
Message-ID: <874kvypgx4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LTOc0kdrOGCDDCLTH5GJVA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/02/20 22:53, Eric Blake wrote:
>> On 1/21/20 11:16 PM, Markus Armbruster wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On Tue, 21 Jan 2020 at 15:11, Marc-Andr=C3=A9 Lureau
>>>> <marcandre.lureau@gmail.com> wrote:
>>>>> There are plenty of refactoring to do. The problem when touching the
>>>>> whole code-base, imho, is review time. It may take a couple of
>>>>> hours/days to come up with a cocci/spatch, and make various patches
>>>>> here and there. But it takes often weeks and a lot of constant push t=
o
>>>>> various folks to get all the reviews (as seens by the qdev prop-ptr
>>>>> series earlier for example). How can we better address whole code-bas=
e
>>>>> changes?
>>>>
>>>> It depends. If it's literally just a cocci/spatch mechanical
>>>> transformation, I think we should be OK with reviewing that
>>>> transform and then applying it; we don't need to get acks
>>>> from every submaintainer for that kind of thing.
>>>
>>> I go one step further: I prefer mechanical changes committed together,
>>> not torn apart and routed through N+1 trees, where N is the number of
>>> active maintainers picking patches from the series, and 1 is the
>>> maintainer taking pity of the inevitable leftovers.
>>>
>>> Tearing a patch series apart may be in order when it's invasive enough
>>> to risk many conflicts.=C2=A0 The subsystem maintainer may need tighter
>>> control over merging order then, and routing picked patches through his
>>> own tree may be the practical way to get it.
>>=20
>> And the pending work on ERRP_AUTO_PROPAGATE is an example of that -
>> Vladimir has been trying to get the improvements in for some time, but
>> it touches so many files, and is awkward to review whether it is split
>> into over 100 patches per maintainer area or when it is consolidates
>> into few but large patches.
>
> If I can help with ERRP_AUTO_PROPAGATE, I can merge it through my tree.

Right now I'm to blame: I need to review the infrastructure and its
pattern of use.

Once that's done, the next questions are what level of review we want
for the instances of the pattern, and how to merge the thing.

One way is to split along subsystems boundaries, and ask subsystem
maintainers to merge their part.  Infrastructure has to go first, of
course.  That would be my job as error subsystem maintainer.  Getting
everything merged via pretty much every subsystem we have will likely be
a drawn out affair.

Another way is to go ahead and merge everything, damn the torpedoes.


