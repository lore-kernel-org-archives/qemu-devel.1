Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74612072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaD/lmKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74612072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbt6f-0001Gn-1H
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 17:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbt66-00006G-B1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:51:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbt64-0004wd-D1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590097882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjybcKmkvEPh8D1tKzbWO/d/SoEg/o9PbiEIgHbvDlY=;
 b=SaD/lmKxCrUniPlTbM/R0WupdCEAqy9Us9vPoqhXF+I8RY+kTd0FkYhMwZpUNjdo3A4tCB
 4wt8TUtblKRgJHELS9mLTi7g956gwTsUPuhG1uPVX0XSgaSDlkkoSPHxdCC5dsX16Z3pTz
 CD0Z7RrT5DBOavfypKoS2y4nWPaAEKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-PbH4wnAxNTOoV_vBnqwKrg-1; Thu, 21 May 2020 17:51:06 -0400
X-MC-Unique: PbH4wnAxNTOoV_vBnqwKrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A968014D7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 21:51:05 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 788CD7FCA8;
 Thu, 21 May 2020 21:51:05 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] net: Drop the NetLegacy structure, always use
 Netdev instead
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
References: <20200518180103.32484-1-thuth@redhat.com>
 <20200518180103.32484-3-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9a059691-b6b2-4315-8156-259baefaffa9@redhat.com>
Date: Thu, 21 May 2020 16:51:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518180103.32484-3-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 1:01 PM, Thomas Huth wrote:
> Now that the "name" parameter is gone, there is hardly any difference
> between NetLegacy and Netdev anymore, so we can drop NetLegacy and always
> use Netdev to simplify the code quite a bit.
> 
> The only two differences that were really left between Netdev and NetLegacy:
> 
> 1) NetLegacy does not allow a "hubport" type. We can continue to block
>     this with a simple check in net_client_init1() for this type.
> 
> 2) The "id" parameter was optional in NetLegacy (and an internal id
>     was chosen via assign_name() during initialization), but it is mandatory
>     for Netdev. To avoid that the visitor code bails out here, we have to
>     add an internal id to the QemuOpts already earlier now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: I did not rename the "is_netdev" parameter of the function (as
>   Eric suggested) - you really have to think of "-netdev" vs. "-net"
>   here and not about "Netdev" vs. "NetLegacy". But if this "is_netdev"
>   thing still confuses us in the future, we can still rename it with an
>   additional follow-up patch later instead.

Works for me. It still might be nice mentioning "-netdev" vs. "-net" in 
the commit message (and the fact that "-net" was what was previously 
using the legacy type).  But with the explanations you've given, the 
code looks correct, and a commit message tweak does not change:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


