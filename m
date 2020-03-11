Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0956EC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CDB2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrE8GfeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CDB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0zU-0007jp-01
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jC0yJ-0006Za-A9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1jC0yE-0006S5-Dj
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:00:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1jC0yE-0006Re-96
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583931621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81ranNgaJ7+QpsDSPTAEq8fKefnUAsd8CB3itcBZlTE=;
 b=SrE8GfeM5k0qJNQtWGu9/T+ssHUN0GHnAlMJ+owm4AKbCJWBrpyEp3pQguDb3oBu7lQHTf
 7MR8d9GOhDmMDiPv1JYo0VrGZWBD8BedavjthLtTjfpEascQLarfzat7+KkaxRwdhb9IdM
 u5DHCQEL2vDrcCfTJ7FoxvojUklJ/9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-2DGGhj-GP7ichjKRl3vFUA-1; Wed, 11 Mar 2020 09:00:18 -0400
X-MC-Unique: 2DGGhj-GP7ichjKRl3vFUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBDA2477;
 Wed, 11 Mar 2020 13:00:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.119.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E574B100EBA6;
 Wed, 11 Mar 2020 13:00:02 +0000 (UTC)
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
To: Markus Armbruster <armbru@redhat.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
 <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
 <20200310101108.3377b878@x1.home>
 <467b2253-a065-91c3-5b0c-4f03ee236d0c@redhat.com>
 <20200310193624.402fdb18@x1.home>
 <30f4a52f-a572-8643-1801-95c9fd2cd8a8@redhat.com>
 <87o8t3ds4a.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1255d677-4c97-c326-890e-2fe132476367@redhat.com>
Date: Wed, 11 Mar 2020 14:00:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o8t3ds4a.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mst@redhat.com, weifuqiang@huawei.com, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 12:54, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:

>> In fact I was about to mention, "I really don't understand why compilers
>> don't yell upon seeing pointer-to-void arithmetic", but I got distracted
>> and forgot about that thought. In retrospect, that may have been for the
>> best! :)
> 
> You're looking for
> 
> '-Wpointer-arith'
>      Warn about anything that depends on the "size of" a function type
>      or of 'void'.  GNU C assigns these types a size of 1, for
>      convenience in calculations with 'void *' pointers and pointers to
>      functions.  In C++, warn also when an arithmetic operation involves
>      'NULL'.  This warning is also enabled by '-Wpedantic'.
> 

Thanks! It seems like "-Wpedantic" and "-pedantic" are synonymous. And
the latter used to be part of my standard set of flags, while I worked
on hosted C programs where I could influence the build flags ;)

Cheers,
Laszlo


