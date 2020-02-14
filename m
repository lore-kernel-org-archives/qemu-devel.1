Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5E9C3B19F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32BE24688
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPClshCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32BE24688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dL2-0005XP-3Q
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2dKS-0004us-3K
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2dKQ-0006dM-7e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:56:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2dKQ-0006cM-2C
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581695789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQlZDbOlRnHD+tkvos+ORkRSeiyycQCLYA9CNq8IhlY=;
 b=YPClshCfaKeEX6vxQaARkIYa7QW7UkedxjW0W88NEd6tmcG+98kWNE6cUuQfUSSeyvS5Oh
 qeOsx+8zGPclrNR+HjS5xrybBQEGY5ikt+nNIbx/KZpthytF0QoEK65Ei6SffUpM7uedwc
 GQwlYSCnkLYbnwnKI/gzr4RJjXs7Dp4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-yTJtVFE1N9KpG4_bwHCENQ-1; Fri, 14 Feb 2020 10:56:26 -0500
Received: by mail-qk1-f200.google.com with SMTP id n126so6427595qkc.18
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 07:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YcLajkLFkMaFXAIlkEGn4ITxAaN0/V1WTpNV3GuJMEU=;
 b=F7JFkkjmEUG9sRiRKho5+qqmZKkEFSHBGH0MyXsUplxSeYjzXn3ZGs9Nry3Y1rONWD
 8BlTwoPt5xpX+3iYmvzlSwBrBQSpqq/exsBL55LEUYnvwV3QM/BNyxF2VDdtOcGe4RvS
 qxxBv9A71Z8wiEygBsuT/GPF0eeFWL8lYoqtk4gTat6hteNCxFx1rD+40u2UVB7NBBoA
 tD43+SbYDMMvDgsiCgMBFXv2GKeyhhW7uawA0sp6kZa7fw1Pouic/cTkWYAXAVzuxHS0
 e3neNXN+I95pglGNlk2Ps7rbk8+Bcq4KNGstV2V2FTvIjG+ILUC4wAIKZw2chih/mK3c
 wykw==
X-Gm-Message-State: APjAAAWuRErbyBDY1liTrJWdVyxVRTr45n/xlp7QoVoddoPTwqN+RIgy
 mOsvBYbtQyOfRrzgJD2dsiqAna6SfdCE1GZ8x6GDZmBOsOCPR+Y5rbISBntd94yU6i3G5WbyRNa
 GEVOg6NIXwO6Juxk=
X-Received: by 2002:ac8:758a:: with SMTP id s10mr3093572qtq.283.1581695786071; 
 Fri, 14 Feb 2020 07:56:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJBZjbJO3PKBIkAOobODLXrxTFYQWFIgtbNlhuY+0CSRl4LoHhgpL2O0wsy6CARaUqRLFQrg==
X-Received: by 2002:ac8:758a:: with SMTP id s10mr3093535qtq.283.1581695785548; 
 Fri, 14 Feb 2020 07:56:25 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id d25sm3560842qkk.77.2020.02.14.07.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 07:56:24 -0800 (PST)
Date: Fri, 14 Feb 2020 10:56:23 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214155623.GA1163818@xz-x1>
References: <20200213172016.196609-1-david@redhat.com>
 <20200213183221.GD1103216@xz-x1>
 <97821f63-bfdc-6342-bb8d-3d2b89c809fc@redhat.com>
 <20200213205636.GE1103216@xz-x1>
 <31872803-15d2-ca70-b750-c08e0fcbd25f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <31872803-15d2-ca70-b750-c08e0fcbd25f@redhat.com>
X-MC-Unique: yTJtVFE1N9KpG4_bwHCENQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 10:17:07AM +0100, David Hildenbrand wrote:
> On 13.02.20 21:56, Peter Xu wrote:
> > On Thu, Feb 13, 2020 at 08:42:23PM +0100, David Hildenbrand wrote:
> >> On 13.02.20 19:32, Peter Xu wrote:
> >>> On Thu, Feb 13, 2020 at 06:20:16PM +0100, David Hildenbrand wrote:
> >>>> Resizing while migrating is dangerous and does not work as expected.
> >>>> The whole migration code works on the usable_length of ram blocks an=
d does
> >>>> not expect this to change at random points in time.
> >>>>
> >>>> Precopy: The ram block size must not change on the source, after
> >>>> ram_save_setup(), so as long as the guest is still running on the so=
urce.
> >>>>
> >>>> Postcopy: The ram block size must not change on the target, after
> >>>> synchronizing the RAM block list (ram_load_precopy()).
> >>>>
> >>>> AFAIKS, resizing can be trigger *after* (but not during) a reset in
> >>>> ACPI code by the guest
> >>>> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> >>>> - hw/i386/acpi-build.c:acpi_ram_update()
> >>>
> >>> What can be the pre-condition of triggering this after reset?  I'm
> >>> thinking whether QEMU can be aware of this "resizing can happen"
> >>> condition, then we could simply stop the migration from happening eve=
n
> >>> before the resizing happens.  Thanks,
> >>
> >> I think the condition is not known before the guest actually tries to
> >> read the relevant memory areas (which trigger the rebuilt+resize, and
> >> AFAIK, the new size depends on fw config done by the guest after the
> >> reset). So it's hard to "predict".
> >=20
> > I chimmed in without much context, sorry if I'm going to ask naive
> > questions. :)
>=20
> I think the problem is quite involved and not obvious, so there are no
> naive questions :)
>=20
> >=20
> > What I was asking is about why the resizing can happen.  A quick read
> > told me that it was majorly for easier extension of ROMs (firmware
> > updates?).  With that, I'm imaging a common case for memory
> > resizing...
> >=20
> >   (1) Source QEMU runs VM on old host, with old firmware
> >=20
> >   (2) Migrate source QEMU to destination new host, with new and bigger
> >       firmware
> >=20
> >   (3) During the migration, the ROM size on the destination will still
> >       be the old, referring to ram_load_precopy(), as long as no
> >       system reset
> >=20
> >   (4) After migration finished, when the system reboots, memory
> >       resizing happens with the new and bigger firmware loaded
>=20
> AFAIK it could trigger
>=20
> a) In precopy during the second migration.
> b) In postcopy during the first migration.

