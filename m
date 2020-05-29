Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F49207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUL1/qiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F49207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecxo-0005P3-DC
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jecwr-0004BL-1r
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:13:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jecwp-0007q9-PV
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590750789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gB04A63VI2Unw4Ky1vvnST2Pf8KKP9aXv3QcFy13LxE=;
 b=dUL1/qiXKM4AxHX0hqHPiSRjVvqqgCSSO3v367U1qGhRBsyHDe66GYIcONZ+/keoJjOMAD
 dE8Gx3LoiKFMEaWBibpf1nBfuWm0E3b3L3kbCLdDur5r5qvOTiLW4sdgWNc0x7mHi9dVzg
 uYh1FVQRzkFipKBa+HbfZld60owUo8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-Og0uXFZ_M4imNKBXPBF75w-1; Fri, 29 May 2020 07:13:07 -0400
X-MC-Unique: Og0uXFZ_M4imNKBXPBF75w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95D4C1005510;
 Fri, 29 May 2020 11:13:04 +0000 (UTC)
Received: from work-vm (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00D7C1A7C8;
 Fri, 29 May 2020 11:12:57 +0000 (UTC)
Date: Fri, 29 May 2020 12:12:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200529111254.GH2856@work-vm>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
 <20200525065925.GA698@joy-OptiPlex-7040>
 <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
 <20200526141939.2632f100@x1.home>
 <20200527062358.GD19560@joy-OptiPlex-7040>
 <20200527084822.GC3001@work-vm>
 <20200528080101.GD1378@joy-OptiPlex-7040>
 <20200528165340.53a57e22@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528165340.53a57e22@x1.home>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org,
 zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, Yan Zhao <yan.y.zhao@intel.com>,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Thu, 28 May 2020 04:01:02 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > > > > This is my understanding of the protocol as well, when the device is
> > > > > running, pending_bytes might drop to zero if no internal state has
> > > > > changed and may be non-zero on the next iteration due to device
> > > > > activity.  When the device is not running, pending_bytes reporting zero
> > > > > indicates the device is done, there is no further state to transmit.
> > > > > Does that meet your need/expectation?
> > > > >  
> > > > (1) on one side, as in vfio_save_pending(),
> > > > vfio_save_pending()
> > > > {
> > > >     ...
> > > >     ret = vfio_update_pending(vbasedev);
> > > >     ...
> > > >     *res_precopy_only += migration->pending_bytes;
> > > >     ...
> > > > }
> > > > the pending_bytes tells migration thread how much data is still hold in
> > > > device side.
> > > > the device data includes
> > > > device internal data + running device dirty data + device state.
> > > > 
> > > > so the pending_bytes should include device state as well, right?
> > > > if so, the pending_bytes should never reach 0 if there's any device
> > > > state to be sent after device is stopped.  
> > > 
> > > I hadn't expected the pending-bytes to include a fixed offset for device
> > > state (If you mean a few registers etc) - I'd expect pending to drop
> > > possibly to zero;  the heuristic as to when to switch from iteration to
> > > stop, is based on the total pending across all iterated devices; so it's
> > > got to be allowed to drop otherwise you'll never transition to stop.
> > >   
> > ok. got it.
> 
> Yeah, as I understand it, a device is not required to participate in
> reporting data available while (_SAVING | _RUNNING), there will always
> be an iteration while the device is !_RUNNING.  Therefore if you have
> fixed device state that you're always going to send, it should only be
> sent once when called during !_RUNNING.  The iterative phase should be
> used where you have a good chance to avoid re-sending data at the
> stop-and-copy phase.  Thanks,

Right.

Dave

> Alex
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


