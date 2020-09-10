Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F284C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FE1208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6CqEWOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FE1208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGM2V-0002x5-Hk
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 08:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1kGM1x-0002Ya-6p
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 08:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1kGM1u-0002q7-NR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 08:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599742217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXGj6k8riNs9Vj4UP7tEqOTrYQ5CAKfprkP6QZPSeR4=;
 b=L6CqEWOYW0seqkrxA66JKNrnCgDnLf9ZRVcgBopJf/niYwyLd9FGHLwkW2pqGNJJN+COt7
 SfV8jAwX0iBdYaL7w/OoHzMwI93dnrBuHW/qWUSBJbK018wU+tPeuldlR+EfHnV2ASgBQR
 kzyegWEnBivvq034tcmSR5zsHYx0xtE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-LuWernbIMPiEk9y9Rh1a1A-1; Thu, 10 Sep 2020 08:50:14 -0400
X-MC-Unique: LuWernbIMPiEk9y9Rh1a1A-1
Received: by mail-wr1-f71.google.com with SMTP id r15so2208292wrt.8
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 05:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZXGj6k8riNs9Vj4UP7tEqOTrYQ5CAKfprkP6QZPSeR4=;
 b=h582HJXl2rlOkqtZyZXHzsGALJ6n6emuYzB3DL30/+L7SpsRoSVkXx9obTHqEtiAI2
 BCuG9zWKgVnEAxj6+EiYeH0k1/lsnP+S96DsB9UzU0vojpB4dgbY2FQwpQs/UUA+hHz1
 D8HuoAblc0tXXA00i/GIZkpn+eOGn95Ey8uy4GKKUUqyV07/V/K6re2QU5eppM9v7WnM
 rL92klSmuGjM4qNAqPVb5atSFdjjOYWkUx78YTaWn1/8swymmu+LwJcGzhJmN9vT9JT7
 uG57cRH69d1nVvbjtMiHpy4oFiH5vUHPI7u8+1Mfc+6yoOFhvBOlnawwD09DOP8u+hR4
 +Omw==
X-Gm-Message-State: AOAM533H378uF5rhjbJEQgWoA9FuWk0ZMQgh0BGTYHj5X/qnxcI1jbPm
 xkKDtMHrIRg5Irp++fGgvKwgyrKCmzjKdBxMfMJuY+vteLmoFx3f6e5XDI78Vstti3A2pi2hyM9
 Yb2vjUMaZaIZv/us=
X-Received: by 2002:a1c:c910:: with SMTP id f16mr8297057wmb.82.1599742213096; 
 Thu, 10 Sep 2020 05:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyXdpf4+Lc20wLIFYpjKwJB8sAx70dr7armMg6ykw8vcU9X+1byflhkDA11+n1XlghezjXOQ==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr8297020wmb.82.1599742212834; 
 Thu, 10 Sep 2020 05:50:12 -0700 (PDT)
Received: from pop-os ([109.79.57.111])
 by smtp.gmail.com with ESMTPSA id v7sm3484718wmj.28.2020.09.10.05.50.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Sep 2020 05:50:12 -0700 (PDT)
Message-ID: <7cebcb6c8d1a1452b43e8358ee6ee18a150a0238.camel@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
From: Sean Mooney <smooney@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
Date: Thu, 10 Sep 2020 13:50:11 +0100
In-Reply-To: <20200910143822.2071eca4.cohuck@redhat.com>
References: <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
 <20200819212234.223667b3@x1.home>
 <20200820031621.GA24997@joy-OptiPlex-7040>
 <20200825163925.1c19b0f0.cohuck@redhat.com>
 <20200826064117.GA22243@joy-OptiPlex-7040>
 <20200828154741.30cfc1a3.cohuck@redhat.com>
 <8f5345be73ebf4f8f7f51d6cdc9c2a0d8e0aa45e.camel@redhat.com>
 <20200831044344.GB13784@joy-OptiPlex-7040>
 <20200908164130.2fe0d106.cohuck@redhat.com>
 <20200909021308.GA1277@joy-OptiPlex-7040>
 <20200910143822.2071eca4.cohuck@redhat.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2
Mime-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=smooney@redhat.com
X-Mimecast-Spam-Score: 0.501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=smooney@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, 2020-09-10 at 14:38 +0200, Cornelia Huck wrote:
> On Wed, 9 Sep 2020 10:13:09 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > > > still, I'd like to put it more explicitly to make ensure it's not missed:
> > > > the reason we want to specify compatible_type as a trait and check
> > > > whether target compatible_type is the superset of source
> > > > compatible_type is for the consideration of backward compatibility.
> > > > e.g.
> > > > an old generation device may have a mdev type xxx-v4-yyy, while a newer
> > > > generation  device may be of mdev type xxx-v5-yyy.
> > > > with the compatible_type traits, the old generation device is still
> > > > able to be regarded as compatible to newer generation device even their
> > > > mdev types are not equal.  
> > > 
> > > If you want to support migration from v4 to v5, can't the (presumably
> > > newer) driver that supports v5 simply register the v4 type as well, so
> > > that the mdev can be created as v4? (Just like QEMU versioned machine
> > > types work.)  
> > 
> > yes, it should work in some conditions.
> > but it may not be that good in some cases when v5 and v4 in the name string
> > of mdev type identify hardware generation (e.g. v4 for gen8, and v5 for
> > gen9)
> > 
> > e.g.
> > (1). when src mdev type is v4 and target mdev type is v5 as
> > software does not support it initially, and v4 and v5 identify hardware
> > differences.
> 
> My first hunch here is: Don't introduce types that may be compatible
> later. Either make them compatible, or make them distinct by design,
> and possibly add a different, compatible type later.
> 
> > then after software upgrade, v5 is now compatible to v4, should the
> > software now downgrade mdev type from v5 to v4?
> > not sure if moving hardware generation info into a separate attribute
> > from mdev type name is better. e.g. remove v4, v5 in mdev type, while use
> > compatible_pci_ids to identify compatibility.
> 
> If the generations are compatible, don't mention it in the mdev type.
> If they aren't, use distinct types, so that management software doesn't
> have to guess. At least that would be my naive approach here.
yep that is what i would prefer to see too.
> 
> > 
> > (2) name string of mdev type is composed by "driver_name + type_name".
> > in some devices, e.g. qat, different generations of devices are binding to
> > drivers of different names, e.g. "qat-v4", "qat-v5".
> > then though type_name is equal, mdev type is not equal. e.g.
> > "qat-v4-type1", "qat-v5-type1".
> 
> I guess that shows a shortcoming of that "driver_name + type_name"
> approach? Or maybe I'm just confused.
yes i really dont like haveing the version in the mdev-type name 
i would stongly perfger just qat-type-1 wehere qat is just there as a way of namespacing.
although symmetric-cryto, asymmetric-cryto and compression woudl be a better name then type-1, type-2, type-3 if
that is what they would end up mapping too. e.g. qat-compression or qat-aes is a much better name then type-1
higher layers of software are unlikely to parse the mdev names but as a human looking at them its much eaiser to
understand if the names are meaningful. the qat prefix i think is important however to make sure that your mdev-types
dont colide with other vendeors mdev types. so i woudl encurage all vendors to prefix there mdev types with etiher the
device name or the vendor.
> 


