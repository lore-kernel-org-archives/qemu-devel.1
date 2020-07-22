Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44457C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF9020709
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAArL+nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF9020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyErg-0004Mk-BE
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyEqy-0003sd-AC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:32:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyEqw-00022L-Bu
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595424729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIAujKQcf1z1CCDDIQiYtu8jyqSKjewe2BRVwl17TP8=;
 b=dAArL+nS8aDLm56oQ33xqzahnQ3nxDket8wHDlK1YO+87wEO/ZuEHtWQ5VBr9ppM2d6fWb
 yTQIlwLTkSjuo7PVOmnGcRtvYoat2ARbPsuLADuteonvtC6xO/83ex6ecZ6DuP8exeuwOh
 q/Sl1Hz4u80Fj9gfHG7f7etRLVqXRBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-WRRnKGttMC2LYw3Z3imXwA-1; Wed, 22 Jul 2020 09:32:07 -0400
X-MC-Unique: WRRnKGttMC2LYw3Z3imXwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77F89803833;
 Wed, 22 Jul 2020 13:32:01 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26A0B61463;
 Wed, 22 Jul 2020 13:31:58 +0000 (UTC)
Subject: Re: [PATCH 3/4] error: Remove NULL checks on error_propagate() calls
 (again)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200722084048.1726105-1-armbru@redhat.com>
 <20200722084048.1726105-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5def3655-aa29-aef1-6683-b97b2faaa289@redhat.com>
Date: Wed, 22 Jul 2020 08:31:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722084048.1726105-4-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jens Freimann <jfreimann@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 3:40 AM, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>      $ spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>               --macro-file scripts/cocci-macro-file.h \
>               --use-gitgrep .
> 
> Cc: Jens Freimann <jfreimann@redhat.com>
> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/migration/colo.c
> @@ -798,9 +798,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>   
>       colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_LOADED,
>                    &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -    }
> +    error_propagate(errp, local_err);
>   }

As this is mechanical, it is fine. But there is now a further cleanup 
possible of passing errp directly to colo_send_message, and possibly 
dropping local_err altogether.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


