Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94515214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOe8OjsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94515214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYFL-0002wQ-Qh
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMYEZ-0002JA-Df
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMYEV-0007kj-SN
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:32:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22930
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMYEV-0007kW-C2
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586442762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujcT+BIDTMUUBh7B9IQDNxoBUzewwRj/dSNEKYP3xJ8=;
 b=aOe8OjsK3nVQAqpWyb9Z9zsf7pkNMMz82Wzq8Cjejznmwjz5EdpH7JZUz7nWebdwGg3mu9
 ZLJVt+9nGx3aDq5dG8oWqaw/2ASpZ1RoZI+gpGXKI9V1OfZQbQS71BWB0cEnA4m0cTREgt
 AUbxVa6tJzyraEjHZmmDjSSto7p+HjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-HgnFJ4hsPP2n2moqsfepRQ-1; Thu, 09 Apr 2020 10:32:38 -0400
X-MC-Unique: HgnFJ4hsPP2n2moqsfepRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67C2D1005509;
 Thu,  9 Apr 2020 14:32:37 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E56B79DD89;
 Thu,  9 Apr 2020 14:32:36 +0000 (UTC)
Subject: Re: qcow2: Zero-initialization of external data files
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
 <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
 <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
 <e91aa2c9-5709-ee1c-d8e9-45f12493613e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cc17fee7-3349-063c-3531-f6239676dc50@redhat.com>
Date: Thu, 9 Apr 2020 09:32:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e91aa2c9-5709-ee1c-d8e9-45f12493613e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 9:10 AM, Max Reitz wrote:

>>
>> What happens when an operation attempts to unmap things?=C2=A0 Do we rej=
ect
>> all unmap operations when data-file-raw is set (thus leaving a cluster
>> marked as allocated at all times, if we can first guarantee that
>> preallocation set things up that way)?
> No, unmap operations currently work.  qcow2_free_any_clusters() passes
> them through to the external data file.
>=20
> The problem is that the unmap also zeroes the L2 entry, so if you then
> write data to the raw file, it won=E2=80=99t be visible from the qcow2 si=
de of
> things.  However, I=E2=80=99m not sure whether we support modifications o=
f a raw
> file when it is already =E2=80=9Cin use=E2=80=9D by a qcow2 image, so may=
be that=E2=80=99s fine.

We don't support concurrent modification. But if the guest is running=20
and unmaps things, then shuts off, then we edit the raw file offline,=20
then we restart the guest, the guest should see the results of those=20
offline edits.

We have to special-case the qcow2 code to either treat unallocated=20
cluster + raw-data-file as not really unallocated (so that we can see=20
those edits), or we have to special case it to handle unmap +=20
raw-data-file specially (pass unmap to the raw file, but do NOT mark the=20
cluster unallocated in the qcow2 wrapper).  Which special case we choose=20
for unmap may in turn affect whether it is easier to require=20
preallocation=3Dmetadata (because we can now guarantee that no cluster=20
will ever be marked unallocated in qcow2) or whether the default=20
preallocation of leaving clusters "unallocated" in qcow2 still sees the=20
proper guest data.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