After reading your reply - even the 1st migration of precopy?  Say,
when source QEMU resets and found changed FW during the precopy?

I'll comment postcopy below.

>=20
> >=20
> > And is this patch trying to fix/warn when there's a reboot during (3)
> > so the new size is discovered at a wrong time?  Is my understanding
> > correct?
>=20
> It's trying to bail out early instead of failing at other random points
> (with an unclear outcome).

Yeah, I am just uncertain on whether in some cases it could be a
silent success (when used_length changed, however migration still
completed without error reported) and now we're changing it to a VM
crash... Could that happen?

  - before the patch, when precopy triggers this,

    - when it didn't encounter issue with the changed used_length, it
      could get silently ignored.  Lucky enough & good case.

    - when it triggered an error, precopy failed.  _However_, we can
      simply restart... so still not so bad.

  - after the patch, when precopy detects this, we abort
    immediately...  Which is really not good...

If you see, that's the major thing I was worrying about...

And since used_length is growing in most cases as you said (at least
before virtio-mem comes? :), I'm suspecting that could be the major
case that there will be a silent success.

>=20
> >>
> >> In the precopy case it would be easier to abort (although, not simple
> >> AFAIKS), in the postcopy not so easy - because you're already partiall=
y
> >> running on the migration target.
> >=20
> > Prior to this patch, would a precopy still survive with such an
> > accident (asked because I _feel_ like migrating a ramblock with
> > smaller used_length to the same ramblock with bigger used_length seems
> > to be fine?)?  Or we can stop the precopy and restart.  After this
>=20
> I assume growing the region is the usual case (not shrinking). FW blobs
> tend to get bigger.
>=20
> Migrating while growing a ram block on the source won't work. The source
> would try to send a dirt page that's outside of the used_length on the
> target, making e.g., ram_load_postcopy()/ram_load_precopy() fail with
> "Illegal RAM offset...".

Right.

>=20
> In the postcopy case, e.g., ram_dirty_bitmap_reload() will fail in case
> there is a mismatch between ram block size on source/target.

IMHO that's an extreme rare case when (one example I can think of):

  - we start a postcopy after a precopy
  - system reset, noticed a firmware update
  - we got a network failure, postcopy interrupted
  - we try to recover a postcopy

So are you using postcopy recovery?  I will be surprised if so because
then you'll be the first user I know that really used that besides QE. :)

>=20
> Another issue is if the used_length changes while in ram_save_setup(),
> just between storing ram_bytes_total_common(true) and storing
> block->used_length. A mismatch will screw up the migration stream.

Yes this seems to be another issue then.  IIUC the ramblocks are
protected by RCU, the migration code has always been with the read
lock there so logically it should see a consistent view of system
ramblocks in ram_save_setup().  IMHO the thing that was inconsistent
is that RCU is not safe enough for changing used_length for a ramblock.

>=20
> But these are just the immediately visible issues. I am more concerned
> about used_length changing at random points in time, resulting in more
> harm. (e.g., non-obvious load-store tearing when accessing the used lengt=
h)
>=20
> Migration code is inherently racy when it comes to ram block resizes.
> And that might become more dangerous once we want to size the migration
> bitmaps smaller (used_length instead of max_length) or disallow access
> to ram blocks beyond the used_length. Both are things I am working on :)

Right. Now I start to wonder whether migration is the only special guy
here.  I noticed at least we've got:

struct RAMBlockNotifier {
    void (*ram_block_added)(RAMBlockNotifier *n, void *host, size_t size);
    void (*ram_block_removed)(RAMBlockNotifier *n, void *host, size_t size)=
;
    QLIST_ENTRY(RAMBlockNotifier) next;
};

I suspect at least all these users could also break in some way if
resize happens.

>=20
> > patch, it'll crash the source VM (&error_abort specified in
> > memory_region_ram_resize()), which seems a bit more harsh?
>=20
> There seems to be no easy way to abort migration from outside the
> migration thread. As Juan said, you actually don't want to fail
> migration but instead soft-abort migration and continue running the
> guest on the target on a reset. But that's not easy as well.
>=20
> One could think about extending ram block notifiers to notify migration
> code (before) resizes, so that migration code can work around the
> resize (how is TBD). Not easy as well :)

True.  But if you see my worry still stands, on whether such a patch
would make things worse by crashing it when it could still have a
chance to survive.  Shall we loose the penalty of that even if we want
to warn the user earlier?

>=20
> But then, I am not sure
> a) If we run into this issue in real life a lot.

/me curious about this too.  I'd bet is it's not happening a lot, even
hardly noticed/triggered.  Since I noticed resizing is there since
2014.  :)

> b) If we actually need an elaborate solutions within QEMU to handle this
> case. For now, it's sufficient to restart the VM on the migration
> target. No data was lost. Not nice, but very simple.

Thanks,

--=20
Peter Xu


