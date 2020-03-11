Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7955CC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CB120873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntrbsvr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CB120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0VW-0002sf-Cr
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jC0US-00022M-B9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jC0UR-0006Zf-7D
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:29:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jC0UR-0006ZN-4I
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583929774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCuibaYC6ojR/kYXj+gnirgJLuQUZGQYHGxrLbAL92s=;
 b=Ntrbsvr0lfJxQGprGh5X3Q4ttjLhgfBvBPL8dDMIH/bMza/KZ/cSTKsrZGil83ddtyQQDg
 PqtWcq2vGjrxqs4PqTgL5roaE8AL7dv/ozNBu0MUG2Jhf3MdubDRZCrwi5xPLW6OgmuzWo
 Q7RDJLreM+HhRkinsoCYji+daB/hmIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-BgJV0j2kODaOWRBUFdj0Hw-1; Wed, 11 Mar 2020 08:29:30 -0400
X-MC-Unique: BgJV0j2kODaOWRBUFdj0Hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BCDD477;
 Wed, 11 Mar 2020 12:29:29 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B400690519;
 Wed, 11 Mar 2020 12:29:28 +0000 (UTC)
Subject: Re: [PATCH 3/3] block: fail on open when file size is unaligned to
 request_alignment
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-4-vsementsov@virtuozzo.com>
 <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <186c8080-a45b-0756-fa4d-c38af02f3a8b@redhat.com>
Date: Wed, 11 Mar 2020 07:29:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
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

On 3/11/20 6:06 AM, Max Reitz wrote:
> On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
>> Prior to the commit the following command lead to crash:
>>
>>    ./qemu-io --image-opts -c 'write 0 512' \
>>    driver=3Dblkdebug,align=3D4096,image.driver=3Dnull-co,image.size=3D51=
2
>>
>> It failes on assertion in bdrv_aligned_pwritev:
>>    "end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE"
>>
>> The problem is obvious: 512 is aligned to 4096 and becomes larger than
>> file size. And the core bad thing is that file size is unaligned to
>> request_alignment.
>>
>> Let's catch such case on bdrv_open_driver and fail.
>=20
> I think we had a discussion on this before, but I can=92t find it right
> now.  (Although I think that had more to do with something in the
> file-posix driver, because it wasn=92t limited to alignments above 512.)
>=20
> In any case, the file itself is totally valid.  Most importantly, qcow2
> will regularly create files with unaligned file lengths.
>=20
> So let me create a qcow2 image on a 4k-aligned device:
>=20
> $ truncate 512M fs.img
> $ sudo losetup -f --show -b 4096 fs.img
> /dev/loop0
> $ sudo mkfs.ext4 /dev/loop0
> [...]
> $ sudo mount /dev/loop0 /mnt/tmp
>=20
> $ sudo ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 64M
> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 size=3D67108864
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ sudo ./qemu-io -t none -c quit /mnt/tmp/foo.qcow2
> qemu-io: can't open device /mnt/tmp/foo.qcow2: File size is unaligned to
> request alignment
>=20
> Which is too bad.
>=20
> So the real solution would probably...  Be to align the file size up to
> the alignment?

Or to bite the bullet and finally implement byte-accurate size=20
everywhere (instead of our current insistence on rounding size up to=20
512-byte multiples).  If we have to deal with unaligned tails anyways,=20
it's better to make the code universally applicable whether that=20
unaligned tail is to 512 or to 4k, than to have it work for 512 but to=20
fail for 4k.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


