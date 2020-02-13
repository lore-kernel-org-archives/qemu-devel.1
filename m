Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A262C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CD020848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhChxU2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CD020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2LYC-0000P5-C0
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2LXR-0008Lz-QO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2LXQ-0000jr-1r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:56:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2LXP-0000eI-Sp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581627402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap30mZ97gP15a6U01OPnLER+dBPFMwjQe00TpcBbGys=;
 b=WhChxU2iOzmMfO7HygR3NvhsCn1xrP7h2BzNIwKqfigMJTP2Bt5zcbLQYI888B9mX+7c6f
 G/VC73K1Bzuj56zuoaWp24Rc7A5ZGOEH4x155jWabVVSCvSGk0lJZ3pVUjrJ/3hpGIJTxw
 s4BlDkbyhS4MfyPFPGD3hYKR0d3w7LE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-gJnWYySKPum4aRM5p9gW3g-1; Thu, 13 Feb 2020 15:56:41 -0500
Received: by mail-qk1-f199.google.com with SMTP id o185so4570540qke.21
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 12:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Paz7QgpWjjS+o+8EToccGSVCZ1VnodiEDyCB2yLmgL0=;
 b=oab6tWbK5DRjMPIUukof+T2gyDi+t7L+TR8QXM1Ebvqe5jFl+zAWeGGWMH2eG41z/q
 TjO4E3uxMwazSrx33SxKmfs/wsKAQinFZaZNrbikHLjyZ9jL3iW+dEbhPeGddU0M7e6w
 w/pZratSyMg3QBKfOmHDQka3dB+R2VkDd8KCbIo8LvMFT40Zq0tqZT1zi4p2HxOiKrDL
 jl4BQoq4Yy4jZFE5UA2qv3Oi/T/DynptKoa0dYsFaumUbjuMlt7tXzpi8CYPGGVbA25v
 4xrKNY1gV/7gBd3GNke5SNykaNk5onxMahm5MwGuftr9WuheXO5slSh1O/yFq3NCHrFL
 /75Q==
X-Gm-Message-State: APjAAAXz6iEHaUaJj1b2DzTgU9ofR4ZhBcaZDRFeTeI8Xqf71pYs6SHH
 A3Q61DzibeMtQPnKkX5v4JyB1gi2Ie2DqcY+t843izfGTyWxkf1TWtJ5Cv7M5TJmnkiyFAosUx8
 3+JR6rHFiDu7sfKA=
X-Received: by 2002:a0c:a910:: with SMTP id y16mr13383975qva.139.1581627400391; 
 Thu, 13 Feb 2020 12:56:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVFT7M2JKlbnABBs1QaOxpQI1MGl1ytpAGhPseDua1mge1jafsQdn98fs+2L496DkPWdwOpg==
X-Received: by 2002:a0c:a910:: with SMTP id y16mr13383961qva.139.1581627400088; 
 Thu, 13 Feb 2020 12:56:40 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id w2sm2138305qtd.97.2020.02.13.12.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 12:56:39 -0800 (PST)
Date: Thu, 13 Feb 2020 15:56:36 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200213205636.GE1103216@xz-x1>
References: <20200213172016.196609-1-david@redhat.com>
 <20200213183221.GD1103216@xz-x1>
 <97821f63-bfdc-6342-bb8d-3d2b89c809fc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <97821f63-bfdc-6342-bb8d-3d2b89c809fc@redhat.com>
X-MC-Unique: gJnWYySKPum4aRM5p9gW3g-1
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

On Thu, Feb 13, 2020 at 08:42:23PM +0100, David Hildenbrand wrote:
> On 13.02.20 19:32, Peter Xu wrote:
> > On Thu, Feb 13, 2020 at 06:20:16PM +0100, David Hildenbrand wrote:
> >> Resizing while migrating is dangerous and does not work as expected.
> >> The whole migration code works on the usable_length of ram blocks and =
does
> >> not expect this to change at random points in time.
> >>
> >> Precopy: The ram block size must not change on the source, after
> >> ram_save_setup(), so as long as the guest is still running on the sour=
ce.
> >>
> >> Postcopy: The ram block size must not change on the target, after
> >> synchronizing the RAM block list (ram_load_precopy()).
> >>
> >> AFAIKS, resizing can be trigger *after* (but not during) a reset in
> >> ACPI code by the guest
> >> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> >> - hw/i386/acpi-build.c:acpi_ram_update()
> >=20
> > What can be the pre-condition of triggering this after reset?  I'm
> > thinking whether QEMU can be aware of this "resizing can happen"
> > condition, then we could simply stop the migration from happening even
> > before the resizing happens.  Thanks,
>=20
> I think the condition is not known before the guest actually tries to
> read the relevant memory areas (which trigger the rebuilt+resize, and
> AFAIK, the new size depends on fw config done by the guest after the
> reset). So it's hard to "predict".

I chimmed in without much context, sorry if I'm going to ask naive
questions. :)

What I was asking is about why the resizing can happen.  A quick read
told me that it was majorly for easier extension of ROMs (firmware
updates?).  With that, I'm imaging a common case for memory
resizing...

  (1) Source QEMU runs VM on old host, with old firmware

  (2) Migrate source QEMU to destination new host, with new and bigger
      firmware

  (3) During the migration, the ROM size on the destination will still
      be the old, referring to ram_load_precopy(), as long as no
      system reset

  (4) After migration finished, when the system reboots, memory
      resizing happens with the new and bigger firmware loaded

And is this patch trying to fix/warn when there's a reboot during (3)
so the new size is discovered at a wrong time?  Is my understanding
correct?

>=20
> In the precopy case it would be easier to abort (although, not simple
> AFAIKS), in the postcopy not so easy - because you're already partially
> running on the migration target.

Prior to this patch, would a precopy still survive with such an
accident (asked because I _feel_ like migrating a ramblock with
smaller used_length to the same ramblock with bigger used_length seems
to be fine?)?  Or we can stop the precopy and restart.  After this
patch, it'll crash the source VM (&error_abort specified in
memory_region_ram_resize()), which seems a bit more harsh?

Thanks,

--=20
Peter Xu


