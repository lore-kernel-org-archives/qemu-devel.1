Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D1C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0515A208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrTtwqVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0515A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iot0z-0001e6-1T
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iot0L-00011z-2O
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iot0I-0002zN-VQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:50:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iot0I-0002xi-CP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578419453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GTm1l5zQtZ52XhEMdXoYtz6Pjm3g5KvI/aIwxC4+9w=;
 b=WrTtwqVgPVINw4HqHyHyhLSL53diSxaqqmCWifSF7rAzv1hSvoIal3XZpU96oTub02S5Am
 V0e82ze+2RlzzFweorsviwpE6BpC131Ried7W2osSDNnG+Dvqmol7k3Kc0Wr+7Ev/eBXc+
 neUeBojm2N6bysjWwJb13cdvb+c3Ak4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-cWjUiVAuMqeB90ek5Knc5w-1; Tue, 07 Jan 2020 12:50:49 -0500
X-MC-Unique: cWjUiVAuMqeB90ek5Knc5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2577E1951287;
 Tue,  7 Jan 2020 17:50:47 +0000 (UTC)
Received: from work-vm (ovpn-117-52.ams2.redhat.com [10.36.117.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E77B29A84;
 Tue,  7 Jan 2020 17:50:40 +0000 (UTC)
Date: Tue, 7 Jan 2020 17:50:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v10 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20200107175037.GL2732@work-vm>
References: <f773a92a-acbd-874d-34ba-36c1e9ffe442@nvidia.com>
 <20191217114357.6496f748@x1.home>
 <3527321f-e310-8324-632c-339b22f15de5@nvidia.com>
 <20191219102706.0a316707@x1.home>
 <928e41b5-c3fd-ed75-abd6-ada05cda91c9@nvidia.com>
 <20191219140929.09fa24da@x1.home> <20200102182537.GK2927@work-vm>
 <20200106161851.07871e28@w520.home> <20200107095740.GB2778@work-vm>
 <20200107095410.2be5a064@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107095410.2be5a064@w520.home>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Tue, 7 Jan 2020 09:57:40 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Alex Williamson (alex.williamson@redhat.com) wrote:
> > > On Thu, 2 Jan 2020 18:25:37 +0000
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Alex Williamson (alex.williamson@redhat.com) wrote:  
> > > > > On Fri, 20 Dec 2019 01:40:35 +0530
> > > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > > >     
> > > > > > On 12/19/2019 10:57 PM, Alex Williamson wrote:
> > > > > > 
> > > > > > <Snip>
> > > > > >     
> > > > 
> > > > <snip>
> > > >   
> > > > > > 
> > > > > > If device state it at pre-copy state (011b).
> > > > > > Transition, i.e., write to device state as stop-and-copy state (010b) 
> > > > > > failed, then by previous state I meant device should return pre-copy 
> > > > > > state(011b), i.e. previous state which was successfully set, or as you 
> > > > > > said current state which was successfully set.    
> > > > > 
> > > > > Yes, the point I'm trying to make is that this version of the spec
> > > > > tries to tell the user what they should do upon error according to our
> > > > > current interpretation of the QEMU migration protocol.  We're not
> > > > > defining the QEMU migration protocol, we're defining something that can
> > > > > be used in a way to support that protocol.  So I think we should be
> > > > > concerned with defining our spec, for example my proposal would be: "If
> > > > > a state transition fails the user can read device_state to determine the
> > > > > current state of the device.  This should be the previous state of the
> > > > > device unless the vendor driver has encountered an internal error, in
> > > > > which case the device may report the invalid device_state 110b.  The
> > > > > user must use the device reset ioctl in order to recover the device
> > > > > from this state.  If the device is indicated in a valid device state
> > > > > via reading device_state, the user may attempt to transition the device
> > > > > to any valid state reachable from the current state."    
> > > > 
> > > > We might want to be able to distinguish between:
> > > >   a) The device has failed and needs a reset
> > > >   b) The migration has failed  
> > > 
> > > I think the above provides this.  For Kirti's example above of
> > > transitioning from pre-copy to stop-and-copy, the device could refuse
> > > to transition to stop-and-copy, generating an error on the write() of
> > > device_state.  The user re-reading device_state would allow them to
> > > determine the current device state, still in pre-copy or failed.  Only
> > > the latter would require a device reset.  
> > 
> > OK - but that doesn't give you any way to figure out 'why' it failed;
> > I guess I was expecting you to then read an 'error' register to find
> > out what happened.
> > Assuming the write() to transition to stop-and-copy fails and you're
> > still in pre-copy, what's the defined thing you're supposed to do next?
> > Decide migration has failed and then do a write() to transition to running?
> 
> Defining semantics for an error register seems like a project on its
> own.  We do have flags, we could use them to add an error register
> later, but I think it's only going to rat hole this effort to try to
> incorporate that now.

OK, to be honest I didn't really mean for that thing to be used by code
to decide on it's next action, rather to have something to report when
it failed.

> The state machine is fairly small, so in the
> scenario you present, I think the user would assume a failure at
> pre-copy to stop-and-copy transition would fail the migration and the
> device could go back to running state.  If the device then fails to
> return to the running state, we might be stuck with a device with
> reduced performance or overhead and the user could warn about that and
> continue with the device as-is.  The vendor drivers could make use of
> -EAGAIN on transition failure to indicate a temporary issue, but
> otherwise the user should probably consider it a persistent error until
> either a device reset or start of a new migration sequence (ie. return
> to running and start over).  Thanks,

OK as long as we define somewhere that the action on a failed transition
is then try and transitino to running before restarting the VM and fail
the migration.

Dave

> Alex
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


