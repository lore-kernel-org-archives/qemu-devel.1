Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F37C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955632075E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtgEm3El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldU6-0003Wx-SM
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jldTV-0002sm-2G
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jldTS-0005jz-OE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592421109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8pgGNGYG5ZlagKSXRsYIDz6ItMik3m9ELoHq2o4UuY=;
 b=BtgEm3El+PGwptncvnvhTo3SfPY8aYH/ieVh6BBIIocOhPwiIeY5AdAKl9GaaZ06W7joOn
 kUW3hrJJCq2s/UHapXCLbxXXnbev4Athes7iFvAK7svnVL7AQaHf7+yVmFt3U/KvRWAoxb
 L4XWcPd4NLiDBXaI4aqJdmL7XS3vsHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-jglA6LHVMsKmqOuHrxSAVA-1; Wed, 17 Jun 2020 15:11:30 -0400
X-MC-Unique: jglA6LHVMsKmqOuHrxSAVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21505EC1A0;
 Wed, 17 Jun 2020 19:11:29 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1C7F19D9E;
 Wed, 17 Jun 2020 19:11:28 +0000 (UTC)
Subject: Re: [PATCH] block: Raise an error when backing file parameter is an
 empty string
To: Connor Kuehl <ckuehl@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
References: <20200617182725.951119-1-ckuehl@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1827f63d-4f8d-1a45-476e-ff2d5a50a53b@redhat.com>
Date: Wed, 17 Jun 2020 14:11:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617182725.951119-1-ckuehl@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 1:27 PM, Connor Kuehl wrote:
> Providing an empty string for the backing file parameter like so:
> 
> 	qemu-img create -f qcow2 -b '' /tmp/foo
> 
> allows the flow of control to reach and subsequently fail an assert
> statement because passing an empty string to
> 
> 	bdrv_get_full_backing_filename_from_filename()
> 
> simply results in NULL being returned without an error being raised.
> 
> To fix this, let's check for an empty string when getting the value from
> the opts list.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Fixes: https://bugzilla.redhat.com/1809553
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>   block.c                    |  4 ++++
>   tests/qemu-iotests/298     | 47 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/298.out |  5 ++++
>   tests/qemu-iotests/group   |  1 +
>   4 files changed, 57 insertions(+)
>   create mode 100755 tests/qemu-iotests/298
>   create mode 100644 tests/qemu-iotests/298.out

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


