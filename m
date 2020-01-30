Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C00C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617C8217BA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9S7zHdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617C8217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixEk2-0003t9-J5
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 13:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixEj7-000392-75
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixEj6-000223-8Q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:39:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixEj6-00020n-58
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580409579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=BsyfA8eI0K2GmcmW7u6uDWk967+NAqrqx11Jx2pETmM=;
 b=O9S7zHdY8wBZFZF4sNs1REwyyTKTxUPaSkWSjKYr7zQbEKp/twOdroGxpJr2xIpjWuNinY
 fngQDaQARmApifvw8Ejdv3UCscTtOuIjZz1zfReTH7L9GQFM2T7M5VGbWG5ZfUNKvQy4k6
 z7sEOfz6vuTbe9q3lTg8tmGbclAihOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-QpfTjF1lMC-nI4-aHDF1bw-1; Thu, 30 Jan 2020 13:39:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 429B318C43D8;
 Thu, 30 Jan 2020 18:39:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-117.ams2.redhat.com [10.36.117.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F89C87B06;
 Thu, 30 Jan 2020 18:39:30 +0000 (UTC)
Subject: Re: [PATCH] target/s390x/translate: Fix RNSBG instruction
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
References: <20200130133417.10531-1-thuth@redhat.com>
 <bed5fd79-4ac7-5064-c527-ef7457198eb3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0a3472ed-f6be-0118-fe24-a9710bc6ed05@redhat.com>
Date: Thu, 30 Jan 2020 19:39:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bed5fd79-4ac7-5064-c527-ef7457198eb3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: QpfTjF1lMC-nI4-aHDF1bw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/2020 14.45, David Hildenbrand wrote:
> On 30.01.20 14:34, Thomas Huth wrote:
>> RNSBG is handled via the op_rosbg() helper function. But RNSBG has
>> the opcode 0xEC54, i.e. 0x54 as second byte, while op_rosbg() currently
>> checks for 0x55. This seems to be a typo, fix it to use 0x54 instead,
>> so that op_rosbg() does not abort() anymore if a program uses RNSBG.
>>
>> I've checked with a simply test function that I now get the same results
>> with KVM and with TCG:
>>
>>  static void test_rnsbg(void)
>>  {
>> 	uint64_t r1, r2;
>>
>> 	r2 = 0xffff000000000000UL;
>> 	r1 = 0x123456789bdfaaaaUL;
>> 	asm volatile (" rnsbg %0,%1,12,61,16 " : "+r"(r1) : "r"(r2));
>>
>> 	printf("r1 afterwards: 0x%lx\n", r1);
>>  }
> 
> You could add a tcg test case for that :)

I already thought about it ... I'll have a try when I've got some spare
time.

 Thomas


