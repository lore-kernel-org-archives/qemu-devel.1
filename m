Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F455C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617BE208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617BE208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTprn-0004NI-Hd
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 12:47:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjt@tls.msk.ru>) id 1jTpoi-0001UF-9V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mjt@tls.msk.ru>) id 1jTpoh-0002GD-Cz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:44:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:46349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jTpog-0002F0-SX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:44:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E7ECC402A6;
 Wed, 29 Apr 2020 19:43:59 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id D1397349;
 Wed, 29 Apr 2020 19:40:38 +0300 (MSK)
To: qemu-devel@nongnu.org
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: -nic model=rocker causes qemu to abort
Message-ID: <eafa7c11-b3af-2247-ddb3-538891ad0732@msgid.tls.msk.ru>
Date: Wed, 29 Apr 2020 19:43:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 12:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 86.62.121.231
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

Just a fun case of (invalid) usage of qemu-system command line.
Someone tried -nic model=rocker, and qemu does this:

 Unexpected error in object_property_find() at /build/qemu/git/qom/object.c:1029:
 qemu-system-x86_64: Property '.mac' not found
 Aborted

This happens after this commit:

commit 52310c3fa7dc854dd2376ae8a518141abcdb78f3
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Mar 2 10:30:50 2018 +0100

    net: allow using any PCI NICs in -net or -nic


Previously rocker rightly wasn't usable as a nic model,
and after this commit it is now possible.

While I agree this is invalid usage, perhaps qemu should not
abort like this?  Maybe it should check the required property
too, before allowing this device to be a nic model?

Thanks,

/mjt

