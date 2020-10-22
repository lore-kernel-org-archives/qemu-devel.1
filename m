Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605F1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E1C22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7jw1h58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E1C22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVOx-0001V5-PX
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kVVO5-0000nt-AX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kVVO0-0002C6-Nk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603353103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZ/XVAKkZ1zDBviSqaM2X5dmqUA6nYddxvyZHoutGz4=;
 b=G7jw1h58e5bTT5FBeDb1PDcP07MnaeI1AoP2V2OgcJP5j6ivnG7GeL8nvQTYFOI7LI93m7
 tn1A7md1xGtPIkVV3OC0BuvTJc5yJqnr/LSgF1IgLX7S0u3PAuSjw5PIdjcNqemdGvBV68
 SszlSAvqVNj4XKQLcf9NL0ZrTitHBDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-dA86uxx_PUOLKqWKu8k3_Q-1; Thu, 22 Oct 2020 03:51:41 -0400
X-MC-Unique: dA86uxx_PUOLKqWKu8k3_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A8CD800050;
 Thu, 22 Oct 2020 07:51:39 +0000 (UTC)
Received: from gondolin (ovpn-112-67.ams2.redhat.com [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 509DF6EF42;
 Thu, 22 Oct 2020 07:51:28 +0000 (UTC)
Date: Thu, 22 Oct 2020 09:51:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20201022095125.60319084.cohuck@redhat.com>
In-Reply-To: <245abdf6-245d-5f88-e04b-35fad763560c@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
 <20200924170220.0a9836fe.cohuck@redhat.com>
 <20200929110312.GF2826@work-vm>
 <3dd3fe95-c81a-de40-47b0-24f0772974d4@nvidia.com>
 <20201020125105.5cd790df.cohuck@redhat.com>
 <245abdf6-245d-5f88-e04b-35fad763560c@nvidia.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, alex.williamson@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 11:03:23 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 10/20/2020 4:21 PM, Cornelia Huck wrote:
> > On Sun, 18 Oct 2020 01:54:56 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 9/29/2020 4:33 PM, Dr. David Alan Gilbert wrote:  
> >>> * Cornelia Huck (cohuck@redhat.com) wrote:  
> >>>> On Wed, 23 Sep 2020 04:54:07 +0530
> >>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:

> >>>>> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> >>>>> +{
> >>>>> +    VFIODevice *vbasedev = opaque;
> >>>>> +
> >>>>> +    if ((vbasedev->vm_running != running)) {
> >>>>> +        int ret;
> >>>>> +        uint32_t value = 0, mask = 0;
> >>>>> +
> >>>>> +        if (running) {
> >>>>> +            value = VFIO_DEVICE_STATE_RUNNING;
> >>>>> +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
> >>>>> +                mask = ~VFIO_DEVICE_STATE_RESUMING;  
> >>>>
> >>>> I've been staring at this for some time and I think that the desired
> >>>> result is
> >>>> - set _RUNNING
> >>>> - if _RESUMING was set, clear it, but leave the other bits intact  
> >>
> >> Upto here, you're correct.
> >>  
> >>>> - if _RESUMING was not set, clear everything previously set
> >>>> This would really benefit from a comment (or am I the only one
> >>>> struggling here?)
> >>>>     
> >>
> >> Here mask should be ~0. Correcting it.  
> > 
> > Hm, now I'm confused. With value == _RUNNING, ~_RUNNING and ~0 as mask
> > should be equivalent, shouldn't they?
> >   
> 
> I too got confused after reading your comment.
> Lets walk through the device states and transitions can happen here:
> 
> if running
>   - device state could be either _SAVING or _RESUMING or _STOP. Both 
> _SAVING and _RESUMING can't be set at a time, that is the error state. 
> _STOP means 0.
>   - Transition from _SAVING to _RUNNING can happen if there is migration 
> failure, in that case we have to clear _SAVING
> - Transition from _RESUMING to _RUNNING can happen on resuming and we 
> have to clear _RESUMING.
> - In both the above cases, we have to set _RUNNING and clear rest 2 bits.
> Then:
> mask = ~VFIO_DEVICE_STATE_MASK;
> value = VFIO_DEVICE_STATE_RUNNING;

ok

> 
> if !running
> - device state could be either _RUNNING or _SAVING|_RUNNING. Here we 
> have to reset running bit.
> Then:
> mask = ~VFIO_DEVICE_STATE_RUNNING;
> value = 0;

ok

> 
> I'll add comment in the code above.

That will help.

I'm a bit worried though that all that reasoning which flags are set or
cleared when is quite complex, and it's easy to make mistakes.

Can we model this as a FSM, where an event (running state changes)
transitions the device state from one state to another? I (personally)
find FSMs easier to comprehend, but I'm not sure whether that change
would be too invasive. If others can parse the state changes with that
mask/value interface, I won't object to it.

> 
> 
> >>
> >>  
> >>>>> +            }
> >>>>> +        } else {
> >>>>> +            mask = ~VFIO_DEVICE_STATE_RUNNING;
> >>>>> +        }


