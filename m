Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5CC10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB12218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Axoz8YUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB12218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFv8Z-0006mK-Uh
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kFv7v-0005rC-Mt; Wed, 09 Sep 2020 04:06:47 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:58972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kFv7q-0002Ph-V4; Wed, 09 Sep 2020 04:06:45 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 08F412E1659;
 Wed,  9 Sep 2020 11:06:37 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 5z0xdbkWRN-6YwepREE; Wed, 09 Sep 2020 11:06:36 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599638796; bh=vsgufCxiBEgmH4bZX2s2omPbxv1bNjwmMUaM/b8g+ts=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=Axoz8YUOVD4+S6V/uMsHkaefGhDCQ2mhhhkgJtuI05h+xLS/9Nb5UnpppHk+Km/m+
 7cnQSbnUzcW/JR9L+NMcaPmITOgF4/m69l/YXqlBVcRuhT2Q3rfP39A0JRoGrfFq/T
 ZpVBMFPBs0u1LfHME5FwAuknfuPgEu/5Q8MqbE4U=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6505::1:2])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 svxU3cYDpf-6Xm8m3he; Wed, 09 Sep 2020 11:06:33 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Wed, 9 Sep 2020 11:06:32 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v4 4/7] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
Message-ID: <20200909080632.GA23110@dimastep-nix>
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <4d78746dfa627cc00e810d826b49e9612a74cdff.1599211479.git.dimastep@yandex-team.ru>
 <CAFubqFvGNV3DVmnanhMZGaRzodAkAU8MboDd2T9W_P__KpUW8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFubqFvGNV3DVmnanhMZGaRzodAkAU8MboDd2T9W_P__KpUW8g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 04:06:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Tue, Sep 08, 2020 at 11:01:57PM -0400, Raphael Norwitz wrote:
> On Fri, Sep 4, 2020 at 5:34 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > Add support for the vhost-user-blk-pci device. This node can be used by
> > the vhost-user-blk tests. Tests for the vhost-user-blk device are added
> > in the following patches.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  tests/qtest/libqos/virtio-blk.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
> > index 5da0259..959c5dc 100644
> > --- a/tests/qtest/libqos/virtio-blk.c
> > +++ b/tests/qtest/libqos/virtio-blk.c
> > @@ -36,6 +36,9 @@ static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
> >      if (!g_strcmp0(interface, "virtio")) {
> >          return v_blk->vdev;
> >      }
> > +    if (!g_strcmp0(interface, "vhost-user-blk")) {
> 
> Small point but why not merge this conditional with the
> !g_strcmp0(interface, "virtio-blk") check above? They both return
> v_blk.
Good point, will made an update. Thanks!
> 
> Otherwise looks good.
> 
> > +        return v_blk;
> > +    }
> >
> >      fprintf(stderr, "%s not present in virtio-blk-device\n", interface);
> >      g_assert_not_reached();
> > @@ -120,6 +123,17 @@ static void virtio_blk_register_nodes(void)
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

