Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DABC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A8B216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foz8vUc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A8B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzsy-0001Is-78
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZzs3-0000lk-C3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZzrz-000443-51
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604423595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsEBzccuLn1sdhET20YiafAIlAjcV3eNG0qU4QbRHQA=;
 b=foz8vUc10vgRsF6a+CB70lKxd2OCaq4+DVqR4Dzj/kUEEZl2i4csIKmRfiE7mq/A85WMYk
 TDjUVUa2fiwwOebLVF9dVb1SSuLVlkHRpPHZaq6yy+Jrc6Jh7gfHPBbRpEK6w+o2/Su3XC
 LqPDSAwzcopENEYJ5SmSktvTIiFVvsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-YWM2uP9xN0Oqwo2lSXCy6A-1; Tue, 03 Nov 2020 12:13:12 -0500
X-MC-Unique: YWM2uP9xN0Oqwo2lSXCy6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3158B1868418;
 Tue,  3 Nov 2020 17:13:10 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C00056EF65;
 Tue,  3 Nov 2020 17:13:05 +0000 (UTC)
Date: Tue, 3 Nov 2020 10:13:05 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103101305.10254ae4@w520.home>
In-Reply-To: <20201103110324.GA243332@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201102123823.066d156a@w520.home>
 <20201103110324.GA243332@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John G Johnson <john.g.johnson@oracle.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, mtsirkin@redhat.com, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, quintela@redhat.com,
 Jason Wang <jasowang@redhat.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 qemu-devel@nongnu.org, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 11:03:24 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Mon, Nov 02, 2020 at 12:38:23PM -0700, Alex Williamson wrote:
> > 
> > Cc+ Intel folks as this really bumps into the migration compatibility
> > discussion[1][2][3]
> > 
> > On Mon, 2 Nov 2020 11:11:53 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:

> > > VFIO Implementation
> > > -------------------
> > > The following applies both to kernel VFIO/mdev drivers and vfio-user device
> > > backends.
> > > 
> > > Devices are instantiated based on a version and/or configuration parameters:
> > > * ``version=1`` - use the device configuration aliased by version 1
> > > * ``version=2,rx-filter-size=64`` - use version 1 and override ``rx-filter-size``
> > > * ``rx-filter-size=0`` - directly set configuration parameters without using a version
> > > 
> > > Device creation fails if the version and/or configuration parameters are not
> > > supported.
> > > 
> > > There must be a mechanism to query the "latest" configuration for a device
> > > model. It may simply report the ``version=5`` where 5 is the latest version but
> > > it could also report all configuration parameters instead of using a version
> > > alias.  
> > 
> > When we talk about "instantiating" a device here, are we referring to
> > managing the device on the host or within QEMU via something like
> > vfio_realize()?  We create an instance of an mdev on the host via an
> > mdev type using operations on the host sysfs.  That mdev type doesn't
> > really seem to map to your idea if a device model represented by a URI.
> > How are supported URIs exposed and specified when the device is
> > instantiated?
> > 
> > Same for device configuration, we might have per device attributes in
> > host sysfs defining the configuration of a given mdev device, are these
> > the device configuration values?  It seems like you're referring to
> > something much more QEMU centric, but vfio-pci in QEMU handles all
> > devices the same, aside from quirks.
> > 
> > Likewise, I don't know where versions would be exposed in the current
> > vfio interface.  
> 
> "Instantiating" means writing to the mdev "create" sysfs attr. I am not
> very familiar with mdev so this could be totally wrong, but I'll try to
> define a mapping:
> 
> 1. The mdev driver sets up struct
>    mdev_parent_opts->supported_type_groups as follows:
> 
>   /* Device model URI */
>   static ssize_t model_show(struct kobject *kobj,
>                             struct device *dev,
>                             char *buf)
>   {
>       return sprintf(buf, "https://vendor-a.com/my-nic\n");
>   }
>   static MDEV_TYPE_ATTR_RO(model);
> 
>   /* Receive Side Scaling (RSS) */
>   static ssize_t rss_show(struct kobject *kobj,
>                           struct dev *dev,
> 			  char *buf)
>   {
>       return sprintf(buf, "%d\n", ...->rss);
>   }
>   static ssize_t rss_store(struct kobject *kobj,
>                            struct attribute *attr,
> 			   const char *page,
> 			   size_t count)
>   {
>       char *p = (char *) page;
>       unsigned long val = simple_strtoul(p, &p, 10);
> 
>       ...->rss = !!val;
>       return count;
>   }
>   static MDEV_TYPE_ATTR_RW(rss);
> 
>   /* Device version */
>   static ssize_t version_show(struct kobject *kobj,
>                               struct dev *dev,
> 			      char *buf)
>   {
>       return sprintf(buf, "%u\n", ...->version);
>   }
>   static ssize_t version_store(struct kobject *kobj,
>                                struct attribute *attr,
> 			       const char *page,
> 			       size_t count)
>   {
>       char *p = (char *) page;
>       unsigned long val = simple_strtoul(p, &p, 10);
> 
>       /* Set device configuration parameters to their defaults */
>       switch (version) {
>       case 1:
>           ...->rss = false;
> 	  ...->version = 1;
> 	  break;
> 
>       case 2:
>           ...->rss = true;
> 	  ...->version = 2;
> 	  break;
> 
>       default:
>           return -ENOTSUPP;
>       }
> 
>       return count;
>   }
>   static MDEV_TYPE_ATTR_RW(rss);
> 
>   static struct attribute *mdev_type_my_nic_attrs[] = {
>       &mdev_type_attr_model.attr,
>       &mdev_type_attr_rss.attr,
>       &mdev_type_attr_version.attr,
>       NULL,
>   };
> 
>   static struct attribute_group mdev_type_group_my_nic = {
>       .name  = "my-nic", /* shorthand name */
>       .attrs = mdev_type_my_nic_attrs,
>   };
> 
>   struct attribute_group *supported_type_groups[] = {
>       &mdev_type_group_my_nic,
>       NULL,
>   };
> 
> 2. The userspace tooling enumerates supported device models by reading
>    the "model" sysfs attr from each supported type attr group.


