Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE83DC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 19:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26D520656
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 19:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWBgtVD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26D520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Jsl-0001oE-Vh
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 14:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2Jrz-0001JT-T0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2Jrw-0004ds-V5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:09:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2Jrw-0004ac-Ot
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581620987;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TD/1DjpBRZBG9PQeyFQZrql99MccnY1E4dxyuL0vEl4=;
 b=AWBgtVD8gNd50dzgTCzWogzsgroZ1cYwwzD+n7q5Akc501Hb5bOyXMTr6qRoq6dfTPXBqE
 adyXF+lNr/eKYapILzqJSRfoRlJVifr+Fe0St1jKFitj2mCxs1Q6NQtsaK8pWr37BJQB0x
 sI1i3lccB8GXeb6rzuXSDGsJRCwVI3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-w24qH3UbOfSeKE6EA4hdew-1; Thu, 13 Feb 2020 14:09:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC8C11083E81;
 Thu, 13 Feb 2020 19:09:44 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 984A26031E;
 Thu, 13 Feb 2020 19:09:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
In-Reply-To: <20200213172016.196609-1-david@redhat.com> (David Hildenbrand's
 message of "Thu, 13 Feb 2020 18:20:16 +0100")
References: <20200213172016.196609-1-david@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 20:09:37 +0100
Message-ID: <877e0ql2xa.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: w24qH3UbOfSeKE6EA4hdew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> wrote:
> Resizing while migrating is dangerous and does not work as expected.
> The whole migration code works on the usable_length of ram blocks and doe=
s
> not expect this to change at random points in time.
>
> Precopy: The ram block size must not change on the source, after
> ram_save_setup(), so as long as the guest is still running on the source.
>
> Postcopy: The ram block size must not change on the target, after
> synchronizing the RAM block list (ram_load_precopy()).
>
> AFAIKS, resizing can be trigger *after* (but not during) a reset in
> ACPI code by the guest
> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> - hw/i386/acpi-build.c:acpi_ram_update()
>
> I see no easy way to work around this. Fail hard instead of failing
> somewhere in migration code due to strange other reasons. AFAIKs, the
> rebuilts will be triggered during reboot, so this should not affect
> running guests, but only guests that reboot at a very bad time and
> actually require size changes.
>
> Let's further limit the impact by checking if an actual resize of the
> RAM (in number of pages) is required.
>
> Don't perform the checks in qemu_ram_resize(), as that's called during
> migration when syncing the used_length. Update documentation.
>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Shannon Zhao <shannon.zhao@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---


>
> Any idea how to avoid killing the guest? Anything obvious I am missing?

If you avoid the resize, it should be ok for both precopy & postcopy.

But, as you point, if acpi guest is the one changing sizes, we are in
trouble.  But really, it makes exactly zero sense to reset during
migrate.  if we _could_ catch the reset, the "intelligent" thing to do
is:

- detect reset
- launch guest on destination from zero.

I.e. not migration at all.  This would be my "better" idea, but I have
no clue how to catch that kind of things in a sane way that works in
every architecture.

You get the:

Reviewed-by: Juan Quintela <quintela@redhat.com>

because:
- your code change makes sense
- the documentation update is good.

Thanks, Juan.


