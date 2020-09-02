Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D4C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D90206EB
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUZJEb0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D90206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDX68-0001or-52
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kDX5b-0001PM-1V
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kDX5Y-00087j-9h
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599069747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cR5qRoDOF0gGHS0+5pyxsOVTqSbv1nmTgctGehP/pY=;
 b=BUZJEb0ktaTVtqQ/cngFoi/ncTkcO4YIvOMYhSz9LN9DF227Hrpw4JqvppGdn0Ydt2ULbm
 0Nq96Xs2Vrxzp/Akg+JTu2713cet3rpuZg6NHqE872VaqvciX11OTul7iMpZXa181T35o5
 uFFGhw5xjZS4SsKl+pgP8vauzvau2xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-HlHWN3WaPeKQUrF3BG4XeA-1; Wed, 02 Sep 2020 14:02:25 -0400
X-MC-Unique: HlHWN3WaPeKQUrF3BG4XeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D1B28015A5;
 Wed,  2 Sep 2020 18:02:24 +0000 (UTC)
Received: from [10.10.117.63] (ovpn-117-63.rdu2.redhat.com [10.10.117.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E66661002D40;
 Wed,  2 Sep 2020 18:02:22 +0000 (UTC)
Subject: Re: [PATCH] ide:do nothing for identify cmd if no any device attached
To: zhaoxinRockCuioc <RockCui-oc@zhaoxin.com>, qemu-devel@nongnu.org
References: <20200817033803.14014-1-RockCui-oc@zhaoxin.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8dbcc856-879a-af83-1a76-a2a875da3699@redhat.com>
Date: Wed, 2 Sep 2020 14:02:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817033803.14014-1-RockCui-oc@zhaoxin.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, CobeChen@zhaoxin.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(CC Max for block backend model confusion, see below)

On 8/16/20 11:38 PM, zhaoxin\RockCuioc wrote:
> This patch is for avoiding win7 IDE driver polling 0x1f7 when
> no any device attached. During Win7 VM boot procedure, if use virtio for
> disk and there is no any device be attached on hda & hdb, the win7 IDE driver
> would poll 0x1f7 for a while. This action may be stop windows LOGO atomic for
> a while too on a poor performance CPU.
> 

A few questions:

(1) How slow is the probing?

(2) If there are no devices attached, why don't you remove the IDE 
controller so that Windows doesn't have to probe it?

> Signed-off-by: zhaoxin\RockCuioc <RockCui-oc@zhaoxin.com>
> ---
>   hw/ide/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index d997a78e47..26d86f4b40 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2073,8 +2073,9 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>       s = idebus_active_if(bus);
>       trace_ide_exec_cmd(bus, s, val);
>   
> -    /* ignore commands to non existent slave */
> -    if (s != bus->ifs && !s->blk) {
> +    /* ignore commands if no any device exist or non existent slave */
> +    if ((!bus->ifs[0].blk && !bus->ifs[1].blk) ||
> +        (s != bus->ifs && !s->blk)) {
>           return;
>       }
>   

I think it's the case that Empty CD-ROM drives will have an anonymous 
block backend representing the empty drive, so I suppose this is maybe fine?

I suppose the idea is that with no drives on the bus that it's fine to 
ignore the register writes, as there are no devices to record those writes.

(But then, why did we ever only check device1? ...)

Maybe before the block-backend split we used to have to check to see if 
we had attached media or not, but I think nowadays we should always have 
a blk pointer if we have a device model intended to be operating at this 
address.

So I guess it can be simplified ...?

if (!s->blk) {
     return;
}

--js


