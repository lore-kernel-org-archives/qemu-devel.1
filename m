Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE3FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAA1246B9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0nUuMdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAA1246B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjUS-0003HS-7F
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXjTX-0002kR-BM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXjTU-000056-Mo
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603883919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThY309hNTI6CdJyVPBp+8BFzeIeVmoxbFf1/HWSirFQ=;
 b=K0nUuMdF7Se0gF7e5BzeSWy7ofy5RMtArisCHIKQyUxk0QnSaWyfCVzVhfAhNJA01fIljS
 xdD5JskwOMl9BcZY1Il4B2rWH/FL/DxFA0B32uEUbEffzCQcp1lA5fjp9s9xN+PzBXBrFr
 e0/yxkCVBbOFK0gqIW8j4kO7IbbTZSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-yV5TYlkVP7iOiARX9sFdpQ-1; Wed, 28 Oct 2020 07:18:38 -0400
X-MC-Unique: yV5TYlkVP7iOiARX9sFdpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6A00640B0;
 Wed, 28 Oct 2020 11:18:36 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C6F610F3;
 Wed, 28 Oct 2020 11:18:30 +0000 (UTC)
Subject: Re: [PATCH 13/25] block/nvme: Introduce Completion Queue definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-14-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f8559bc0-0d58-b43f-b149-5d3907a83bf8@redhat.com>
Date: Wed, 28 Oct 2020 12:18:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-14-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> Rename Submission Queue flags with 'Sq' 
... to differentiate submission queue flags from command queue flags.

and introduce
> Completion Queue flag definitions.

besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/block/nvme.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 65e68a82c89..079f884a2d3 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -491,6 +491,11 @@ typedef struct QEMU_PACKED NvmeCreateCq {
>  #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
>  #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
>  
> +enum NvmeFlagsCq {
> +    NVME_CQ_PC          = 1,
> +    NVME_CQ_IEN         = 2,
> +};
> +
>  typedef struct QEMU_PACKED NvmeCreateSq {
>      uint8_t     opcode;
>      uint8_t     flags;
> @@ -508,12 +513,12 @@ typedef struct QEMU_PACKED NvmeCreateSq {
>  #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
>  #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
>  
> -enum NvmeQueueFlags {
> -    NVME_Q_PC           = 1,
> -    NVME_Q_PRIO_URGENT  = 0,
> -    NVME_Q_PRIO_HIGH    = 1,
> -    NVME_Q_PRIO_NORMAL  = 2,
> -    NVME_Q_PRIO_LOW     = 3,
> +enum NvmeFlagsSq {
> +    NVME_SQ_PC          = 1,
> +    NVME_SQ_PRIO_URGENT = 0,
> +    NVME_SQ_PRIO_HIGH   = 1,
> +    NVME_SQ_PRIO_NORMAL = 2,
> +    NVME_SQ_PRIO_LOW    = 3,
>  };
>  
>  typedef struct QEMU_PACKED NvmeIdentify {
> 


