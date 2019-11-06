Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C6AC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9352320869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDwmWVm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9352320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKfE-0000Lh-Rs
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iSKeK-0008Ia-LG
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iSKeI-0001Qh-31
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:43:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iSKeH-0001PN-Tg
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573044176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcoSnJV/XROrB9qvHyy7GqkQWJQhzfECWq9JgnH+xxA=;
 b=FDwmWVm6xKKn4Gn1jvDGWDSZmy0mXmSHPNjyppoBlxGp/msx1bWvZmJO6AdMQzkwAOEDS8
 N5zq1kTyhX6iRZhHYKiuZCXLudXCEfR14zQAtFLvWW2lnWF1GB9twRJrIEgAFqjm49qf7N
 /petkGDFcIEX/vjQHIaXZAdUEejd0f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-RZviNECVO3WCnJ0YrwcZHw-1; Wed, 06 Nov 2019 07:42:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A1338017DD;
 Wed,  6 Nov 2019 12:42:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECCD760C88;
 Wed,  6 Nov 2019 12:42:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 669A511385C9; Wed,  6 Nov 2019 13:42:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <87lft9rnfs.fsf@dusky.pond.sub.org> <87lft8lvdh.fsf@linaro.org>
 <874kzw60bp.fsf@dusky.pond.sub.org>
Date: Wed, 06 Nov 2019 13:42:50 +0100
In-Reply-To: <874kzw60bp.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 25 Oct 2019 22:23:54 +0200")
Message-ID: <87h83hqiph.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: RZviNECVO3WCnJ0YrwcZHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> I hate to interfere with the merging of working code for non-technical
>>> reasons....
>>>
>>> This is a plugin interface.  As I wrote in reply to v4, I'd like to see
>>> a pragmatic argument why abuse of the plugin interface to circumvent th=
e
>>> GPL is not practical.  This might include "not a stable interface", "yo=
u
>>> have to link with a truckload of gpl code", "the set of things you can
>>> do is deliberately extremely limited".
[...]
>>> If merging this could be delayed until the licensing ramifications have
>>> become a bit more clear, I'd be obliged.
>>
>> I'd rather not unless we can make an exception for late merging of the
>> PR. I've worked quite hard to make sure everything is ready for the 4.2
>> window and I'd rather not miss a whole release cycle on a
>> misunderstanding of what these plugins allow.
>
> I think there are multiple ways to avoid the nuclear outcome.
>
> Coming to a conclusion before the soft freeze is the nicest one.
>
> Making an exception for late merging is another one, but Peter may
> prefer not to.
>
> Yet another one is merging the pull request before the soft freeze with
> the understanding that it'll be reverted unless we come to a positive
> conclusion before say -rc0 (Nov 5).  I'm confident we can work it out in
> Lyon.

The series has since been merged, so just for the record: we did.  The
plugin interface looks useful for its stated purposes, yet pretty
useless for GPL circumvention.  We'll evolve it deliberately to preserve
that property.

Alex, thank you for your patience.


