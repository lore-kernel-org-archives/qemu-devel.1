Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2CCC47414
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B2922CAD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jREyGYZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B2922CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUutu-000354-H0
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iUus7-0001jx-4d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iUus4-0001zE-QD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:47:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iUus4-0001yq-Fp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573660071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVBI6+zSYliadKreU+RbCZ4FzUu8MZVuWdCnoGKhCNc=;
 b=jREyGYZbnGLUngetRbVsldeOKrBf6SUXElD8C+dIyKh1TORlAl2CAEHIYgLNdc17SGPUl/
 zOVvg1r6hihi75a60ilti1jBTV0XngcT6517LVYZp2t6l0vURW3OQR8ztAjaltlcrMdHWM
 Ft29fpGMBSR417R7wXRrNTQYtHnaIKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-T-ygnvbSMJ2STGX8odyX9g-1; Wed, 13 Nov 2019 10:47:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77700131921;
 Wed, 13 Nov 2019 15:47:48 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D567A10246F9;
 Wed, 13 Nov 2019 15:47:45 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] nbd: Don't send oversize strings
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191010210018.22000-1-eblake@redhat.com>
 <20191010210018.22000-2-eblake@redhat.com>
 <e777bd6b-525d-99e1-2584-a31f3609d5cd@virtuozzo.com>
 <c7ed4149-8cef-7897-ae95-9b24a3d4f378@redhat.com>
 <dcdeae8f-6cb7-4f93-5fa8-aa02eb03bed7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7ee96077-32e1-1f98-9e64-52f40d702c0b@redhat.com>
Date: Wed, 13 Nov 2019 09:47:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <dcdeae8f-6cb7-4f93-5fa8-aa02eb03bed7@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: T-ygnvbSMJ2STGX8odyX9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 11:16 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> @@ -1561,6 +1569,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, =
uint64_t dev_offset,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp->exp=
ort_bitmap =3D bm;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp->exp=
ort_bitmap_context =3D g_strdup_printf("qemu:dirty-bitmap:%s",
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* See BME_MAX_NAME_SIZE i=
n block/qcow2-bitmap.c */
>>>
>>> Hmm. BME_MAX_NAME_SIZE is checked only when creating persistent bitmaps=
. But for non-persistent
>>> name length is actually unlimited. So, we should either limit all bitma=
p names to 1023 (hope,
>>> this will not break existing scenarios) or error out here (or earlier) =
instead of assertion.

I'm seriously doubting that any existing scenarios try to use a name=20
that long. If no one was relying on a long name (especially since it was=20
inconsistent between persistent being limited to qcow2 constraints and=20
non-persistent having no limit), we can consider it as a bug-fix rather=20
than something needing a deprecation period.

>>
>> I'm leaning towards limiting ALL bitmaps to the same length (as we've al=
ready debated the idea of being able to convert an existing bitmap from tra=
nsient to persistent).
>=20
> Agreed, but ..
>=20
>>
>>>
>>> We also may want QEMU_BUILD_BUG_ON(NBD_MAX_STRING_SIZE < BME_MAX_NAME_S=
IZE + sizeof("qemu:dirty-bitmap:") - 1)
>>
>> Except that BME_MAX_NAME_SIZE is not (currently) in a public .h file.
>>
>=20
> .. I think, than it should be new BLOCK_DIRTY_BITMAP_MAX_NAME_SIZE.. And =
we'll have to note it in qapi doc..
> Should this change go through deprecation? Or we consider non-persistent =
bitmaps as something not really useful?

I'm preparing a v3 patch that just goes ahead and adds the limit on=20
bitmap names everywhere, as a separate patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


