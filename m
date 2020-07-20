Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34303C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A6622482
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4uhBx00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A6622482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxTDH-0004zu-9i
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1jxTCf-0004an-V6
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:39:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1jxTCd-0005QA-8a
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595241560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sklRsRTSQU9Hiyxm0q5Mr8YUheq3vmnY8+P0vWizCkA=;
 b=U4uhBx00dO1iLI+GCoLycxHk1FXCD+XKmqD92xLSY2VRfjLs7tC1lepZi7jWJr29x94Vkz
 49O+NUVlWJXRtetLdBtoORGP+L9cOleS5Yh2EfpG0zh4/gYQUxIZ4kocJGQI2twmVyNaQR
 6ycZWVHBBUYJPl1l1XIS7FECAA6xiF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-c0-oIzruMzyjMsrnIBb83Q-1; Mon, 20 Jul 2020 06:39:17 -0400
X-MC-Unique: c0-oIzruMzyjMsrnIBb83Q-1
Received: by mail-wr1-f70.google.com with SMTP id d11so11971557wrw.12
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 03:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sklRsRTSQU9Hiyxm0q5Mr8YUheq3vmnY8+P0vWizCkA=;
 b=d7oIb/pL9ml42662QRwQQjs2GBjsdjX5N/XfGg3aykeyN4weAvxB01RxjtnxK1g1WI
 g1TqUokGZ3Mo7NvQah9B3crEjKnR9iBrMrhvZRxmUR6wMTQofpvdIxsWf1CgGQ1hm2HB
 7A4ppkbUuAWPdD27cGFUJR4iaUXHFW+OI6mpF9SPHsPL/K2WtedtZqrrTKJMHaRPFeZr
 PN9JPOr/vpjAL3CWDcYKJgb+0eifOPLce8GatK6f9yw/DHI1O0VQPALFX33iGLlKlR7t
 AQlZkM0dHQH/81tprFYMrTPvAP9+kAaXqXJay2zHJJU6Wk6xvUJuKy/dtje4EmrFbyTx
 +nJQ==
X-Gm-Message-State: AOAM532ClWbAog9OaIEkVyJj1gB0H14qvE9ipYp1raYqkoRjX/Of2Sd8
 p527/ARuMkwDSOf6B3Sk6GJZf4PCrqDRKll5RAZSIE236X5UUMecvk7xMKvFbZ3WAUkMD16mc0N
 WUsFKaYgpbnqJwew=
X-Received: by 2002:adf:a11d:: with SMTP id o29mr3508143wro.421.1595241556149; 
 Mon, 20 Jul 2020 03:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl8UsImJLC98sdzsBmUeXUpIS1hPMSxtTVUgonzL8XKvJioH4iWMe8CewSGE+efnYGdkopJQ==
X-Received: by 2002:adf:a11d:: with SMTP id o29mr3508112wro.421.1595241555829; 
 Mon, 20 Jul 2020 03:39:15 -0700 (PDT)
Received: from pop-os ([51.37.88.107])
 by smtp.gmail.com with ESMTPSA id t13sm8425187wru.65.2020.07.20.03.39.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 Jul 2020 03:39:15 -0700 (PDT)
Message-ID: <60d5c1609aaef72f2877aaacff04dc7187e4b3a5.camel@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
From: Sean Mooney <smooney@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
Date: Mon, 20 Jul 2020 11:39:14 +0100
In-Reply-To: <95c13c9b-daab-469b-f244-a0f741f1b41d@redhat.com>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040>
 <20200717101258.65555978@x1.home>
 <95c13c9b-daab-469b-f244-a0f741f1b41d@redhat.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2
Mime-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=smooney@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: shaohe.feng@intel.com, corbet@lwn.net, kevin.tian@intel.com,
 cohuck@redhat.com, berrange@redhat.com, kvm@vger.kernel.org, devel@ovirt.org,
 libvir-list@redhat.com, eskultet@redhat.com, jian-feng.ding@intel.com,
 qemu-devel@nongnu.org, zhenyuw@linux.intel.com, dgilbert@redhat.com,
 bao.yumeng@zte.com.cn, kwankhede@nvidia.com,
 openstack-discuss@lists.openstack.org, xin-ran.wang@intel.com,
 dinechin@redhat.com, hejie.xu@intel.com, intel-gvt-dev@lists.freedesktop.org,
 eauger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-20 at 11:41 +0800, Jason Wang wrote:
> On 2020/7/18 上午12:12, Alex Williamson wrote:
> > On Thu, 16 Jul 2020 16:32:30 +0800
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > 
> > > On Thu, Jul 16, 2020 at 12:16:26PM +0800, Jason Wang wrote:
> > > > On 2020/7/14 上午7:29, Yan Zhao wrote:
> > > > > hi folks,
> > > > > we are defining a device migration compatibility interface that helps upper
> > > > > layer stack like openstack/ovirt/libvirt to check if two devices are
> > > > > live migration compatible.
> > > > > The "devices" here could be MDEVs, physical devices, or hybrid of the two.
> > > > > e.g. we could use it to check whether
> > > > > - a src MDEV can migrate to a target MDEV,
> > > > > - a src VF in SRIOV can migrate to a target VF in SRIOV,
> > > > > - a src MDEV can migration to a target VF in SRIOV.
> > > > >     (e.g. SIOV/SRIOV backward compatibility case)
> > > > > 
> > > > > The upper layer stack could use this interface as the last step to check
> > > > > if one device is able to migrate to another device before triggering a real
> > > > > live migration procedure.
> > > > > we are not sure if this interface is of value or help to you. please don't
> > > > > hesitate to drop your valuable comments.
> > > > > 
> > > > > 
> > > > > (1) interface definition
> > > > > The interface is defined in below way:
> > > > > 
> > > > >                __    userspace
> > > > >                 /\              \
> > > > >                /                 \write
> > > > >               / read              \
> > > > >      ________/__________       ___\|/_____________
> > > > >     | migration_version |     | migration_version |-->check migration
> > > > >     ---------------------     ---------------------   compatibility
> > > > >        device A                    device B
> > > > > 
> > > > > 
> > > > > a device attribute named migration_version is defined under each device's
> > > > > sysfs node. e.g. (/sys/bus/pci/devices/0000\:00\:02.0/$mdev_UUID/migration_version).
> > > > 
> > > > Are you aware of the devlink based device management interface that is
> > > > proposed upstream? I think it has many advantages over sysfs, do you
> > > > consider to switch to that?
> > 
> > Advantages, such as?
> 
> 
> My understanding for devlink(netlink) over sysfs (some are mentioned at 
> the time of vDPA sysfs mgmt API discussion) are:
i tought netlink was used more a as a configuration protocoal to qurry and confire nic and i guess
other devices in its devlink form requireint a tool to be witten that can speak the protocal to interact with.
the primary advantate of sysfs is that everything is just a file. there are no addtional depleenceis
needed and unlike netlink there are not interoperatblity issues in a coanitnerised env. if you are using diffrenet
version of libc and gcc in the contaienr vs the host my understanding is tools like ethtool from ubuntu deployed
in a container on a centos host can have issue communicating with the host kernel. if its jsut a file unless
the format the data is returnin in chagnes or the layout of sysfs changes its compatiable regardless of what you
use to read it.
> 
> - existing users (NIC, crypto, SCSI, ib), mature and stable
> - much better error reporting (ext_ack other than string or errno)
> - namespace aware
> - do not couple with kobject
> 
> Thanks
> 


