Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB18AC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982C62051A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpjRZv+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982C62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xb2-0006t8-Pt
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1XZI-0004ZV-W1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1XZH-00048R-QB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1XZH-00048K-Mg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581435319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CB7sZAqTkFI88bV54qWIx5RAQXb390dPiYTE7mKqv9c=;
 b=BpjRZv+pbrZ8RdXKVO9hT0w0CDPYr9CUP1ep2hCSSUTEQbWDoZQazT/lj0jeurEAjaLG1F
 DBMIr4n+432tz7gLPJOA4pMcf+BOKSSEsO2uA2BNWStmYryzkGRtjAZnV/7DGWTsEh7ZTr
 Y9uOD2gA8A5vl07zVC67DM76mnWh+2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-7ZYV3ajFPBKkxxg5NgH_wA-1; Tue, 11 Feb 2020 10:35:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6362107ACC4;
 Tue, 11 Feb 2020 15:35:01 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CC1B384;
 Tue, 11 Feb 2020 15:35:01 +0000 (UTC)
Subject: Re: [PATCH v2 03/33] block: Add BdrvChildRole
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-4-mreitz@redhat.com>
 <ab321260-f03c-2540-e443-9b1f066f819f@redhat.com>
 <f566b3d0-fe94-3e83-1d96-8d90324d5317@redhat.com>
 <f00b4c3b-2034-230a-376b-5b8b41a5a7a7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a00e3413-b9d4-42a4-bfaf-00d0b4db4fc4@redhat.com>
Date: Tue, 11 Feb 2020 09:35:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f00b4c3b-2034-230a-376b-5b8b41a5a7a7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7ZYV3ajFPBKkxxg5NgH_wA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 4:49 AM, Max Reitz wrote:

>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Filtered child */
>>>> +=C2=A0=C2=A0=C2=A0 BDRV_CHILD_FILTERED=C2=A0=C2=A0=C2=A0=C2=A0 =3D (1=
 << 2),
>>>
>>> I'm not sure this comment does justice for what the flag represents, bu=
t
>>> am not sure of what longer comment to put in its place.
>>
>> You=E2=80=99re right.  I thought I could just rely on our .is_filter
>> documentation (at least after
>> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01721.html),
>> but that doesn=E2=80=99t really apply here.
>>
>> For example, this series makes raw (without further parameters) have a
>> CHILD_FILTERED child, without raw being a filter itself.
>>
>> So there should indeed be some definition here.
>>
>> Maybe:
>>
>> A child to which the parent forwards all reads and writes.  Therefore,
>> this child presents exactly the same visible data as the parent.
>=20
> On second thought, the =E2=80=9Ctherefore=E2=80=9D is wrong, because the =
first sentence
> applies to quorum, but the logical conclusion does not.
>=20
> So maybe rather:
>=20
> A child to which the parent forwards all reads and writes.  It must
> present exactly the same visible data as the parent.
> Any node may have at most one filtered child at a time.

Yes, this works for me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