So a given mdev type can only support a single model, model just gives
us some independence from the vendor driver association of the mdev
type?  I wonder how "model" is really different from the "name"
attribute on an mdev type other than being more formalized.

 
> 3. Userspace picks the device model it wishes to instantiate and sets
>    the "version" sysfs attr and other device configuration parameters as
>    desired.
> 
> 4. Userspace instantiates the device by writing to the mdev "create" sysfs
>    attr. If instantiation succeeds then migrating a device state saved
>    by the same device model with the same configuration parameters is
>    possible.


These are not feasible semantics, multiple tasks may be instantiating
devices simultaneously, we can't lock a sub-hierarchy of sysfs while
one process configures features to their liking.  It seems more like
these attributes would be read-only to advertise support, but be
applied as part of the write to create, ie. we'd append device specific
attributes after the uuid string, similar to how we've previously
discussed supporting device aggregation.

> 
> Maybe a cleaner way to structure this is to include the version as part
> of the supported type group. So "my-nic" becomes "my-nic-1", "my-nic-2",
> etc. There would still be a "version" sysfs attr but it would be
> read-only. Device configuration parameters would only be present if they
> were actually available in that version. For example, "my-nic-1" would
> not expose an "rss" sysfs attr because it was introduced in "my-nic-2".
> I see pros and cons to both the approach I outlined above and this
> alternative, maybe someone more familiar with mdev has a preference?


How exactly is this different from an mdev type?  An mdev type is
supposed to define a software compatible device configuration.  If
version 2 is not compatible with version 1, we'd expect a vendor to
define a new type.  In practice vendors are often defining new types to
indicate the scale of a device, for example with vGPUs types may
different in the amount of graphics memory per instance.  The topic of
"aggregation" came about as a generic way to describe this within a
single type, when for example we might have an untenable number of
scaling increments to describe each as a separate type.  Unfortunately
"aggregation" is also too generic, "aggregation of what" needs to be
more clearly defined.

 
> > There's also a desire to support the vfio migration interface on
> > non-mdev vfio devices.  We don't know yet if those will be separate,
> > device specific vfio bus drivers or be integrated into existing
> > vfio-pci, but the host device is likely instantiated by binding to a
> > driver, so again I don't really understand where you're proposing this
> > negotiation occurs.  Will management tools be required to create a
> > device on-demand to fulfill a migration request or can we manipulate an
> > existing device into that desired.  Some management layers embrace the
> > idea of device pools rather than dynamic creation.  Thanks,  
> 
> The concept of device instantiation is natural for mdev and vfio-user,
> but not essential.
> 
> When dealing with physical devices (even PCI SR-IOV), we don't need to
> instantiate them explicitly. Device instances can already exist. As long
> as we know their device model URI and configuration parameters we can
> ensure migration compatibility.
> 
> For example, imagine a physical PCI NIC accompanied by a non-mdev VFIO
> migration driver. The device model URI and configuration parameter
> information can be distributed alongside the VFIO migration driver. It
> could be available via modinfo(8), as a separate metadata file, via a
> vendor-specific tool, etc.


I think we want instances of objects to expose their device and
configuration through sysfs, we don't want to require userspace to use
different methods for different flavors of devices, nor should it be
required for someone to remember how a device was instantiated.

 
> Management tools need to match the device model/configuration from the
> source device against the destination device. If the destination is
> capable of supporting the source's device model/configuration then
> migration can proceed safely.
> 
> Let's look at the case where we are migration from an older version of a
> device to a newer version. On the source we have:
> 
>   model = https://vendor-a.com/my-nic
> 
> On the destination we have:
> 
>   model = https://vendor-a.com/my-nic
>   rss = on
> 
> The two devices are incompatible because the destination exposes the RSS
> feature that is not present on the source. The RSS feature involves
> guest-visible hardware interface changes and a change to the device
> state representation. It is not safe to migrate!
> 
> In this case an extra configuration step is necessary so that the
> destination device can accept the device state from the source. The
> management tool invokes a vendor-specific tool to put the device into
> the right configuration:
> 
>   # vendor-tool set-migration-config --device 0000:00:04.0 \
>                                      --model https://vendor-a.com/my-nic
> 
> (This tool only succeeds when the device is bound to VFIO but not yet
> opened.)
> 
> The tool invokes ioctls on the vendor-specific VFIO driver that does two
> things:
> 1. Tells the device to present the old hardware interface without RSS
> 2. Uses the old device state representation without RSS support
> 
> Does this approach fit?


Should we not require that any sort of configuration like this occurs
through sysfs?  We must be able to create an instance with a specific
configuration without using vendor specific tools, therefore in the
worse case we should be able to remove and recreate an instance as we
desire without invoking vendor specific tools.  Thanks,

Alex


