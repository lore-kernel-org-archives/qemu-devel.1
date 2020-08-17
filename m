Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293EDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B3020716
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp86t1G+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B3020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Ynv-0006V9-5r
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 02:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7YnK-00064W-9j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 02:38:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7YnF-0006is-G8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 02:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597646330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p27bQOF4p6q5oYpRrHd1HKqo5O+sKCNmptEH4q2zCDY=;
 b=Zp86t1G+zPTmpEmcbhg5WMeLjaFqh0+GQ6BOI1A/cPUVHK0sL0j+rLFeKiBurukm6JfPqU
 xrcBGaOHNO+PXJ3nuHF+aP3tyJVvEeZ9nRLLuXhrUMKbb/aeNcIQrXbZbsKSsXwT48NTyV
 sNHsEZa/cizjs/DBRqVfJWZQ5tacOH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-LJkz_mXvMI2EhpfIOLxf7g-1; Mon, 17 Aug 2020 02:38:48 -0400
X-MC-Unique: LJkz_mXvMI2EhpfIOLxf7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E053D801AAC;
 Mon, 17 Aug 2020 06:38:45 +0000 (UTC)
Received: from gondolin (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 896B65C1DC;
 Mon, 17 Aug 2020 06:38:30 +0000 (UTC)
Date: Mon, 17 Aug 2020 08:38:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200817083828.187315ef.cohuck@redhat.com>
In-Reply-To: <315669b0-5c75-d359-a912-62ebab496abf@linux.ibm.com>
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
 <20200807135942.5d56a202.cohuck@redhat.com>
 <20200813173347.239801fa.cohuck@redhat.com>
 <315669b0-5c75-d359-a912-62ebab496abf@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:54:24
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
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
 Parav Pandit <parav@mellanox.com>, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, Jiri Pirko <jiri@mellanox.com>,
 Sean Mooney <smooney@redhat.com>, intel-gvt-dev@lists.freedesktop.org,
 berrange@redhat.com, eskultet@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>, dinechin@redhat.com,
 devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 15:02:53 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 8/13/20 11:33 AM, Cornelia Huck wrote:
> > On Fri, 7 Aug 2020 13:59:42 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Wed, 05 Aug 2020 12:35:01 +0100
> >> Sean Mooney <smooney@redhat.com> wrote:
> >>  
> >>> On Wed, 2020-08-05 at 12:53 +0200, Jiri Pirko wrote:    
> >>>> Wed, Aug 05, 2020 at 11:33:38AM CEST, yan.y.zhao@intel.com wrote:      
> >>
> >> (...)
> >>  
> >>>>>    software_version: device driver's version.
> >>>>>               in <major>.<minor>[.bugfix] scheme, where there is no
> >>>>> 	       compatibility across major versions, minor versions have
> >>>>> 	       forward compatibility (ex. 1-> 2 is ok, 2 -> 1 is not) and
> >>>>> 	       bugfix version number indicates some degree of internal
> >>>>> 	       improvement that is not visible to the user in terms of
> >>>>> 	       features or compatibility,
> >>>>>
> >>>>> vendor specific attributes: each vendor may define different attributes
> >>>>>   device id : device id of a physical devices or mdev's parent pci device.
> >>>>>               it could be equal to pci id for pci devices
> >>>>>   aggregator: used together with mdev_type. e.g. aggregator=2 together
> >>>>>               with i915-GVTg_V5_4 means 2*1/4=1/2 of a gen9 Intel
> >>>>> 	       graphics device.
> >>>>>   remote_url: for a local NVMe VF, it may be configured with a remote
> >>>>>               url of a remote storage and all data is stored in the
> >>>>> 	       remote side specified by the remote url.
> >>>>>   ...      
> >>> just a minor not that i find ^ much more simmple to understand then
> >>> the current proposal with self and compatiable.
> >>> if i have well defiend attibute that i can parse and understand that allow
> >>> me to calulate the what is and is not compatible that is likely going to
> >>> more useful as you wont have to keep maintianing a list of other compatible
> >>> devices every time a new sku is released.
> >>>
> >>> in anycase thank for actully shareing ^ as it make it simpler to reson about what
> >>> you have previously proposed.    
> >>
> >> So, what would be the most helpful format? A 'software_version' field
> >> that follows the conventions outlined above, and other (possibly
> >> optional) fields that have to match?  
> > 
> > Just to get a different perspective, I've been trying to come up with
> > what would be useful for a very different kind of device, namely
> > vfio-ccw. (Adding Eric to cc: for that.)
> > 
> > software_version makes sense for everybody, so it should be a standard
> > attribute.
> > 
> > For the vfio-ccw type, we have only one vendor driver (vfio-ccw_IO).
> > 
> > Given a subchannel A, we want to make sure that subchannel B has a
> > reasonable chance of being compatible. I guess that means:
> > 
> > - same subchannel type (I/O)
> > - same chpid type (e.g. all FICON; I assume there are no 'mixed' setups
> >   -- Eric?)  
> 
> Correct.
> 
> > - same number of chpids? Maybe we can live without that and just inject
> >   some machine checks, I don't know. Same chpid numbers is something we
> >   cannot guarantee, especially if we want to migrate cross-CEC (to
> >   another machine.)  
> 
> I think we'd live without it, because I wouldn't expect it to be
> consistent between systems.

Yes, and the guest needs to be able to deal with changing path
configurations anyway.

> 
> > 
> > Other possibly interesting information is not available at the
> > subchannel level (vfio-ccw is a subchannel driver.)  
> 
> I presume you're alluding to the DASD uid (dasdinfo -x) here?

Yes, or the even more basic Sense ID information.

> 
> > 
> > So, looking at a concrete subchannel on one of my machines, it would
> > look something like the following:
> > 
> > <common>
> > software_version=1.0.0
> > type=vfio-ccw          <-- would be vfio-pci on the example above
> > <vfio-ccw specific>
> > subchannel_type=0
> > <vfio-ccw_IO specific>
> > chpid_type=0x1a
> > chpid_mask=0xf0        <-- not sure if needed/wanted

Let's just drop the chpid_mask here.

> > 
> > Does that make sense?

Would be interesting if someone could come up with some possible
information for a third type of device.


