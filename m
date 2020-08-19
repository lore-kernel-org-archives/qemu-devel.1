Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFF82078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INte5ODl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Uyo-0004T0-Nm
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 16:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8Uxt-0003wR-8z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8Uxq-0002CE-Ed
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597869940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIEo/nusaUA9g8upMurl6etjaA2YhL9fpGKM41gUDNQ=;
 b=INte5ODlXmedwTnJ7RnGc9ISfU/dIhhwIu3O2DZ+MzoJ9S0jFhx6R2YSnU4AsOWF46Hv2+
 NTOcMegLScApD1CS5gBxBLkx949i0kQ8a3iR7cX74/zQJAsGdASAwARQi14Q948ADM/BMp
 KEdn5m2q1fnXfZtMmLMGl542qIe3d2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-vGWkKzAQOSCunEu3pj8S2g-1; Wed, 19 Aug 2020 16:45:38 -0400
X-MC-Unique: vGWkKzAQOSCunEu3pj8S2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53C51839A49;
 Wed, 19 Aug 2020 20:45:37 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B7B5D9D5;
 Wed, 19 Aug 2020 20:45:36 +0000 (UTC)
Subject: Re: [RFC PATCH 12/22] nbd/server: Simplify export shutdown
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-13-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a09969a1-4bea-7c3d-b2f5-341d1d10d977@redhat.com>
Date: Wed, 19 Aug 2020 15:45:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-13-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:29 AM, Kevin Wolf wrote:
> Closing export is somewhat convoluted because nbd_export_close() and
> nbd_export_put() call each other and the ways they actually end up being
> nested is not necessarily obvious.

You are in a maze of twisty little passages, all alike.

Yes, I've always hated that part of the code; thanks for tackling a cleanup.

> 
> However, it is not really necessary to call nbd_export_close() from
> nbd_export_put() when putting the last reference because it only does
> three things:
> 
> 1. Close all clients. We're going to refcount 0 and all clients hold a
>     reference, so we know there is no active client any more.
> 
> 2. Close the user reference (represented by exp->name being non-NULL).
>     The same argument applies: If the export were still named, we would
>     still have a reference.
> 
> 3. Freeing exp->description. This is really cleanup work to be done when
>     the export is finally freed. There is no reason to already clear it
>     while clients are still in the process of shutting down.
> 
> So after moving the cleanup of exp->description, the code can be
> simplified so that only nbd_export_close() calls nbd_export_put(), but
> never the other way around.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   nbd/server.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


