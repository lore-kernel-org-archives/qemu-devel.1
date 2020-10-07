Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241E7C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92046206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCh2lU/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92046206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCcu-0000Kq-Dy
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQCPm-0000AA-In
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQCPi-0007fm-Bw
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602088530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f59Tr3yLal+hTdQ7g/ImlN+a/DyVZOA5Qz+nlbKAc08=;
 b=iCh2lU/3V26/76vXq+NWq6Kyi1bZX0tyBQIVbq/PVvF5otue+sLAPCyYZGskUig5UMzzh5
 wGKSOe+xbSmK5J/7IhELSJtEXuaBt7KkYAOqHNGzqF7fiBcvkmX2rJAzKgBkLFb97nScUC
 1TdFxZCTeRaLMg9IV6nKc+35acShruU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-iub3khIIPnqicO6wmgGo1A-1; Wed, 07 Oct 2020 12:35:28 -0400
X-MC-Unique: iub3khIIPnqicO6wmgGo1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C9A1921FAA;
 Wed,  7 Oct 2020 16:35:27 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE21519C59;
 Wed,  7 Oct 2020 16:35:26 +0000 (UTC)
Subject: Re: [PATCH v1 03/22] hw/ide: restore replay support of IDE
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201007160038.26953-1-alex.bennee@linaro.org>
 <20201007160038.26953-4-alex.bennee@linaro.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <5739951f-b0ff-ec78-b306-8c0bbcf0e3f3@redhat.com>
Date: Wed, 7 Oct 2020 12:35:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007160038.26953-4-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 "open list:IDE" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 12:00 PM, Alex Bennée wrote:
> A recent change to weak reset handling broke replay due to the use of
> aio_bh_schedule_oneshot instead of the replay aware
> replay_bh_schedule_oneshot_event.
> 
> Fixes: 55adb3c456 ("ide: cancel pending callbacks on SRST")
> Suggested-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/ide/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0e32abd779..693b352d5e 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2289,8 +2289,8 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
>               s = &bus->ifs[i];
>               s->status |= BUSY_STAT;
>           }
> -        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> -                                ide_bus_perform_srst, bus);
> +        replay_bh_schedule_oneshot_event(qemu_get_aio_context(),
> +                                         ide_bus_perform_srst, bus);
>       }
>   
>       bus->cmd = val;
> 

Reviewed-by: John Snow <jsnow@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>


