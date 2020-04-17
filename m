Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367D3C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 00:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC1520857
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 00:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIXA2EYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC1520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPEif-0004g6-5V
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 20:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPEhl-0004Bh-GL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 20:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPEhj-0002d9-Sb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 20:18:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45873
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPEhj-0002cu-Or
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 20:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587082679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVDKQS89YFlUExExsitQ+FvXCY50LFBoF0g6JKI2j8A=;
 b=LIXA2EYE3WV4tch3TU1SZGanxpOi0/wyWg1KJlClxvdKLRqcNuEV7V6YJ/tFsVCPWugVDK
 6EZczjtgZCJPO2rUg64+X059owFfeav7BzDy1vX6uLTSZ/sRI1SiOd+zUP2zbhSQ254z76
 fiTjWoNBUF+kq39gOFFDORHWsOaqiN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-IOi0h4kVN_C723DlqsuPhA-1; Thu, 16 Apr 2020 20:17:54 -0400
X-MC-Unique: IOi0h4kVN_C723DlqsuPhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 581F7107ACC9;
 Fri, 17 Apr 2020 00:17:53 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 763595C219;
 Fri, 17 Apr 2020 00:17:52 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Expose bitmaps' size during measure
To: qemu-devel@nongnu.org
References: <158707735381.15335.6543965736162160984@39012742ff91>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a995b3cc-e17a-58ef-f778-9edeb21b4623@redhat.com>
Date: Thu, 16 Apr 2020 19:17:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158707735381.15335.6543965736162160984@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 5:49 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200416212349.731404-1-eblake@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> Not run: 259
> Failures: 190
> Failed 1 of 117 iotests

Hmm - the email truncated the useful part of the failure.  Anyways, 
reading from...

> The full log is available at
> http://patchew.org/logs/20200416212349.731404-1-eblake@redhat.com/testing.docker-quick@centos7/?type=message.

I see:

--- /tmp/qemu-test/src/tests/qemu-iotests/190.out	2020-04-16 
21:15:51.000000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/190.out.bad	2020-04-16 
22:45:47.504493172 +0000
@@ -4,6 +4,7 @@
  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2199023255552
  required size: 2199023255552
  fully allocated size: 2199023255552
+bitmaps size: 4846791580151137091
  required size: 335806464

which looks suspiciously like an uninitialized variable leaking through 
when there are no bitmaps to be measured.  I'll fix it in v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


