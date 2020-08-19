Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EA2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46DA20639
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTK7VuCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46DA20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8E0T-0000bT-3C
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 22:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8Dzv-00009M-D9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 22:38:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8Dzs-0002fd-Gz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 22:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597804718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ahF9kHkk+KzE1v5hPws7TWhx97Oq/uytmMOo+VABGc=;
 b=WTK7VuCkQxOZCOiwhioTQvhRJSYuLLCOxCsaJRwibqSW7nnih1HOWmGpaLbZUpVTX0waU/
 CWzdFtOu4HjIGPgJ+SXsmOCHK+RTTdukc9hGr/O1kNJODnIkcX7Rt3ViPBLyP8OZ48nN4j
 oNwEuVMVCQfL38VDGtlC8ejrl3zBveE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-tVAsAyPbNA6-594zY0pgiQ-1; Tue, 18 Aug 2020 22:38:36 -0400
X-MC-Unique: tVAsAyPbNA6-594zY0pgiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC671DDF4;
 Wed, 19 Aug 2020 02:38:34 +0000 (UTC)
Received: from [10.72.13.88] (ovpn-13-88.pek2.redhat.com [10.72.13.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36A017DFDD;
 Wed, 19 Aug 2020 02:38:14 +0000 (UTC)
Subject: Re: device compatibility interface for live migration with assigned
 devices
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040> <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5aea4ae6-e8c8-1120-453d-20a78cee6b20@redhat.com>
Date: Wed, 19 Aug 2020 10:38:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818091628.GC20215@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:38:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


On 2020/8/18 下午5:16, Daniel P. Berrangé wrote:
> Your mail came through as HTML-only so all the quoting and attribution
> is mangled / lost now :-(


My bad, sorry.


>
> On Tue, Aug 18, 2020 at 05:01:51PM +0800, Jason Wang wrote:
>>     On 2020/8/18 下午4:55, Daniel P. Berrangé wrote:
>>
>>   On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote:
>>
>>   On 2020/8/14 下午1:16, Yan Zhao wrote:
>>
>>   On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
>>
>>   On 2020/8/10 下午3:46, Yan Zhao wrote:
>>   we actually can also retrieve the same information through sysfs, .e.g
>>
>>   |- [path to device]
>>      |--- migration
>>      |     |--- self
>>      |     |   |---device_api
>>      |    |   |---mdev_type
>>      |    |   |---software_version
>>      |    |   |---device_id
>>      |    |   |---aggregator
>>      |     |--- compatible
>>      |     |   |---device_api
>>      |    |   |---mdev_type
>>      |    |   |---software_version
>>      |    |   |---device_id
>>      |    |   |---aggregator
>>
>>
>>   Yes but:
>>
>>   - You need one file per attribute (one syscall for one attribute)
>>   - Attribute is coupled with kobject
>>
>>   All of above seems unnecessary.
>>
>>   Another point, as we discussed in another thread, it's really hard to make
>>   sure the above API work for all types of devices and frameworks. So having a
>>   vendor specific API looks much better.
>>
>>   From the POV of userspace mgmt apps doing device compat checking / migration,
>>   we certainly do NOT want to use different vendor specific APIs. We want to
>>   have an API that can be used / controlled in a standard manner across vendors.
>>
>>     Yes, but it could be hard. E.g vDPA will chose to use devlink (there's a
>>     long debate on sysfs vs devlink). So if we go with sysfs, at least two
>>     APIs needs to be supported ...
> NB, I was not questioning devlink vs sysfs directly. If devlink is related
> to netlink, I can't say I'm enthusiastic as IMKE sysfs is easier to deal
> with. I don't know enough about devlink to have much of an opinion though.
> The key point was that I don't want the userspace APIs we need to deal with
> to be vendor specific.
>
> What I care about is that we have a *standard* userspace API for performing
> device compatibility checking / state migration, for use by QEMU/libvirt/
> OpenStack, such that we can write code without countless vendor specific
> code paths.
>
> If there is vendor specific stuff on the side, that's fine as we can ignore
> that, but the core functionality for device compat / migration needs to be
> standardized.


Ok, I agree with you.

Thanks


>
> Regards,
> Daniel


