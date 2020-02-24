Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF03C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B5A20838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKwOrWRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6JGg-0006NE-BN
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 14:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6JFv-0005qd-Q9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6JFu-0003Tw-8p
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:19:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6JFu-0003S0-4B
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582571941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29JgnxfB+87cOx2QZcNbV6/2vpnOOXDT53wEP80EEJY=;
 b=KKwOrWRlAXH86RibOwWCvEbD/nHH2G37eqSgQ1V1AV8gtiW61He/ybXTWnmDE/sIceJbo/
 9KBIilwStCZCdfpGvkTLxPhqm5XA/xVx6VdNRPNEGltSWWHgf0Q4FmtRYjlT+ZyVRQTQu5
 MAsw/29FpCNura7tFXOIwwplM7onTqY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-mxMqojOXOOKTnsmIFLDSOQ-1; Mon, 24 Feb 2020 14:18:59 -0500
X-MC-Unique: mxMqojOXOOKTnsmIFLDSOQ-1
Received: by mail-qv1-f69.google.com with SMTP id c1so9974922qvw.17
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 11:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4NuNQ7H0skUF+g6r33M42mAbTradAOXlw8Oc/mFe8tQ=;
 b=shucIXETZoDwbNhM0X4BqoKaO+Nbi8XjPlWMkx6EhSEa4y6t+ThW6eEeosvcr2iGCF
 EC1WWiK4A53Hl3+K27GtY7NEobEDIDaX0EektC2pOfaXQO20746t8AT95XgbJlTm/sDi
 2DGB104d2zZsmNO9rJVawC0TtRfocA7Hn+iMmqnCz/PsFUY154cui6ZD0G5+/2PWWW1t
 j1cvHKOjqHopscqC0Bt5u2QhiXGEbhuu1YS+Yy6uzpDvf6hKkWFU+7WYrFkXeMf7h7+R
 B1qa29BCxow/D/r9b4tIVx7CyuuMA5owu73rVfdjy5KbphCNNRVmX+QHPXgcJtI/yu49
 TQrw==
X-Gm-Message-State: APjAAAWTuMULbhr/aGwNveyGYZwxda60balvs/sXOnaJpzr//mlQkSyD
 MxvmV4ofs3H0hECD4knp+4HpfbLRr4USyyJB74/YjNOfDZOT2KBBkcrvQgmYpQO63By1BCM9cns
 uZbaCZnMzNExcluc=
X-Received: by 2002:a37:a744:: with SMTP id q65mr9512891qke.354.1582571939026; 
 Mon, 24 Feb 2020 11:18:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYuwSG9IMaJId06ZM9DE53mOTDCl+yBUutUEYHs4nCs2I1BTfowpo5vymfwG5rfv1uWeAQuA==
X-Received: by 2002:a37:a744:: with SMTP id q65mr9512848qke.354.1582571938669; 
 Mon, 24 Feb 2020 11:18:58 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id d9sm6248724qtw.32.2020.02.24.11.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 11:18:57 -0800 (PST)
Date: Mon, 24 Feb 2020 14:18:56 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 00/13] migrate/ram: Fix resizing RAM blocks while
 migrating
Message-ID: <20200224191856.GK37727@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221180440.GE37727@xz-x1>
 <d10b53cc-89f3-042b-9889-d16ea7572f42@redhat.com>
 <20200224174515.GJ37727@xz-x1>
 <39ced494-023b-e020-e986-218919063af5@redhat.com>
 <0ffb449a-84a3-3555-e0c1-0bc842977bb2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0ffb449a-84a3-3555-e0c1-0bc842977bb2@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paul Durrant <paul@xen.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 07:59:10PM +0100, David Hildenbrand wrote:
