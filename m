Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23C1C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E52720714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwkLqF3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E52720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGxD-0005MQ-MH
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWGpe-0003M1-I0
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:59:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWGpd-0007s7-Ik
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588759152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4zvEnd1h/BCOSS6RyUBo4IOIsyq26sFYQfuwkmJ6Ldo=;
 b=GwkLqF3AmWnNyYdh1pl6sD64bRaYyKk674dUk+U+V/8311LmZa1I6mKnqV4JpPIkxAfjaI
 v4bxMb+k/CyLQz/rl2kXzIQEeMf3S/h0B06V7WyiokEsjoaR5ef20rpGM7RNfwIV6Y/A46
 GM/8SvqkEz4PGjbaX6mdMMYRiIVWYqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-pB3vgmhlNSmjEN2GyA768g-1; Wed, 06 May 2020 05:59:09 -0400
X-MC-Unique: pB3vgmhlNSmjEN2GyA768g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F871899520;
 Wed,  6 May 2020 09:59:06 +0000 (UTC)
Received: from gondolin (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 781E92E16F;
 Wed,  6 May 2020 09:58:59 +0000 (UTC)
Date: Wed, 6 May 2020 11:58:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200506115856.012c88d8.cohuck@redhat.com>
In-Reply-To: <20200506063846.GB19334@joy-OptiPlex-7040>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
 <20200325150248.6661e1bd@w520.home>
 <a3a082a4-cc2f-b84b-60c6-a20f86528a6d@nvidia.com>
 <20200504223726.5d4bb9ce@x1.home>
 <20200506063846.GB19334@joy-OptiPlex-7040>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu, 
 Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 May 2020 02:38:46 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Tue, May 05, 2020 at 12:37:26PM +0800, Alex Williamson wrote:
> > It's been a long time, but that doesn't seem like what I was asking.
> > The sysfs version checking is used to select a target that is likely to
> > succeed, but the migration stream is still generated by a user and the
> > vendor driver is still ultimately responsible for validating that
> > stream.  I would hope that a vendor migration stream therefore starts
> > with information similar to that found in the sysfs interface, allowing
> > the receiving vendor driver to validate the source device and vendor
> > software version, such that we can fail an incoming migration that the
> > vendor driver deems incompatible.  Ideally the vendor driver might also
> > include consistency and sequence checking throughout the stream to
> > prevent a malicious user from exploiting the internal operation of the
> > vendor driver.  Thanks,

Some kind of somewhat standardized marker for driver/version seems like
a good idea. Further checking is also a good idea, but I think the
details of that need to be left to the individual drivers.

> >   
> maybe we can add a rw field migration_version in
> struct vfio_device_migration_info besides sysfs interface ?
> 
> when reading it in src, it gets the same string as that from sysfs;
> when writing it in target, it returns success or not to check
> compatibility and fails the migration early in setup phase.

Getting both populated from the same source seems like a good idea.

Not sure if a string is the best value to put into a migration stream;
maybe the sysfs interface can derive a human-readable string from a
more compact value to be put into the migration region (and ultimately
the stream)? Might be overengineering, just thinking out aloud here.


