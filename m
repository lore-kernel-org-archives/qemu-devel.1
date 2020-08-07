Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AFAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF582075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJe7+cUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF582075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k413q-0000b3-Ay
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 08:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k412e-0008Hc-LS
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:00:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k412b-0004OO-L9
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596801603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVwqKyqW50wYrrH5JlBPTOAfT6+kzPwRmFuVW8KPOc8=;
 b=ZJe7+cUr2hHbv116RmvWIS2dQtyLoNjHfmbvEEQ3cCX52i1N6CvNHs5aE13ez3QBT7bUgR
 8Z9k4NUnZHHewGo2yOzGksdysAXTwEOqP8SHHO0fprnWNRsKwZwzu9SP9myZmaRdLcMR/C
 IAA0QTKfwRcDLqNZjgs9Fc5427IBt/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-KrXRZ7ZLMsSPqWzO7L0ebg-1; Fri, 07 Aug 2020 08:00:01 -0400
X-MC-Unique: KrXRZ7ZLMsSPqWzO7L0ebg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92E8F100960F;
 Fri,  7 Aug 2020 11:59:59 +0000 (UTC)
Received: from gondolin (ovpn-112-214.ams2.redhat.com [10.36.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E0A865C94;
 Fri,  7 Aug 2020 11:59:45 +0000 (UTC)
Date: Fri, 7 Aug 2020 13:59:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Sean Mooney <smooney@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200807135942.5d56a202.cohuck@redhat.com>
In-Reply-To: <4cf2824c803c96496e846c5b06767db305e9fb5a.camel@redhat.com>
References: <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
 <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
 <20200805021654.GB30485@joy-OptiPlex-7040>
 <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
 <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <4cf2824c803c96496e846c5b06767db305e9fb5a.camel@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
 Parav Pandit <parav@mellanox.com>, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, Jiri Pirko <jiri@mellanox.com>,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com, eskultet@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>, dinechin@redhat.com,
 devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 05 Aug 2020 12:35:01 +0100
Sean Mooney <smooney@redhat.com> wrote:

> On Wed, 2020-08-05 at 12:53 +0200, Jiri Pirko wrote:
> > Wed, Aug 05, 2020 at 11:33:38AM CEST, yan.y.zhao@intel.com wrote:  

(...)

> > >    software_version: device driver's version.
> > >               in <major>.<minor>[.bugfix] scheme, where there is no
> > > 	       compatibility across major versions, minor versions have
> > > 	       forward compatibility (ex. 1-> 2 is ok, 2 -> 1 is not) and
> > > 	       bugfix version number indicates some degree of internal
> > > 	       improvement that is not visible to the user in terms of
> > > 	       features or compatibility,
> > > 
> > > vendor specific attributes: each vendor may define different attributes
> > >   device id : device id of a physical devices or mdev's parent pci device.
> > >               it could be equal to pci id for pci devices
> > >   aggregator: used together with mdev_type. e.g. aggregator=2 together
> > >               with i915-GVTg_V5_4 means 2*1/4=1/2 of a gen9 Intel
> > > 	       graphics device.
> > >   remote_url: for a local NVMe VF, it may be configured with a remote
> > >               url of a remote storage and all data is stored in the
> > > 	       remote side specified by the remote url.
> > >   ...  
> just a minor not that i find ^ much more simmple to understand then
> the current proposal with self and compatiable.
> if i have well defiend attibute that i can parse and understand that allow
> me to calulate the what is and is not compatible that is likely going to
> more useful as you wont have to keep maintianing a list of other compatible
> devices every time a new sku is released.
> 
> in anycase thank for actully shareing ^ as it make it simpler to reson about what
> you have previously proposed.

So, what would be the most helpful format? A 'software_version' field
that follows the conventions outlined above, and other (possibly
optional) fields that have to match?

(...)

> > Thanks for the explanation, I'm still fuzzy about the details.
> > Anyway, I suggest you to check "devlink dev info" command we have
> > implemented for multiple drivers.  
> 
> is devlink exposed as a filesytem we can read with just open?
> openstack will likely try to leverage libvirt to get this info but when we
> cant its much simpler to read sysfs then it is to take a a depenency on a commandline
> too and have to fork shell to execute it and parse the cli output.
> pyroute2 which we use in some openstack poject has basic python binding for devlink but im not
> sure how complete it is as i think its relitivly new addtion. if we need to take a dependcy
> we will but that would be a drawback fo devlink not that that is a large one just something
> to keep in mind.

A devlinkfs, maybe? At least for reading information (IIUC, "devlink
dev info" is only about information retrieval, right?)


