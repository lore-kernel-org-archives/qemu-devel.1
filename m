Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2814DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57F320866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cANsGgRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57F320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6YsV-0002ay-00
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 08:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1k6Yqg-0001YS-RC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 08:30:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <smooney@redhat.com>)
 id 1k6Yqa-0002Qt-Br
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 08:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597408210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1es+FhXf2z4s1o6I95UCtDQxtUvu4w172t+j0+i0n8o=;
 b=cANsGgRImAlfXI4T3iieulp+71Li+jbblthuG1s9UQyYhG/HJjo9xu1LVIJRovpqpJuJ3R
 gGsBFEFam7ltoiKrUydie6mOdLnAhwNHQf6Vb91LrV8TGXhtepQh5RHey3iXdbJBmWFw/e
 9APLBFPohyEjvXU+E+WfDhsujaMy8sQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-vVtovyioPhy09FHoxMgAKA-1; Fri, 14 Aug 2020 08:30:05 -0400
X-MC-Unique: vVtovyioPhy09FHoxMgAKA-1
Received: by mail-wm1-f71.google.com with SMTP id s4so3137033wmh.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 05:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1es+FhXf2z4s1o6I95UCtDQxtUvu4w172t+j0+i0n8o=;
 b=NUaVoLVQhOSP7/NLxBf9k++OC8R6Oyf6+HtWEB8zk37hnB223HiDNzyTIAKIdd7o2Q
 jMxwzkUkmicatojyLFgfJYizQf5SlyNq0cs6N210edtBcmWFiJQTWIyxnEusThJN/wtq
 /E4/Q0CN0bpZEuKnhkPO0Zh8pjOAAmn9ht66bbGvdnIV1kU1SoAQW2rZ1pD+6pNoR816
 WQGopWgT4/LL4sMm0E4AJxMuo4HTl84mPuuKO2kZj08WKLAFqPrbdRXrZNy5J5jIAQFw
 D7c7MO1dgXOlwLC//PUqQF0zNSak/DQ/xpLqpQZ+7kuqL4bM/+NQwf1id09DsI03o25N
 YQzg==
X-Gm-Message-State: AOAM532fDi+6jwRQETa8i5XBh85nEeqYPTkjvG3Hi6mxlfQFutrAjzoy
 wYWGjrmff+17GpokVYD6KdMW/wLFAk8XRPvAIM9PoMFmcdSNQ9WrOquWOy6e2IIr1JlkYrgPHCU
 fKt1unBYnD1qQlXs=
X-Received: by 2002:a1c:9909:: with SMTP id b9mr2354757wme.98.1597408204290;
 Fri, 14 Aug 2020 05:30:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgh08eJQ+zuIOVbZA25ftPbBneCLgohlliBAPXoRqIxCkWEgig17fG/vnPhy7CGR0+dWUICw==
X-Received: by 2002:a1c:9909:: with SMTP id b9mr2354734wme.98.1597408203987;
 Fri, 14 Aug 2020 05:30:03 -0700 (PDT)
Received: from pop-os ([2001:470:1f1d:1ea:4fde:6f63:1f5a:12b1])
 by smtp.gmail.com with ESMTPSA id v8sm14694061wmb.24.2020.08.14.05.30.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Aug 2020 05:30:03 -0700 (PDT)
Message-ID: <a4f4a3cf76b87346a4cc4c39c116f575eaab9bac.camel@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
From: Sean Mooney <smooney@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>, Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Aug 2020 13:30:00 +0100
In-Reply-To: <20200814051601.GD15344@joy-OptiPlex-7040>
References: <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
 <20200805021654.GB30485@joy-OptiPlex-7040>
 <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
 <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2
Mime-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=smooney@redhat.com
X-Mimecast-Spam-Score: 0.502
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=smooney@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 08:30:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com, eskultet@redhat.com,
 Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-08-14 at 13:16 +0800, Yan Zhao wrote:
