Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42460C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D24820722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd1daRAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D24820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j430o-0001ap-3b
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j430F-0001Bb-0P
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j430D-0005GS-Ib
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:33:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j430D-0005GG-F4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582032808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8p3mgFCnafp4RH/5PsacyvQkeCP3WO1t35oO7kJgPk=;
 b=bd1daRAWWD1hC04Z8f4bFkPw7w28YTjZQq45vcXmLTLY7t854/pXwjCRkHQsLdHq3YZxgP
 cdsLj6sztaYUK8woaOleFMSInHzsIe6rIq9rOy44/5HbV/CpxxpG5R5nTvuiN8pTUFvN97
 H+fHzAIITowfxFx/dMXFTtkTWfWIXCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-ln8Cy1okO_OJ01vCqshpiQ-1; Tue, 18 Feb 2020 08:33:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6908C13E2;
 Tue, 18 Feb 2020 13:33:25 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 000E360C80;
 Tue, 18 Feb 2020 13:33:21 +0000 (UTC)
Subject: Re: [PATCH v2] Avoid address_space_rw() with a constant is_write
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200218112457.22712-1-peter.maydell@linaro.org>
 <f87dbeeb-2259-9eb9-45c7-a30819eec2ee@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <08b37e02-49b5-1485-aa71-83ead1adf407@redhat.com>
Date: Tue, 18 Feb 2020 07:33:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f87dbeeb-2259-9eb9-45c7-a30819eec2ee@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ln8Cy1okO_OJ01vCqshpiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 6:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>> +++ b/scripts/coccinelle/as_rw_const.cocci
>> @@ -0,0 +1,30 @@
>> +// Avoid uses of address_space_rw() with a constant is_write argument.
>> +// Usage:
>> +//=C2=A0 spatch --sp-file as-rw-const.spatch --dir . --in-place
>=20
> Nitpick, script is now scripts/coccinelle/as_rw_const.cocci.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> +
>> +@@
>> +expression E1, E2, E3, E4, E5;
>> +symbol false;
>> +@@
>> +
>> +- address_space_rw(E1, E2, E3, E4, E5, false)
>> ++ address_space_read(E1, E2, E3, E4, E5)
>> +@@
>> +expression E1, E2, E3, E4, E5;
>> +@@
>> +
>> +- address_space_rw(E1, E2, E3, E4, E5, 0)
>> ++ address_space_read(E1, E2, E3, E4, E5)

This feels a bit redundant.  Doesn't coccinelle have enough smarts about=20
isomorphisms (such as 0 =3D=3D false, 1 =3D=3D true) that it could get by w=
ith=20
one @@ hunk instead of 2, if we come up with the right way to represent=20
any isomorphism to a constant value?  But admittedly, I don't know what=20
that representation would actually be, and your verbose patch works even=20
if it is not the most concise possible.  So don't let my remarks hold=20
this patch up.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


