Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D492074B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4XUUBc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D492074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeRPy-0006te-78
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jeRPN-0006TZ-Bx
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:53:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jeRPL-0005bo-M5
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590706430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fP2ApTtN9i4VyxWY+o5Q36Obi7PmYNpALvuVo0SLA8=;
 b=f4XUUBc0/Xymv24TTXQ1LcWPWeu5x7xFTSj4xQJHf/qDkRavDhvR1HTK8Rj6XwGxgFDDLV
 rYl2I8sUL0YlOR/mMfxGi5kmuFc/DG3HGW42/XBiMGHCy4xkjij+ACIJcal4zU+WOT1kKF
 WsuuOdb8thh1cCLLEJLTqdhXd6fqfVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-LeE-_7KEOYCMqSIgEvVNUQ-1; Thu, 28 May 2020 18:53:46 -0400
X-MC-Unique: LeE-_7KEOYCMqSIgEvVNUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 133148014D7;
 Thu, 28 May 2020 22:53:43 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9CFA7A8BB;
 Thu, 28 May 2020 22:53:40 +0000 (UTC)
Date: Thu, 28 May 2020 16:53:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200528165340.53a57e22@x1.home>
In-Reply-To: <20200528080101.GD1378@joy-OptiPlex-7040>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
 <20200525065925.GA698@joy-OptiPlex-7040>
 <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
 <20200526141939.2632f100@x1.home>
 <20200527062358.GD19560@joy-OptiPlex-7040>
 <20200527084822.GC3001@work-vm>
 <20200528080101.GD1378@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:46:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 04:01:02 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> > > > This is my understanding of the protocol as well, when the device is
> > > > running, pending_bytes might drop to zero if no internal state has
> > > > changed and may be non-zero on the next iteration due to device
> > > > activity.  When the device is not running, pending_bytes reporting zero
> > > > indicates the device is done, there is no further state to transmit.
> > > > Does that meet your need/expectation?
> > > >  
> > > (1) on one side, as in vfio_save_pending(),
> > > vfio_save_pending()
> > > {
> > >     ...
> > >     ret = vfio_update_pending(vbasedev);
> > >     ...
> > >     *res_precopy_only += migration->pending_bytes;
> > >     ...
> > > }
> > > the pending_bytes tells migration thread how much data is still hold in
> > > device side.
> > > the device data includes
> > > device internal data + running device dirty data + device state.
> > > 
> > > so the pending_bytes should include device state as well, right?
> > > if so, the pending_bytes should never reach 0 if there's any device
> > > state to be sent after device is stopped.  
> > 
> > I hadn't expected the pending-bytes to include a fixed offset for device
> > state (If you mean a few registers etc) - I'd expect pending to drop
> > possibly to zero;  the heuristic as to when to switch from iteration to
> > stop, is based on the total pending across all iterated devices; so it's
> > got to be allowed to drop otherwise you'll never transition to stop.
> >   
> ok. got it.

Yeah, as I understand it, a device is not required to participate in
reporting data available while (_SAVING | _RUNNING), there will always
be an iteration while the device is !_RUNNING.  Therefore if you have
fixed device state that you're always going to send, it should only be
sent once when called during !_RUNNING.  The iterative phase should be
used where you have a good chance to avoid re-sending data at the
stop-and-copy phase.  Thanks,

Alex


