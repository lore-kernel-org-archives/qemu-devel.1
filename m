Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9254E2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOVbLxPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9254E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18Yw-0002J6-TB
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1k18Y7-0001sD-Rn
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:24:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1k18Y4-00063v-SO
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596115479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trBMDum5jaV2PmP6FGjCemPgC956VMcTP3eowoAov1g=;
 b=LOVbLxPb2UPcHVZgDLM7KuWagUXwfaAVvrN5XMhAQRsuBSRY+7yzPPJvFtZQ7RhVKXvb2S
 SytRhs4flFhA5TnnJsyndvo7SiaxfGYnw5obFnlNghKQ5vezRjgAnG9xRzpw9T1QXwtvSF
 8Urs52f/BO1DgT1pTrd6EA5EXN5RXLo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-wUhUt8HkOZmWpPj-6-5AOw-1; Thu, 30 Jul 2020 09:24:35 -0400
X-MC-Unique: wUhUt8HkOZmWpPj-6-5AOw-1
Received: by mail-wm1-f71.google.com with SMTP id u14so1315299wml.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=trBMDum5jaV2PmP6FGjCemPgC956VMcTP3eowoAov1g=;
 b=gHwOW2czoj0t+Aqi/SXPUVK6iSix2MpJUoHMCz2ft0aGtydAHKKEm2f0RRYta/o0HH
 R+YOLHXDLR3ow7akUVS60oui1G/l2ex+2P1sFhlseKpyJy2wlRj8DdJMXeGtjkKjwuw+
 WMAurRnvMQtNCMZxAs3pUlO8iWsoNoIomnmOO6ldJMQDjRmAFe3jnCCpP2uYIP5IrxmZ
 Z3zYNG5rn6zCyT3q0CGsrkFC/ZBgLd43x70lWuG7qkSgXuh89v4xT2ABq+5u0S1JfSCT
 KorKmzqSpu8xs2Dd29RYl6Wn8tUVEILx9PDU8hwkWfS9lzj6YZvjaiXJRc3BeorKUKHz
 j8zw==
X-Gm-Message-State: AOAM5303vwP7pxrOBPxRB4vyBZsQCBbQLy7oLWPZcgByJSCqIdego4qW
 k5xljIjpE+/fBtVBneeRYmHkdh+M4RKOytmQbM3docc9n77WQGm4u7KiZC7yc5/rBoQa1YBV+eS
 udB61T4m/QRODgc4=
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr12750871wmo.62.1596115474321; 
 Thu, 30 Jul 2020 06:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbK20wdWHvC4AuD4fC98U/RMEiNOX+IYs63dLbAh2/L5ig+EHrNSXl9Gtwq/lrg+jGKUC+8g==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr12750834wmo.62.1596115474070; 
 Thu, 30 Jul 2020 06:24:34 -0700 (PDT)
Received: from pop-os ([2001:470:1f1d:1ea:4fde:6f63:1f5a:12b1])
 by smtp.gmail.com with ESMTPSA id l11sm8654553wme.11.2020.07.30.06.24.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 30 Jul 2020 06:24:33 -0700 (PDT)
Message-ID: <c56990fe775268793b06d94c679bec2c458b7ecf.camel@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
From: Sean Mooney <smooney@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
Date: Thu, 30 Jul 2020 14:24:31 +0100
In-Reply-To: <20200730034104.GB32327@joy-OptiPlex-7040>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040>
 <20200717101258.65555978@x1.home>
 <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
 <e8a973ea0bb2bc3eb15649fb1c44599ae3509e84.camel@redhat.com>
 <20200729131255.68730f68@x1.home>
 <20200730034104.GB32327@joy-OptiPlex-7040>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2
Mime-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=smooney@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=smooney@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net, devel@ovirt.org,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, eskultet@redhat.com, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, intel-gvt-dev@lists.freedesktop.org,
 berrange@redhat.com, cohuck@redhat.com, dinechin@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-07-30 at 11:41 +0800, Yan Zhao wrote:
> > > >    interface_version=3
> > 
> > Not much granularity here, I prefer Sean's previous
> > <major>.<minor>[.bugfix] scheme.
> > 
> 
> yes, <major>.<minor>[.bugfix] scheme may be better, but I'm not sure if
> it works for a complicated scenario.
> e.g for pv_mode,
> (1) initially,  pv_mode is not supported, so it's pv_mode=none, it's 0.0.0,
> (2) then, pv_mode=ppgtt is supported, pv_mode="none+ppgtt", it's 0.1.0,
> indicating pv_mode=none can migrate to pv_mode="none+ppgtt", but not vice versa.
> (3) later, pv_mode=context is also supported,
> pv_mode="none+ppgtt+context", so it's 0.2.0.
> 
> But if later, pv_mode=ppgtt is removed. pv_mode="none+context", how to
> name its version?
it would become 1.0.0
addtion of a feature is a minor version bump as its backwards compatiable.
if you dont request the new feature you dont need to use it and it can continue to behave like
a 0.0.0 device evne if its capably of acting as a 0.1.0 device.
when you remove a feature that is backward incompatable as any isnstance that was prevously not
using it would nolonger work so you have to bump the major version.
>  "none+ppgtt" (0.1.0) is not compatible to
> "none+context", but "none+ppgtt+context" (0.2.0) is compatible to
> "none+context".
> 
> Maintain such scheme is painful to vendor driver.
not really its how most software libs are version today. some use other schemes
but semantic versioning is don right is a concies and easy to consume set of rules
https://semver.org/ however you are right that it forcnes vendor to think about backwards
and forwards compatiablty with each change which for the most part is a good thing.
it goes hand in hand with have stable abi and api definitons to ensuring firmware updates and driver chagnes
dont break userspace that depend on the kernel interfaces they expose.



