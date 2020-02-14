Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C2CC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C84E2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ielFQbxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C84E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gyB-0006kh-GD
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2gtj-0001Td-FL
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2gth-0005VB-G7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:45:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2gth-0005RF-Bh
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581709508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzJGhNhe/BNZaiRzL9E0tMxQK4mcalIUwtMr8B5/h5s=;
 b=ielFQbxZxuKkUvmbT0EsmsFhrdzg2rdXFX26Ay+2l/fpqt6NoJ5eXSqLUL8EdI2SMMRSs0
 aeT1yRfnf/RTm38/O7N1yIrsc7WWUqn/ShPdEpbFB2vMxvdJJ3yyrLon+XDOdO8BKGp8gZ
 YZ0WFRaz4VKmEnpLs8Qt9YrCHqObW14=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-LKlv5AaXMDm7rb29vlm6lg-1; Fri, 14 Feb 2020 14:45:03 -0500
Received: by mail-qt1-f198.google.com with SMTP id k20so6583450qtm.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/y8fLUP3TrEcEVk+KHzq6XbRwc/XczGdLhiK+iW8CMU=;
 b=kneHYnvV487dvfhZxz0bIzYTLDvragzP7szAoMSD3Jp1UjlGRO4u2VKFNjQi1k2vMM
 3l0hVPB6O1VDUE4nuqeqaHM2f5OqRmtWZfRnY5LnmbnthclHA2Q80CFosITxWwn8/mVe
 J1O6ZxQNZDCSd+SdGpMNS44wWmQ2uhk44RPdB8udFKMlqdsmIgwjKRGZcgEheouNStTB
 4kfHTB5rV12boFspnYrTbn8Abb/tM5JCkgwkNUQ1X7WxMNPm5vmRtscYxpMemW1WwWSn
 duMrL3gRXR98ilmtELw5+FvMS4nM2DWbldJdosBZC2YaWPWFfMo4bS1PlysATwKccLRI
 cqpQ==
X-Gm-Message-State: APjAAAUpBk7wpClmNAT5NZRTGxy4gZFkywB/Lvf5wbAZbLl0TbVFcubW
 kKubliztTgHyGZdTdELNrfEczunLz+YZjtyOjiORV/03lBl7Apyu+MGGqOdO7JeIcMnxzAuaayp
 Bx9PexVPbu88+Xwo=
X-Received: by 2002:ac8:3946:: with SMTP id t6mr3963620qtb.278.1581709503162; 
 Fri, 14 Feb 2020 11:45:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYN9bVmN8IuJ4XZAWKzSXo2uqRMKtXsbTHa5hJllo/mCr6LJmsCxVvt/ZPetMeNtCWgl6p5w==
X-Received: by 2002:ac8:3946:: with SMTP id t6mr3963593qtb.278.1581709502845; 
 Fri, 14 Feb 2020 11:45:02 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id t3sm3895771qtc.8.2020.02.14.11.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 11:45:02 -0800 (PST)
Date: Fri, 14 Feb 2020 14:44:59 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214194459.GB1193332@xz-x1>
References: <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
 <20200214110226.GD3283@work-vm>
 <9a15fd0e-77d1-b3a0-4824-665f85f79c71@redhat.com>
 <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com>
 <20200214172933.GC1163818@xz-x1>
 <9597c9a9-05d2-d99d-e153-8ffc112910bc@redhat.com>
 <20200214181146.GE1163818@xz-x1>
 <ab0c4b8f-c18b-cf02-282a-eb968bb6677e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ab0c4b8f-c18b-cf02-282a-eb968bb6677e@redhat.com>
X-MC-Unique: LKlv5AaXMDm7rb29vlm6lg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 07:26:59PM +0100, David Hildenbrand wrote:
> >>>> +    if (!postcopy_is_running()) {
> >>>> +        Error *err =3D NULL;
> >>>> +
> >>>> +        /*
> >>>> +         * Precopy code cannot deal with the size of ram blocks cha=
nging at
> >>>> +         * random points in time. We're still running on the source=
, abort
> >>>> +         * the migration and continue running here. Make sure to wa=
it until
> >>>> +         * migration was canceled.
> >>>> +         */
> >>>> +        error_setg(&err, "RAM resized during precopy.");
> >>>> +        migrate_set_error(migrate_get_current(), err);
> >>>> +        error_free(err);
> >>>> +        migration_cancel();
> >>>> +    } else {
> >>>> +        /*
> >>>> +         * Postcopy code cannot deal with the size of ram blocks ch=
anging at
> >>>> +         * random points in time. We're running on the target. Fail=
 hard.
> >>>> +         *
> >>>> +         * TODO: How to handle this in a better way?
> >>>> +         */
> >>>> +        error_report("RAM resized during postcopy.");
> >>>> +        exit(-1);
> >>>
> >>> Now I'm rethinking the postcopy case....
> >>>
> >>> ram_dirty_bitmap_reload() should only happen during the postcopy
> >>> recovery, and when that happens the VM should be stopped on both
> >>> sides.  Which means, ram resizing should not trigger there...
> >>
> >> But that guest got the chance to run for a bit and eventually reboot
> >> AFAIK. Also, there are other data races possible when used_length
> >> suddenly changes, this is just the most obvious one where things will;
> >> get screwed up.
> >=20
> > Right, the major one could be in ram_load_postcopy() where we call
> > host_from_ram_block_offset().  However if FW extension is the major
> > use case then it seems to still work (still better than crashing,
> > isn't it? :).
>=20
> "Let's close our eyes and hope it will never happen" ? :) No, I don't
> like that. This screams for a better solution long term, and until then
> a proper fencing IMHO. We're making here wild guesses about data races
> and why they might not be that bad in certain cases (did I mention
> load/store tearing? used_length is not an atomic value ...).

Yeah fencing is good, but crashing a VM while it wasn't going to crash
is another thing, imho.  You can dump an error message if you really
like, but instead of exit() I really prefer we either still let the
old way to at least work or really fix it.

When I say "really fix it", I mean we can even start to think about
the shrinking case and how to support that for postcopy.  For example,
in the above case host_from_ram_block_offset() will return NULL then,
and the fix could be that we drop that extra page because we don't
need that any more, instead of bailing out.

Thanks,

--=20
Peter Xu


