Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD0C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26C5206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D10NS/tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26C5206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHu6G-00030i-4m
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHu5g-0002c0-8X
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHu5e-0001HL-44
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:52:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHu5c-00016W-CR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585335139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSHrU53WNenHfU0CEVdVpegT4l+i/SSx8bONTKGRtZ8=;
 b=D10NS/tlwEcAOfN1KKYn573yescn3zCwPF4uo9EYNvzAKiUGFxJCp0CC9jw7PbPmtXRCoC
 otdPzkaqVIcFNoY5ijkuGy9Hvz0QK4gte9O1rq8efCpSWunhskESQ5ahVuVT+JYofsGZDw
 S1GGTuRO2+IP0QXxR62pSf1E/dpx5mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-g7Fd8XqPPEKjXpllSOJKBg-1; Fri, 27 Mar 2020 14:52:17 -0400
X-MC-Unique: g7Fd8XqPPEKjXpllSOJKBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59EA2800D4E;
 Fri, 27 Mar 2020 18:52:16 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84D0B60BF4;
 Fri, 27 Mar 2020 18:52:15 +0000 (UTC)
Subject: Re: [PATCH v3] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200327164857.31415-1-berto@igalia.com>
 <abf9a6c8-7b15-b3c1-e26a-f0ffe9523c85@redhat.com>
 <w51eetdhc52.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6b561422-e3f5-eca2-8b11-e23081cb7ec2@redhat.com>
Date: Fri, 27 Mar 2020 13:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <w51eetdhc52.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 1:43 PM, Alberto Garcia wrote:
> On Fri 27 Mar 2020 07:13:04 PM CET, Eric Blake wrote:
>>> +for qcow2_compat in 0.10 1.1; do
>>> +    echo "# Create an image with compat=$qcow2_compat without a backing file"
>>> +    _make_test_img -o "compat=$qcow2_compat" 128k
>>> +
>>> +    echo "# Fill all clusters with data and then discard them"
>>> +    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
>>> +    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
>>> +
>>> +    echo "# Read the data from the discarded clusters"
>>> +    $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
>>> +done
>>
>> Should this loop also inspect qemu-img map output?
> 
> I guess we can, although here the image is completely unallocated in
> both cases.

Which shows that even for v2 images, discard DOES do something when 
there is no backing file (even if it is now a no-op when there is a 
backing file after this patch).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


