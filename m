Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E4EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4679720674
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWo+NaER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4679720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCobr-0006Nq-9A
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCoZi-0004aG-V1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCoZh-0003TI-Uh
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:58:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCoZh-0003K3-PW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584122301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IG4J0vLrYyluQnmz12sJ7wFaLiKfzpfk0xm3KnMd9G0=;
 b=UWo+NaERSPI74VHroVPA/S7UwIOEJboqDzh5F5BcD2e8+qQlH9Lhnfk+dsWuQ8eKR3bThd
 9eUipsZiOupMuXF3jGuwHneaTuIXMnrZKSJgwsEPxEfLcW5nRCgqpaFDGxrEZCyKweGY1/
 g0cTRf63FkTtWnrzenoIre+LAGO/8P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-Wjb0-WcfMYawYZJl0HjjaQ-1; Fri, 13 Mar 2020 13:58:18 -0400
X-MC-Unique: Wjb0-WcfMYawYZJl0HjjaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1CB9800D50;
 Fri, 13 Mar 2020 17:58:16 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ED9F5D9CA;
 Fri, 13 Mar 2020 17:58:16 +0000 (UTC)
Subject: Re: [PATCH 2/3] hw/misc/ivshmem: Use one Error * variable instead of
 two
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <88a64410-e502-9b4b-3892-55fe764cc895@redhat.com>
Date: Fri, 13 Mar 2020 12:58:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313170517.22480-3-armbru@redhat.com>
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
Cc: alxndr@bu.edu, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 ashijeetacharya@gmail.com, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 12:05 PM, Markus Armbruster wrote:
> Commit fe44dc9180 "migration: disallow migrate_add_blocker during
> migration" accidentally added a second Error * variable.  Use the
> first one instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/misc/ivshmem.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


