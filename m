Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101D82078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkGib0eY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101D82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ZP8-00033O-8i
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1k8ZOF-0002dR-5t
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:29:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1k8ZOD-000299-9g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597886952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mv65M1+t+HPSl/WRfYZMesR9s3J7YwA43eBtlMjfynM=;
 b=dkGib0eY81Kw0+YUS4GeTHdbIwRg4eo9DNtv9g48yRXq9NPnfxTYe333BaXIVPvaHgiA6Z
 GL9p41+xkHne256gk5UGHFnFcSJ+UkMu2aoLcmyySPCZaPy+3YqCC1um2VcXE51fHc0plT
 YnJLuVpKqHccF6V9t6owaba5btFp59A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-vccxfbDZPtuEvnqRbbYcwg-1; Wed, 19 Aug 2020 21:29:10 -0400
X-MC-Unique: vccxfbDZPtuEvnqRbbYcwg-1
Received: by mail-ed1-f70.google.com with SMTP id v13so263357edx.9
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 18:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mv65M1+t+HPSl/WRfYZMesR9s3J7YwA43eBtlMjfynM=;
 b=sZ2g1Pbujb6UURCmQp/Js3N68z4kMolS1H5QFdaWQZJ+OQyRfhEpmVKeJHzhvTOGbY
 P4ZpgUhD7ANnOtn+WZOwlvGIhsDjPGdBVJ5aCtWgDwHZeSxVyapJjjhVjo6EUJ9mfb7R
 W4Wcfaqc+l1j789yBky4je/TiZ+ZXsWxz1vy/MGrgLRvoGVZvsOi70LlS8U0EA3MMUMh
 jJ5gRvee+oPg/rqYabfL6f95LA9Z3cTeWmOi+G11BKggCWJVdueiSeV5LU0y+GkeBLpp
 WmItEVLNHDpjaAnfCBYqqI3CwOHQXVR0Aa31uUSo0JzuVxo1H4iHTBWeTr7e55TKIXBM
 ZWYA==
X-Gm-Message-State: AOAM533m4mZ9A83tKCEmbhkwCK9QbHNYKOcU7Ch1gEA2SiqL1ERPxWyL
 yFwUhqWt/BRVnbEseXppwI7oP51xnYpu54x8uZobdNrd/WgG2pv5kQvZLZ0CkLPpLighPv3wkm8
 yViG37AfMC6Vh/Wo=
X-Received: by 2002:a17:906:4356:: with SMTP id
 z22mr1078940ejm.414.1597886949049; 
 Wed, 19 Aug 2020 18:29:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoyKfjf0D7MrJMX9479zeQtARXzClfhI3mERBVAU5/JYOmhYh4Jk1gt0aNrlay6m1myoOVsg==
X-Received: by 2002:a17:906:4356:: with SMTP id
 z22mr1078909ejm.414.1597886948787; 
 Wed, 19 Aug 2020 18:29:08 -0700 (PDT)
Received: from pop-os ([51.37.51.98])
 by smtp.gmail.com with ESMTPSA id m12sm287263edv.94.2020.08.19.18.29.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Aug 2020 18:29:08 -0700 (PDT)
Message-ID: <242591bb809b68c618f62fdc93d4f8ae7b146b6d.camel@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
From: Sean Mooney <smooney@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>, Cornelia Huck <cohuck@redhat.com>
Date: Thu, 20 Aug 2020 02:29:07 +0100
In-Reply-To: <20200820003922.GE21172@joy-OptiPlex-7040>
References: <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2
Mime-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=smooney@redhat.com
X-Mimecast-Spam-Score: 0.501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=smooney@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 eskultet@redhat.com, Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com,
 devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-08-20 at 08:39 +0800, Yan Zhao wrote:
