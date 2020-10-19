Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20BFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FEB223BE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUOjmDTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FEB223BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbXi-0003XC-N2
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUbWx-00033n-3y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUbWu-0001nC-Su
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603138395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8oK2OSMJ71biq+H2Uwb0DF726ROGV/8ficJdat86Zk=;
 b=QUOjmDTOv0IkUH7anFYCLzoKfOuCdarRKENkD6dpcB7I2PnbFJhUzZ3rmuWuFNPjud/ZD/
 siI8EVSq9sVTK3Rzg/vF+Bmh5pncpZ2WHssQXcFgTyeQgCyEgf3WTbSVER32J3wZ/rQW6u
 s6ATFlLA+x+EJyOC7xR+etY+9A8dXz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-EewGO0N6MmW_HQ7pFlneew-1; Mon, 19 Oct 2020 16:13:14 -0400
X-MC-Unique: EewGO0N6MmW_HQ7pFlneew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D895F64089;
 Mon, 19 Oct 2020 20:13:12 +0000 (UTC)
Received: from [10.3.112.28] (ovpn-112-28.phx2.redhat.com [10.3.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AEC027CD3;
 Mon, 19 Oct 2020 20:13:08 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: add support for rate limit in qemu-img convert
To: Zhengui li <lizhengui@huawei.com>, pbonzini@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com
References: <1603002879-26288-1-git-send-email-lizhengui@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c9cc09b4-517e-2aa0-3099-d991ca4c0713@redhat.com>
Date: Mon, 19 Oct 2020 15:13:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1603002879-26288-1-git-send-email-lizhengui@huawei.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: xieyingtai@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/20 1:34 AM, Zhengui li wrote:
> From: Zhengui <lizhengui@huawei.com>
> 
> Currently, there is no rate limit for qemu-img convert. This may
> cause the task of qemu-img convert to consume all the bandwidth
> of the storage. This will affect the IO performance of other processes
> and virtual machines under shared storage. So we add support for
> offline rate limit in qemu-img convert to get better quality of sevice.
> 

service

Also, I'd suggest bundling your related patches into a 0/N series (it 
took me a while to notice that you had two separate emails, one for 
commit and one for convert, sent at nearly the same time, because the 
subject line was long enough to truncate the important part in my view-pane)

> Signed-off-by: Zhengui <lizhengui@huawei.com>
> ---
>   qemu-img-cmds.hx |  4 ++--
>   qemu-img.c       | 34 +++++++++++++++++++++++++++++++++-
>   2 files changed, 35 insertions(+), 3 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


