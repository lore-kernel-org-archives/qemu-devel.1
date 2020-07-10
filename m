Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8633DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A60206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioJeHBlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A60206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpZn-00086j-JN
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jtpYy-0007G6-BI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:43:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jtpYw-00068u-7B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594374200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZiQFfssr8io+rGo+mp5QaxauIHIz9M3j4+xQZYrdKI=;
 b=ioJeHBlL8WtS5z0f9hFfG2CycqQsQkA9swns5oPZ6LWuwm8S0UkSmP6n9x3a8UR7MJhbFQ
 zg0B1Hdclf5PP3bTVCZuxzRFeehZIzxAdl/akiD56WzHtJ0dRoCp5a9dMYuSp811aV1JOg
 HrqBBCmYnxGbUEBTrNHTBG7blDEPTFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-RMn9aX6_MUWK0tNVOYRwFw-1; Fri, 10 Jul 2020 05:43:17 -0400
X-MC-Unique: RMn9aX6_MUWK0tNVOYRwFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A877619057A4;
 Fri, 10 Jul 2020 09:43:16 +0000 (UTC)
Received: from [10.40.194.26] (unknown [10.40.194.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B9AC7EF93;
 Fri, 10 Jul 2020 09:43:13 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] qga: Ditch g_get_host_name()
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
References: <cover.1592849834.git.mprivozn@redhat.com>
Message-ID: <d4a48322-a2f2-5125-15a2-6f9f9845ad0b@redhat.com>
Date: Fri, 10 Jul 2020 11:43:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1592849834.git.mprivozn@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pbonzini@redhat.com, sw@weilnetz.de, marcandre.lureau@gmail.com,
 vfeenstr@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 8:19 PM, Michal Privoznik wrote:
> v3 of:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg06913.html
> 
> diff to v2:
> - don't leak @hostname in util/oslib-posix.c:qemu_get_host_name()
> - document why we are allocating one byte more than needed
> - switch to g_new0() from g_malloc0().
> 
> Michal Privoznik (2):
>    util: Introduce qemu_get_host_name()
>    qga: Use qemu_get_host_name() instead of g_get_host_name()
> 
>   include/qemu/osdep.h | 10 ++++++++++
>   qga/commands.c       | 17 +++++++++++++----
>   util/oslib-posix.c   | 35 +++++++++++++++++++++++++++++++++++
>   util/oslib-win32.c   | 13 +++++++++++++
>   4 files changed, 71 insertions(+), 4 deletions(-)
> 

Ping? How can I get these merged please?

Michal


