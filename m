Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57215C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2265C208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI//zI4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2265C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWnB9-0004fu-9N
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 16:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jWn9l-0003XH-GD
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:30:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jWn9k-0004pn-DE
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588883406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSPG8LmJWo/Yo4/88W6Fprf/b9+l5K9exKHS17d3I5w=;
 b=EI//zI4WEvoSCd6efT9CNzVtN+1gHWGfNjq8O2MHXOFW0fTN4f6tPwg1jBkGmj0bahxxM6
 PCFMUFiwwzyl8c2SNDZiIuFsYB3TK0AITAMGzsvHPWfJ7DtKrmGDF4sX/GJ0hM/wzedd7v
 FsWa6NnX50iyD0zxdDfdr7D5VEJXKC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-9_3naw9PPyCT1iMx3bifUQ-1; Thu, 07 May 2020 16:30:02 -0400
X-MC-Unique: 9_3naw9PPyCT1iMx3bifUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B02B1107ACCA;
 Thu,  7 May 2020 20:29:59 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48EAF579AD;
 Thu,  7 May 2020 20:29:57 +0000 (UTC)
Date: Thu, 7 May 2020 14:29:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200507142956.0c8a030f@x1.home>
In-Reply-To: <f351c0f0-685f-7d9b-46cc-1e1c7187f06d@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
 <20200325150248.6661e1bd@w520.home>
 <a3a082a4-cc2f-b84b-60c6-a20f86528a6d@nvidia.com>
 <20200504223726.5d4bb9ce@x1.home>
 <20200506063846.GB19334@joy-OptiPlex-7040>
 <20200506115856.012c88d8.cohuck@redhat.com>
 <20200506165305.GP2743@work-vm>
 <f351c0f0-685f-7d9b-46cc-1e1c7187f06d@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Yan Zhao <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020 01:00:05 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/6/2020 10:23 PM, Dr. David Alan Gilbert wrote:
> > * Cornelia Huck (cohuck@redhat.com) wrote:  
> >> On Wed, 6 May 2020 02:38:46 -0400
> >> Yan Zhao <yan.y.zhao@intel.com> wrote:
> >>  
> >>> On Tue, May 05, 2020 at 12:37:26PM +0800, Alex Williamson wrote:  
> >>>> It's been a long time, but that doesn't seem like what I was asking.
> >>>> The sysfs version checking is used to select a target that is likely to
> >>>> succeed, but the migration stream is still generated by a user and the
> >>>> vendor driver is still ultimately responsible for validating that
> >>>> stream.  I would hope that a vendor migration stream therefore starts
> >>>> with information similar to that found in the sysfs interface, allowing
> >>>> the receiving vendor driver to validate the source device and vendor
> >>>> software version, such that we can fail an incoming migration that the
> >>>> vendor driver deems incompatible.  Ideally the vendor driver might also
> >>>> include consistency and sequence checking throughout the stream to
> >>>> prevent a malicious user from exploiting the internal operation of the
> >>>> vendor driver.  Thanks,  
> >>
> >> Some kind of somewhat standardized marker for driver/version seems like
> >> a good idea. Further checking is also a good idea, but I think the
> >> details of that need to be left to the individual drivers.  
> > 
> > Standardised markers like that would be useful; although the rules of
> > how to compare them might be a bit vendor specific; but still - it would
> > be good for us to be able to dump something out when it all goes wrong.
> >   
> 
> Such checking should already there in vendor driver. Vendor driver might 
> also support across version migration. I think checking in QEMU again 
> would be redundant. Let vendor driver handle version checks.
>
> >>>>      
> >>> maybe we can add a rw field migration_version in
> >>> struct vfio_device_migration_info besides sysfs interface ?
> >>>
> >>> when reading it in src, it gets the same string as that from sysfs;
> >>> when writing it in target, it returns success or not to check
> >>> compatibility and fails the migration early in setup phase.  
> >>
> >> Getting both populated from the same source seems like a good idea.
> >>
> >> Not sure if a string is the best value to put into a migration stream;
> >> maybe the sysfs interface can derive a human-readable string from a
> >> more compact value to be put into the migration region (and ultimately
> >> the stream)? Might be overengineering, just thinking out aloud here.  
> > 
> > A string might be OK fi you specify a little about it.

I think we've already hashed through that the version is represented by
a string, but interpretation of that string is reserved for the vendor
driver.  I believe this particular thread started out as a question of
whether QEMU is right to validate target compatibility by comparing the
migration region size versus the source, which I see as an overstep of
leaving the compatibility testing to the vendor driver.  A write
exceeding the migration region is clearly a protocol violation, but
unless we're going to scan the entire migration stream to look for that
violation, it's the vendor driver's business where and how it exposes
data within the region.  IOW, different migration region sizes might
suggest to be suspicious, but nothing in our specification requires
that the target region is at least as big as the source.

If we had a mechanism to report and test the migration version through
this migration API, using similar semantics to the sysfs interface,
what would we actually do with it?  The vendor driver's processing of
an incoming migration stream cannot rely on the user.  I initially
struggled with Kirti's use of "should" rather than "must" in describing
this checking, but I think that might actually be correct.  If a user
chooses to ignore the sysfs interface for compatibility testing, or
otherwise chooses to allow the data stream to be corrupted or
manipulated, I think the only requirement of the vendor driver is to
contain the damage to the user's device.  So, I think we're really
looking at whether it's a benefit to the user to be able to retrieve
the version and test it on the target through the migration API.  IOW,
is it sufficient for QEMU to presume that a well informed agent, that
has already tested the source and target device compatibility, has setup
this migration and that a well supported mdev vendor driver should fail
the migration gracefully if the versions are incompatible, or contain
the error within the user's device otherwise, or is there value to be
gained if QEMU performs a separate compatibility test?  Thanks,

Alex


