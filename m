Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025B7C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC442168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPWjKNvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC442168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37295 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ykk-0004kK-V9
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2Yk7-0004Il-4O
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2Yk5-0000QM-1c
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:02:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40944
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2Yk4-0000NL-QS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581678159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ua3uSJApCUcG4F6j+XKqOrkCwLtjA120cKKRVsRESwM=;
 b=jPWjKNvgORL12km4R4UGQMoo8dIWumMgtuyWz0BSy1DhLl1GDKoiLXLDdnC2OFtOUGq/NV
 9MlDtDRRBuR2QooaBOIVG60m8vHCcAICIgiL1iuCEnB+mVF33W2ObehaBV2DnMDB4l0pOp
 z9tHhbEkxsjOUelKUZUbHG+LYgz4e+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-koJL5pyzNsaxYvYBq83Teg-1; Fri, 14 Feb 2020 06:02:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AF9E100550E;
 Fri, 14 Feb 2020 11:02:36 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BEAA60BE2;
 Fri, 14 Feb 2020 11:02:28 +0000 (UTC)
Date: Fri, 14 Feb 2020 11:02:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214110226.GD3283@work-vm>
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: koJL5pyzNsaxYvYBq83Teg-1
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
> On 14.02.20 11:42, Dr. David Alan Gilbert wrote:
> > * David Hildenbrand (david@redhat.com) wrote:
> >> On 14.02.20 11:25, Dr. David Alan Gilbert wrote:
> >>> * David Hildenbrand (david@redhat.com) wrote:
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
> >>>>
> >>>> I see no easy way to work around this. Fail hard instead of failing
> >>>> somewhere in migration code due to strange other reasons. AFAIKs, th=
e
> >>>> rebuilts will be triggered during reboot, so this should not affect
> >>>> running guests, but only guests that reboot at a very bad time and
> >>>> actually require size changes.
> >>>>
> >>>> Let's further limit the impact by checking if an actual resize of th=
e
> >>>> RAM (in number of pages) is required.
> >>>>
> >>>> Don't perform the checks in qemu_ram_resize(), as that's called duri=
ng
> >>>> migration when syncing the used_length. Update documentation.
> >>>
> >>> Interesting; we need to do something about this - but banning resets
> >>> during migration is a bit harsh; and aborting the source VM is really
> >>> nasty - for a precopy especially we shouldn't kill the source VM,
> >>> we should just abort the migration.
> >>
> >> Any alternative, easy solutions to handle this? I do wonder how often
> >> this will actually trigger in real life.
> >=20
> > Well it's not that hard to abort a migration (I'm not sure we've got a
> > convenient wrapper to do it - but it shouldn't be hard to add).
> >=20
>=20
> We do have qmp_migrate_cancel(). I hope that can be called under BQL.

Well it's a monitor command so I think so; although it's not really
designed for an error - it's a user action.  Doing a
migrate_set_error(..) followed by a qemu_file_shutdown is probably a
good bet.

> Can that be called in both, precopy and postcopy case? I assume in the
> precopy, it's easy.

The problem is during postcopy you're toast when that happens because
you can't restart; however, can this happen once we're actually in
postcopy?  It's a little different - if it happens before the transition
to postcopy then it's the same as precopy; if it happens afterwards..
well it's going to happen ont he destination side and that's quite
different.

Dave

>=20
> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


