Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F06EC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C85F2465D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGgCXX+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C85F2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Iz-0003OZ-Kc
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j054J-0001Pd-9B
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j054I-0002eT-2a
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:57:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60736
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j054H-0002d6-Vp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581087436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLeF0ZwrtvVqyJ9GzHJ0R8yvKN2lP6DNAlpt3SV1x6I=;
 b=XGgCXX+CjKY5mgbFwsE5mnLbMcW6awAuSqt7em6QEr4Ue3urtTeCu9jY+OWHD9KDzd4IY5
 c9GsJOgSMpyS6I0hAoWGVc3UUlZINWaiiOOXO96oBiyxusShCFiBVsw+TAODMskZRxPWoH
 1as57zYvUxY6Pf71ZFIfIOtQKhb3nKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-bmhki6ZePsqY3zewJwluVQ-1; Fri, 07 Feb 2020 09:57:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90E6D1081FA3;
 Fri,  7 Feb 2020 14:57:03 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2639B60C05;
 Fri,  7 Feb 2020 14:57:03 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
 <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
 <38ac63ec-af49-d9d5-c1d4-e45614b71d4c@redhat.com>
 <f110458f-b3e7-6301-64bf-2b4957f3601e@virtuozzo.com>
 <570489b5-8d1b-27c4-01d3-0e63130d2c57@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bc572c68-4a4a-9734-39bb-07d78322de1b@redhat.com>
Date: Fri, 7 Feb 2020 08:57:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <570489b5-8d1b-27c4-01d3-0e63130d2c57@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bmhki6ZePsqY3zewJwluVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 8:41 AM, Max Reitz wrote:

>>> I could imagine a user creating a qcow2 image on some block device with
>>> preallocation where we cannot verify that the result will be zero.=C2=
=A0 But
>>> they want qemu not to zero the device, so they would specify
>>> --target-is-zero.
>>
>> If user create image, setting --target-is-zero is always valid. But if
>> we in
>> same operation create the image automatically, having --target-is-zero,
>> when
>> we know that what we are creating is not zero is misleading and should
>> fail..
>=20
> bdrv_has_zero_init() doesn=E2=80=99t return false only for images that we=
 know
> are not zero.  It returns true for images where we know they are.  But
> if we don=E2=80=99t know, then it returns false also.

Huh?

bdrv_has_zero_init() currently returns 1 if a driver knows that creating=20
an image results in that image reading as 0.  That means it can return 1=20
even for non-zero images that were not just created.  Thus, that=20
interface has both false positives (returning 1 for a non-zero image if=20
the driver hard-codes it to 1) and false negatives (returning 0 for an=20
image that happens to read as zero).  The false negatives are less=20
important (if we don't know if the image is already zero, then zeroing=20
it again is a waste of time but not semantically wrong) than the false=20
positives (but as long as you don't rely on bdrv_has_zero_init() unless=20
you also know the image was just created, you are safely avoiding the=20
false positives).

And that's the whole point of my series to add a qcow2 persistent bit to=20
track whether an image has known-zero contents: qemu-img should not be=20
calling bdrv_has_zero_init(), since it is so finicky on what it means.

>=20
>> If we want to add a behavior to skip zeros unconditionally, we should
>> call new
>> option --skip-zeroes, to clearly specify what we want.
>=20
> It was my impression that this was exactly what --target-is-zero means
> and implies.

--target-is-zero turns into the behavior of 'skip a pre-zeroing pass'.=20
If the destination is already zero, then copying zeroes from the source=20
is a waste of time. If the destination is not already zero, then zeroes=20
from the source are not copied, and the destination will not be=20
identical to the source.  We then have a choice of whether=20
--target-is-zero is merely a way to tell qemu something that it couldn't=20
learn otherwise but still be as safe as possible (if we can quickly=20
prove the target has non-zero data, the user lied about it being already=20
zero, so fail the command, so add yet another option to bypass the=20
safety check), or whether it really is synonymous with 'only copy the=20
non-zero portions of the source, and if the destination was not all zero=20
the copy is not faithful but I meant for it to be that way'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


