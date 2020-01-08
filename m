Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20263C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3AB20678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEEXmeD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3AB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCqZ-0003jV-QS
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ipCoi-00029u-8r
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ipCog-0007qa-0N
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:00:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ipCoe-0007oK-AB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578495611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxa/kWRQEkiOz7sBIo3ceOTr8QumRNMa49cKsp3Y8Xk=;
 b=PEEXmeD0ObL5pKWwH3UirWCJzolG/G3Dj/buogj2pkxqVLWaYT7VnD5mtSYhTEbgVjdhli
 i1O+v8M9a2D510fnTzz5dD9zAKKTmAH8Fh2QqJQQKWfKnS3fqmNuW+sm7+DCyZPP2ja+yN
 eOniTF4p3mMBIfFF7nzqx5pEfcD8/54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-AemsO7ccOuSy8JUg1pUO4w-1; Wed, 08 Jan 2020 10:00:08 -0500
X-MC-Unique: AemsO7ccOuSy8JUg1pUO4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18483DB62;
 Wed,  8 Jan 2020 15:00:05 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12CA35D9E5;
 Wed,  8 Jan 2020 14:59:57 +0000 (UTC)
Date: Wed, 8 Jan 2020 15:59:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v10 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20200108155955.78e908c1.cohuck@redhat.com>
In-Reply-To: <20200107115602.25156c41@w520.home>
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
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Tue, 7 Jan 2020 11:56:02 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 7 Jan 2020 23:23:17 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:

> > There are 3 invalid states:
> >   *  101b => Invalid state
> >   *  110b => Invalid state
> >   *  111b => Invalid state
> > 
> > why only 110b should be used to report error from vendor driver to 
> > report error? Aren't we adding more confusions in the interface?  
> 
> I think the only chance of confusion is poor documentation.  If we
> define all of the above as invalid and then say any invalid state
> indicates an error condition, then the burden is on the user to
> enumerate all the invalid states.  That's not a good idea.  Instead we
> could say 101b (_RESUMING|_RUNNING) is reserved, it's not currently
> used but it might be useful some day.  Therefore there are no valid
> transitions into or out of this state.  A vendor driver should fail a
> write(2) attempting to enter this state.
> 
> That leaves 11Xb, where we consider _RESUMING and _SAVING as mutually
> exclusive, so neither are likely to ever be valid states.  Logically,
> if the device is in a failed state such that it needs to be reset to be
> recovered, I would hope the device is not running, so !_RUNNING (110b)
> seems appropriate.  I'm not sure we need that level of detail yet
> though, so I was actually just assuming both 11Xb states would indicate
> an error state and the undefined _RUNNING bit might differentiate
> something in the future.
> 
> Therefore, I think we'd have:
> 
>  * 101b => Reserved
>  * 11Xb => Error
> 
> Where the device can only self transition into the Error state on a
> failed device_state transition and the only exit from the Error state
> is via the reset ioctl.  The Reserved state is unreachable.  The vendor
> driver must error on device_state writes to enter or exit the Error
> state and must error on writes to enter Reserved states.  Is that still
> confusing?

I think one thing we could do is start to tie the meaning more to the
actual state (bit combination) and less to the individual bits. I.e.

- bit 0 indicates 'running',
- bit 1 indicates 'saving',
- bit 2 indicates 'resuming',
- bits 3-31 are reserved. [Aside: reserved-and-ignored or
  reserved-and-must-be-zero?]

[Note that I don't specify what happens when a bit is set or unset.]

States are then defined as:
000b => stopped state (not saving or resuming)
001b => running state (not saving or resuming)
010b => stop-and-copy state
011b => pre-copy state
100b => resuming state

[Transitions between these states defined, as before.]

101b => reserved [for post-copy; no transitions defined]
111b => reserved [state does not make sense; no transitions defined]
110b => error state [state does not make sense per se, but it does not
        indicate running; transitions into this state *are* possible]

To a 'reserved' state, we can later assign a different meaning (we
could even re-use 111b for a different error state, if needed); while
the error state must always stay the error state.

We should probably use some kind of feature indication to signify
whether a 'reserved' state actually has a meaning. Also, maybe we also
should designate the states > 111b as 'reserved'.

Does that make sense?


