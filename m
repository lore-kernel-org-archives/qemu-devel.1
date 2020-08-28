Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A518C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC3D2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeXIsKKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC3D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBf00-0006od-6z
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1kBezP-0006OK-3e
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:04:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1kBezL-0002n1-V1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598623457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gi+o9kVZ3pRl9KJVntsAEDs9X1jzPPrVq1ZT4piLZwc=;
 b=DeXIsKKxZWlJgtEoP5gzZGBPx82BOgP5YoXTjB8epaoA4AIReq9YEY+sHzpuJp77iDkg+K
 LUpj5pwb+Ge/iS1Mk114RHQothzfArSGg8mODlCnFxDRKFR1lDdH510OCE1NK9mE8luac5
 9zjXXFBi4EaO0/N3+JfVe7f/gATrmeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-A6bgVmc-MiKBwbKefrrB_Q-1; Fri, 28 Aug 2020 10:04:16 -0400
X-MC-Unique: A6bgVmc-MiKBwbKefrrB_Q-1
Received: by mail-wm1-f69.google.com with SMTP id b73so423466wmb.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gi+o9kVZ3pRl9KJVntsAEDs9X1jzPPrVq1ZT4piLZwc=;
 b=cF6vn9lCzoyyTDXJaaFECvh1IdO1mgOjbBgG+3pj9h/hqJp/eAsfTPy6VD2aO5toAj
 A/OOHwN5xz8lgsnlPSyBCKAcem4lzUUoem+Rvr1DH7C7UzoPcQ5TJPHapXwD+Z/0Hjrq
 sToGYJJs0O9TcY0wAV3Iy4bLj6N+N5oS6Rp2022AXLATaj0w73yj0+t9oRDYTa60aQI3
 Y2pvxBxt8THS5f9NIeZOOQ8+ah2UlQzLKQNfIxicSTljN6FQNldAAS/XNZZ2NOROHd+K
 PsbbabnEcM49ruokJb6D5hEHoFIyOILzdi/BuPqF7oYx4geo1AaLdDMfgU3De2H0LhCN
 QdgQ==
X-Gm-Message-State: AOAM532H2+dDWWdP5xLELevdDkIYxyws+hEQQTmH4x+gaw0aoZ4ddDN5
 90JcM/U6X6nU6vuLug5QM81mPLh6Yo4Z8ZOv2CTcMCP12WsxLZ5yE0gSsz3Dv5SQ3ZdbHadqTUW
 q9WBQVltCd1L+cjM=
X-Received: by 2002:adf:ec08:: with SMTP id x8mr1578092wrn.235.1598623454942; 
 Fri, 28 Aug 2020 07:04:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjcEcmgw98Ndt+QARtzjoATu98n1weTlJlDzx2jKF8LfrQcWGZlMQP/bfAOjJPZD2xR/7NHA==
X-Received: by 2002:adf:ec08:: with SMTP id x8mr1578044wrn.235.1598623454652; 
 Fri, 28 Aug 2020 07:04:14 -0700 (PDT)
Received: from pop-os ([51.37.51.98])
 by smtp.gmail.com with ESMTPSA id m10sm2344213wmi.9.2020.08.28.07.04.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Aug 2020 07:04:13 -0700 (PDT)
Message-ID: <8f5345be73ebf4f8f7f51d6cdc9c2a0d8e0aa45e.camel@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
From: Sean Mooney <smooney@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
Date: Fri, 28 Aug 2020 15:04:12 +0100
In-Reply-To: <20200828154741.30cfc1a3.cohuck@redhat.com>
References: <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
 <20200819212234.223667b3@x1.home>
 <20200820031621.GA24997@joy-OptiPlex-7040>
 <20200825163925.1c19b0f0.cohuck@redhat.com>
 <20200826064117.GA22243@joy-OptiPlex-7040>
 <20200828154741.30cfc1a3.cohuck@redhat.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2
Mime-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=smooney@redhat.com
X-Mimecast-Spam-Score: 0.501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=smooney@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 00:28:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 eskultet@redhat.com, Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com,
 devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-08-28 at 15:47 +0200, Cornelia Huck wrote:
> On Wed, 26 Aug 2020 14:41:17 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > previously, we want to regard the two mdevs created with dsa-1dwq x 30 and
> > dsa-2dwq x 15 as compatible, because the two mdevs consist equal resources.
> > 
> > But, as it's a burden to upper layer, we agree that if this condition
> > happens, we still treat the two as incompatible.
> > 
> > To fix it, either the driver should expose dsa-1dwq only, or the target
> > dsa-2dwq needs to be destroyed and reallocated via dsa-1dwq x 30.
> 
> AFAIU, these are mdev types, aren't they? So, basically, any management
> software needs to take care to use the matching mdev type on the target
> system for device creation?

or just do the simple thing of use the same mdev type on the source and dest.
matching mdevtypes is not nessiarly trivial. we could do that but we woudl have
to do that in python rather then sql so it would be slower to do at least today.

we dont currently have the ablity to say the resouce provider must have 1 of these
set of traits. just that we must have a specific trait. this is a feature we have
disucssed a couple of times and delayed untill we really really need it but its not out
of the question that we could add it for this usecase. i suspect however we would do exact
match first and explore this later after the inital mdev migration works.

by the way i was looking at some vdpa reslated matiail today and noticed vdpa devices are nolonger
usign mdevs and and now use a vhost chardev so i guess we will need a completely seperate mechanioum
for vdpa vs mdev migration as a result. that is rather unfortunet but i guess that is life.
> 


