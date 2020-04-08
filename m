Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBBAC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171F220753
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGJiG0Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171F220753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM89O-0005JS-6l
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jM88Y-0004iA-4j
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jM88W-0001fH-4g
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:40:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jM88V-0001f4-Tj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586342447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=br8XVJYlGyJzOcxTIihoJuqdGOfv9W56CwbbS6teb4k=;
 b=KGJiG0MrTksueQB1sYD4Av35fa87cQmsSnedN47oCmRu5RWbu2oESTT9PGlNHxn0n1vbkb
 9fpPcLKMVqj30dQqDWFopHSX13R1MVhi5WbSmTK5o0ERzbA0zdgBsR1qLS1e8oCh5Wvqpk
 CiPIyMewWuDPYjLiaQcSZUbEvVlzH5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ODsUQ6SFPpyvIUQgqploCg-1; Wed, 08 Apr 2020 06:40:45 -0400
X-MC-Unique: ODsUQ6SFPpyvIUQgqploCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D86D107ACC4;
 Wed,  8 Apr 2020 10:40:44 +0000 (UTC)
Received: from localhost (unknown [10.40.208.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3C0038F;
 Wed,  8 Apr 2020 10:40:37 +0000 (UTC)
Date: Wed, 8 Apr 2020 12:40:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: hotplug issue of vhost-user-blk
Message-ID: <20200408124035.41c1d242@redhat.com>
In-Reply-To: <CAHckoCzojVSHLAwBP2QhFx3Gw6j9DVPRwNSML9D4GQMzKr9Y3g@mail.gmail.com>
References: <CAHckoCzojVSHLAwBP2QhFx3Gw6j9DVPRwNSML9D4GQMzKr9Y3g@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 raphael.norwitz@nutanix.com, Kyle Zhang <kyle@smartx.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Apr 2020 10:25:42 +0800
Li Feng <fengli@smartx.com> wrote:

> Hi all,
> 
> Hotplug of vhost-user-blk doesn't not work in qemu master branch and
> all previous version.
> 
> The action I insert a vhost-user-blk disk is:
> (qemu) chardev-add socket,id=spdk_vhost_blk2,path=/vhost-blk.0,reconnect=1
> (qemu) device_add
> vhost-user-blk-pci,chardev=spdk_vhost_blk2,id=spdk_vhost_blk2,num-queues=4
> 
> Until here, it's well.
> 
> Then I unplug it from qemu:
> (qemu) device_del spdk_vhost_blk2
> (qemu) chardev-remove spdk_vhost_blk2
> Error: Chardev 'spdk_vhost_blk2' is busy
> 
> The related code is here:
> qmp_chardev_remove
>     -> qemu_chr_is_busy
>     -> object_unparent(OBJECT(chr));  
> 
>  330 static bool qemu_chr_is_busy(Chardev *s)
>  331 {
>  332     if (CHARDEV_IS_MUX(s)) {
>  333         MuxChardev *d = MUX_CHARDEV(s);
>  334         return d->mux_cnt >= 0;
>  335     } else {
>  336         return s->be != NULL;
>  337     }
>  338 }
> 
> My question is:
> 1. s->be is set to NULL when qemu_chr_fe_deinit is called.
> However, the qmp_chardev_remove is blocked at qemu_chr_is_busy check,
> then the object_unparent will not be called.
> 2. Is there a path that device_del will trigger the s->be that been set to NULL?

device_del is request for guest to eject device and once it's done backend
could be removed. 

what's you command line? (so I could point out entry point where ejection happens
for you to troubleshoot it further)

> 
> How should I fix this issue?
> I have tested that comment the qemu_chr_is_busy works well.
> 
> Thanks in advance.
> 
> Feng Li
> 


