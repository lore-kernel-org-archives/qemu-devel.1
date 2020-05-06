Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA7C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09CB2073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2kdcYzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09CB2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJik-0004z0-2Y
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWJhn-0004T4-7g
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:03:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWJhm-00073C-Fp
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588770197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAk505gVCiTUfKzRe4XgWJrqdwjep1brRbwmel2lnW4=;
 b=O2kdcYzqB2tcgW6VcLSV26BHF4Ln7fuytoE7muaXofU/0IF7i14/NPLfYS54fBGMqpV1SP
 uYcGF3muwxvmhJknb7F8lF+AK9w9VvHe2n2Q4OOGOFZxwO0VlBxBx0GcfyNMNPodm1QhOC
 ojtUxrM0KyQ14VKaZMB3djksI/GvhjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-pxq-GjXUOgiGfcRlGCpgfg-1; Wed, 06 May 2020 09:03:06 -0400
X-MC-Unique: pxq-GjXUOgiGfcRlGCpgfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AAF6107ACF2;
 Wed,  6 May 2020 13:03:05 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7C976109F;
 Wed,  6 May 2020 13:03:04 +0000 (UTC)
Subject: Re: [PATCH 0/9] More truncate improvements
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200428202905.770727-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f23a15e3-8918-4731-05ad-92e6ebe89355@redhat.com>
Date: Wed, 6 May 2020 08:03:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 3:28 PM, Eric Blake wrote:
> Based-on: <20200424125448.63318-1-kwolf@redhat.com>
> [PATCH v7 00/10] block: Fix resize (extending) of short overlays
> 
> After reviewing Kevin's work, I questioned if we had a redundancy with
> bdrv_has_zero_init_truncate.  It turns out we do, and this is the result.
> 
> Patch 1 has been previously posted [1] and reviewed, the rest is new.
> I did not address Neils' comment that modern gluster also always
> 0-initializes [2], as I am not set up to verify it (my changes to the
> other drivers are semantic no-ops, so I don't feel as bad about
> posting them with less rigourous testing).
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08070.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04266.html
> 
> Eric Blake (9):
>    gluster: Drop useless has_zero_init callback
>    file-win32: Support BDRV_REQ_ZERO_WRITE for truncate
>    nfs: Support BDRV_REQ_ZERO_WRITE for truncate
>    rbd: Support BDRV_REQ_ZERO_WRITE for truncate
>    sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate
>    ssh: Support BDRV_REQ_ZERO_WRITE for truncate
>    parallels: Rework truncation logic
>    vhdx: Rework truncation logic
>    block: Drop unused .bdrv_has_zero_init_truncate
> 

Ping.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


