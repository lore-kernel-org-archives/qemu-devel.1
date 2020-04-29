Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D93C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F188F2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSE4atRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F188F2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTn7a-0004aY-1o
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTn6N-0003OX-OG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTn6F-0007eL-IK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:50:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTn6F-0007di-3u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+a0ko92n+eAhMl7J+pDvqj5gI2QSzOqt2Fc/xg5wtlk=;
 b=NSE4atRqztcTYkaBLT75jiTeciYO6mHf7JwpRGup4OsXciYv/NSS4tGmfSlU+vLEmQ71Kn
 /LugBhTuqBloQZNOAiWkPtgA45MZuMKtMS/RCroZRfFvgRqujVAlgp+6L4TQPYi/G8PSsm
 x3rjGF+gMjvOWTJIFXzuV42q0iP8490=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-e2PUZqwiNqyTc6YKxjNR5g-1; Wed, 29 Apr 2020 09:49:48 -0400
X-MC-Unique: e2PUZqwiNqyTc6YKxjNR5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B85AE835BAD;
 Wed, 29 Apr 2020 13:49:46 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5BC85D9F1;
 Wed, 29 Apr 2020 13:49:44 +0000 (UTC)
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
 <feeec7a1-6987-18a1-1352-1512dc42824e@virtuozzo.com>
 <be6f57c0-23d9-6a6c-3a39-3a7132f23a42@redhat.com>
 <23f0a79a-6e8d-3702-3d82-9db54a442a5f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <008d2753-eabd-14a9-22e5-3cb304999051@redhat.com>
Date: Wed, 29 Apr 2020 08:49:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <23f0a79a-6e8d-3702-3d82-9db54a442a5f@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, den@openvz.org, berto@igalia.com, armbru@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 8:02 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>>> +=A0=A0=A0 /*
>>>>> +=A0=A0=A0=A0 * The compressed stream from the input buffer may consi=
st of=20
>>>>> more
>>>>> +=A0=A0=A0=A0 * than one zstd frame.
>>>>
>>>> Can it?
>>>
>>> If not, we must require it in the specification.
>>
>> Actually, now that you mention it, it would make sense anyway to add
>> some note to the specification on what exactly compressed with zstd=20
>> means.

> So, we don't know do we want one frame restriction or not. Do you have a=
=20
> preference?
>=20

I'm a fan of 'be strict in what you produce, liberal in what you=20
accept'. While our implementation always produces only a single frame of=20
compressed data, I think our decoder should be prepared to see more than=20
one frame from other implementations, as that is more liberal than=20
tightening the specification to require that encoding must produce=20
exactly one frame.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


