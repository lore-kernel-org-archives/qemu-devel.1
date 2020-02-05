Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F0EC35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 08:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FE820730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 08:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czdl+SD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FE820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izG0Q-0000pk-Fw
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 03:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izFz5-0000Cu-Uf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 03:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izFz3-0003H7-MZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 03:24:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izFz3-0003Ax-Ar
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 03:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580891067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCpnI5cEy/V3XOm+FZ8L38pzSU3OdNarT8lY2kfXfqo=;
 b=czdl+SD77TDbFFrd27zCS8fEI+NRPiGImhyxY9x13ABtiqk8CD/Wwi8dM2kMts9u6Xe7Jl
 duh2lA6IrB4VA2RlDZJXaCnWyvPDwOfJ2yugHyQo7hfFuYThrO25GsXFjo/2aZXIUrLi9O
 KmlLeyyHNmHuzm1u1bUmzIzORo0EdnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-yUsUEbs9N3avGlQVVM8frA-1; Wed, 05 Feb 2020 03:24:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EA30DBA5;
 Wed,  5 Feb 2020 08:24:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB96A84779;
 Wed,  5 Feb 2020 08:24:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7109A11386A7; Wed,  5 Feb 2020 09:24:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
Date: Wed, 05 Feb 2020 09:24:20 +0100
In-Reply-To: <877e18oq76.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 30 Jan 2020 17:37:49 +0100")
Message-ID: <87mu9xxwzv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: yUsUEbs9N3avGlQVVM8frA-1
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel, Kevin, any comments or objections to the QAPI schema design
sketch developed below?

For your convenience, here's the result again:

    { 'enum': 'LUKSKeyslotState',
      'data': [ 'active', 'inactive' ] }
    { 'struct': 'LUKSKeyslotActive',
      'data': { 'secret': 'str',
                '*iter-time': 'int } }
    { 'union': 'LUKSKeyslotAmend',
      'base': { '*keyslot': 'int',
                'state': 'LUKSKeyslotState' }
      'discriminator': 'state',
      'data': { 'active': 'LUKSKeyslotActive' } }

Markus Armbruster <armbru@redhat.com> writes:

[...]
> A keyslot can be either inactive or active.
>
> Let's start low-level, i.e. we specify the slot by slot#:
>
>     state       new state   action
>     inactive    inactive    nop
>     inactive    active      put secret, iter-time, mark active
>     active      inactive    mark inactive (effectively deletes secret)
>     active      active      in general, error (unsafe update in place)
>                             we can make it a nop when secret, iter-time
>                                 remain unchanged
>                             we can allow unsafe update with force: true
>
> As struct:
>
>     { 'struct': 'LUKSKeyslotUpdate',
>       'data': { 'active': 'bool',       # could do enum instead
>                 'keyslot': 'int',
>                 '*secret': 'str',       # present if @active is true
>                 '*iter-time': 'int' } } # absent if @active is false
>
> As union:
>
>     { 'enum': 'LUKSKeyslotState',
>       'data': [ 'active', 'inactive' ] }
>     { 'struct': 'LUKSKeyslotActive',
>       'data': { 'secret': 'str',
>                 '*iter-time': 'int } }
>     { 'union': 'LUKSKeyslotAmend',
>       'base': { 'state': 'LUKSKeyslotState' }   # must do enum
>       'discriminator': 'state',
>       'data': { 'active': 'LUKSKeyslotActive' } }
>
> When we don't specify the slot#, then "new state active" selects an
> inactive slot (chosen by the system, and "new state inactive selects
> slots by secret (commonly just one slot).
>
> New state active:
>
>     state       new state   action
>     inactive    active      put secret, iter-time, mark active
>     active      active      N/A (system choses inactive slot)
>
> New state inactive, for each slot holding the specified secret:
>
>     state       new state   action
>     inactive    inactive    N/A (inactive slot holds no secret)
>     active      inactive    mark inactive (effectively deletes secret)
>
> As struct:
>
>     { 'struct': 'LUKSKeyslotUpdate',
>       'data': { 'active': 'bool',       # could do enum instead
>                 '*keyslot': 'int',
>                 '*secret': 'str',       # present if @active is true
>                 '*iter-time': 'int' } } # absent if @active is false
>
> As union:
>
>     { 'enum': 'LUKSKeyslotState',
>       'data': [ 'active', 'inactive' ] }
>     { 'struct': 'LUKSKeyslotActive',
>       'data': { 'secret': 'str',
>                 '*iter-time': 'int } }
>     { 'union': 'LUKSKeyslotAmend',
>       'base': { '*keyslot': 'int',
>                 'state': 'LUKSKeyslotState' }
>       'discriminator': 'state',
>       'data': { 'active': 'LUKSKeyslotActive' } }
>
> Union looks more complicated because our union notation sucks[*].  I
> like it anyway, because you don't have to explain when which optional
> members aren't actually optional.
>
> Regardless of struct vs. union, this supports an active -> active
> transition only with an explicit keyslot.  Feels fine to me.  If we want
> to support it without keyslot as well, we need a way to specify both old
> and new secret.  Do we?
>
>
> [*] I hope to fix that one day.  It's not even hard.


