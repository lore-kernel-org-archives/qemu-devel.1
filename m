Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA581C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDBF20897
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOJZdMbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDBF20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLBc2-0000fa-RA
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLBZz-0000BO-OE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLBZw-0008RO-H6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600893687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQq5jY/jky0oTybRoPxLOZU7yIH0V12Nje2ZVCqMstQ=;
 b=jOJZdMbUsJN1kDdmBMNsaFgVOVCaZJuvev23Cx/WSWmnhojaUvFmS0zRF57mC+swpGmDJA
 CrRmw5gdxndnG1Bkqp2iEV6zh0Q2KucevIz+AUN4ZH4mEWmvuxmOwEI8/BpZdNBXmexXhu
 yr7QvP5RkcvnXGzC/vhFqRj1SDnbXGg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-oVcXta8wMYeO_uJZ24UC8g-1; Wed, 23 Sep 2020 16:41:23 -0400
X-MC-Unique: oVcXta8wMYeO_uJZ24UC8g-1
Received: by mail-wr1-f70.google.com with SMTP id a12so298268wrg.13
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 13:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zQq5jY/jky0oTybRoPxLOZU7yIH0V12Nje2ZVCqMstQ=;
 b=cbQzAAIHdXXqI29Y77jxSmh3jvwB/aMV3xUIJpPVgF/CIPv1WdHxAgVy/qZig1RhyZ
 pw/Ois3NJm7eTHlbbhQN3LQdHu/KILZ3CPlZqHhwuikpg/isbOOtrOmCqIVFCyikfhtN
 utxKOMQOiZsBJfqhHp9gHuxGt8VkH6REY9MEMHUZQYW2PG4n64Ibu/ddWPgM9mWZBR1M
 O0GpyqO8wiKmmZyHwzR8cG1gytWTEl5Hp6TRuA+LFmyEUzNNDLtFgWn8VuQarqwBJV+r
 jippsSMEmO/vpFVdmpyTXC9lWnpjuLwsSS0BM4lrgkn5qw9kgP1SpOmFieWSWW23hCCR
 Htfw==
X-Gm-Message-State: AOAM532wyzbcvM9tyi8wmULtzGgKImR753DE3QMt4CFJG/jxNvgdnvDu
 i0hgMSNKUSrWU+TBcTthkrzU7iGt9RpSXHPDyLGNwizjtPySdr8MXyOQmPknhHp4sKZQIqEZVCp
 MuBjwXE/yGQXMMUw=
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr1493847wrn.228.1600893682507; 
 Wed, 23 Sep 2020 13:41:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTDSERIzok8R62Oh+81w9TwU7g3e9GUWX3Pdo3vBraTllUTp5StogQj7zSMJFumsh2VbbgBw==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr1493834wrn.228.1600893682273; 
 Wed, 23 Sep 2020 13:41:22 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d6sm973111wrq.67.2020.09.23.13.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 13:41:20 -0700 (PDT)
Date: Wed, 23 Sep 2020 16:41:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
Message-ID: <20200923164029-mutt-send-email-mst@kernel.org>
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
 <20200921083052-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200921083052-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter, you said you see issues on some systems.
I pushed a tag: 
    git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream_test
which drops some patches I suspect.
If that helps, pls let me know.


On Mon, Sep 21, 2020 at 08:31:35AM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 21, 2020 at 07:44:42PM +0800, Li Qiang wrote:
> > Michael S. Tsirkin <mst@redhat.com> 于2020年9月21日周一 下午7:30写道：
> > >
> > > The following changes since commit 053a4177817db307ec854356e95b5b350800a216:
> > >
> > >   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918' into staging (2020-09-18 16:34:26 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to acbdbd5db6dab68534702987a487360fd8ae02b7:
> > >
> > >   virtio-iommu-pci: force virtio version 1 (2020-09-21 06:14:46 -0400)
> > >
> > > ----------------------------------------------------------------
> > > virtio,pc,acpi: fixes, tests
> > >
> > > Fixes and tests all over the place.
> > > Batch iommu updates for vdpa.
> > > Removal of deprecated cpu hotplug commands.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------
> > > David Hildenbrand (1):
> > >       pc: fix auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
> > >
> > > Dima Stepanov (7):
> > >       vhost: recheck dev state in the vhost_migration_log routine
> > >       vhost: check queue state in the vhost_dev_set_log routine
> > >       tests/qtest/vhost-user-test: prepare the tests for adding new dev class
> > >       tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
> > >       tests/qtest/vhost-user-test: add support for the vhost-user-blk device
> > >       tests/qtest/vhost-user-test: add migrate_reconnect test
> > >       tests/qtest/vhost-user-test: enable the reconnect tests
> > >
> > > Eric Auger (2):
> > >       virtio-iommu: Check gtrees are non null before destroying them
> > >       virtio-iommu-pci: force virtio version 1
> > >
> > > Igor Mammedov (1):
> > >       cphp: remove deprecated cpu-add command(s)
> > >
> > > Jason Wang (3):
> > >       linux headers: sync to 5.9-rc4
> > >       vhost: switch to use IOTLB v2 format
> > >       vhost-vdpa: batch updating IOTLB mappings
> > >
> > > Li Qiang (1):
> > >       virtio-mem: detach the element from the virtqueue when error occurs
> > 
> > Hello Michael,
> > It seems you lost the virtio-pmem patch.
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02639.html
> 
> That's because I was never copied. Can you repost with all tags and Cc
> me?
> Subject can be PATCH repost.
> 
> > Anyway, it can be queued in the next pr.
> > 
> > Thanks,
> > Li Qiang


