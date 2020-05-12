Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A761DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2426420673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmCUMcWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2426420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVsn-0005AQ-06
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYVs8-0004kg-BC
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:27:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYVs7-0006YV-5W
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589293622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwepF22maz6RTRFS+eW4oqWi1nLfQQ9rzNSNlORD2aY=;
 b=VmCUMcWhgl2ujeuBhvRUjufj72fsRPqzTNaLQasXZnDXB1FzZOQ33iP0vwVHunDuDb/HPa
 Rh9GyEFL6tuj30JN01TzjzuBXhufBBCVQSmTYLOEaWM2S04dRtXqza8pQDbSUYZ/WnF8v2
 sVqO/XsuN7yOR7BS0LAKQg/baefGANc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-6Hp3YpgkMI-GjP8Eq2dtSQ-1; Tue, 12 May 2020 10:27:00 -0400
X-MC-Unique: 6Hp3YpgkMI-GjP8Eq2dtSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E3E8107ACCD
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 14:26:59 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC91E5C297;
 Tue, 12 May 2020 14:26:53 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] net: Drop the legacy "name" parameter from the
 -net option
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20200512123149.30207-1-thuth@redhat.com>
 <20200512123149.30207-2-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <34b66d39-27ce-36a9-b478-c17cbd1e5712@redhat.com>
Date: Tue, 12 May 2020 09:26:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512123149.30207-2-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

On 5/12/20 7:31 AM, Thomas Huth wrote:
> It's been deprecated since QEMU v3.1, so it's time to finally
> remove it. The "id" parameter can simply be used instead.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/system/deprecated.rst | 15 +++++++++------
>   net/net.c                  | 10 +---------
>   qapi/net.json              |  3 ---
>   3 files changed, 10 insertions(+), 18 deletions(-)
> 

> +++ b/qapi/net.json
> @@ -474,8 +474,6 @@
>   #
>   # @id: identifier for monitor commands
>   #
> -# @name: identifier for monitor commands, ignored if @id is present
> -#
>   # @opts: device type specific properties (legacy)
>   #
>   # Since: 1.2
> @@ -483,7 +481,6 @@
>   { 'struct': 'NetLegacy',
>     'data': {
>       '*id':   'str',
> -    '*name': 'str',
>       'opts':  'NetLegacyOptions' } }

Why is 'id' left optional? I'd expect it to be mandatory, now.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


