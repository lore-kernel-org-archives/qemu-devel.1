Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAACC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA77206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bi/ubAwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA77206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVuT-0000o6-RK
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCVtJ-0008KL-Jh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCVtH-0006Xv-EE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:01:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58336
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCVtH-0006X6-Ae
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584050479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkamC+fKMdNKcd5Zm/3Gj1NYi0y4T+EZ4RCC9YiMKy4=;
 b=Bi/ubAwSe7iSyFHlwWNkU28ZOpKpLDpLNUDAudH9LL6OMlMWRFI9g+Bf0ds/xv+jnHq0hF
 FCK9zRXevmkn0NRbqfpDLy6pKMeWZW/BfR6NvF55MZZGDlX+XQE47SG5crbWW83Q7yaiiO
 5zlz21n+wYdGq8ehECV5dC2G3tIafJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-RwzvlAq-NNOXG1XTnDIr-w-1; Thu, 12 Mar 2020 18:01:12 -0400
X-MC-Unique: RwzvlAq-NNOXG1XTnDIr-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B54140A;
 Thu, 12 Mar 2020 22:01:11 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D52719C6A;
 Thu, 12 Mar 2020 22:01:10 +0000 (UTC)
Subject: Re: [PATCH v4 0/7] Tighten qemu-img rules on missing backing format
To: qemu-devel@nongnu.org
References: <158404914429.16773.14555927621203301707@39012742ff91>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0bf30278-a4a4-a87e-bd62-36b733193076@redhat.com>
Date: Thu, 12 Mar 2020 17:01:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158404914429.16773.14555927621203301707@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: kwolf@redhat.com, libvir-list@redhat.com, pkrempa@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 4:39 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200312192822.3739399-1-eblake@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the asan build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    CC      block/replication.o
>    CC      block/throttle.o
>    CC      block/copy-on-read.o
> /tmp/qemu-test/src/block/sheepdog.c:2174:9: error: variable 'qdict' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>      if (backing_fmt && strcmp(backing_fmt, "sheepdog") != 0) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/qemu-test/src/block/sheepdog.c:2241:19: note: uninitialized use occurs here
> ---
>                  ^
>                   = NULL

Bah, real problem (and I missed it because I compiled for debug, while 
this error depends on -O2 for gcc to flag it).  Squash this in:

diff --git i/block/sheepdog.c w/block/sheepdog.c
index 376f4ef74638..e0ea335131d9 100644
--- i/block/sheepdog.c
+++ w/block/sheepdog.c
@@ -2161,9 +2161,9 @@ static int coroutine_fn sd_co_create_opts(const 
char *filename, QemuOpts *opts,
                                            Error **errp)
  {
      BlockdevCreateOptions *create_options = NULL;
-    QDict *qdict, *location_qdict;
+    QDict *qdict = NULL, *location_qdict;
      Visitor *v;
-    char *redundancy;
+    char *redundancy = NULL;
      Error *local_err = NULL;
      int ret;
      char *backing_fmt = NULL;

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


