Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC60C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A83206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="dukkGLXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A83206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIfhI-0000PK-9V
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 18:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kIfgK-00088o-7D; Wed, 16 Sep 2020 18:13:40 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:56252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kIfgF-0006Zo-Mm; Wed, 16 Sep 2020 18:13:38 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C0C2F2E14EF;
 Thu, 17 Sep 2020 01:13:27 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Pm7NBUDL03-DQv8xcGP; Thu, 17 Sep 2020 01:13:27 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1600294407; bh=gkREErUOc/Pg8bv+bjxA5l3kt2UwYdELAd8vlORfiic=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=dukkGLXwnThtjfpUf24Sj3gnYvXMM6FPMyCgvkUqaBu/UKrA6fprSgtCubAELxbgH
 G6G3Qso/AI7YFP3oGo2tKmS05RNITqResCL7rr9yjK9JhtVF6YbmtdYz0JQS93L5p/
 Y368IzQVpVyK/1uTgkv58Oqn/ooH4/80ipQx+BzA=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net
 [2a02:6b8:b080:9011::1:1])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 zySMtzWiWA-DJmOONdO; Thu, 17 Sep 2020 01:13:26 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Thu, 17 Sep 2020 01:13:14 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v5 4/7] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
Message-ID: <20200916221313.GA3324@dimastep-nix>
References: <cover.1599813294.git.dimastep@yandex-team.ru>
 <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
 <CAFubqFssie0eqor4sL+v09kwam6aaoa8P7k+y0x=KHLZXs_7bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFubqFssie0eqor4sL+v09kwam6aaoa8P7k+y0x=KHLZXs_7bA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 09:23:42PM -0400, Raphael Norwitz wrote:
> On Fri, Sep 11, 2020 at 4:43 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > Add support for the vhost-user-blk-pci device. This node can be used by
> > the vhost-user-blk tests. Tests for the vhost-user-blk device are added
> > in the following patches.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> 
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Hi,

Looks like that all the patch set is reviewed except 7/7. If it is an
issue, we can cut it from the set and merge other six commits.

Raphael,

Will you take it for merge?

Thanks, Dima.

> 
> > ---
> >  tests/qtest/libqos/virtio-blk.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
> > index 5da0259..c0fd9d2 100644
> > --- a/tests/qtest/libqos/virtio-blk.c
> > +++ b/tests/qtest/libqos/virtio-blk.c
> > @@ -30,7 +30,8 @@
> >  static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
> >                                      const char *interface)
> >  {
> > -    if (!g_strcmp0(interface, "virtio-blk")) {
> > +    if (!g_strcmp0(interface, "virtio-blk") ||
> > +            !g_strcmp0(interface, "vhost-user-blk")) {
> >          return v_blk;
> >      }
> >      if (!g_strcmp0(interface, "virtio")) {
> > @@ -120,6 +121,17 @@ static void virtio_blk_register_nodes(void)
> >      qos_node_produces("virtio-blk-pci", "virtio-blk");
> >
> >      g_free(arg);
> > +
> > +    /* vhost-user-blk-pci */
> > +    arg = g_strdup_printf("id=drv0,chardev=chdev0,addr=%x.%x",
> > +                                PCI_SLOT, PCI_FN);
> > +    opts.extra_device_opts = arg;
> > +    add_qpci_address(&opts, &addr);
> > +    qos_node_create_driver("vhost-user-blk-pci", virtio_blk_pci_create);
> > +    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
> > +    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
> > +
> > +    g_free(arg);
> >  }
> >
> >  libqos_init(virtio_blk_register_nodes);
> > --
> > 2.7.4
> >
> >