> On 24.02.20 19:44, David Hildenbrand wrote:
> > On 24.02.20 18:45, Peter Xu wrote:
> >> On Mon, Feb 24, 2020 at 10:09:19AM +0100, David Hildenbrand wrote:
> >>> On 21.02.20 19:04, Peter Xu wrote:
> >>>> On Fri, Feb 21, 2020 at 05:41:51PM +0100, David Hildenbrand wrote:
> >>>>> I was now able to actually test resizing while migrating. I am usin=
g the
> >>>>> prototype of virtio-mem to test (which also makes use of resizable
> >>>>> allocations). Things I was able to reproduce:
> >>>>
> >>>> The test cases cover quite a lot.  Thanks for doing that.
> >>>>
> >>>>> - Resize while still running on the migration source. Migration is =
canceled
> >>>>> -- Test case for "migraton/ram: Handle RAM block resizes during pre=
copy"
> >>>>
> >>>>> - Resize (grow+shrink) on the migration target during postcopy migr=
ation
> >>>>>   (when syncing RAM blocks), while not yet running on the target
> >>>>> -- Test case for "migration/ram: Discard new RAM when growing RAM b=
locks
> >>>>>    and the VM is stopped", and overall RAM size synchronization. Se=
ems to
> >>>>>    work just fine.
> >>>>
> >>>> This won't be able to trigger without virtio-mem, right?
> >>>
> >>> AFAIK all cases can also be triggered without virtio-mem (not just th=
at
> >>> easily :) ). This case would be "RAM block is bigger on source than o=
n
> >>> destination.".
> >>>
> >>>>
> >>>> And I'm also curious on how to test this even with virtio-mem.  Is
> >>>> that a QMP command to extend/shrink virtio-mem?
> >>>
> >>> Currently, there is a single qom property that can be modifed via
> >>> QMP/HMP - "requested-size". With resizable resizable memory backends,
> >>> increasing the requested size will also implicitly grow the RAM block=
.
> >>> Shrinking the requested size will currently result in shrinking the R=
AM
> >>> block on the next reboot.
> >>>
> >>> So, to trigger growing of a RAM block (assuming requested-size was
> >>> smaller before, e.g., 1000M)
> >>>
> >>> echo "qom-set vm1 requested-size 6000M" | sudo nc -U $MON
> >>>
> >>> To trigger shrinking (assuming requested-size was bigger before)
> >>>
> >>> echo "qom-set vm1 requested-size 100M" | sudo nc -U $MON
> >>> echo 'system_reset' | sudo nc -U $MON
> >>>
> >>>
> >>> Placing these at the right spots during a migration allows to test th=
is
> >>> very reliably.
> >>
> >> I see, thanks for the context.  The question was majorly about when
> >> you say "during postcopy migration (when syncing RAM blocks), while
> >> not yet running on the target" - it's not easy to do so imho, because:
> >=20
> > This case is very easy to trigger, even with acpi. Simply have a ram
> > block on the source be bigger than one on the target. The sync code
> > (migration/ram.c:qemu_ram_resize()) will perform the resize during
> > precopy. Postcopy misses to discard the additional memory.

But when resizing happens during precopy, we should cancel this
migration directly?  Hmm?...

> >=20
> > Maybe my description was confusing. But this really just triggers when
> >=20
> > - Postcopy is advised and discards memory on all ram blocks
> > - Precopy grows the RAM block when syncing the RAM block sizes with the
> > source
> >=20
> > Postcopy misses to discard the new RAM.
> >=20
> >>
> >>   - it's a very short transition period between precopy and postcopy,
> >>     so I was curious about how you made sure that the grow/shrink
> >>     happened exactly during that period
> >>
> >>   - during the period, IIUC it was still in the main thread, which
> >>     means logically QEMU should not be able to respond to any QMP/HMP
> >>     command at all...  So even if you send a command, I think it'll
> >>     only be executed later after the transition completes
> >>
> >>   - this I'm not sure, but ... even for virtio-mem, the resizing can
> >>     only happen after guest ack it, right?  During the precopy to
> >>     postcopy transition period, the VM is stopped, AFAICT, so
> >>     logically we can't trigger resizing during the transition
>=20
> Regarding that question: Resizes will happen without guest interaction
> (e.g., during a reboot, or when increasing the requested size). In the
> future, there are theoretical plans to have resizes that can be
> triggered by guest interaction/request to some extend as well.

I see.  I was thinking about shrinking case which should probably need
an acknowledgement from the guest, but yes increasing seems to be fine
even without it.  Thanks,

--=20
Peter Xu


