Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7987C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB5520643
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgzZHNZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB5520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWM99-0006rz-Q7
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWM8R-0006Od-Td
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:38:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWM8P-0005Bw-Si
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588779535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTTEPO2wQd22paCiAlDGlxpM1nImRPV1kKlLKu5EYJk=;
 b=TgzZHNZvxGPFP7OuqMsOyS+gZBOO+C/BYpu8kfOD+QXw8IXdEjKN7xCeVmLFQd347t4ufj
 58V8rRIUfrLrWzwuiVcWbDF7jChljCVsR+D/EdEA4RV0L9UxlfbrBvmKkUjWp3adD9y8m7
 0A7RwYx7AfPfQ5ji3wA16JMB3avFfmo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-PFXju6M3OH6QT3Bsz5KJfg-1; Wed, 06 May 2020 11:38:51 -0400
X-MC-Unique: PFXju6M3OH6QT3Bsz5KJfg-1
Received: by mail-qt1-f200.google.com with SMTP id y31so2786618qta.16
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 08:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T6r7JiHYqcsiWKRUL7KKi0cO0frGqQWrM2Sr/ahvxXw=;
 b=XmJ687QGe62tayYpYQCGAfC3ZJYCPothz1LKLBkPrWDJbzZ8tvYQTAGBBcZ/VzWCuJ
 asmAd95E+QFk9hWMAz7HFVFLBvrR6xW9utAPuWqZD/HiuL5qWSuqKj20bBgdxz57D9Tz
 xiNEB2Kc5HUn5F7sjX/sN5LLOL9NSfJwdRWPF8Z7Zgq79qwuUnl7RAXZpO4KNwazVYqI
 ZMYoHmx5VJgSZEb9oZr9UZMaiQGeim3poh1Owu/zmVpTb0XYUieUZ/5tOF9qxKoWS5ZP
 tDAjlaMuogLfS9z1nMvGW4694A1K40CqbQlAWNvyqwSuh3iYVVk8sNPWh521hYwnolUp
 AtVQ==
X-Gm-Message-State: AGi0PuaKIQIXUBECl2AFENNCIMWJz5evFwX7JMvqz2DF4F6XNsv1bcC4
 +UVFEyFX2kQjJkkth6Uro/0P3ajQq7fsAZRCRFSZzql4PrV6vixO+wFrJkHYSj5GwhGrOr7xG8H
 TlgQDcCU+Uh9XkGM=
X-Received: by 2002:a37:5d6:: with SMTP id 205mr9916158qkf.105.1588779529322; 
 Wed, 06 May 2020 08:38:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypJefmvluJVmFrrXoiwkdLmWDbvd5Rh7iDnzo/zx0IYLPZll7ZQl0qA77nrBzani0lVA7OOp0Q==
X-Received: by 2002:a37:5d6:: with SMTP id 205mr9915987qkf.105.1588779527527; 
 Wed, 06 May 2020 08:38:47 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id z1sm1910439qkz.3.2020.05.06.08.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 08:38:46 -0700 (PDT)
Date: Wed, 6 May 2020 11:38:45 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 3/4] vl: Sync dirty bits for system resets during
 precopy
Message-ID: <20200506153845.GL6299@xz-x1>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200428194219.10963-4-peterx@redhat.com>
 <20200506105340.GH2743@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200506105340.GH2743@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 11:53:40AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > System resets will also reset system memory layout.  Although the memor=
y layout
> > after the reset should probably the same as before the reset, we still =
need to
> > do frequent memory section removals and additions during the reset proc=
ess.
> > Those operations could accidentally lose per-mem-section information li=
ke KVM
> > memslot dirty bitmaps.
> >=20
> > Previously we keep those dirty bitmaps by sync it during memory removal=
.
> > However that's hard to make it right after all [1].  Instead, we sync d=
irty
> > pages before system reset if we know we're during a precopy migration. =
 This
> > should solve the same problem explicitly.
> >=20
> > [1] https://lore.kernel.org/qemu-devel/20200327150425.GJ422390@xz-x1/
>=20
> I think the problem is knowing whether this is sufficient or whether you
> definitely need to do it for other cases of removal/readd.

Right that's the tricky part.  I planned to look into the other potential c=
ases
after I get a feedback from Paolo or anyone that think this approach is
acceptable, but of course I can even start to look into them now.

When I said this should mostly be for reset, it comes from this commit mess=
age:

    commit 4cc856fabae1447d53890e707c70f257a7691174
    Author: zhanghailiang <zhang.zhanghailiang@huawei.com>
    Date:   Thu Apr 2 19:26:31 2015 +0000

    kvm-all: Sync dirty-bitmap from kvm before kvm destroy the correspondin=
g dirty_bitmap
   =20
    Sometimes, we destroy the dirty_bitmap in kvm_memory_slot before any sy=
nc action
    occur, this bit in dirty_bitmap will be missed, and which will lead the=
 corresponding
    dirty pages to be missed in migration.
   =20
    This usually happens when do migration during VM's Start-up or Reboot.

That's where the get-dirty-log was missing and Hailiang reported an issue w=
ith
that probably on system reboot (but, again, I know nothing about the use ca=
se
behind this...).

Today I even tried to dig deeper into the initial place that this is
introduced, and it's:

    commit 3fbffb628c001bd540dc9c1805bdf7aa8591da4d
    Author: Avi Kivity <avi@redhat.com>
    Date:   Sun Jan 15 16:13:59 2012 +0200

    kvm: flush the dirty log when unregistering a slot
   =20
    Otherwise, the dirty log information is lost in the kernel forever.
   =20
    Fixes opensuse-12.1 boot screen, which changes the vga windows rapidly.
   =20
    Signed-off-by: Avi Kivity <avi@redhat.com>

So it's Avi's 8 years ago patch probably trying to fix a display issue sinc=
e
VGA tracks dirty bit without migration.  IIUC this should belong to the cas=
e
you raised the concern about "removing a device MMIO region with RAM backed=
".
So I'll definitely look into that too, which I planned to, after all.

>=20
> However, assuming we need to do it during reset, how do we know this is
> the right point to do it, and not something further inside the reset
> process?  Is this just on the basis that vcpus are stopped?

"Stopped vcpus" is not the hint for "this is the right place", but definite=
ly a
good thing because we don't even need to consider multiple layers of dirty =
bit
caches when they're stopped (for which the last layer is the PML, which is
unluckily per-vcpu rather than per-memslot).  It's just something nice and
something extra we got.  Even if vcpus are not stopped at this point (I bel=
ieve
the above VGA MMIO region removal could be the case where I need to take ca=
re
of later, that we will have to collect dirty bits during the vcpus running)=
,
however as I mentioned in the other thread it should be a stack high enough=
 to
do some global dirty sync (because both dirty log and dirty ring need some
global sync, and I believe that's one of the reasons why current code is st=
ill
racy - we always need to flush the PML on every vcpu even for dirty log!).

Sorry I went too far... should probably go back to the topic on "the right
place" - I think this should be the right place for reset because AFAIK all=
 the
memslot add/remove is done inside device reset hooks, qemu_devices_reset() =
(or
MachineClass.reset(), which could also change stuff, but finally calls
qemu_devices_reset() too).  I tried to verify this by enable the tracepoint=
 at
trace_kvm_set_user_memory() and also dump something at qemu_system_reset()
before qemu_devices_reset(), I think it proves my understanding that all
trace_kvm_set_user_memory() triggers after that point.

Thanks,

--=20
Peter Xu


