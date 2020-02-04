Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79CC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B08E20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLXxoLm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B08E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz2Lw-0001uZ-K1
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iz2LH-0001N6-W5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iz2LG-0008Ja-8p
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:50:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iz2LG-0008Ch-4o
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580838629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rilB3bwV8M0GR8ePKZw+TBs715slXw2YSNkh0DRKsA=;
 b=jLXxoLm7xYt+Xal0uImfp7MdOC+zCPjb7QZfeqHkidyLWGCcTDOiOP9EG/YHYwKZzv6asu
 9kvbmGfecnemjueRJXryH849rJn4/TN67qpX3OjcxtnrtzJlgEQK0nHPrjqAj+qsiyzg3w
 sgcDGMEN29v6szuH8cATWMOTO0QSd2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-Plcqssz4OviADEFfqXsV6w-1; Tue, 04 Feb 2020 12:50:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87BD107BA98;
 Tue,  4 Feb 2020 17:50:25 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D000B867FD;
 Tue,  4 Feb 2020 17:50:22 +0000 (UTC)
Subject: Re: [PATCH 10/17] block: Add new BDRV_ZERO_OPEN flag
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-11-eblake@redhat.com>
 <d4df9a48-6fb6-3432-3189-54bb7c7bb20c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5c19c0fe-f8d0-5011-7cc6-4bb46a46cedf@redhat.com>
Date: Tue, 4 Feb 2020 11:50:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d4df9a48-6fb6-3432-3189-54bb7c7bb20c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Plcqssz4OviADEFfqXsV6w-1
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:34 AM, Max Reitz wrote:

>> +++ b/include/block/block.h
>> @@ -105,6 +105,16 @@ typedef enum {
>>        * for drivers that set .bdrv_co_truncate.
>>        */
>>       BDRV_ZERO_TRUNCATE      =3D 0x2,
>> +
>> +    /*
>> +     * bdrv_known_zeroes() should include this bit if an image is
>> +     * known to read as all zeroes when first opened; this bit should
>> +     * not be relied on after any writes to the image.
>=20
> Is there a good reason for this?  Because to me this screams like we are
> going to check this flag without ensuring that the image has actually
> not been written to yet.  So if it=E2=80=99s generally easy for drivers t=
o stop
> reporting this flag after a write, then maybe we should do so.

In patch 15 (implementing things in qcow2), I actually wrote the driver=20
to return live results, rather than just open-time results, in part=20
because writing the bit to persistent storage in qcow2 means that the=20
bit must be accurate, without relying on the block layer's help.

But my pending NBD patch (not posted yet, but will be soon), the=20
proposal I'm making for the NBD protocol itself is just open-time, not=20
live, and so it would be more work than necessary to make the NBD driver=20
report live results.

But it seems like it should be easy enough to also patch the block layer=20
itself to guarantee that callers of bdrv_known_zeroes() cannot see this=20
bit set if the block layer has been used in any non-zero transaction, by=20
repeating the same logic as used in qcow2 to kill the bit (any=20
write/write_compressed/bdrv_copy clear the bit, any trim clears the bit=20
if the driver does not guarantee trim reads as zero, any truncate clears=20
the bit if the driver does not guarantee truncate reads as zero, etc).=20
Basically, the block layer would cache the results of .bdrv_known_zeroes=20
during .bdrv_co_open, bdrv_co_pwrite() and friends would update that=20
cache, and and bdrv_known_zeroes() would report the cached value rather=20
than a fresh call to .bdrv_known_zeroes.

Are we worried enough about clients of this interface to make the block=20
layer more robust?  (From the maintenance standpoint, the more the block=20
layer guarantees, the easier it is to write code that uses the block=20
layer; but there is the counter-argument that making the block layer=20
track whether an image has been modified means a [slight] penalty to=20
every write request to update the boolean.)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


