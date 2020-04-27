Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75222C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D105206BF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmP6rU5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D105206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4EP-0002VT-BE
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT4Dg-0001sA-OD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT4Dg-0001IE-1L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:54:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jT4Df-0001Hw-L8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587995686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FsqSCyyjILT5y4vW/HmCxfbVPZ2bOix7eRbdptCVv0=;
 b=DmP6rU5iAjZq5Y8ltodkxOqRPOF0+aZp9gXX2qh7m8vh0FpffB29+E3O1ueB4afSFxYd3l
 +CsIt/Koz0zObBqz1DbhW2uGbJ+KYBIXC2Om7tFfHM/nwuWvokJGg23FyHSD26w99L/PSp
 0ls4ZoBX2VDdHMJn0pNeyI6wA6APWyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-7qCtyJkrOEqWAblutf3nKA-1; Mon, 27 Apr 2020 09:54:37 -0400
X-MC-Unique: 7qCtyJkrOEqWAblutf3nKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66DC518B6423;
 Mon, 27 Apr 2020 13:54:35 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DFBB5C1D4;
 Mon, 27 Apr 2020 13:54:30 +0000 (UTC)
Subject: Re: [PATCH] Convert DPRINTF() to trace event
To: teachk <teachk@foxmail.com>, qemu-devel@nongnu.org
References: <20200426131909.1463-1-teachk@foxmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <562db865-9f49-d12d-d583-51e4e4ac7caa@redhat.com>
Date: Mon, 27 Apr 2020 08:54:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426131909.1463-1-teachk@foxmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: arei.gonglei@huawei.com, Halloween <halloweenwx@163.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/26/20 8:19 AM, teachk wrote:
> From: Halloween <halloweenwx@163.com>
> 
> Signed-off-by: Halloween <halloweenwx@163.com>

Thanks for this submission.  However, we prefer that you use a legal 
name for your authorship and signed-off-by tag rather than a pseudonym. 
https://wiki.qemu.org/Contribute/SubmitAPatch explains:
"You must provide a Signed-off-by: line (this is a hard requirement 
because it's how you say "I'm legally okay to contribute this and happy 
for it to go into QEMU", modeled after the Linux kernel policy.)"

and Linux states:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297

"using your real name (sorry, no pseudonyms or anonymous contributions.)"

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


