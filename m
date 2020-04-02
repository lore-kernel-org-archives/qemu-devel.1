Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48310C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D175206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ7UoaN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D175206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK06z-0004W8-8G
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK06N-00042f-53
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK06M-0003zW-0Z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:41:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK06L-0003yP-TJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585834905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/Azu/dxUOGB9qqjJfs0I7T/Xl2C8GgnCyzjg0MKAkc=;
 b=XQ7UoaN/p6MJOWOln2Sa0/juWE7tsqp/Kn6AXpjp0o0NrK67KeVIGNosSfrzJ0PIo0GOwq
 FCDgXXGcHZqOyH0oxbUyvW6x5nL4bh1gHLXXoAU+dJosx6i30pZmrKrz6thqJcY62yfhG3
 LsKrq3FPnkRtZvePrSfUCMM+nPCIOb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-7pXCHvutPx6ajlBsSRRrLQ-1; Thu, 02 Apr 2020 09:41:42 -0400
X-MC-Unique: 7pXCHvutPx6ajlBsSRRrLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D3A3190B2D6;
 Thu,  2 Apr 2020 13:41:35 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F1551E2C0;
 Thu,  2 Apr 2020 13:41:32 +0000 (UTC)
Subject: Re: [PATCH for-5.0?] nbd: Attempt reconnect after server error of
 ESHUTDOWN
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <20200401223841.312793-1-eblake@redhat.com>
 <20200402083826.GY3888@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6b66952d-24a4-593c-2160-8c2877e42f49@redhat.com>
Date: Thu, 2 Apr 2020 08:41:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402083826.GY3888@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 3:38 AM, Richard W.M. Jones wrote:
> 
> On Wed, Apr 01, 2020 at 05:38:41PM -0500, Eric Blake wrote:
>> I was trying to test qemu's reconnect-delay parameter by using nbdkit
>> as a server that I could easily make disappear and resume.  A bit of
>> experimenting shows that when nbdkit is abruptly killed (SIGKILL),
>> qemu detects EOF on the socket and manages to reconnect just fine; but
>> when nbdkit is gracefully killed (SIGTERM), it merely fails all
>> further guest requests with NBD_ESHUTDOWN until the client disconnects
>> first, and qemu was blindly failing the I/O request with ESHUTDOWN
>> from the server instead of attempting to reconnect.
>>
>> While most NBD server failures are unlikely to change by merely
>> retrying the same transaction, our decision to not start a retry loop
>> in the common case is correct.  But NBD_ESHUTDOWN is rare enough, and
>> really is indicative of a transient situation, that it is worth
>> special-casing.
>>

> 
> For the case I care about (long running virt-v2v conversions with an
> intermittent network) we don't expect that nbdkit will be killed nor
> gracefully shut down.  Instead what we expect is that nbdkit returns
> an error such as NBD_EIO and keeps running.
> 
> Indeed if nbdkit actually dies then reconnecting will not help since
> there will be no server to reconnect to.

Hmm.  The idea of reconnect-delay in qemu is that if the connection to 
the server is dropped, we try to reconnect and then retry the I/O 
operation.  Maybe what we want is an nbdkit filter which turns EIO 
errors from the v2v plugin into forced server connection drops, but 
leave nbdkit up and running to allow the next client to connect.  That's 
different from the existing --filter=retry behavior (where we try to 
keep the client connection alive and reopen the plugin), but has a 
similar effect (because we force the connection to the client to drop, 
the client would have to reconnect to get more data, and reconnecting 
triggers a retry on connecting to the plugin).  And it's different from 
--filter=exitlast (that says to quit nbdkit altogether, rather than just 
the current connection with a client).

> 
> So I'm neutral about this patch.  If you want it for qemu that's fine
> but I don't think it will affect v2v.

Then this patch is no longer 5.0 material.  We may still want to improve 
shutdown handling in qemu (both in the client and in the server), but 
doing it correctly will be bigger than just one patch, based on 
Vladimir's response.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


