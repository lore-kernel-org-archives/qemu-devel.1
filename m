Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B3AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06B6206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qh/bbpTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06B6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyz8h-0004Rp-5G
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyz7u-0003ag-2c
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:56:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34357
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyz7q-0008NT-IQ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595602600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeWYr2gc55W8sk1bIP20qvUC9swsCCrUszLWImQ0zZ0=;
 b=Qh/bbpTOzqrRBWUwye/YJDLQvwxbyhKE0RC6rpQ/qabO/EwWcuFfAYInFCMINuz9cKcqYs
 ZPYpWvY5ZLWK9jwhaHGXSMK8QA53yuq0Jmdz/lpYokEupty3R/6NHR9wahMJLD0m1018pa
 u2XXHEo/9TKQjhBEb6lmZ0/BFCgelnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-8edadLxOPdihUZ0Lp5gmoQ-1; Fri, 24 Jul 2020 10:56:38 -0400
X-MC-Unique: 8edadLxOPdihUZ0Lp5gmoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6DB7800C64;
 Fri, 24 Jul 2020 14:56:37 +0000 (UTC)
Received: from gondolin (ovpn-112-188.ams2.redhat.com [10.36.112.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DF142E021;
 Fri, 24 Jul 2020 14:56:29 +0000 (UTC)
Date: Fri, 24 Jul 2020 16:56:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [BUG] vhost-vdpa: qemu-system-s390x crashes with second
 virtio-net-ccw device
Message-ID: <20200724165627.70c6dfd6.cohuck@redhat.com>
In-Reply-To: <20200724092906-mutt-send-email-mst@kernel.org>
References: <20200724152718.4e1cbc9e.cohuck@redhat.com>
 <20200724092906-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-s390x@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 09:30:58 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 24, 2020 at 03:27:18PM +0200, Cornelia Huck wrote:
> > When I start qemu with a second virtio-net-ccw device (i.e. adding
> > -device virtio-net-ccw in addition to the autogenerated device), I get
> > a segfault. gdb points to
> > 
> > #0  0x000055d6ab52681d in virtio_net_get_config (vdev=<optimized out>, 
> >     config=0x55d6ad9e3f80 "RT") at /home/cohuck/git/qemu/hw/net/virtio-net.c:146
> > 146	    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > 
> > (backtrace doesn't go further)

The core was incomplete, but running under gdb directly shows that it
is just a bog-standard config space access (first for that device).

The cause of the crash is that nc->peer is not set... no idea how that
can happen, not that familiar with that part of QEMU. (Should the code
check, or is that really something that should not happen?)

What I don't understand is why it is set correctly for the first,
autogenerated virtio-net-ccw device, but not for the second one, and
why virtio-net-pci doesn't show these problems. The only difference
between -ccw and -pci that comes to my mind here is that config space
accesses for ccw are done via an asynchronous operation, so timing
might be different.

> > 
> > Starting qemu with no additional "-device virtio-net-ccw" (i.e., only
> > the autogenerated virtio-net-ccw device is present) works. Specifying
> > several "-device virtio-net-pci" works as well.
> > 
> > Things break with 1e0a84ea49b6 ("vhost-vdpa: introduce vhost-vdpa net
> > client"), 38140cc4d971 ("vhost_net: introduce set_config & get_config")
> > works (in-between state does not compile).  
> 
> Ouch. I didn't test all in-between states :(
> But I wish we had a 0-day instrastructure like kernel has,
> that catches things like that.

Yep, that would be useful... so patchew only builds the complete series?

> 
> > This is reproducible with tcg as well. Same problem both with
> > --enable-vhost-vdpa and --disable-vhost-vdpa.
> > 
> > Have not yet tried to figure out what might be special with
> > virtio-ccw... anyone have an idea?
> > 
> > [This should probably be considered a blocker?]  

I think so, as it makes s390x unusable with more that one
virtio-net-ccw device, and I don't even see a workaround.


