Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB2F207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGO1A6vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB2F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQSx-0003c8-1Y
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKQRP-0001vS-QR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKQRN-00081b-29
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:49:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKQRM-0007xo-Mt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585936147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9qyaZuEgsUg9ZZ5yoZwuE4+ztB5tJAEPeaIEW38d+4=;
 b=BGO1A6vmEgOq5SEbG0ONHZU+zQHkVQdugfG2xKc5B0dbBCDn9WLgDTRukIbqYDH8C9VZzm
 zrt1uZk1GgXeDYNy4ne8v4aT/95jJciGmiWq6/ZqhJ68r9xZrMyTazpBBorePiPRe5JLdG
 1l+WuM6ITzRyROGmofOsYPXFmMgbUlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-oODtQZ_9MwCLr3tsoPriNg-1; Fri, 03 Apr 2020 13:49:05 -0400
X-MC-Unique: oODtQZ_9MwCLr3tsoPriNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68F5318A8C80;
 Fri,  3 Apr 2020 17:49:04 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B78CC10016E8;
 Fri,  3 Apr 2020 17:49:03 +0000 (UTC)
Subject: Re: [PATCH-for-5.0?] configure: Do not leave sphinx in-tree artifacts
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200403165422.21714-1-philmd@redhat.com>
 <CAFEAcA-BAvi3HEuvpMyyir9CqAbkg3nF3920zBVF-sPyFz++Rg@mail.gmail.com>
 <7c976a7a-beeb-e3ce-5760-e4239ff7dd1f@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <41cac243-105c-51c9-3747-7ee23441b226@redhat.com>
Date: Fri, 3 Apr 2020 12:49:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7c976a7a-beeb-e3ce-5760-e4239ff7dd1f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 12:37 PM, Eric Blake wrote:
> On 4/3/20 11:57 AM, Peter Maydell wrote:
>> On Fri, 3 Apr 2020 at 17:54, Philippe Mathieu-Daud=C3=A9=20
>> <philmd@redhat.com> wrote:
>>>
>>> When ./configure checks the sphinx version is new enough, it leaves
>>> the docs/sphinx/__pycache__/ directory. Avoid this by using the '-B'
>>> option (don't write .py[co] files on import) via the
>>> PYTHONDONTWRITEBYTECODE environment variable.
>>>
>>> Reported-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> This only happens for an in-tree build, right? I think in
>> that case you're kind of OK with having random stuff
>> left in the source tree... It seems easy enough to suppress
>> them though, so I guess we might as well.
>=20
> It happens in VPATH too - and what's more, in VPATH, it is still=20
> creating it under srcdir rather than builddir, which feels like=20
> unnecessary pollution.=C2=A0 I was trying to prove whether 'make distclea=
n'=20
> got us back to a pristine state; this was one of the files that escaped=
=20
> 'make distclean', so our choice is to either add it to the clean rules,=
=20
> or to avoid creating it in the first place.=C2=A0 I like the approach of =
not=20
> creating it in the first place :)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Hmm, I spoke early.  Your patch only addresses the pollution during=20
'./configure'.  But running 'make' (even in a VPATH build) equally=20
creates the same pollution.  Which means we really ought to be cleaning=20
it up during 'make distclean' rather than just trying to make=20
'./configure' clever.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


