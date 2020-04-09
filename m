Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE4C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4206020678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ/KngXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4206020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXYg-00014C-Bb
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMXWy-0007ed-7O
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMXWx-0001RD-9V
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:47:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31194
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMXWx-0001R2-6a
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586440062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehoOSQ7bqGYev3slS73lHjePd8DvkKgdfmQv+zGW9OI=;
 b=LQ/KngXJJcGGWTk6bAeOxmOtDDpTfMd5hGkHbNIImIz9PfTUrOB+/TMKceTqVBYt5ao5Nm
 i/EyrtYmZQxdFCGwWaaCRfYIf7876q5XMVyWKbS403pMd58qkNYHVAHGR66qoH2t+/pZ3T
 lIuB7Sicl8UYIPbw07nIQg/7SzbtKRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-HcdxK1HjOneXL4pAjBxgGw-1; Thu, 09 Apr 2020 09:47:40 -0400
X-MC-Unique: HcdxK1HjOneXL4pAjBxgGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A73C6107ACCC;
 Thu,  9 Apr 2020 13:47:39 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 509C728579;
 Thu,  9 Apr 2020 13:47:39 +0000 (UTC)
Subject: Re: qcow2: Zero-initialization of external data files
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
 <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
Date: Thu, 9 Apr 2020 08:47:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

On 4/9/20 8:42 AM, Eric Blake wrote:

>>> I'd argue that requiring the user to pre-zero the raw data file is
>>> undesirable; and that we should instead fix our code to not report the
>>> image as reading all zeroes when creating with data_file_raw=3Don.
>>
>> OK.=C2=A0 I think that could be achieved by just enforcing @preallocatio=
n to
>> be at least =E2=80=9Cmetadata=E2=80=9D whenever @data-file-raw is set.=
=C2=A0 Would that make
>> sense?
>=20
> Is a preallocation of metadata sufficient to report things correctly? If=
=20
> so, it seems like a reasonable compromise to me.=C2=A0 I was more envisio=
ning=20
> a fix elsewhere: if we are reporting block status of what looks like an=
=20
> unallocated cluster, but data-file-raw is set, we change our answer to=20
> instead report it as allocated with unknown contents.=C2=A0 But with=20
> preallocation, you either force the qcow2 file to list no cluster as=20
> unallocated (which matches the fact that the raw image really is fully=20
> allocated) while not touching the raw image, or you can go one step=20
> further and request full preallocation to wipe the raw image to 0 in the=
=20
> process.

What happens when an operation attempts to unmap things?  Do we reject=20
all unmap operations when data-file-raw is set (thus leaving a cluster=20
marked as allocated at all times, if we can first guarantee that=20
preallocation set things up that way)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


