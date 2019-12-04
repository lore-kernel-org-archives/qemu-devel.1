Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA16C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEFA20675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De36cm6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEFA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVep-0008HP-Lk
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icVdJ-0007IT-8B
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icVdG-0008IL-61
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:27:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icVdG-0008Fn-2K
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575469677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7dmIVKBVeeqt6B3XzkylvqIcDOKGkxHQ3q+McB36ME=;
 b=De36cm6n8VOxwa9YMPZTjVBFUBgIu5XrbJF3hJHebbyu38hFA9Mj0TcKZCE0Nl51xsnXJ+
 wA1qeNn7NC5cYbSpvq6SuGZmqMRmK+H4hdBYZMuSYiwgLXfJPdgYbLsa016rz+XWLoIUlg
 s3X7u7KrwFBb66nM2qma+84UQ7BKLKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-_bL0yWIFNmOKYx3jff0Rgg-1; Wed, 04 Dec 2019 09:27:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D3DB102312C
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 14:27:54 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06EFB5D6AE;
 Wed,  4 Dec 2019 14:27:53 +0000 (UTC)
Subject: Re: [PATCH v2 04/18] tests: Clean up initialization of Error *err
 variables
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191204093625.14836-1-armbru@redhat.com>
 <20191204093625.14836-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <16bd72f9-1247-b562-25b8-71a2744f4efe@redhat.com>
Date: Wed, 4 Dec 2019 08:27:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204093625.14836-5-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _bL0yWIFNmOKYx3jff0Rgg-1
X-Mimecast-Spam-Score: 0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 3:36 AM, Markus Armbruster wrote:
> Declaring a local Error *err without initializer looks suspicious.
> Fuse the declaration with the initialization to avoid that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qobject-output-visitor.c | 8 ++++----
>   tests/test-string-output-visitor.c  | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


