Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D84222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOmDiZV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D84222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpKB-0001l2-6d
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUpJ8-0001Jm-SL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUpJ6-0005pD-IR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603191355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJXCLkniSpumrpo5/33KeTxARBhqTH2dEuPHMfhlhoI=;
 b=YOmDiZV2u9TtIBqXaLwjMPYZp+RsMJJSGw4/4OdrMQkmV1l1M3zhIDfTnuU6SQ/xgF/JCC
 DFXZ4vD7q6cTAGHR0Mu4QuSmdKW9OmznpNBCfkfPWNXN29Rjgf7fHJUKYef5rreeAEmwef
 crHimeF7ij7n1EraF9d2pLD0Q9+JvMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-cXSV2ct1NPWBDaip7_o2CQ-1; Tue, 20 Oct 2020 06:55:53 -0400
X-MC-Unique: cXSV2ct1NPWBDaip7_o2CQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12E7107465A;
 Tue, 20 Oct 2020 10:55:51 +0000 (UTC)
Received: from gondolin (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D8D66EF40;
 Tue, 20 Oct 2020 10:55:40 +0000 (UTC)
Date: Tue, 20 Oct 2020 12:55:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v26 06/17] vfio: Add migration state change notifier
Message-ID: <20201020125537.5920fa8b.cohuck@redhat.com>
In-Reply-To: <20201019115747.15846824@w520.home>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-7-git-send-email-kwankhede@nvidia.com>
 <20200925142032.524c1a79@x1.home>
 <048540b5-9e03-e6ec-64e5-a78b99a78c08@nvidia.com>
 <20201019115747.15846824@w520.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 11:57:47 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Sun, 18 Oct 2020 02:05:03 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > On 9/26/2020 1:50 AM, Alex Williamson wrote:  
> > > On Wed, 23 Sep 2020 04:54:08 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:

> > >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > >> index 25e3b1a3b90a..49c7c7a0e29a 100644
> > >> --- a/include/hw/vfio/vfio-common.h
> > >> +++ b/include/hw/vfio/vfio-common.h
> > >> @@ -123,6 +123,7 @@ typedef struct VFIODevice {
> > >>       VMChangeStateEntry *vm_state;
> > >>       uint32_t device_state;
> > >>       int vm_running;
> > >> +    Notifier migration_state;    
> > > 
> > > Can this live in VFIOMigration?  Thanks,
> > >     
> > 
> > No, callback vfio_migration_state_notifier() has notifier argument and 
> > to reach its corresponding device structure as below, its should be in 
> > VFIODevice.
> > 
> > VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);  
> 
> An alternative would be to place migration_state within VFIOMigration,
> along with a pointer back to vbasedev (like we do in VFIORegion) then
> the notifier could use container_of to get the VFIOMigration structure,
> from which we could get to the VFIODevice via the vbasedev pointer.
> This would better compartmentalize the migration related data into a
> single structure.  Thanks,
> 
> Alex

+1, I think having everything in VFIOMigration would be nicer.


