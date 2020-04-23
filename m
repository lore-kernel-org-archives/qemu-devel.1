Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BFC55194
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBA720663
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy2JVAiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBA720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRg6C-0001yS-Vj
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRg5Q-00013S-WA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRg5P-0006xD-T9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:56:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23890
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRg5P-0006uu-DC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587664590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NliOtH3eRX+7FlzqE0XEQ1VWutMVs3I/iFICAy4XcsI=;
 b=fy2JVAiYhGvzQvJSFyuMn8K1kNs/aGriWcwvRwVnj3HIzmhIqblYGGfNMWFhCLL9gKQGee
 cNOmEhUeNoM2PxumUi5gsJb3m1dn2Q8myYNc1jyCTZqRTNdw+GMO3XzfhvtMqKvp7bZ0Wa
 89DUoBjHedcu/vKy2z/e30ZjnxMQKXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-rvoYCYlWPyi7i5KvRV_JhA-1; Thu, 23 Apr 2020 13:56:20 -0400
X-MC-Unique: rvoYCYlWPyi7i5KvRV_JhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B3851800D51;
 Thu, 23 Apr 2020 17:56:19 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4ABA60CD1;
 Thu, 23 Apr 2020 17:56:18 +0000 (UTC)
Subject: Re: [PATCH 08/13] qapi: Assert output visitors see only valid enum
 values
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200423160036.7048-1-armbru@redhat.com>
 <20200423160036.7048-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <75ecc321-7301-3c4c-c3be-741855d13e14@redhat.com>
Date: Thu, 23 Apr 2020 12:56:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423160036.7048-9-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 11:00 AM, Markus Armbruster wrote:
> output_type_enum() fails when *obj is not a valid value of the enum
> type.  Should not happen.  Drop the check, along with its unit tests.
> qapi_enum_lookup()'s assertion still guards.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/qapi-visit-core.c              |  9 -------
>   tests/test-qobject-output-visitor.c | 39 -----------------------------
>   tests/test-string-output-visitor.c  | 19 --------------
>   3 files changed, 67 deletions(-)

Nice cleanup.

The commit message implies adding an assertion; but in reality, the 
change is deleting dead code (because we already have the assertion in 
place).  Maybe it's worth updating the subject?

Reviewed-by: Eric Blake <eblake@redhat.com>

> -    /*
> -     * TODO why is this an error, not an assertion?  If assertion:
> -     * delete, and rely on qapi_enum_lookup()
> -     */
> -    if (value < 0 || value >= lookup->size) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, name ? name : "null");
> -        return;
> -    }

The comment being deleted is what points out the assertion that already 
exists.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


