Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35BEC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A650F20663
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV0fcrbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A650F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR0ko-0003h6-JL
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 17:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0jK-0002pR-0z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0jI-0001Mb-Nb
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:46:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jR0jI-0001JN-6c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587505615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISw6c4GHvGqoGOp/HGKgTicBxUOMvPj3sGUkvS18AKg=;
 b=CV0fcrbBo/qmawoL3CsOgyWU3ctBaV7GUs88Umq69QROAlEguoTnXZ27H+sGkKcc68eVLF
 3km5XoRIW9rQHZOoVS/JX1oZdcQRfpkcD84SU3f30GKlVZ180i6lQGPQoW9nZwpxsg6deE
 rFXTA8ZtTmtXttCoZDMvta1fsL3Vpwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-RIeGk8QAMraxEdo2ii6iHA-1; Tue, 21 Apr 2020 17:46:52 -0400
X-MC-Unique: RIeGk8QAMraxEdo2ii6iHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D365802570;
 Tue, 21 Apr 2020 21:46:39 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E027860BEC;
 Tue, 21 Apr 2020 21:46:38 +0000 (UTC)
Subject: Re: [PATCH 2/2] tools: Fix use of fcntl(F_SETFD) during socket
 activation
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200420175309.75894-1-eblake@redhat.com>
 <20200420175309.75894-3-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <645b3b83-1494-36a9-35df-fa09c364b85e@redhat.com>
Date: Tue, 21 Apr 2020 16:46:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420175309.75894-3-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 17:20:31
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 12:53 PM, Eric Blake wrote:
> Blindly setting FD_CLOEXEC without a read-modify-write will
> inadvertently clear any other intentionally-set bits, such as a
> proposed new bit for designating a fd that must behave in 32-bit mode.
> However, we cannot use our wrapper qemu_set_cloexec(), because that
> wrapper intentionally abort()s on failure, whereas the probe here
> intentionally tolerates failure to deal with incorrect socket
> activation gracefully.  Instead, fix the code to do the proper
> read-modify-write.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   util/systemd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

As qemu-nbd is impacted, I'll queue 2/2 through my NBD tree if 
qemu-trivial doesn't pick it up first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


