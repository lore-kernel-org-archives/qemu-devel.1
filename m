Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88263C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 18:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC1C20814
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 18:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRYhoWGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC1C20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeNVA-0006mg-JX
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 14:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeNTy-0006He-2n
 for qemu-devel@nongnu.org; Thu, 28 May 2020 14:42:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeNTw-0006Ab-JJ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 14:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590691339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWsnNDdDpwdiNLphTuOG4I0T1cZNHXlDJRrcJjmqUJo=;
 b=TRYhoWGmomNvTVCFfnyAnEQbq9oM7Zlg0T/j9XLh7cMCYJ7SJYELjt+pWZo/bGaiVy+b6d
 flGZrwm4sstWQAMLptZ/9mIa1sgXdfryOLuCHVzN+gC38tIYZAAdxog+Zvo2hDq9WPDSou
 OAvEnfllJnNDGTPcKiMW4I1Fpxgdow8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-1UOqNRsbN_CXteslP1qhwA-1; Thu, 28 May 2020 14:42:15 -0400
X-MC-Unique: 1UOqNRsbN_CXteslP1qhwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2755B18A076E;
 Thu, 28 May 2020 18:42:12 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBCCD5D9CD;
 Thu, 28 May 2020 18:42:11 +0000 (UTC)
Subject: Re: [PATCH v6 05/12] qmp: Call monitor_set_cur() only in
 qmp_dispatch()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9d626612-b0df-6623-5592-5045db96f42b@redhat.com>
Date: Thu, 28 May 2020 13:42:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528153742.274164-6-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 10:37 AM, Kevin Wolf wrote:
> The correct way to set the current monitor for a coroutine handler is
> different that for a blocking handler, so monitor_set_cur() can only be

s/that/than/

> called in qmp_dispatch().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qapi/qmp/dispatch.h | 3 ++-
>   monitor/qmp.c               | 7 +------
>   qapi/qmp-dispatch.c         | 8 +++++++-
>   qga/main.c                  | 2 +-
>   stubs/monitor-core.c        | 4 ++++
>   tests/test-qmp-cmds.c       | 6 +++---
>   6 files changed, 18 insertions(+), 12 deletions(-)
> 

> +++ b/stubs/monitor-core.c
> @@ -8,6 +8,10 @@ Monitor *monitor_cur(void)
>       return NULL;
>   }
>   
> +void monitor_set_cur(Monitor *mon)
> +{
> +}
> +

Should this stub assert(!mon)?

Otherwise looks reasonable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


