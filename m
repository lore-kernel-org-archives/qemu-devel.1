Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD1C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996C224650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAMZ2AlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996C224650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7IsK-0002vi-Py
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7IrS-0002S2-CJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7IrR-0007t1-3S
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:05:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7IrQ-0007rv-Uj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582808750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6HQB4gaP+eZ99NIo7zUw+QpWBtueKbifVRClt7IJWY=;
 b=LAMZ2AlT55bldodJ+YgJ26EqZPlSM/1JV7eMc2GJdvdaNMmHMAU1tQ21NjKNidO3uiVpdL
 SOp+HWc1Ouxw51CDy6eAoqau8RuHx9mSvo0tMHJ85WfNyWqgnfV4J3cB/HAZuZKAj5CdD3
 ANU0qzbCCLiK1/7jJ3Zd/lb6+6pJp6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-ueiHzDeNPjWPjKPSnG8TnA-1; Thu, 27 Feb 2020 08:05:48 -0500
X-MC-Unique: ueiHzDeNPjWPjKPSnG8TnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D065618FF66B;
 Thu, 27 Feb 2020 13:05:47 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3051101D48E;
 Thu, 27 Feb 2020 13:05:44 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] iotests: Specify explicit backing format where
 sensible
To: Peter Krempa <pkrempa@redhat.com>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-2-eblake@redhat.com>
 <20200227072046.GC20737@andariel.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3ae47ca2-b7b0-e07e-d725-9ea6cb431d0f@redhat.com>
Date: Thu, 27 Feb 2020 07:05:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227072046.GC20737@andariel.pipo.sk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:20 AM, Peter Krempa wrote:
> On Wed, Feb 26, 2020 at 20:39:26 -0600, Eric Blake wrote:
>> There are many existing qcow2 images that specify a backing file but
>> no format.  This has been the source of CVEs in the past, but has
>> become more prominent of a problem now that libvirt has switched to
>> -blockdev.  With older -drive, at least the probing was always done by
>> qemu (so the only risk of a changed format between successive boots of
>> a guest was if qemu was upgraded and probed differently).  But with
>> newer -blockdev, libvirt must specify a format; if libvirt guesses raw
>> where the image was formatted, this results in data corruption visible
>> to the guest; conversely, if libvirt guesses qcow2 where qemu was
>> using raw, this can result in potential security holes, so modern
>> libvirt instead refuses to use images without explicit backing format.
>>
>> The change in libvirt to reject images without explicit backing format
>> has pointed out that a number of tools have been far too reliant on
>> probing in the past.  It's time to set a better example in our own
>> iotests of properly setting this parameter.
>>
>> iotest calls to create, rebase, convert, and amend are all impacted to
>> some degree.  It's a bit annoying that we are inconsistent on command
>> line - while all of those accept -o backing_file=...,backing_fmt=...,
>> the shortcuts are different: create and rebase have -b and -F, convert
>> has -B but no -F, and amend has no shortcuts.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
> 
> [...]
> 
>>   113 files changed, 414 insertions(+), 338 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
>> index 0a4b854e6520..585512bb296b 100755
>> --- a/tests/qemu-iotests/017
>> +++ b/tests/qemu-iotests/017
>> @@ -66,7 +66,7 @@ echo "Creating test image with backing file"
>>   echo
>>
>>   TEST_IMG=$TEST_IMG_SAVE
>> -_make_test_img -b "$TEST_IMG.base" 6G
>> +_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
>>
> 
> My understanding of the intricacies of the qemu-iotest suite is not good
> enoug to be able to review this patch. Specifically $IMGFMT in this
> instance is also used in the '-f' switch of qemu-img in _make_test_img
> and I don't know if it's expected for the backing file to share the
> format.

That's fine; I'm hoping a qemu expert reviews as well.

$IMGFMT allows an iotest to be run on multiple formats (qcow2, qed, 
vmdk); most tests in this patch series either hard-coded the base image 
to be 'raw' (in which case I added -F raw) or to be the same type as the 
wrapper image under test (in which case it is -F $IMGFMT).  We have very 
few tests that would try to mix-and-match other formats, such as a qcow2 
on top of qed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


