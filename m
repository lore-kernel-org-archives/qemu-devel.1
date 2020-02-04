Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFBEC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496E92084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVFPEoqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496E92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0U3-0005SZ-Dh
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iz0T2-0004b7-Ox
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iz0T1-0001Ib-2x
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:50:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iz0T0-0001Fz-Vb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580831422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=liY4SNYj3wL+XINu7s++zPKr0d1WygNffrkeTOZ87a4=;
 b=VVFPEoqRG3pN7nXzMXPD6AWwYQCQCSMae5zj6gE9Bo20K0JSW2ShK3+RG+Cfbvm6HhcUo9
 BgjAWPdP4Y5xBubN7Cu5V9MZo08ScDcDh1P7RNvHOdH1RzOlG0nToFYhlhyczwYNMplIyY
 d0n4ASdMRDgSfi3Awpmvs4DVVZFsAvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-f8LnB7lbMUiHLOyc7AclIw-1; Tue, 04 Feb 2020 10:49:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE41818B635A;
 Tue,  4 Feb 2020 15:49:54 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EADBA90A6;
 Tue,  4 Feb 2020 15:49:46 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6247aca7-4a2e-ffa9-6336-4c1e71f63d96@redhat.com>
Date: Tue, 4 Feb 2020 09:49:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: f8LnB7lbMUiHLOyc7AclIw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 mreitz@redhat.com, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 9:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2020 20:44, Eric Blake wrote:
>> Having two slightly-different function names for related purposes is
>> unwieldy, especially since I envision adding yet another notion of
>> zero support in an upcoming patch.=C2=A0 It doesn't help that
>> bdrv_has_zero_init() is a misleading name (I originally thought that a
>> driver could only return 1 when opening an already-existing image
>> known to be all zeroes; but in reality many drivers always return 1
>> because it only applies to a just-created image).=C2=A0 Refactor all use=
s
>> to instead have a single function that returns multiple bits of
>> information, with better naming and documentation.
>=20
> Sounds good
>=20
>>
>> No semantic change, although some of the changes (such as to qcow2.c)
>> require a careful reading to see how it remains the same.
>>
>=20
> ...
>=20
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 6cd566324d95..a6a227f50678 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>=20
> Hmm, header file in the middle of the patch, possibly you don't use
> [diff]
>  =C2=A0=C2=A0=C2=A0 orderFile =3D scripts/git.orderfile
>=20
> in git config.. Or it is broken.

I do have it set up, so I'm not sure why it didn't work as planned.=20
I'll make sure v2 follows the order I intended.

>=20
>> @@ -85,6 +85,28 @@ typedef enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3ff,
>> =C2=A0 } BdrvRequestFlags;
>>
>> +typedef enum {
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit =
if the contents of
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a freshly-created image with no backing file=
 reads as all
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=A0 =
If .bdrv_co_truncate is
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set, then this must be clear if BDRV_ZERO_TR=
UNCATE is clear.
>=20
> I understand that this is preexisting logic, but could I ask: why?=20
> What's wrong
> if driver can guarantee that created file is all-zero, but is not sure=20
> about
> file resizing? I agree that it's normal for these flags to have the same=
=20
> value,
> but what is the reason for this restriction?..

For _this_ patch, my goal is to preserve pre-existing practice. Where we=20
think pre-existing practice is wrong, we can then improve it in other=20
patches (see patch 6, for example).

I _think_ the reason for this original limitation is as follows: If an=20
image can be resized, we could choose to perform 'create(size=3D0),=20
truncate(size=3Dfinal)' instead of 'create(size=3Dfinal)', and we want to=
=20
guarantee the same behavior. If truncation can't guarantee a zero read,=20
then why is creation doing so?

But as I did not write the original patch, I would welcome Max's input=20
with regards to the thought behind commit ceaca56f.

>=20
> So, the only possible combination of flags, when they differs, is=20
> create=3D0 and
> truncate=3D1.. How is it possible?

qcow2 had that mode, at least before patch 5.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Since this bit is only reliable at image cre=
ation, a driver may
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * return this bit even for existing images tha=
t do not currently
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * read as zero.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 BDRV_ZERO_CREATE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 0x1,
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit =
if growing an image
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with PREALLOC_MODE_OFF (either with no backi=
ng file, or beyond
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the size of the backing file) will read the =
new data as all
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=A0 =
This bit only matters
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * for drivers that set .bdrv_co_truncate.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 BDRV_ZERO_TRUNCATE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 0x2,
>> +} BdrvZeroFlags;
>> +
>=20
> ...
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


