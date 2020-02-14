Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A8C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C0A206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7jMjOoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C0A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2YRX-00078p-Ga
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2YQo-0006hY-7I
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2YQm-0002x7-VA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:42:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2YQm-0002uc-PJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581676963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlCVf9RuC0nOiTCR8QIIDK5IOe6P17qPwcF3yj0Pe3g=;
 b=G7jMjOoKz0F/GiikYLREQIlIxlbGzAfAlEHugzJG08ep7B/M5h5QrGnsI1byKIy3My9Gkf
 stwfLPFYTnyuIJDTSZahaFZZ4ppNO6b/YvLJFutrJe6uE9yx4WHr8ChlsVFoXd3joMoQ60
 oLsOcI977NjCRL4HuK5r6f0w68nWvXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-5_cNBrm9Nxq5i-1pYG9JdQ-1; Fri, 14 Feb 2020 05:42:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CFB1100DFC5;
 Fri, 14 Feb 2020 10:42:40 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C4715C115;
 Fri, 14 Feb 2020 10:42:32 +0000 (UTC)
Date: Fri, 14 Feb 2020 10:42:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214104230.GC3283@work-vm>
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
MIME-Version: 1.0
In-Reply-To: <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5_cNBrm9Nxq5i-1pYG9JdQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 14.02.20 11:25, Dr. David Alan Gilbert wrote:
> > * David Hildenbrand (david@redhat.com) wrote:
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
> >>
> >> I see no easy way to work around this. Fail hard instead of failing
> >> somewhere in migration code due to strange other reasons. AFAIKs, the
> >> rebuilts will be triggered during reboot, so this should not affect
> >> running guests, but only guests that reboot at a very bad time and
> >> actually require size changes.
> >>
> >> Let's further limit the impact by checking if an actual resize of the
> >> RAM (in number of pages) is required.
> >>
> >> Don't perform the checks in qemu_ram_resize(), as that's called during
> >> migration when syncing the used_length. Update documentation.
> >=20
> > Interesting; we need to do something about this - but banning resets
> > during migration is a bit harsh; and aborting the source VM is really
> > nasty - for a precopy especially we shouldn't kill the source VM,
> > we should just abort the migration.
>=20
> Any alternative, easy solutions to handle this? I do wonder how often
> this will actually trigger in real life.

Well it's not that hard to abort a migration (I'm not sure we've got a
convenient wrapper to do it - but it shouldn't be hard to add).

> >=20
> > The other thing that worries me is that acpi_build_update calls
> >    acpi_ram_update->memory_region_ram_resize
> > multiple times.
>=20
> It's different memory regions, no? table_mr, rsdp_mr, linker_mr.

Oh, so it is.

> > So, it might be that the size you end up with at the end of
> > acpi_build_update is actually the same size as the original - so
> > the net effect is the RAMBlock didn't really get resized.
>=20
> Are you sure?

No!
Avocado has a migration+reset test, so it's worth trying.
Certainly in a cloud setup migrations happen often and no one knows
what the guest is doing;  aborting the source isn't acceptable.

It surprises me a bit that the region sizes would change due to guest
actions - I thought they were determined by the set of virtual hardware;
not sure if a hot-unplug/plug followed by reset would trigger it or not.

Dave

>=20
> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


