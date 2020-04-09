Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC0C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9AF2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNQlEako"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9AF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXVW-0006HG-N3
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMXUg-0005KI-Tu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMXUc-0000eN-6Y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:45:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMXUc-0000eE-3G
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586439917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrO14x8xPSQAdo1wI2OloDQpIOXbIws0USeaLL97TKY=;
 b=cNQlEako5DDwCq5w0apInhujeZbZJl1Jni2cUEBbH8RUnX7cG8ukRTWyn52kgKD9O0tJSb
 q7hy7RKA6grsPYnYmD3QnD/y2xv+3UuZr7sEEcQWqzOa1wC9o2W5aoOoB1PUYIIo39Sszc
 7lLha8AHSPdrQG0wFYhyyKv5aPG+pVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-DIVG5hqqPteidH6L_JFXcg-1; Thu, 09 Apr 2020 09:45:16 -0400
X-MC-Unique: DIVG5hqqPteidH6L_JFXcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE163800D53;
 Thu,  9 Apr 2020 13:45:14 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E6405D9CA;
 Thu,  9 Apr 2020 13:45:14 +0000 (UTC)
Subject: Re: [PATCH] Fixed IPv6 payload lenght without jumbo option
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200405191940.866972-1-andrew@daynix.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee6a3c9c-1ef0-850e-651c-5258698461a3@redhat.com>
Date: Thu, 9 Apr 2020 08:45:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405191940.866972-1-andrew@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/5/20 2:19 PM, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>

In the subject: s/lenght/length/

> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1708065
> e1000e driver doesn't sets 'plen' field for IPv6 for big packets

s/sets/set the/

> if TSO is enabled. Jumbo option isn't added yet, until
> qemu supports packets greater than 64K.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


