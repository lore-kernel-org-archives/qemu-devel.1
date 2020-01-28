Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEB4C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABDA2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An7Kt/jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABDA2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwLpG-0001BJ-DZ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 03:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwLo6-0000js-AN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwLnz-0002S3-Rp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:01:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwLny-0002Nz-Ss
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580198461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8m7G6b9pakRMsTMrEZbQW0ozU1PN6+An79UaMe5QIWM=;
 b=An7Kt/jrLhzdxN/1LBkzilsMm98uLjtiDb8YXY65KdDAq3lzLFIjQKjzJdG6lrHMWkTcDh
 6aYUrKu1KUoEm56QUIqEbXCL4iQpPmHQBKZWlfPy4BKx1+Lokx82ifEo4siMoyTTNYUgfQ
 ZU7CaQRUiYw1np9Qa+7qyzLFqCY22uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-dtyWCDbfM9CIkiSSbRQxyQ-1; Tue, 28 Jan 2020 03:00:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E33800D48;
 Tue, 28 Jan 2020 08:00:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C213A8E9F2;
 Tue, 28 Jan 2020 08:00:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3EA8B1138600; Tue, 28 Jan 2020 09:00:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Integrating QOM into QAPI
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
 <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
 <CAFEAcA9xtwNzZQS7biDy=LtZEiLDis3iQztOcP2+2NnCj80c0Q@mail.gmail.com>
 <B442E0A6-E0C5-426A-8234-EE6491AE4BB0@redhat.com>
Date: Tue, 28 Jan 2020 09:00:40 +0100
In-Reply-To: <B442E0A6-E0C5-426A-8234-EE6491AE4BB0@redhat.com> (Christophe de
 Dinechin's message of "Mon, 27 Jan 2020 20:05:36 +0100")
Message-ID: <87a768j9hz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dtyWCDbfM9CIkiSSbRQxyQ-1
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
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

>> On 26 Jan 2020, at 16:04, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>>=20
>> On Sun, 26 Jan 2020 at 08:10, Christophe de Dinechin
>> <dinechin@redhat.com> wrote:
[...]
>> You'd have more luck persuading me we should move to Rust:
>> at least then we'd get some clear benefits (no more buffer
>> overrun security bugs) for the upheaval :-)
>
> This is largely a myth as soon as you need to do =E2=80=9Cyour own stuff=
=E2=80=9D.
> Example: CVE-2019-18960, https://seclists.org/oss-sec/2019/q4/141.

I think "largely a myth" is too harsh.  Yes, it's not a silver bullet to
insta-slay all memory and concurrency safety vampires.  It does provide
useful guarantees, though.  How useful exactly in practice time will
tell.


