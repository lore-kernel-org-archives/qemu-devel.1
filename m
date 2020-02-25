Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E0AC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C5A21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgBALMUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C5A21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cpV-0005gM-Ss
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6cnp-0004KW-7P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6cnn-000129-Tm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:11:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6cnn-0000zK-BJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582647077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEnWpP9+2hlpWb7lBAm1eGqScW8EvNNIntNHjO7o6Nk=;
 b=CgBALMUlY2RlQGkQi3augZIt5zdUyhzlLrHVA/8gLiilSMpGL7HUQn60yHNaKxQtMTzlQl
 fKKWDWn0r8BETv6rA4pW8/Aa7F40NcTIujgkc0Zr6718LwNh9a3zJbpmNa2p6NJ+2jg9BS
 4s4TQVkFgS5xd8Xg8T9dzNPGw5R+ZzI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-7Evn9FVYPaW7QmhDuZkabQ-1; Tue, 25 Feb 2020 11:11:15 -0500
X-MC-Unique: 7Evn9FVYPaW7QmhDuZkabQ-1
Received: by mail-qk1-f200.google.com with SMTP id 133so10494754qkn.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=liXdliBkhc73MwDcLRKDFgh4yQ98lb5ccEFdOL5Rn78=;
 b=UXfc+r9vAUgoNuDEizNkJBjFgR5yISuKI7sv/Zc8639dQPcZBfmNxGlRrd3QyZ/t2C
 KaMmp7wByArA7cRe1zsVGEO83xIsQHo0Q2Ua+n8Evv5i4S1WO1NLkDraxMpcdRrLoR4b
 KrqIWHK/PTV9N3wXuNNV7nT/hwuoGWh6o5YC+vHlXbR2OVIzNp7hVtPpmej6XB/GPLN+
 HN19lhEDHYDrsNvstwwfmcU/PeyQMHVlngjuVIhwP1BusSmLVd0QNKdPuGJCx7eAsyXc
 kNx9knARpU0qJb8MPJFDbJiI/t6NVE9vwVQy9pfPtCexFHO38SFB8AtiA4N0XDSahGeM
 rLYg==
X-Gm-Message-State: APjAAAUBMMpT/nrynYfI9LCy9o8fQQVkXObmSsC6E4Tkqsq0O7ocZPJH
 KQTjCharSesnTiaULJT74OIrsXwJk0ufhoFJXXZqF9KpuBgVM48ZWmlplIsndOn5mcZ6cKgxCmK
 biHG1EmIXUD1mwGM=
X-Received: by 2002:a05:620a:4e:: with SMTP id
 t14mr59663472qkt.396.1582647075025; 
 Tue, 25 Feb 2020 08:11:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpEAdtstnjaO/swcpD8Qqukk/VLFYYCOqd22utf8lOdF8Frs+n0bEqVUldJAtq0mZK6pcaLg==
X-Received: by 2002:a05:620a:4e:: with SMTP id
 t14mr59663443qkt.396.1582647074799; 
 Tue, 25 Feb 2020 08:11:14 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id z6sm7568039qka.34.2020.02.25.08.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 08:11:13 -0800 (PST)
Date: Tue, 25 Feb 2020 11:11:12 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 10/13] migration/ram: Handle RAM block resizes during
 postcopy
Message-ID: <20200225161112.GA132133@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-11-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221164204.105570-11-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 05:42:01PM +0100, David Hildenbrand wrote:
> Resizing while migrating is dangerous and does not work as expected.
> The whole migration code works on the usable_length of ram blocks and doe=
s
> not expect this to change at random points in time.
>=20
> In the case of postcopy, relying on used_length is racy as soon as the
> guest is running. Also, when used_length changes we might leave the
> uffd handler registered for some memory regions, reject valid pages
> when migrating and fail when sending the recv bitmap to the source.
>=20
> Resizing can be trigger *after* (but not during) a reset in
> ACPI code by the guest
> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> - hw/i386/acpi-build.c:acpi_ram_update()
>=20
> Let's remember the original used_length in a separate variable and
> use it in relevant postcopy code. Make sure to update it when we resize
> during precopy, when synchronizing the RAM block sizes with the source.
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Shannon Zhao <shannon.zhao@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


