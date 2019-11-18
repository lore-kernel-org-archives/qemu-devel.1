Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177BC222C2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8fUVoVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177BC222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWm0R-0006tW-7o
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWlyy-00064l-QK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWlyw-0000sE-TH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:42:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWlyw-0000rc-OK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574102557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEdJqtRj7FvPjTb3Rr2nH1P95ASTUqg5fccA2ZxkeG8=;
 b=X8fUVoVfGddNRRd6cdTjVPPhXcXpJ2SaqrAw0NtSIpGB19R+iALR4bP+YiguPRgqx9Nzna
 ffUQVQMy2X7Z5MarCQyeWEI4OFIFXQ7g/81YqlEDaAlHf5aUmuTlIciMljwnOzDX1pSJhP
 T3cYgjVRpEWZolIYxKEEnBfsLfkuXa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-yLYeoTojOdWw9CZHCSC9aQ-1; Mon, 18 Nov 2019 13:42:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 512368018A3;
 Mon, 18 Nov 2019 18:42:34 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EC291D9;
 Mon, 18 Nov 2019 18:42:26 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] trace: Forbid dynamic field width in event format
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108144042.30245-1-philmd@redhat.com>
 <20191108144042.30245-4-philmd@redhat.com>
 <191fbe18-73b2-4d22-5540-8775688166a8@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <da2f1c61-1f99-8124-4485-c1ed4358d1e2@redhat.com>
Date: Mon, 18 Nov 2019 12:42:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <191fbe18-73b2-4d22-5540-8775688166a8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: yLYeoTojOdWw9CZHCSC9aQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 10:07 AM, Eric Blake wrote:
> On 11/8/19 8:40 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since not all trace backends support dynamic field width in
>> format (dtrace via stap does not), forbid them.
>>
>> Add a check to refuse field width in new formats:
>>
>=20
>> +++ b/scripts/tracetool/__init__.py
>> @@ -206,6 +206,7 @@ class Event(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\s*"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "(?:(?:(=
?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\s*")
>> +=C2=A0=C2=A0=C2=A0 _DFWRE =3D re.compile(".*(%0?\*).*")
>=20
> The use of leading and trailing .* is pointless if the RE itself is used=
=20
> unanchored and where you only care if the () matched.

Following up on this (based on an IRC conversation):

re.match _is_ anchored by default, while re.search is unanchored

>=20
> This doesn't catch all valid uses of * in a printf format.=C2=A0 Better m=
ight=20
> be something like:
>=20
> _DFWRE =3D re.compile("%[\d\.\- +#']*\*")
>=20
> which matches only if there is a %, any number of characters that can=20
> form a printf flag, as well as a numeric field width but dynamic precisio=
n.
>=20
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if Event._DFWRE.match(fmt):

Or put differently, if you want to drop the .* from the compiled regex,=20
then you need to use .search(fmt) here rather than .match(fmt).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


