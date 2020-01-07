Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D79C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ABE206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi/KsMhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ABE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosAW-0005Dd-4f
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ios7i-0001SH-04
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ios7f-0006UK-8E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:54:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ios7f-0006S4-3i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578416065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvxBS3wP3ArlR+uY1I3fF6NEpA+/gbdCJUjIk1BEp10=;
 b=Gi/KsMhga+xWg0J0WvBQY72DJMg4RduB83uWzKXcm4YdZyWUbOgCpYyb6SRhg+WPS6hcmh
 5YMpa6eqOvt+CHXWh7Mz6h5h89N1e2jMRNDd7xdxzeKoeycfvH8nvLZBJt+v4keAACV1QL
 LOUs6xNVX+oYTl8fMV0NLMTt9Tha9J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-MY1PdedVNCKULG1qmdo77g-1; Tue, 07 Jan 2020 11:54:22 -0500
X-MC-Unique: MY1PdedVNCKULG1qmdo77g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7516DB6F;
 Tue,  7 Jan 2020 16:54:19 +0000 (UTC)
Received: from w520.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B51AC5D9E5;
 Tue,  7 Jan 2020 16:54:11 +0000 (UTC)
Date: Tue, 7 Jan 2020 09:54:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v10 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20200107095410.2be5a064@w520.home>
In-Reply-To: <20200107095740.GB2778@work-vm>
References: <1576527700-21805-2-git-send-email-kwankhede@nvidia.com>
 <20191216154406.023f912b@x1.home>
 <f773a92a-acbd-874d-34ba-36c1e9ffe442@nvidia.com>
 <20191217114357.6496f748@x1.home>
 <3527321f-e310-8324-632c-339b22f15de5@nvidia.com>
 <20191219102706.0a316707@x1.home>
 <928e41b5-c3fd-ed75-abd6-ada05cda91c9@nvidia.com>
 <20191219140929.09fa24da@x1.home> <20200102182537.GK2927@work-vm>
 <20200106161851.07871e28@w520.home> <20200107095740.GB2778@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Tue, 7 Jan 2020 09:57:40 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > On Thu, 2 Jan 2020 18:25:37 +0000
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >   
> > > * Alex Williamson (alex.williamson@redhat.com) wrote:  
> > > > On Fri, 20 Dec 2019 01:40:35 +0530
> > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >     
> > > > > On 12/19/2019 10:57 PM, Alex Williamson wrote:
> > > > > 
> > > > > <Snip>
> > > > >     
> > > 
> > > <snip>
> > >   
> > > > > 
> > > > > If device state it at pre-copy state (011b).
> > > > > Transition, i.e., write to device state as stop-and-copy state (010b) 
> > > > > failed, then by previous state I meant device should return pre-copy 
> > > > > state(011b), i.e. previous state which was successfully set, or as you 
> > > > > said current state which was successfully set.    
> > > > 
> > > > Yes, the point I'm trying to make is that this version of the spec
> > > > tries to tell the user what they should do upon error according to our
> > > > current interpretation of the QEMU migration protocol.  We're not
> > > > defining the QEMU migration protocol, we're defining something that can
> > > > be used in a way to support that protocol.  So I think we should be
> > > > concerned with defining our spec, for example my proposal would be: "If
> > > > a state transition fails the user can read device_state to determine the
> > > > current state of the device.  This should be the previous state of the
> > > > device unless the vendor driver has encountered an internal error, in
> > > > which case the device may report the invalid device_state 110b.  The
> > > > user must use the device reset ioctl in order to recover the device
> > > > from this state.  If the device is indicated in a valid device state
> > > > via reading device_state, the user may attempt to transition the device
> > > > to any valid state reachable from the current state."    
> > > 
> > > We might want to be able to distinguish between:
> > >   a) The device has failed and needs a reset
> > >   b) The migration has failed  
> > 
> > I think the above provides this.  For Kirti's example above of
> > transitioning from pre-copy to stop-and-copy, the device could refuse
> > to transition to stop-and-copy, generating an error on the write() of
> > device_state.  The user re-reading device_state would allow them to
> > determine the current device state, still in pre-copy or failed.  Only
> > the latter would require a device reset.  
> 
> OK - but that doesn't give you any way to figure out 'why' it failed;
> I guess I was expecting you to then read an 'error' register to find
> out what happened.
> Assuming the write() to transition to stop-and-copy fails and you're
> still in pre-copy, what's the defined thing you're supposed to do next?
> Decide migration has failed and then do a write() to transition to running?

Defining semantics for an error register seems like a project on its
own.  We do have flags, we could use them to add an error register
later, but I think it's only going to rat hole this effort to try to
incorporate that now.  The state machine is fairly small, so in the
scenario you present, I think the user would assume a failure at
pre-copy to stop-and-copy transition would fail the migration and the
device could go back to running state.  If the device then fails to
return to the running state, we might be stuck with a device with
reduced performance or overhead and the user could warn about that and
continue with the device as-is.  The vendor drivers could make use of
-EAGAIN on transition failure to indicate a temporary issue, but
otherwise the user should probably consider it a persistent error until
either a device reset or start of a new migration sequence (ie. return
to running and start over).  Thanks,

Alex


