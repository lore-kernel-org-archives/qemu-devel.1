Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECCEC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EA124656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ab2Ivxdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EA124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8OH-000842-84
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iu8NU-0007cO-9Q
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iu8NR-0006Vf-Dv
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:16:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20374
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iu8NR-0006Uh-3W
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579670188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STto//pbkBoN/wrHN/ihAlDGfDE+PKnUy+KH/BwKa0A=;
 b=Ab2IvxdhIVNNNk9Ajl3ha4KeUigG8Q2gNR54xQmGTl1/QrPSBGkHPQ97WrW+/6rzc5kmTA
 Vd9QbUzIF5yP6BTA9QZD25TlMzbX5lPBojPBlIDBLMJU+jvfZ+R8LkGMyPJuRMyaYQcq6J
 oxXVwgeQp/a4BA/typA16jwCWgpMUuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-QpThFC41MjeFfaIQyHdClw-1; Wed, 22 Jan 2020 00:16:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64A2B8010CB;
 Wed, 22 Jan 2020 05:16:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A16A110016EB;
 Wed, 22 Jan 2020 05:16:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35D2D1138600; Wed, 22 Jan 2020 06:16:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Getting whole-tree patches reviewed and merged (was: Integrating QOM
 into QAPI)
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
Date: Wed, 22 Jan 2020 06:16:18 +0100
In-Reply-To: <CAFEAcA-C5Kvp-tUZfXSeAiFAHW-YXb+ddwFqyo5Y=0ziPhFbDA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 21 Jan 2020 16:21:18 +0000")
Message-ID: <871rrs136l.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QpThFC41MjeFfaIQyHdClw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 21 Jan 2020 at 15:11, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>> There are plenty of refactoring to do. The problem when touching the
>> whole code-base, imho, is review time. It may take a couple of
>> hours/days to come up with a cocci/spatch, and make various patches
>> here and there. But it takes often weeks and a lot of constant push to
>> various folks to get all the reviews (as seens by the qdev prop-ptr
>> series earlier for example). How can we better address whole code-base
>> changes?
>
> It depends. If it's literally just a cocci/spatch mechanical
> transformation, I think we should be OK with reviewing that
> transform and then applying it; we don't need to get acks
> from every submaintainer for that kind of thing.

I go one step further: I prefer mechanical changes committed together,
not torn apart and routed through N+1 trees, where N is the number of
active maintainers picking patches from the series, and 1 is the
maintainer taking pity of the inevitable leftovers.

Tearing a patch series apart may be in order when it's invasive enough
to risk many conflicts.  The subsystem maintainer may need tighter
control over merging order then, and routing picked patches through his
own tree may be the practical way to get it.

[...]


