Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3144FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F065720716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNWhR2by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F065720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCM4g-0004nZ-5A
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCM3o-0003ji-JO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCM3n-0001YV-6J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:31:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCM3n-0001Wy-1m
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584012690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTD4u4Wu68SFCG13V+atSpPvjESIXKbysbaIuDUHkqc=;
 b=QNWhR2byiBGw5yWIUvHRuAQ0xksqB5FYizu44rtgN4B7l9ZIaj1gi1DXmWPmsVqCaGhgsa
 AnHaDkBP/o0M4eM/9pvJrBKCC42YW754yyPzN5Fo0te+c3n5EINiv4rAl8zM5ccoFd8yXJ
 0U3BISPkxBL+DN+2xyCNjQWqVk50vhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-93dpCz5xO0m_8nRJY6gymg-1; Thu, 12 Mar 2020 07:31:26 -0400
X-MC-Unique: 93dpCz5xO0m_8nRJY6gymg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CAC8017CC;
 Thu, 12 Mar 2020 11:31:24 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7530F91D63;
 Thu, 12 Mar 2020 11:31:23 +0000 (UTC)
Subject: Re: [PATCH 3/3] block: fail on open when file size is unaligned to
 request_alignment
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-4-vsementsov@virtuozzo.com>
 <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
 <186c8080-a45b-0756-fa4d-c38af02f3a8b@redhat.com>
 <c30d19ae-52c0-455e-8ff1-0af7a853ef0f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ebd77000-d761-1d9d-a6fb-4a719c2b7c8c@redhat.com>
Date: Thu, 12 Mar 2020 06:31:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c30d19ae-52c0-455e-8ff1-0af7a853ef0f@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 4:06 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> So the real solution would probably...=A0 Be to align the file size up =
to
>>> the alignment?
>>
>> Or to bite the bullet and finally implement byte-accurate size=20
>> everywhere (instead of our current insistence on rounding size up to=20
>> 512-byte multiples).=A0 If we have to deal with unaligned tails anyways,=
=20
>> it's better to make the code universally applicable whether that=20
>> unaligned tail is to 512 or to 4k, than to have it work for 512 but to=
=20
>> fail for 4k.
>>
>=20
> But how it helps with the problem of files unaligned to=20
> request_alignment defined by driver?

In a byte-accurate world, no driver should ever report an unaligned=20
size.  If the driver is capable of sub-sector sizes, it is also capable=20
of sub-sector I/O and should state as such in its request_alignment.=20
The block layer then takes care of ensuring that any access of the final=20
unaligned sector or 4k region either leaves the bytes past EOF alone, or=20
at most reads those bytes as zeroes, and maybe permits attempts to write=20
no-op zeroes to those bytes, but gracefully forbids attempts to store=20
data that would cause the file to be resized.

But that's the ideal world, and it requires a lot of code auditing to=20
get there. It probably won't happen in time for the 5.0 release.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