> On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> > 
> > On 2020/8/10 下午3:46, Yan Zhao wrote:
> > > > driver is it handled by?
> > > 
> > > It looks that the devlink is for network device specific, and in
> > > devlink.h, it says
> > > include/uapi/linux/devlink.h - Network physical device Netlink
> > > interface,
> > 
> > 
> > Actually not, I think there used to have some discussion last year and the
> > conclusion is to remove this comment.
> > 
> > It supports IB and probably vDPA in the future.
> > 
> 
> hmm... sorry, I didn't find the referred discussion. only below discussion
> regarding to why to add devlink.
> 
> https://www.mail-archive.com/netdev@vger.kernel.org/msg95801.html
> 	>This doesn't seem to be too much related to networking? Why can't something
> 	>like this be in sysfs?
> 	
> 	It is related to networking quite bit. There has been couple of
> 	iteration of this, including sysfs and configfs implementations. There
> 	has been a consensus reached that this should be done by netlink. I
> 	believe netlink is really the best for this purpose. Sysfs is not a good
> 	idea
> 
> https://www.mail-archive.com/netdev@vger.kernel.org/msg96102.html
> 	>there is already a way to change eth/ib via
> 	>echo 'eth' > /sys/bus/pci/drivers/mlx4_core/0000:02:00.0/mlx4_port1
> 	>
> 	>sounds like this is another way to achieve the same?
> 	
> 	It is. However the current way is driver-specific, not correct.
> 	For mlx5, we need the same, it cannot be done in this way. Do devlink is
> 	the correct way to go.
im not sure i agree with that.
standardising a filesystem based api that is used across all vendors is also a valid
option.  that said if devlink is the right choice form a kerenl perspective by all
means use it but i have not heard a convincing argument for why it actually better.
with tthat said we have been uing tools like ethtool to manage aspect of nics for decades
so its not that strange an idea to use a tool and binary protocoal rather then a text
based interface for this but there are advantages to both approches.
> 
> https://lwn.net/Articles/674867/
> 	There a is need for some userspace API that would allow to expose things
> 	that are not directly related to any device class like net_device of
> 	ib_device, but rather chip-wide/switch-ASIC-wide stuff.
> 
> 	Use cases:
> 	1) get/set of port type (Ethernet/InfiniBand)
> 	2) monitoring of hardware messages to and from chip
> 	3) setting up port splitters - split port into multiple ones and squash again,
> 	   enables usage of splitter cable
> 	4) setting up shared buffers - shared among multiple ports within one chip
> 
> 
> 
> we actually can also retrieve the same information through sysfs, .e.g
> 
> > - [path to device]
> 
>   |--- migration
>   |     |--- self
>   |     |   |---device_api
>   |	|   |---mdev_type
>   |	|   |---software_version
>   |	|   |---device_id
>   |	|   |---aggregator
>   |     |--- compatible
>   |     |   |---device_api
>   |	|   |---mdev_type
>   |	|   |---software_version
>   |	|   |---device_id
>   |	|   |---aggregator
> 
> 
> 
> > 
> > >   I feel like it's not very appropriate for a GPU driver to use
> > > this interface. Is that right?
> > 
> > 
> > I think not though most of the users are switch or ethernet devices. It
> > doesn't prevent you from inventing new abstractions.
> 
> so need to patch devlink core and the userspace devlink tool?
> e.g. devlink migration
and devlink python libs if openstack was to use it directly.
we do have caes where we just frok a process and execaute a comannd in a shell
with or without elevated privladge but we really dont like doing that due to 
the performacne impacat and security implciations so where we can use python bindign
over c apis we do. pyroute2 is the only python lib i know off of the top of my head
that support devlink so we would need to enhacne it to support this new devlink api.
there may be otherss i have not really looked in the past since we dont need to use
devlink at all today.
> 
> > Note that devlink is based on netlink, netlink has been widely used by
> > various subsystems other than networking.
> 
> the advantage of netlink I see is that it can monitor device status and
> notify upper layer that migration database needs to get updated.
> But not sure whether openstack would like to use this capability.
> As Sean said, it's heavy for openstack. it's heavy for vendor driver
> as well :)
> 
> And devlink monitor now listens the notification and dumps the state
> changes. If we want to use it, need to let it forward the notification
> and dumped info to openstack, right?
i dont think we would use direct devlink monitoring in nova even if it was avaiable.
we could but we already poll libvirt and the system for other resouce periodicly.
we likely wouldl just add monitoriv via devlink to that periodic task.
we certenly would not use it to detect a migration or a need to update a migration database(not sure what that is)

in reality if we can consume this info indirectly via a libvirt api that will
be the appcoh we will take at least for the libvirt driver in nova. for cyborg
they may take a different appoch. we already use pyroute2 in 2 projects, os-vif and
neutron and it does have devlink support so the burden of using devlink is not that
high for openstack but its a less frineadly interface for configuration tools like
ansiable vs a filesystem based approch.
> 
> Thanks
> Yan
> 


