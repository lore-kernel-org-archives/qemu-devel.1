Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430AE2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOBDaVOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430AE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7xkR-0003Pl-I0
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7xjj-0002kC-Qq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:16:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7xjh-00008c-TH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597742212;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVFj7FoFlCmRwOr98i1isDMUsMu/x19B/RyjX8oAjpw=;
 b=FOBDaVOkaJoVHuBc9FFlVFwWgLFhqCfetCXvPeYtY0tN+hcrXoiy67ol4nKQpHbxS7fgrj
 0WW/3GcJhjQWVaJl7+VBm8sv1SV+U8Ze750L6GuOfijAfoZm/6YzO/JDu0LhamcdkLSx9h
 dvZRY45bsIK97J55l+pqRS2+WBY0sh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-hPDVDA2kNsyMqa_cPBHKPg-1; Tue, 18 Aug 2020 05:16:50 -0400
X-MC-Unique: hPDVDA2kNsyMqa_cPBHKPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48C781006701;
 Tue, 18 Aug 2020 09:16:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F0D5D757;
 Tue, 18 Aug 2020 09:16:31 +0000 (UTC)
Date: Tue, 18 Aug 2020 10:16:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200818091628.GC20215@redhat.com>
References: <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: none client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, eauger@redhat.com, xin-ran.wang@intel.com,
 corbet@lwn.net, openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
 Parav Pandit <parav@mellanox.com>, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, Alex Williamson <alex.williamson@redhat.com>,
 eskultet@redhat.com, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 Cornelia Huck <cohuck@redhat.com>, Jiri Pirko <jiri@mellanox.com>,
 dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Your mail came through as HTML-only so all the quoting and attribution
is mangled / lost now :-(

On Tue, Aug 18, 2020 at 05:01:51PM +0800, Jason Wang wrote:
>    On 2020/8/18 下午4:55, Daniel P. Berrangé wrote:
> 
>  On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote:
> 
>  On 2020/8/14 下午1:16, Yan Zhao wrote:
> 
>  On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> 
>  On 2020/8/10 下午3:46, Yan Zhao wrote:

>  we actually can also retrieve the same information through sysfs, .e.g
> 
>  |- [path to device]
>     |--- migration
>     |     |--- self
>     |     |   |---device_api
>     |    |   |---mdev_type
>     |    |   |---software_version
>     |    |   |---device_id
>     |    |   |---aggregator
>     |     |--- compatible
>     |     |   |---device_api
>     |    |   |---mdev_type
>     |    |   |---software_version
>     |    |   |---device_id
>     |    |   |---aggregator
> 
> 
>  Yes but:
> 
>  - You need one file per attribute (one syscall for one attribute)
>  - Attribute is coupled with kobject
> 
>  All of above seems unnecessary.
> 
>  Another point, as we discussed in another thread, it's really hard to make
>  sure the above API work for all types of devices and frameworks. So having a
>  vendor specific API looks much better.
> 
>  From the POV of userspace mgmt apps doing device compat checking / migration,
>  we certainly do NOT want to use different vendor specific APIs. We want to
>  have an API that can be used / controlled in a standard manner across vendors.
> 
>    Yes, but it could be hard. E.g vDPA will chose to use devlink (there's a
>    long debate on sysfs vs devlink). So if we go with sysfs, at least two
>    APIs needs to be supported ...

NB, I was not questioning devlink vs sysfs directly. If devlink is related
to netlink, I can't say I'm enthusiastic as IMKE sysfs is easier to deal
with. I don't know enough about devlink to have much of an opinion though.
The key point was that I don't want the userspace APIs we need to deal with
to be vendor specific.

What I care about is that we have a *standard* userspace API for performing
device compatibility checking / state migration, for use by QEMU/libvirt/
OpenStack, such that we can write code without countless vendor specific
code paths.

If there is vendor specific stuff on the side, that's fine as we can ignore
that, but the core functionality for device compat / migration needs to be
standardized.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


