Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3794C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB0B20656
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx7xFAHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB0B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo75e-0002Wb-Pk
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo74y-0001tY-Mt
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:12:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48991
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo74w-0002lp-Mu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593011565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVn2gaF7jwb31PXPBMRaPi1nuPd8l9JoF+gIvaDOSUQ=;
 b=Nx7xFAHiY5PGYZCdbBjubR0obcl5/Zf7yPePaA2+2RGbnJMMUhNSVU+LLAIx98YMmujkrs
 iYAmi1yrPS20kq4bE+UaZ5nOzHg3XDCOujlZCqWJf/xmDnI+gaCChUkV77oiFuYt4Hedmn
 H7MdkBHut+52J8RbILR1VRSDSCtC7Vo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-ywcJGysHPn2GjUaCiWcMDw-1; Wed, 24 Jun 2020 11:12:43 -0400
X-MC-Unique: ywcJGysHPn2GjUaCiWcMDw-1
Received: by mail-wm1-f70.google.com with SMTP id p24so2943831wma.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FVn2gaF7jwb31PXPBMRaPi1nuPd8l9JoF+gIvaDOSUQ=;
 b=ikeEIqHuFd1yJJRa2e66BcGpUXlTum9VB9WTwqvgzaOIDLpoOb2uaV7gDNaTwcYANx
 Qy5DSCqklTeZFI3OuATaHi1BwVG+O1/buhQeutuF2526Qxsu0HlJ0UHfOMn4iVlPiq83
 SVi6Uhkz4cklwmhjRRL7dvthOrPj8Zdv/NzTWEiyBZH9b5ugUlIkGZ2ZG1LlD038jHhq
 uz4yaYbVBlQDpSIHfCkNEZVdmQN7OhvXiJUnQvBsXMkImgjX6f778TiZlAm7jQK2uFQg
 79f7OTWWdrDfa+16JPB7cRTaGVIMWZX1732wBErVQvqeXjRVg/DU+zMKEkU3xNcmfhE9
 HADw==
X-Gm-Message-State: AOAM530kbMtJlVjt4bnQWDoSvk3Ssz5KgR+UFLNbdYq8sgF2HIWof2iS
 YeZ/WjuXihHsaq3pSPrkU7d2ILGI71fd2gt7wSPrTQ9vCcZw6d+P95mhF+KxQE7Dl4jwbYIqJtC
 hDYGBMcZCyQGYKhI=
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr31753955wmk.9.1593011561659; 
 Wed, 24 Jun 2020 08:12:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8ZkE9RrcswvYGyr/clqEh2eXTGQUi/qSaZA43nybXVhNFDlBTJVEt/wU46j1J51On9E3Phw==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr31753930wmk.9.1593011561416; 
 Wed, 24 Jun 2020 08:12:41 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id w12sm17526080wrm.79.2020.06.24.08.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 08:12:40 -0700 (PDT)
Date: Wed, 24 Jun 2020 11:12:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 01/22] net/virtio: Fix failover_replug_primary() return
 value regression
Message-ID: <20200624111204-mutt-send-email-mst@kernel.org>
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-2-armbru@redhat.com>
 <20200622212559.GD18041@jenstp.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200622212559.GD18041@jenstp.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
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
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 11:25:59PM +0200, Jens Freimann wrote:
> On Mon, Jun 22, 2020 at 12:42:29PM +0200, Markus Armbruster wrote:
> > Commit 150ab54aa6 "net/virtio: fix re-plugging of primary device"
> > fixed failover_replug_primary() to return false on failure.  Commit
> > 5a0948d36c "net/virtio: Fix failover error handling crash bugs" broke
> > it again for hotplug_handler_plug() failure.  Unbreak it.
> > 
> > Commit 5a0948d36c4cbc1c5534afac6fee99de55245d12
> > 
> > Fixes: 5a0948d36c4cbc1c5534afac6fee99de55245d12
> > Cc: Jens Freimann <jfreimann@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> > hw/net/virtio-net.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Reviewed-by: Jens Freimann <jfreimann@redhat.com>
> 
> Thanks!
> 
> regards,
> Jens

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Who's merging this? Jason? Or is all this going through a single tree?


