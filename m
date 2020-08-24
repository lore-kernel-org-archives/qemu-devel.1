Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C3BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A0B206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeuNhVIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A0B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADn5-0003vy-2o
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADb6-00047l-Dw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:37:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADb4-00043u-Oq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598279838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAB3Vqs+4h4X6GqWGtz00+zBjPGbiugtDFIALSgbNeQ=;
 b=PeuNhVIiJa7Lo0MiITEl4aYiUn6uri/+l29ZwU6hfO8580AimqFo0FtnT3plaT1fsL2sPy
 BaIQviMU4YUm1KB4nzHcxVajI/8N0h5Z8OBQkpthtmLWgT+Ty8VK22IzDO3vAJ8tCmLE6h
 qeKL1lb9EMTjqWC6g/rCcTzN9bTvi/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-uHGIkQN9M6-NfhweBhoFVw-1; Mon, 24 Aug 2020 10:37:08 -0400
X-MC-Unique: uHGIkQN9M6-NfhweBhoFVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB58A1006717;
 Mon, 24 Aug 2020 14:37:07 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B42D110013C4;
 Mon, 24 Aug 2020 14:37:07 +0000 (UTC)
Subject: Re: [PATCH 1/4] configure: Use discovered make for in-source build
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-2-r.bolshakov@yadro.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0d4354b5-87bc-ee2b-a028-bc9e64baf4f0@redhat.com>
Date: Mon, 24 Aug 2020 09:37:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200822212129.97758-2-r.bolshakov@yadro.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/20 4:21 PM, Roman Bolshakov wrote:
> A recursive make is inovked if in-source build is used but $(MAKE) is
> the same as the one used in the original make invocaton.
> 
> Some platforms have preference to use gmake, or a make passed as an
> option to "configure". Honor the choice.
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>   configure | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configure b/configure
> index 4e5fe33211..9e0d505067 100755
> --- a/configure
> +++ b/configure
> @@ -38,6 +38,8 @@ then
>   # This file is auto-generated by configure to support in-source tree
>   # 'make' command invocation
>   
> +include build/config-host.mak

Should this use '-include' (also spelled 'sinclude'), to avoid halting 
the build if build/config-host.mak doesn't exist for whatever reason?

> +
>   ifeq ($(MAKECMDGOALS),)
>   recurse: all
>   endif
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


