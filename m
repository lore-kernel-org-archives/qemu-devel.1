Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C27DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74ECD21655
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekEm1kW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ECD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwb4-0006ZO-AX
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kRwHQ-0001v2-GB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kRwHN-00006P-Er
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6NNePQtXu69boGFY4l2E/MJeMuJShoIPJehgVt2D7aM=;
 b=ekEm1kW2rGap9wBDC+eqp6ja8jwWUBx78PD/VWM1eIzuqKthPVHpix1/c6bQYV9H6en3w2
 oUQWHi6MUoXX+gLtFSdWr1UBXdCFN/H4W2dra/ZghmEbjrANllLdhx4dJQ//48JqWmZY1Z
 NyYByIdgA46/719BvdcGwmZqm9Ppp18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-wcm03TThPsK8nFKS6H4ekA-1; Mon, 12 Oct 2020 07:46:11 -0400
X-MC-Unique: wcm03TThPsK8nFKS6H4ekA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169881084C80;
 Mon, 12 Oct 2020 11:46:09 +0000 (UTC)
Received: from [10.3.112.62] (ovpn-112-62.phx2.redhat.com [10.3.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B95C319C78;
 Mon, 12 Oct 2020 11:46:08 +0000 (UTC)
Subject: Re: [PATCH v4 3/7] keyval: Fix parsing of ', ' in value of implied key
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201011073505.1185335-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8e077249-d186-7b1c-6cf3-0da3ca476530@redhat.com>
Date: Mon, 12 Oct 2020 06:46:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201011073505.1185335-4-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/20 2:35 AM, Markus Armbruster wrote:
> The previous commit demonstrated documentation and code disagree on
> parsing of ',' in the value of an implied key.  Fix the code to match
> the documentation.
> 
> This breaks uses of keyval_parse() that pass an implied key and accept
> a value containing ','.  None of the existing uses does:
> 
> * audiodev: implied key "driver" is enum AudiodevDriver, none of the
>    values contains ','
> 
> * display: implied key "type" is enum DisplayType, none of the values
>    contains ','
> 
> * blockdev: implied key "driver is enum BlockdevDriver, none of the
>    values contains ','
> 
> * export: implied key "type" is enum BlockExportType, none of the
>    values contains ','
> 
> * monitor: implied key "mode" is enum MonitorMode, none of the values
>    contains ','
> 
> * nbd-server: no implied key.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-keyval.c |  8 +++-----
>   util/keyval.c       | 28 +++++++++++++++++-----------
>   2 files changed, 20 insertions(+), 16 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


