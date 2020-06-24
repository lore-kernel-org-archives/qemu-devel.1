Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B206C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 18:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6D4206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 18:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLY+Yh6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6D4206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo9kz-0007F6-IT
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 14:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jo9k3-0005XP-Uy
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:03:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jo9k1-00012r-Nq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593021800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXBOR0EA1Bxzz1drkW7Sd4QXmuZ+UhZnFzoclc9SfdQ=;
 b=aLY+Yh6OgJ8R3Kof6JO2BWVWL9GLQtEIrcRZi4o0wmuhXQ4R3If8/epF7LqH2xcoa2npLm
 VT1hBepEyNin2Bs65HFNPw2oPlLjW6SW89ZDHB4k7Ez+OwxNWABbIEdFNxeX/L3y10XaOe
 hKE6Noo7XAEhjks4o3tlpp8ZqoZjzjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-LVRT6PKdONmqnAeIJjsotg-1; Wed, 24 Jun 2020 14:03:18 -0400
X-MC-Unique: LVRT6PKdONmqnAeIJjsotg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91A7D107ACCD;
 Wed, 24 Jun 2020 18:03:17 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDED55BACC;
 Wed, 24 Jun 2020 18:03:16 +0000 (UTC)
Subject: Re: [PATCH 03/46] qdev: Smooth error checking of qdev_realize() &
 friends
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c503f65b-9d1e-6a1b-502a-fdcc4bfa4bcf@redhat.com>
Date: Wed, 24 Jun 2020 13:03:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-4-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 11:43 AM, Markus Armbruster wrote:
> Convert
> 
>      foo(..., &err);
>      if (err) {
>          ...
>      }
> 
> to
> 
>      if (!foo(..., &err)) {
>          ...
>      }
> 
> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
> Coccinelle script:

Automated patching is so much easier than manual :)

> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Convert manually.
> 
> Eliminate error_propagate() that are now unnecessary.  Delete @err
> that are now unused.  Clean up whitespace.

Well, so there's still some manual stuff.  But that's okay; hopefully we 
don't have too many stragglers reintroduced via pending patches.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>   65 files changed, 248 insertions(+), 768 deletions(-)

Quite a big trim.  But I didn't spot any obvious problems.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


