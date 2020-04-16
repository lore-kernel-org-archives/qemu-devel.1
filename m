Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A65C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0A82087E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+B2/Lhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0A82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOy75-0007RQ-G1
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 02:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOy6X-00072p-5f
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOy6V-0004YW-La
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:34:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOy6V-0004XI-Hi
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587018866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V88xKaqKjfnp7Q4Y8PlhYLKIFmKmFYGT9uuu8JJdao8=;
 b=K+B2/LhsFUBo2CQ/h843143nen8wqi8atCKFRfYdIpg8jZ5rwMFZ9wcFTK62ffwhoTKssr
 uPQdoPFUlj8V8AkSt7BLz5adLv+F8dbNxhfGkcCudTe9/ewH0MLtz5yObJRZ7XHL6At/VL
 +3zCAjYiuQcYNd63WtMk4MGvPAXH5pM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-ERJpsicNNoarmDVY0kj44w-1; Thu, 16 Apr 2020 02:34:24 -0400
X-MC-Unique: ERJpsicNNoarmDVY0kj44w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79111800D5C;
 Thu, 16 Apr 2020 06:34:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 266145C1C5;
 Thu, 16 Apr 2020 06:34:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B07711385C8; Thu, 16 Apr 2020 08:34:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC] configure: prefer sphinx-build to sphinx-build-3
References: <20200415173329.4920-1-jsnow@redhat.com>
 <CAFEAcA-ipjVsGuzTWhEq59SvSSSiO+ufcqdcx9JYDOZMLLfPfA@mail.gmail.com>
 <17333d73-f5be-b43b-0087-22529f985a50@redhat.com>
Date: Thu, 16 Apr 2020 08:34:21 +0200
In-Reply-To: <17333d73-f5be-b43b-0087-22529f985a50@redhat.com> (John Snow's
 message of "Wed, 15 Apr 2020 14:01:51 -0400")
Message-ID: <875ze0c51u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 4/15/20 1:55 PM, Peter Maydell wrote:
>> On Wed, 15 Apr 2020 at 18:33, John Snow <jsnow@redhat.com> wrote:
>>>
>>> sphinx-build is the name of the script entry point from the sphinx
>>> package itself. sphinx-build-3 is a pacakging convention by Linux
>>> distributions. Prefer, where possible, the canonical package name.
>>=20
>> This was Markus's code originally; cc'ing him.
>>=20
>> (Incidentally I think when we say "Linux distributions" we
>> really mean "Red Hat"; Debian/Ubuntu don't use the "sphinx-build-3" name=
.)
>>=20
>
> I'll take your word for it :)
>
>> thanks
>> -- PMM
>> (rest of email untrimmed for context)
>>=20
>
> My only goal here is that if you are using a virtual environment with
> sphinx installed that it prefers that, so non-standard names need to
> come last.
>
> There's probably 10,000,000 ways to do that, hence the RFC.

My goal when I wrote the patch was to make the doc-building work out of
the box on systems where sphinx-build gets you a Python 2 Sphinx, which
does not work for us, and sphinx-build-3 gets you one that does.

I patterned the Sphinx check after the Python check: first the -3. and
only then the indeterminate version.

I won't object to a patch that makes things better for you without
making them worse for me :)


