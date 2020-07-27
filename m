Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A66FC433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAEE206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIATvVxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAEE206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0309-0007EA-Fg
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k02zE-0006lX-BF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:16:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52512
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k02zA-0005dw-W1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595855767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfFckRJ4LicWDyMej7FrHpE4LgASDzS77pRTnW4YHRY=;
 b=jIATvVxyspjvsMU6ncC5HKwO5Ox2Em/c/GAhtD4Xlv6D1UbzUNvOiD10vO0EyzaM45bhSc
 myUJD1vK0qHQcYxFg9WCWDgXZO42yZS0irxwg383QCG5DfsYCdukIjLGzLXrXLQYVvTZy8
 O1qi1OBQPwS7A/emxAd6vvB7td6hDIY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-1CLrrcyvOA2hdtnNmqog2w-1; Mon, 27 Jul 2020 09:16:06 -0400
X-MC-Unique: 1CLrrcyvOA2hdtnNmqog2w-1
Received: by mail-wr1-f69.google.com with SMTP id d6so2369594wrv.23
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bfFckRJ4LicWDyMej7FrHpE4LgASDzS77pRTnW4YHRY=;
 b=LjMxlM1DC92V223+T+5vEXycrzhgRV1N0sOrxCE2kEnXw3dp0tniVkaBkZwuj+ISlb
 vhVsi6ZVW63tDaJn/YAW1ufziAacEtoNsbtJcx8q1mPU80wo+coz0QH77F7bUwZggPPj
 cQYJXB6DyIcEl5zRKLnNEu6bXlQrP7A0zHhfQwgjiz+5+Q7nzMGgXKQswmHwxXymxLdJ
 3FRybhCn0YEwryV9/HSyLvmhvB1vNqkY5U4gje4N6I4xJLN/jGpehq0zfx4tPBA3VQMv
 STJDIZsqhX8VPwzVV12eC73FdU0ZbHsqggxDQEOp/+x1AmAT0M7u8ydGoiipRf4mQvd1
 8USg==
X-Gm-Message-State: AOAM531sy39j4RDFciXRtOSjzaIElFaoFkBwz5IY9USjnp4lr+EmOEs5
 Wd2uRmjlibVpBV8E8cykGk9zGxnvzAgdFMcMcFqxL+Ca8x0NZQvZ+IKrsMmOsGLm8r7LugcUyxN
 toyfKNdYK6Iwyre4=
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr18954059wrp.350.1595855764217; 
 Mon, 27 Jul 2020 06:16:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvxccJAgdIiLbuYI65AQzcx+XS/sof59vdN40SbwqK51woUVP/8pnyFOKFSWxhHI/J0EV3qg==
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr18954035wrp.350.1595855763887; 
 Mon, 27 Jul 2020 06:16:03 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id v67sm9146889wma.46.2020.07.27.06.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:16:02 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:16:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [BUG] vhost-vdpa: qemu-system-s390x crashes with second
 virtio-net-ccw device
Message-ID: <20200727091422-mutt-send-email-mst@kernel.org>
References: <20200724165627.70c6dfd6.cohuck@redhat.com>
 <20200724111512-mutt-send-email-mst@kernel.org>
 <20200724173448.18773aec.cohuck@redhat.com>
 <5a0dfa0b-5a1d-e7d2-1785-8cca6ddb9db8@redhat.com>
 <20200727084310.7d29ec6d.cohuck@redhat.com>
 <676ce079-adf6-a279-c2ea-68f43146e2ac@redhat.com>
 <20200727104148.4ae49715.cohuck@redhat.com>
 <fe474426-bb3e-5021-7d43-f3d0812dcaa4@redhat.com>
 <20200727074221-mutt-send-email-mst@kernel.org>
 <c574a3c6-239f-9e8a-ee0d-de56c795a8cc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c574a3c6-239f-9e8a-ee0d-de56c795a8cc@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 08:44:09PM +0800, Jason Wang wrote:
