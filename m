Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4907FC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155862051A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBHeuTO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155862051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xc5-0007vG-4i
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1XbV-0007SE-FS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1XbU-0004zu-Ef
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:37:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1XbU-0004za-BL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581435454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0Ccpfqtvh5xhrwqeCxU+lK32upuAOFC8XAbpg8N2hs=;
 b=WBHeuTO+BF51K7ovRWlnxNQT2DIJZMNALbDCnaV7HXlohzxgOC+ykvvn73oBYZpFQMkzrM
 s0ioaTgnaCUNdIeJ5tfjfK9D2sX99Gt+4DsT9apspt73ufjsmd3MBwE75GsGi6SVmNI00N
 lsjo4bRXIS2GGv+/8eTXjjX32AJNSPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-A3_j1GbxPFmGdYIgYp6uPQ-1; Tue, 11 Feb 2020 10:37:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 624668024FA;
 Tue, 11 Feb 2020 15:37:29 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E23A826E4C;
 Tue, 11 Feb 2020 15:37:28 +0000 (UTC)
Subject: Re: [PATCH v2 04/33] block: Add BdrvChildRole to BdrvChild
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-5-mreitz@redhat.com>
 <3113019f-797f-fe89-abbd-280bbddded31@redhat.com>
 <61ad1ad4-e118-c92c-bbe2-cdd03d02a8d8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2f287423-10e6-f962-ae4e-5644fd8a37f4@redhat.com>
Date: Tue, 11 Feb 2020 09:37:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <61ad1ad4-e118-c92c-bbe2-cdd03d02a8d8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: A3_j1GbxPFmGdYIgYp6uPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 4:53 AM, Max Reitz wrote:

>>> +++ b/block.c
>>> @@ -2381,6 +2381,7 @@ static void bdrv_replace_child(BdrvChild *child,
>>> BlockDriverState *new_bs)
>>>  =C2=A0 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const ch=
ar *child_name,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const Bd=
rvChildClass *child_class,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvChildRole child_=
role,
>>
>> Hmm - C is loose enough to allow the declaration of a parameter as an
>> enum type even when its intended usage is to receive a bitwise-or
>> derived from that enum but not declared in the enum.=C2=A0 For example, =
if I
>> understand intent correctly, a caller might pass in 0x3
>> (BDRV_CHILD_DATA|BDRV_CHILD_METADATA) which does NOT appear in
>> BdrvChildRole.=C2=A0 It feels like it might be cleaner to document the
>> interface as taking an unsigned int (although then you've lost the
>> documentation that the int is derived from BdrvChildRole), than to abuse
>> the typesystem to pass values that are not BdrvChildRole through the
>> parameter.
>=20
> I don=E2=80=99t necessarily disagree, but we have pre-existing examples o=
f such
> abuse, like BdrvRequestFlags.
>=20
> The advantage of using BdrvChildRole as a type here is to show that we
> expect values from that enum.  I personally prefer that.

Yeah, the self-documenting aspect is nice.

>=20
> I mean, we could do something else entirely and name the enum
> =E2=80=9CBdrvChildRoleBits=E2=80=9D and add a =E2=80=9Ctypedef unsigned i=
nt BdrvChildRole;=E2=80=9D.  I
> don=E2=80=99t think we=E2=80=99ve ever done that before but maybe it=E2=
=80=99d be the cleanest way?

You're right that we haven't done it, but it is also the slickest=20
solution that preserves documentation intent.  In C, such a typedef=20
serves only as documentation (and the compiler doesn't enforce it,=20
compared to what a strongly-typed language would do), but I do like the=20
idea.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


