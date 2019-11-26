Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD544C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4E52071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhnRtdgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4E52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdDt-0004er-ND
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZdD7-0003lK-1T
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZdD5-0007mH-UO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:57:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47439
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZdD5-0007lp-RK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574783823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJCM1RRVC1OWqzLcYNheTD3NDgNGgluGpNAeKDE5wP0=;
 b=fhnRtdguGhwVL/I0WspBV+LzYRGxCi4v0weXoBmwXIqK+Mc2E8UFZFikL9j2FlecG+4KdU
 irE8XglWVXF2L1L1uL7qM1WSOTJbSyoIq2aFY+pYNUrIaX8un3hImf5AUPDid6VTpKzWTx
 IM0kvKO2X3t7agS258sSMjfGBMIZn8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63--BJAE0-UPPK0zarQn5fBiw-1; Tue, 26 Nov 2019 10:56:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE10464A7D;
 Tue, 26 Nov 2019 15:56:58 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B7761001281;
 Tue, 26 Nov 2019 15:56:58 +0000 (UTC)
Subject: Re: [PATCH] block: Error out on image creation with conflicting size
 options
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191126154835.27915-1-kwolf@redhat.com>
 <cf113754-c582-03ae-9e53-ab0213c0ccf9@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2e913e12-4819-a729-2179-2b664601087a@redhat.com>
Date: Tue, 26 Nov 2019 09:56:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cf113754-c582-03ae-9e53-ab0213c0ccf9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -BJAE0-UPPK0zarQn5fBiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/19 9:54 AM, Eric Blake wrote:
> On 11/26/19 9:48 AM, Kevin Wolf wrote:
>> If both the create options (qemu-img create -o ...) and the size
>> parameter were given, the size parameter was silently ignored. Instead,
>> make specifying two sizes an error.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++--
>> =C2=A0 tests/qemu-iotests/049=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
>> =C2=A0 tests/qemu-iotests/049.out |=C2=A0 5 +++++
>> =C2=A0 3 files changed, 18 insertions(+), 2 deletions(-)
>=20
> Longtime bug, so not essential for 4.2-rc3.=C2=A0 But small enough that y=
ou=20
> could sneak it in if you have other patches to queue and don't want to=20
> wait for 5.0.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Actually, your patch fails to diagnose:

$ qemu-img create -o size=3D1m,size=3D2m -f qcow2 x.qcow2
Formatting 'x.qcow2', fmt=3Dqcow2 size=3D2097152 cluster_size=3D65536=20
lazy_refcounts=3Doff refcount_bits=3D16

so you may want to enhance this patch to also catch the case of -o size=20
used more than once.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