> 
> On 2020/7/27 下午7:43, Michael S. Tsirkin wrote:
> > On Mon, Jul 27, 2020 at 04:51:23PM +0800, Jason Wang wrote:
> > > On 2020/7/27 下午4:41, Cornelia Huck wrote:
> > > > On Mon, 27 Jul 2020 15:38:12 +0800
> > > > Jason Wang<jasowang@redhat.com>  wrote:
> > > > 
> > > > > On 2020/7/27 下午2:43, Cornelia Huck wrote:
> > > > > > On Sat, 25 Jul 2020 08:40:07 +0800
> > > > > > Jason Wang<jasowang@redhat.com>  wrote:
> > > > > > > On 2020/7/24 下午11:34, Cornelia Huck wrote:
> > > > > > > > On Fri, 24 Jul 2020 11:17:57 -0400
> > > > > > > > "Michael S. Tsirkin"<mst@redhat.com>   wrote:
> > > > > > > > > On Fri, Jul 24, 2020 at 04:56:27PM +0200, Cornelia Huck wrote:
> > > > > > > > > > On Fri, 24 Jul 2020 09:30:58 -0400
> > > > > > > > > > "Michael S. Tsirkin"<mst@redhat.com>   wrote:
> > > > > > > > > > > On Fri, Jul 24, 2020 at 03:27:18PM +0200, Cornelia Huck wrote:
> > > > > > > > > > > > When I start qemu with a second virtio-net-ccw device (i.e. adding
> > > > > > > > > > > > -device virtio-net-ccw in addition to the autogenerated device), I get
> > > > > > > > > > > > a segfault. gdb points to
> > > > > > > > > > > > 
> > > > > > > > > > > > #0  0x000055d6ab52681d in virtio_net_get_config (vdev=<optimized out>,
> > > > > > > > > > > >         config=0x55d6ad9e3f80 "RT") at /home/cohuck/git/qemu/hw/net/virtio-net.c:146
> > > > > > > > > > > > 146	    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > > > > > > > > > > 
> > > > > > > > > > > > (backtrace doesn't go further)
> > > > > > > > > > The core was incomplete, but running under gdb directly shows that it
> > > > > > > > > > is just a bog-standard config space access (first for that device).
> > > > > > > > > > 
> > > > > > > > > > The cause of the crash is that nc->peer is not set... no idea how that
> > > > > > > > > > can happen, not that familiar with that part of QEMU. (Should the code
> > > > > > > > > > check, or is that really something that should not happen?)
> > > > > > > > > > 
> > > > > > > > > > What I don't understand is why it is set correctly for the first,
> > > > > > > > > > autogenerated virtio-net-ccw device, but not for the second one, and
> > > > > > > > > > why virtio-net-pci doesn't show these problems. The only difference
> > > > > > > > > > between -ccw and -pci that comes to my mind here is that config space
> > > > > > > > > > accesses for ccw are done via an asynchronous operation, so timing
> > > > > > > > > > might be different.
> > > > > > > > > Hopefully Jason has an idea. Could you post a full command line
> > > > > > > > > please? Do you need a working guest to trigger this? Does this trigger
> > > > > > > > > on an x86 host?
> > > > > > > > Yes, it does trigger with tcg-on-x86 as well. I've been using
> > > > > > > > 
> > > > > > > > s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu qemu,zpci=on
> > > > > > > > -m 1024 -nographic -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001
> > > > > > > > -drive file=/path/to/image,format=qcow2,if=none,id=drive-scsi0-0-0-0
> > > > > > > > -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1
> > > > > > > > -device virtio-net-ccw
> > > > > > > > 
> > > > > > > > It seems it needs the guest actually doing something with the nics; I
> > > > > > > > cannot reproduce the crash if I use the old advent calendar moon buggy
> > > > > > > > image and just add a virtio-net-ccw device.
> > > > > > > > 
> > > > > > > > (I don't think it's a problem with my local build, as I see the problem
> > > > > > > > both on my laptop and on an LPAR.)
> > > > > > > It looks to me we forget the check the existence of peer.
> > > > > > > 
> > > > > > > Please try the attached patch to see if it works.
> > > > > > Thanks, that patch gets my guest up and running again. So, FWIW,
> > > > > > 
> > > > > > Tested-by: Cornelia Huck<cohuck@redhat.com>
> > > > > > 
> > > > > > Any idea why this did not hit with virtio-net-pci (or the autogenerated
> > > > > > virtio-net-ccw device)?
> > > > > It can be hit with virtio-net-pci as well (just start without peer).
> > > > Hm, I had not been able to reproduce the crash with a 'naked' -device
> > > > virtio-net-pci. But checking seems to be the right idea anyway.
> > > Sorry for being unclear, I meant for networking part, you just need start
> > > without peer, and you need a real guest (any Linux) that is trying to access
> > > the config space of virtio-net.
> > > 
> > > Thanks
> > A pxe guest will do it, but that doesn't support ccw, right?
> 
> 
> Yes, it depends on the cli actually.
> 
> 
> > 
> > I'm still unclear why this triggers with ccw but not pci -
> > any idea?
> 
> 
> I don't test pxe but I can reproduce this with pci (just start a linux guest
> without a peer).
> 
> Thanks
> 

Might be a good addition to a unit test. Not sure what would the
test do exactly: just make sure guest runs? Looks like a lot of work
for an empty test ... maybe we can poke at the guest config with
qtest commands at least.

-- 
MST


