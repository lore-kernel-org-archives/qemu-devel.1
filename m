Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21536C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA7F2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpAtD92W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA7F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipvB2-000663-3Q
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 09:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ipvAP-0005Tm-KD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ipvAO-0000Xz-Ba
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:21:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ipvAO-0000W4-6E
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578666095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGXWI3monwW6hEW9z+N5Xg8fGIxYQC8MXY9UwxRNWf8=;
 b=UpAtD92WAvoyCIPlIyE3FVwtwQHeVxB2K7WmdN6dP1HPbee3OWuJHS14aD8qAVgq+l59zB
 YHAa54lSDHTEUYeXfk56YyNJ34GDGiRCJq5xZ9G/UAnb7Xn3RTt6o0MAqbuJoTrIb1TFjd
 CyM4lfWELi2drK0XkBpCHH3N7+zKblo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-3p3V5eZ6M_yHk9YIo3GFMg-1; Fri, 10 Jan 2020 09:21:22 -0500
X-MC-Unique: 3p3V5eZ6M_yHk9YIo3GFMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FDD218C35BC;
 Fri, 10 Jan 2020 14:21:20 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C70EE87EC0;
 Fri, 10 Jan 2020 14:21:13 +0000 (UTC)
Date: Fri, 10 Jan 2020 15:21:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v10 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20200110152111.74c87595.cohuck@redhat.com>
In-Reply-To: <20200108154428.02bb312d@w520.home>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-2-git-send-email-kwankhede@nvidia.com>
 <20191216154406.023f912b@x1.home>
 <f773a92a-acbd-874d-34ba-36c1e9ffe442@nvidia.com>
 <20191217114357.6496f748@x1.home>
 <3527321f-e310-8324-632c-339b22f15de5@nvidia.com>
 <20191219102706.0a316707@x1.home>
 <928e41b5-c3fd-ed75-abd6-ada05cda91c9@nvidia.com>
 <20191219140929.09fa24da@x1.home> <20200102182537.GK2927@work-vm>
 <20200106161851.07871e28@w520.home>
 <ce132929-64a7-9a5b-81ff-38616202b757@nvidia.com>
 <20200107100923.2f7b5597@w520.home>
 <08b7f953-6ac5-cd79-b1ff-54338da32d1e@nvidia.com>
 <20200107115602.25156c41@w520.home>
 <20200108155955.78e908c1.cohuck@redhat.com>
 <20200108113134.05c08470@w520.home>
 <46ac2d9e-4f4e-27d5-2a96-932c444e3461@nvidia.com>
 <20200108154428.02bb312d@w520.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 15:44:28 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 9 Jan 2020 02:11:11 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > On 1/9/2020 12:01 AM, Alex Williamson wrote:  
> > > On Wed, 8 Jan 2020 15:59:55 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:

> > >> I think one thing we could do is start to tie the meaning more to the
> > >> actual state (bit combination) and less to the individual bits. I.e.
> > >>
> > >> - bit 0 indicates 'running',
> > >> - bit 1 indicates 'saving',
> > >> - bit 2 indicates 'resuming',
> > >> - bits 3-31 are reserved. [Aside: reserved-and-ignored or
> > >>    reserved-and-must-be-zero?]    
> > > 
> > > This version specified them as:
> > > 
> > > 	Bits 3 - 31 are reserved for future use. User should perform
> > > 	read-modify-write operation on this field.
> > > 
> > > The intention is that the user should not make any assumptions about
> > > the state of the reserved bits, but should preserve them when changing
> > > known bits.  Therefore I think it's ignored but preserved.  If we
> > > specify them as zero, then I think we lose any chance to define them
> > > later.

Nod. What about extending the description to:

"Bits 3-31 are reserved for future use. In order to preserve them, a
read-modify-write operation on this field should be used when modifying
the specified bits."

?

> > >     
> > >> [Note that I don't specify what happens when a bit is set or unset.]
> > >>
> > >> States are then defined as:
> > >> 000b => stopped state (not saving or resuming)
> > >> 001b => running state (not saving or resuming)
> > >> 010b => stop-and-copy state
> > >> 011b => pre-copy state
> > >> 100b => resuming state
> > >>
> > >> [Transitions between these states defined, as before.]
> > >>
> > >> 101b => reserved [for post-copy; no transitions defined]
> > >> 111b => reserved [state does not make sense; no transitions defined]
> > >> 110b => error state [state does not make sense per se, but it does not
> > >>          indicate running; transitions into this state *are* possible]
> > >>
> > >> To a 'reserved' state, we can later assign a different meaning (we
> > >> could even re-use 111b for a different error state, if needed); while
> > >> the error state must always stay the error state.
> > >>
> > >> We should probably use some kind of feature indication to signify
> > >> whether a 'reserved' state actually has a meaning. Also, maybe we also
> > >> should designate the states > 111b as 'reserved'.
> > >>
> > >> Does that make sense?    
> > > 
> > > It seems you have an opinion to restrict this particular error state to
> > > 110b rather than 11Xb, reserving 111b for some future error condition.
> > > That's fine and I think we agree that using the state with _RUNNING set
> > > to zero is more logical as we expect the device to be non-operational
> > > in this state.

Good.

> > > 
> > > I'm also thinking more of these as states, but at the same time we're
> > > not doing away with the bit definitions.  I think the states are much
> > > easier to decode and use if we think about the function of each bit,
> > > which leads to the logical incongruity that the 11Xb states are
> > > impossible and therefore must be error states.

Yes, that's fine.

> > >     
> > 
> > I agree on bit definition is better.
> > 
> > Ok. Should there be a defined value for error, which can be used by 
> > vendor driver for error state?
> > 
> > #define VFIO_DEVICE_STATE_ERROR			\
> > 		(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING)  
> 
> Seems like a good idea for consistency.  Thanks,
> 
> Alex

Agreed, I like that as well.


