Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3324DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB10E208FE
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dH6EDT66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB10E208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXTP-0004Mp-46
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMXSj-0003vA-NE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMXSi-00008m-KK
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:43:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMXSi-00008X-HY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586439800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqpqM4zPlmC8+9rzbrXkEdDbEIOx4neVz1jbG3y3kBI=;
 b=dH6EDT66RcIMkFW0qxgO2H4PDCVLyQfY0tD/w02BgslPibX9rRDet47ji24psQ6dDdQc/S
 AApm5ASvVLh+xti1rjAP//KuM2eTGFg1u8nX+O4lvWx63LhGxstHfcjsunbghuzN9hUt+m
 tOTMVUu2PdPBQ0iR8XxJFW462pyIapY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-vMM5dpe-NuW8IW4zHEaR_A-1; Thu, 09 Apr 2020 09:43:04 -0400
X-MC-Unique: vMM5dpe-NuW8IW4zHEaR_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75042801E6C;
 Thu,  9 Apr 2020 13:43:03 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8F705E242;
 Thu,  9 Apr 2020 13:42:56 +0000 (UTC)
Subject: Re: qcow2: Zero-initialization of external data files
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
Date: Thu, 9 Apr 2020 08:42:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 8:05 AM, Max Reitz wrote:

>>> $ sudo ./qemu-img create -f qcow2 -o \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 data_file=3D/dev/loop0,data_file_raw=3Don foo=
.qcow2 64M
>>> [...]
>>>
>>> $ sudo ./qemu-io -c 'read -P 0 0 64M' foo.qcow2
>>> read 67108864/67108864 bytes at offset 0
>>> 64 MiB, 1 ops; 00.00 sec (25.036 GiB/sec and 400.5751 ops/sec)
>>
>> This looks like a bug (and we should fix it for 5.0 if possible)
>=20
> It seems a bit difficult for 5.0 now.  (But I don=E2=80=99t think it=E2=
=80=99d be a
> regression, so that shouldn=E2=80=99t be too bad.)

So, you're arguing that since 4.2 has the same bug, slipping the fix to=20
5.1 instead of 5.0 is not bad because it's not a regression new to 5.0.=20
Yes, that's a reasonable answer, if a fix is not fast.


>>> I suppose this behavior is fine for blockdev-create because I guess it=
=E2=80=99s
>>> the user=E2=80=99s responsibility to ensure that the external data file=
 is zero.
>>>  =C2=A0 But maybe it isn=E2=80=99t, so that=E2=80=99s my first question=
: Is it really the
>>> user=E2=80=99s responsibility or should we always ensure it=E2=80=99s z=
ero?
>>
>> I'd argue that requiring the user to pre-zero the raw data file is
>> undesirable; and that we should instead fix our code to not report the
>> image as reading all zeroes when creating with data_file_raw=3Don.
>=20
> OK.  I think that could be achieved by just enforcing @preallocation to
> be at least =E2=80=9Cmetadata=E2=80=9D whenever @data-file-raw is set.  W=
ould that make
> sense?

Is a preallocation of metadata sufficient to report things correctly?=20
If so, it seems like a reasonable compromise to me.  I was more=20
envisioning a fix elsewhere: if we are reporting block status of what=20
looks like an unallocated cluster, but data-file-raw is set, we change=20
our answer to instead report it as allocated with unknown contents.  But=20
with preallocation, you either force the qcow2 file to list no cluster=20
as unallocated (which matches the fact that the raw image really is=20
fully allocated) while not touching the raw image, or you can go one=20
step further and request full preallocation to wipe the raw image to 0=20
in the process.

>=20
> Max
>=20
>>> My second question is: If we decide that this is fine for
>>> blockdev-create, should at least qcow2_co_create_opts() ensure the data
>>> file it just created is zero?
>>
>> Having an option to make qemu force-zero the raw image during
>> qcow2_co_create_opts seems reasonable, but for performance reasons, I
>> don't think the flag should be on by default.

And by mentioning preallocation, you've managed to convince me that we=20
may already have exactly the option I was envisioning.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


