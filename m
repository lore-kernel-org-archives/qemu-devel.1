Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2CC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BEE21835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnA0VP+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BEE21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icz6J-0002KH-2W
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 16:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icz4U-0001iI-2A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icz4R-0008BK-8Z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:54:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icz4R-00089b-2h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575582838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=At2m2a29zc4FwCxYNNrpeRQ+7jfORYjxusnlFlYRdVE=;
 b=gnA0VP+bEOQp2v5z2wLr7bPDWIy5wU8RIdNglGZAUcTXSUKKBEm/ZThPhT115j1dM2q+4P
 iu7O7V6qFeXX2/WWZQUnsoXeiC8KvZK0zuJDFhKcmIUGXh/57Sr1st62c3gTSsCLLJoQoa
 dWmuWQSUwA+ibgI6WnUo/eTw9gxGCkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-sNcGfnqmOFu6K9NNOBl5ow-1; Thu, 05 Dec 2019 16:53:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D3B48005B1;
 Thu,  5 Dec 2019 21:53:54 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 680B360143;
 Thu,  5 Dec 2019 21:53:45 +0000 (UTC)
Subject: Re: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191205193049.30666-1-vsementsov@virtuozzo.com>
 <22af83d1-91e2-ab71-2dc4-349b5b24d1d8@redhat.com>
 <990da2e0-8223-b257-254d-a27659ef1d24@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9fa95d95-f17f-d529-a0df-6d6197192785@redhat.com>
Date: Thu, 5 Dec 2019 15:53:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <990da2e0-8223-b257-254d-a27659ef1d24@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: sNcGfnqmOFu6K9NNOBl5ow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: kwolf@redhat.com, libvirt-list@redhat.com,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 2:16 PM, John Snow wrote:

>>> Last minute edit: hmm, actually, transaction action introduced in
>>> 4.2, so crash is not a regression, only broken block-dirty-bitmap-remov=
e
>>> command is a regression... Maybe it's OK for stable.
>>
>> Libvirt REALLY wants to use transaction bitmap management (and require
>> qemu 4.2) for its incremental backup patches that Peter is almost ready
>> to merge in.=A0 I'm trying to ascertain:
>>
>> When exactly can this bug hit?=A0 Can you give a sequence of QMP command=
s
>> that will trigger it for easy reproduction?=A0 Are there workarounds (su=
ch
>> as checking that a bitmap exists prior to attempting to remove it)?=A0 I=
f
>> it does NOT get fixed in rc5, how will libvirt be able to probe whether
>> the fix is in place?
>>
>=20
> It looks like:
>=20
> - You need to have at least one bitmap
> - You need to use transactional remove
> - you need to misspell the bitmap name
> - The remove will fail (return -EINVAL) but doesn't set errp
> - The caller chokes on incomplete information, state->bitmap is NULL

So in libvirt's case, as long as libvirt manages bitmaps completely,=20
it's a bug in libvirt to request deletion of a bitmap that doesn't=20
exist.  Or, someone messes with a qcow2 image of an offline guest behind=20
libvirt's back without updating libvirt's metadata of what bitmaps=20
should exist, and then if libvirt fails to check that a bitmap actually=20
exists, a user may be able to coerce libvirt into requesting a bitmap=20
deletion that will cause a qemu crash, but that's the user's fault for=20
going behind libvirt's back.  Or, libvirt could add code that instead of=20
trying to blindly delete a bitmap, it first makes a QMP call to ensure=20
the bitmap still exists (annoying, but harmless even when the bug is=20
fixed), instead of blaming the bug on the user operating behind=20
libvirt's back.

The bug is nasty, but feels to be enough of a corner case that I think=20
deferring to 5.0 with CC: stable (and then downstreams can backport it=20
at will) is the right approach; no need to hold up 4.2 if this is the=20
only flaw.  But I'm also not opposed to it going in 4.2 if we have=20
anything else serious.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


