Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC394C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67342072E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOXcB3/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67342072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxhlb-0004d9-0g
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 22:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxhl3-0004Cm-N8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 22:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxhl1-0002EV-N8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 22:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595297510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MGkYyLolwmpjGs18XHJUdlW5jQj9rWopB2tBLoYWfM=;
 b=HOXcB3/rhxynFeQMPGVNC3y8UT6L5HXMGrhWUMy9BGkrt5wl4H6QmuY50M5yWNRSAPCVK2
 9tSXdSUtjnlmkoQL/LORX12L0AdeTNIEGZ943io3WArNunajjvxghnXDWGDAQsHotArVGE
 AYOPOUk8OTTeCIDtJLtX1hmDm0TYdLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-LsNWMkKxO_auNxJgu-F5Ig-1; Mon, 20 Jul 2020 22:11:47 -0400
X-MC-Unique: LsNWMkKxO_auNxJgu-F5Ig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E46D580046C;
 Tue, 21 Jul 2020 02:11:44 +0000 (UTC)
Received: from [10.72.13.146] (ovpn-13-146.pek2.redhat.com [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41A436FEE9;
 Tue, 21 Jul 2020 02:11:25 +0000 (UTC)
Subject: Re: device compatibility interface for live migration with assigned
 devices
To: Sean Mooney <smooney@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040> <20200717101258.65555978@x1.home>
 <95c13c9b-daab-469b-f244-a0f741f1b41d@redhat.com>
 <60d5c1609aaef72f2877aaacff04dc7187e4b3a5.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <22599bc3-cb22-7a62-d463-9a53714def57@redhat.com>
Date: Tue, 21 Jul 2020 10:11:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <60d5c1609aaef72f2877aaacff04dc7187e4b3a5.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 22:11:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


On 2020/7/20 下午6:39, Sean Mooney wrote:
> On Mon, 2020-07-20 at 11:41 +0800, Jason Wang wrote:
>> On 2020/7/18 上午12:12, Alex Williamson wrote:
>>> On Thu, 16 Jul 2020 16:32:30 +0800
>>> Yan Zhao <yan.y.zhao@intel.com> wrote:
>>>
>>>> On Thu, Jul 16, 2020 at 12:16:26PM +0800, Jason Wang wrote:
>>>>> On 2020/7/14 上午7:29, Yan Zhao wrote:
>>>>>> hi folks,
>>>>>> we are defining a device migration compatibility interface that helps upper
>>>>>> layer stack like openstack/ovirt/libvirt to check if two devices are
>>>>>> live migration compatible.
>>>>>> The "devices" here could be MDEVs, physical devices, or hybrid of the two.
>>>>>> e.g. we could use it to check whether
>>>>>> - a src MDEV can migrate to a target MDEV,
>>>>>> - a src VF in SRIOV can migrate to a target VF in SRIOV,
>>>>>> - a src MDEV can migration to a target VF in SRIOV.
>>>>>>      (e.g. SIOV/SRIOV backward compatibility case)
>>>>>>
>>>>>> The upper layer stack could use this interface as the last step to check
>>>>>> if one device is able to migrate to another device before triggering a real
>>>>>> live migration procedure.
>>>>>> we are not sure if this interface is of value or help to you. please don't
>>>>>> hesitate to drop your valuable comments.
>>>>>>
>>>>>>
>>>>>> (1) interface definition
>>>>>> The interface is defined in below way:
>>>>>>
>>>>>>                 __    userspace
>>>>>>                  /\              \
>>>>>>                 /                 \write
>>>>>>                / read              \
>>>>>>       ________/__________       ___\|/_____________
>>>>>>      | migration_version |     | migration_version |-->check migration
>>>>>>      ---------------------     ---------------------   compatibility
>>>>>>         device A                    device B
>>>>>>
>>>>>>
>>>>>> a device attribute named migration_version is defined under each device's
>>>>>> sysfs node. e.g. (/sys/bus/pci/devices/0000\:00\:02.0/$mdev_UUID/migration_version).
>>>>> Are you aware of the devlink based device management interface that is
>>>>> proposed upstream? I think it has many advantages over sysfs, do you
>>>>> consider to switch to that?
>>> Advantages, such as?
>>
>> My understanding for devlink(netlink) over sysfs (some are mentioned at
>> the time of vDPA sysfs mgmt API discussion) are:
> i tought netlink was used more a as a configuration protocoal to qurry and confire nic and i guess
> other devices in its devlink form requireint a tool to be witten that can speak the protocal to interact with.
> the primary advantate of sysfs is that everything is just a file. there are no addtional depleenceis
> needed


Well, if you try to build logic like introspection on top for a 
sophisticated hardware, you probably need to have library on top. And 
it's attribute per file is pretty inefficient.


>   and unlike netlink there are not interoperatblity issues in a coanitnerised env. if you are using diffrenet
> version of libc and gcc in the contaienr vs the host my understanding is tools like ethtool from ubuntu deployed
> in a container on a centos host can have issue communicating with the host kernel.


Kernel provides stable ABI for userspace, so it's not something that we 
can't fix.


> if its jsut a file unless
> the format the data is returnin in chagnes or the layout of sysfs changes its compatiable regardless of what you
> use to read it.


I believe you can't change sysfs layout which is part of uABI. But as I 
mentioned below, sysfs has several drawbacks. It's not harm to compare 
between different approach when you start a new device management API.

Thanks


>> - existing users (NIC, crypto, SCSI, ib), mature and stable
>> - much better error reporting (ext_ack other than string or errno)
>> - namespace aware
>> - do not couple with kobject
>>
>> Thanks
>>


