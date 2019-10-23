Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B5CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE982086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDfd65dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE982086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNI2D-000267-4g
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iNHyo-0000GA-W5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iNHyl-0003Lc-6o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:51:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iNHyk-0003Ku-UA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571842274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCMoXQ7OJjpHyk+0rDRRwwMxrzJAWRebvQFF9/clXKk=;
 b=gDfd65dCO089Mtn16XDHhn4raBUbiHk9coxmxY1PoPGRRmcl0qROcE6NxtpKxVE+8+ogku
 ooYCg1wwRHkPsBEr6cAZwDEGhDIazygO1Uewy8yHLY9e5zsRHFZxhNH+UGP3jNJwJTLLOF
 ZTHUtoutzYzzL0sBEbkb/Z45044WKYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-_3NY9hfeODO19g51Locnhw-1; Wed, 23 Oct 2019 10:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC7FF800D57;
 Wed, 23 Oct 2019 14:51:10 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54F8C60852;
 Wed, 23 Oct 2019 14:51:10 +0000 (UTC)
Subject: Re: [PATCH 3/3] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
To: Laurent Vivier <laurent@vivier.eu>, Frediano Ziglio <fziglio@redhat.com>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-3-fziglio@redhat.com>
 <5f20705e-60bc-08d5-8b6e-72438afabefe@vivier.eu>
 <c2836c58-5a3c-2356-6e94-9b2341ab2194@redhat.com>
 <1860840671.8198083.1571840126307.JavaMail.zimbra@redhat.com>
 <21fd3aa0-232c-06e8-1e20-b5c98f125468@redhat.com>
 <8b52c02c-1e26-4ac7-3f79-db4459f9c178@vivier.eu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <173d8641-ff6b-adc4-b0d4-f4dd5909f87c@redhat.com>
Date: Wed, 23 Oct 2019 09:51:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8b52c02c-1e26-4ac7-3f79-db4459f9c178@vivier.eu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _3NY9hfeODO19g51Locnhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 9:45 AM, Laurent Vivier wrote:

>> The C rules for ternary type promotion guarantee that the MIN macro
>> produces the correct type without the cast ('cond ? int64_t : int32_t'
>> produces int64_t).
>=20
> gdb seems to disagree with that:
>=20
> (gdb) whatis l
> type =3D long long
> (gdb) whatis i
> type =3D int
> (gdb) whatis 1 ? l : i
> type =3D long long
> (gdb) whatis 0 ? l : i
> type =3D int

It looks like you've found a gdb bug.

C99 6.5.15 p5 states:
"If both the second and third operands have arithmetic type, the result=20
type that would be determined by the usual arithmetic conversions, were=20
they applied to those two operands, is the type of the result."

and the usual arithmetic conversion of 'long long OP int' is 'long=20
long', per 6.3.1.8.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