> On Tue, Aug 18, 2020 at 11:36:52AM +0200, Cornelia Huck wrote:
> > On Tue, 18 Aug 2020 10:16:28 +0100
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > > On Tue, Aug 18, 2020 at 05:01:51PM +0800, Jason Wang wrote:
> > > >    On 2020/8/18 下午4:55, Daniel P. Berrangé wrote:
> > > > 
> > > >  On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote:
> > > > 
> > > >  On 2020/8/14 下午1:16, Yan Zhao wrote:
> > > > 
> > > >  On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> > > > 
> > > >  On 2020/8/10 下午3:46, Yan Zhao wrote:  
> > > >  we actually can also retrieve the same information through sysfs, .e.g
> > > > 
> > > >  |- [path to device]
> > > >     |--- migration
> > > >     |     |--- self
> > > >     |     |   |---device_api
> > > >     |    |   |---mdev_type
> > > >     |    |   |---software_version
> > > >     |    |   |---device_id
> > > >     |    |   |---aggregator
> > > >     |     |--- compatible
> > > >     |     |   |---device_api
> > > >     |    |   |---mdev_type
> > > >     |    |   |---software_version
> > > >     |    |   |---device_id
> > > >     |    |   |---aggregator
> > > > 
> > > > 
> > > >  Yes but:
> > > > 
> > > >  - You need one file per attribute (one syscall for one attribute)
> > > >  - Attribute is coupled with kobject
> > 
> > Is that really that bad? You have the device with an embedded kobject
> > anyway, and you can just put things into an attribute group?
> > 
> > [Also, I think that self/compatible split in the example makes things
> > needlessly complex. Shouldn't semantic versioning and matching already
> > cover nearly everything? I would expect very few cases that are more
> > complex than that. Maybe the aggregation stuff, but I don't think we
> > need that self/compatible split for that, either.]
> 
> Hi Cornelia,
> 
> The reason I want to declare compatible list of attributes is that
> sometimes it's not a simple 1:1 matching of source attributes and target attributes
> as I demonstrated below,
> source mdev of (mdev_type i915-GVTg_V5_2 + aggregator 1) is compatible to
> target mdev of (mdev_type i915-GVTg_V5_4 + aggregator 2),
>                (mdev_type i915-GVTg_V5_8 + aggregator 4)
the way you are doing the nameing is till really confusing by the way
if this has not already been merged in the kernel can you chagne the mdev
so that mdev_type i915-GVTg_V5_2 is 2 of mdev_type i915-GVTg_V5_1 instead of half the device

currently you need to deived the aggratod by the number at the end of the mdev type to figure out
how much of the phsicial device is being used with is a very unfridly api convention

the way aggrator are being proposed in general is not really someting i like but i thin this at least
is something that should be able to correct.

with the complexity in the mdev type name + aggrator i suspect that this will never be support
in openstack nova directly requireing integration via cyborg unless we can pre partion the
device in to mdevs staicaly and just ignore this.

this is way to vendor sepecif to integrate into something like openstack in nova unless we can guarentee
taht how aggreator work will be portable across vendors genericly.

> 
> and aggragator may be just one of such examples that 1:1 matching does not
> fit.
for openstack nova i dont see us support anything beyond the 1:1 case where the mdev type does not change.

i woudl really prefer if there was just one mdev type that repsented the minimal allcatable unit and the
aggragaotr where used to create compostions of that. i.e instad of i915-GVTg_V5_2 beign half the device,
have 1 mdev type i915-GVTg and if the device support 8 of them then we can aggrate 4 of i915-GVTg

if you want to have muplie mdev type to model the different amoutn of the resouce e.g. i915-GVTg_small i915-GVTg_large
that is totlaly fine too or even i915-GVTg_4 indcating it sis 4 of i915-GVTg

failing that i would just expose an mdev type per composable resouce and allow us to compose them a the user level with
some other construct mudeling a attament to the device. e.g. create composed mdev or somethig that is an aggreateion of
multiple sub resouces each of which is an mdev. so kind of like how bond port work. we would create an mdev for each of
the sub resouces and then create a bond or aggrated mdev by reference the other mdevs by uuid then attach only the
aggreated mdev to the instance.

the current aggrator syntax and sematic however make me rather uncofrotable when i think about orchestating vms on top
of it even to boot them let alone migrate them.
> 
> So, we explicitly list out self/compatible attributes, and management
> tools only need to check if self attributes is contained compatible
> attributes.
> 
> or do you mean only compatible list is enough, and the management tools
> need to find out self list by themselves?
> But I think provide a self list is easier for management tools.
> 
> Thanks
> Yan
> 


