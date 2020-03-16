Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FAFC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F2520679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQEc5Xdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F2520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDueM-0003l9-DJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jDtf1-0000OX-Li
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jDtf0-0004LW-GM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:36:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jDtf0-0004F6-9q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584380177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+g2fuIrEPsxqgEjuqJldBkTUKocOSywNVdIr105EYCY=;
 b=FQEc5XdijorjCpyhPg9lB6tTnCEPjdNljO+kD0H67CKB4HkDWoVWz9K0ROCED8iHREdVZh
 w88Om4dcU8VFOwyzGWImB+TGGmZsoPMvDc3Wac90q+r7FD9+GDHuxxeVXE1FL2vgivg1yj
 zhKEqYxqM4dHWuzqRSv4Hv4OefrNfhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-XMIp0nJrNY-lCDV26OQesg-1; Mon, 16 Mar 2020 13:36:16 -0400
X-MC-Unique: XMIp0nJrNY-lCDV26OQesg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E53F11A242E;
 Mon, 16 Mar 2020 17:16:51 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB7D37E300;
 Mon, 16 Mar 2020 17:16:50 +0000 (UTC)
Subject: Re: [PATCH v3 05/34] tests/test-qmp-cmds: Factor out qmp_dispatch()
 test helpers
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4f5e46be-2ddc-018e-8821-4d07a17a70c8@redhat.com>
Date: Mon, 16 Mar 2020 12:16:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315144653.22660-6-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On 3/15/20 9:46 AM, Markus Armbruster wrote:
> Checking the value of qmp_dispatch() is repetitive.  Factor out
> helpers do_qmp_dispatch() and do_qmp_dispatch_error().  Without this,
> the next commit would make things even more repetitive.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qmp-cmds.c | 72 +++++++++++++++++++++----------------------
>   1 file changed, 35 insertions(+), 37 deletions(-)
> 

> +
> +static void do_qmp_dispatch_error(QDict *req, bool allow_oob, ErrorClass cls)
> +{
> +    QDict *resp;
> +
> +    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
> +    g_assert(resp && qdict_haskey(resp, "error"));
> +
> +    qobject_unref(resp);
> +}

No checking of cls?  Or is that what you hint at as coming later?

At any rate, the refactoring is sane.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


