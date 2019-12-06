Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20075C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD955205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Efvqhpvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD955205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idH0e-0000lz-H2
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1idFCs-00083k-QO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1idFCr-00077k-A9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:07:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1idFCr-00076m-4Z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAjbO0EIJadU4oKA2ogTtFgaYDmjfcVZvsCSB1ePxoI=;
 b=Efvqhpvq6mCQewl87ckSS4Ot7bFrV0ga+e0dMQvH2GOXWFSPFdDMATY458LzreYTbGVTgA
 azrDCxSWsQLyor6q6kNOL0Zw1idP6w0uiVx2XWA5yGc21Ua/+wUVnZVFwy0IrXwHSb82JY
 qQlNl5KystUT7Bo7Nu2maflw6sGOn70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-BqooXlJjMjypfLUTU9SI1Q-1; Fri, 06 Dec 2019 10:07:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DFE6189DF44
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 15:07:42 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 824965D9E2;
 Fri,  6 Dec 2019 15:07:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] net: Drop the legacy "name" parameter from the -net
 option
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20191206053640.29368-1-thuth@redhat.com>
 <20191206053640.29368-2-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ef00c6f6-ae47-4eb8-7874-d9aed403a5b4@redhat.com>
Date: Fri, 6 Dec 2019 09:07:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206053640.29368-2-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: BqooXlJjMjypfLUTU9SI1Q-1
X-Mimecast-Spam-Score: 0
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
Cc: libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 11:36 PM, Thomas Huth wrote:
> It's been deprecated since QEMU v3.1, so it's time to finally
> remove it. The "id" parameter can simply be used instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   net/net.c            | 10 +---------
>   qapi/net.json        |  4 +---
>   qemu-deprecated.texi | 12 +++++++-----
>   3 files changed, 9 insertions(+), 17 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

A quick grep of 'name.*netdev' and 'netdev.*name' in libvirt did not 
seem to find any uses of the deprecated syntax.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


