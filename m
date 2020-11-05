Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B4C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB45206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA6S008k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB45206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaf7j-00064V-WF
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaf6K-00052J-PT
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaf6H-0003Ku-RH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604582088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUllzKNOOSMX+2XbJSAzy9I6CO8B8YyJr/YwdkLToes=;
 b=KA6S008kBophcFLLuhigSS3G+wH5b/sD7yHaxm/zbiloOn2LVPlFTnAMxj3h0KvhHGxyXu
 PvRjZTgs9O3JM984Y227WABZnyX3Oh6cwMmctckItRqer2St4PZxbDosKebhFUhSL0kNz/
 Db6ZmdLfvdJgL6PHP8OwfQZa2AWNxoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-rPxgPh3hN5mf8pHnk4mpsA-1; Thu, 05 Nov 2020 08:14:44 -0500
X-MC-Unique: rPxgPh3hN5mf8pHnk4mpsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA18987951C;
 Thu,  5 Nov 2020 13:14:43 +0000 (UTC)
Received: from [10.3.114.103] (ovpn-114-103.phx2.redhat.com [10.3.114.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D5015B4BA;
 Thu,  5 Nov 2020 13:14:42 +0000 (UTC)
Subject: Re: [PATCH] block: Fix integer promotion error in bdrv_getlength()
To: Max Reitz <mreitz@redhat.com>, Tuguoyi <tu.guoyi@h3c.com>,
 Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
References: <c0d398ea9d7141bcbb9b3746f97852b4@h3c.com>
 <bb1cfa18-badd-75af-587e-bd476544ddd2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <703e17a1-544f-4e5e-a431-6e20d4a04974@redhat.com>
Date: Thu, 5 Nov 2020 07:14:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <bb1cfa18-badd-75af-587e-bd476544ddd2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 2:31 AM, Max Reitz wrote:
> On 05.11.20 06:40, Tuguoyi wrote:
>> As BDRV_SECTOR_SIZE is of type uint64_t, the expression will
>> automatically convert the @ret to uint64_t. When an error code
>> returned from bdrv_nb_sectors(), the promoted @ret will be a very
>> large number, as a result the -EFBIG will be returned which is not the
>> real error code.
>>
>> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
>> ---
>>   block.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks, applied to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 

I actually preferred the v1 solution, rather than this v2, as it avoided
a cast.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


