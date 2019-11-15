Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB4C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC89920723
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAK61XmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC89920723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeo8-0002R3-Lg
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVeXG-0000Po-8Z
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVeXF-0005OR-2J
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:33:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35729
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVeXE-0005Nq-UQ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573835604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0egKsDNYyaAsKZw2Aoql8Q0HQfoDcgXVU0JgdBJdHk=;
 b=KAK61XmLH1SnhYLrAmjiX+XzdXbiG3XuSp3ACyhu+EJnvUa9oNKXkQew+jsgYZhvOEO5+x
 g+8UdGutVC7uHewk6fXZcYvJPRnuQsNEb2V5rpHpJnBuomwuoSpaCUu5TS+xWTmcTelsUW
 3Y+qHvtaICprSFg2iD/3s2F5J/LpJzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-efPNeMcxOOm0m11iViw4zQ-1; Fri, 15 Nov 2019 11:33:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 285B51095A9B;
 Fri, 15 Nov 2019 16:33:20 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 385666013C;
 Fri, 15 Nov 2019 16:33:16 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-3-eblake@redhat.com>
 <0a25974f-f9cd-07a1-4cb7-2bbd4dfe4375@virtuozzo.com>
 <6d54c6eb-4f28-6a5d-81e1-a175e34f3cf8@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8461437b-8991-3725-308d-68e054c7f3a8@redhat.com>
Date: Fri, 15 Nov 2019 10:33:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6d54c6eb-4f28-6a5d-81e1-a175e34f3cf8@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: efPNeMcxOOm0m11iViw4zQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 9:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.11.2019 18:03, Vladimir Sementsov-Ogievskiy wrote:
>> 14.11.2019 5:46, Eric Blake wrote:
>>> We document that for qcow2 persistent bitmaps, the name cannot exceed
>>> 1023 bytes.=A0 It is inconsistent if transient bitmaps do not have to
>>> abide by the same limit, and it is unlikely that any existing client
>>> even cares about using bitmap names this long.=A0 It's time to codify
>>> that ALL bitmaps managed by qemu (whether persistent in qcow2 or not)
>>> have a documented maximum length.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>>
>=20
> One doubt:
>=20
> Is it good idea to include string larger than 4K into error message
> (in next patch too)? I doubt that such message would be
> readable, and I think that most possible source of such message is
> some kind of memory corruption, so the whole message would be garbage,
> which may contain special symbols which may look bad or even break
> output.

The string was provided by the user. You are correct that it results in=20
a lot of output on stderr, but it is no more garbage than what the user=20
provided in the first place. If we wanted, we could truncate (list only=20
the first 256 or so bytes and then output "..."), but it's such a corner=20
case error that I don't think it's worth the effort to worry about it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


