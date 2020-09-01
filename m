Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64408C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 08:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C76B206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 08:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="laDWElzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C76B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD1n5-0003oC-CD
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 04:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kD1mL-0003Ny-I5; Tue, 01 Sep 2020 04:36:33 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:55778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kD1mG-00012g-Vl; Tue, 01 Sep 2020 04:36:32 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A85122E1507;
 Tue,  1 Sep 2020 11:36:21 +0300 (MSK)
Received: from sas1-58a37b48fb94.qloud-c.yandex.net
 (sas1-58a37b48fb94.qloud-c.yandex.net [2a02:6b8:c08:1d1b:0:640:58a3:7b48])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 0kiuyNJj1e-aIvq6eWJ; Tue, 01 Sep 2020 11:36:21 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1598949381; bh=p3U7+LUx5n/ED+wNoTAE86ES+sx6+03eaz6fSXoHlRg=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=laDWElzqShn/qjHXPAVxqPtw92ey+d6cazKOfXTZiOR/PoMozVrOQbH24PmZu99EU
 2eMt7VpdW3joLDBlu+PlYUD5sFt9m/rKrRHSWQjeBBEeIv7BjWeSqsPvfN0+fHhXF4
 zjF4mwtkbWUnZ6TDZ06m1bRzRB3QB2AxBuj6/DLM=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:110::1:6])
 by sas1-58a37b48fb94.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 WWZGn7wzbR-aImWve6J; Tue, 01 Sep 2020 11:36:18 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 1 Sep 2020 11:36:17 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v2 2/7] vhost: check queue state in the vhost_dev_set_log
 routine
Message-ID: <20200901083616.GA18268@dimastep-nix>
References: <cover.1598257838.git.dimastep@yandex-team.ru>
 <a2eca26b79e1fcc30128a266bfa416237366c533.1598257838.git.dimastep@yandex-team.ru>
 <CAFubqFsnc3VjkYB-CqgeQ6Knwtvgb0Zyw-nOHD1CugLzTBe9Ew@mail.gmail.com>
 <20200831083740.GA6083@dimastep-nix>
 <CAFubqFu8ek_gBVFV1+MaLHnhjkQ=955QYP8Ss84diZrkbuNOAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFubqFu8ek_gBVFV1+MaLHnhjkQ=955QYP8Ss84diZrkbuNOAw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 04:36:21
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 11:22:14PM -0400, Raphael Norwitz wrote:
> On Mon, Aug 31, 2020 at 4:37 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > On Thu, Aug 27, 2020 at 09:46:03PM -0400, Raphael Norwitz wrote:
> > > On Mon, Aug 24, 2020 at 4:41 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> > > >
> > > > If the vhost-user-blk daemon provides only one virtqueue, but device was
> > > > added with several queues, then QEMU will send more VHOST-USER command
> > > > than expected by daemon side. The vhost_virtqueue_start() routine
> > > > handles such case by checking the return value from the
> > > > virtio_queue_get_desc_addr() function call. Add the same check to the
> > > > vhost_dev_set_log() routine.
> > > >
> > > > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > > > ---
> > > >  hw/virtio/vhost.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > index ffef7ab..a33ffd4 100644
> > > > --- a/hw/virtio/vhost.c
> > > > +++ b/hw/virtio/vhost.c
> > > > @@ -825,12 +825,24 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
> > > >  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> > > >  {
> > > >      int r, i, idx;
> > > > +    hwaddr addr;
> > > > +
> > > >      r = vhost_dev_set_features(dev, enable_log);
> > > >      if (r < 0) {
> > > >          goto err_features;
> > > >      }
> > > >      for (i = 0; i < dev->nvqs; ++i) {
> > > >          idx = dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + i);
> > > > +        addr = virtio_queue_get_desc_addr(dev->vdev, idx);
> > > > +        if (!addr) {
> > > > +            /*
> > > > +             * The queue might not be ready for start. If this
> > > > +             * is the case there is no reason to continue the process.
> > > > +             * The similar logic is used by the vhost_virtqueue_start()
> > > > +             * routine.
> > > > +             */
> > >
> > > Shouldn’t we goto err_vq here to reset the logging state of any vqs
> > > which have already been set?
> > As i understand it, no we shouldn't reset the state of other queues. In
> > general it is pretty valid case. Let's assume that the backend
> > vhost-user device supports only two queues. But for instance, the QEMU
> > command line is using value 4 to define number of virtqueues of such
> > device. In this case only 2 queues will be initializaed.
> 
> I see - makes more sense now.
> 
> >
> > I've tried to reflect it in the comment section, that the
> > vhost_virtqueue_start() routine has been alread made the same:
> >   "if a queue isn't ready for start, just return 0 without any error"
> > So i made the same here.
> >
> 
> In your example is a reason why, if queue 3 is uninitialized, queue 4
> must also be uninitialized? I realize queue 4 being initialized while
> queue 3 is not is a strange case, but it may still make the code more
> robust to use a "continue" here instead of a "break". This also seems
> more like the logic in vhost_virtqueue_start()/vhost_dev_start().
Good point! Should really use "continue" instead of a "break" to keep
the logic. Will update it in v4. Hope to get some review feedback for
the qtest framework update aswell ).

> 
> > I've found this issue, while testing migration with the default
> > vhost-user-blk daemon. It fails with assert or sigsegv (don't remember),
> > because it receives NULL for the queues it doesn't have. In general
> > the daemon should not fall, because of unexpected VHOST_USER
> > communication, but also there is no reason for QEMU to send additional
> > packets.
> >
> > >
> > > > +            break;
> > > > +        }
> > > >          r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
> > > >                                       enable_log);
> > > >          if (r < 0) {
> > > > --
> > > > 2.7.4
> > > >
> > > >

