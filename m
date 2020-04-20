Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E2C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FBC20575
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FblPVe3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FBC20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYHu-0004GK-53
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60456 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQYHI-0003pO-Cr
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:24:08 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQYHH-0000LI-BX
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:24:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQYHG-0000Kb-Qp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587396245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8ey1M/uqJZkOtKQsKP7oHVU1isoUNVylcTf7jiJ2so=;
 b=FblPVe3gALR24x6ZCi9F+Ytuymgqaib3iYFHh5ovri1u4TUwQvwqM4dJYxO01svKQO7m3c
 g9fD9PKWqEa5XRkYSO7r1e8fu0eDZc6PQMFlUOQFcvEikkymZwUjSraO3l4sOP0HDWSo3O
 ICCm+MtQHI79y5ikq6QwqS4ugHJEQKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-MHXz6fomNpKIbV05wZeu1A-1; Mon, 20 Apr 2020 11:23:51 -0400
X-MC-Unique: MHXz6fomNpKIbV05wZeu1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 697AD149C5;
 Mon, 20 Apr 2020 15:23:49 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79012129F8E;
 Mon, 20 Apr 2020 15:23:47 +0000 (UTC)
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
 Linus Walleij <linus.walleij@linaro.org>
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <20200420151344.GC1080594@mit.edu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
Date: Mon, 20 Apr 2020 10:23:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420151344.GC1080594@mit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, linux-api@vger.kernel.org,
 qemu-devel@nongnu.org, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 10:13 AM, Theodore Y. Ts'o wrote:
> On Tue, Mar 31, 2020 at 03:35:36PM +0200, Linus Walleij wrote:
>> It was brought to my attention that this bug from 2018 was
>> still unresolved: 32 bit emulators like QEMU were given
>> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>>
>> This adds a fcntl() operation to set the underlying filesystem
>> into 32bit mode even if the file hanle was opened using 64bit
>> mode without the compat syscalls.
> 
> s/hanle/handle/
> 
> The API that you've proposed as a way to set the 32-bit mode, but
> there is no way to clear the 32-bit mode, nor there is a way to get
> the current status mode.
> 
> My suggestion is to add a flag bit for F_GETFD and F_SETFD (set and
> get file descriptor flags).  Currently the only file descriptor flag
> is FD_CLOEXEC, so why not add a FD_32BIT_MODE bit?

Also, POSIX is proposing standardizing FD_CLOFORK, which would be 
another file descriptor flag worth considering in Linux (Solaris and BSD 
already have it):

https://www.austingroupbugs.net/view.php?id=1318

It will be interesting to find how much code (wrongly) assumes it can 
use a blind assignment of fcntl(fd, F_SETFD, 1) and thereby accidentally 
wipes out other existing flags, when it should have instead been doing a 
read-modify-write to protect flags other than FD_CLOEXEC.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


