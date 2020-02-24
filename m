Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA8BC38BFF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C500D20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVY4Eadz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C500D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MNM-0004Tk-V4
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6MCK-0004qY-2i
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6MCI-0007yX-UN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:27:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34696
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6MCI-0007xc-PM
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582583247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SuNMBs7xqqezCKUcnHcxxQBl2nlkQ3oRp0J3zoy5uo=;
 b=NVY4EadzLnSIHxy95wV//xhd0ldHtgk4J1VNWVtZQVIUF6GbVCvNakM2Rt3hXgybLcdJLl
 fr9HqVzbzeDJk1IhxSu+XV38frijZTn3ufizz0P+LQupS082Z9eEbRg/NlPTbJcbDRMIzL
 9cqCZVvRvXck5EnLHDyaJMG59vmKmOY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-JHZb4uQ8OZKAZKcWmNhWbg-1; Mon, 24 Feb 2020 17:27:25 -0500
X-MC-Unique: JHZb4uQ8OZKAZKcWmNhWbg-1
Received: by mail-qv1-f71.google.com with SMTP id l1so10582329qvu.13
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uti38CYS7tX+GBqLDLshYm022Tw7iaJ3BeF6ZqS0HO4=;
 b=sWu8AkvmVv9xMqqy06I9bK4ZWwlqTL/QOHiHwDWtnObdYQkE8EJaxnavQLRf2hcfSD
 OYDu400qXrLZs+siiB30H1FrTENNJ4AO7vqktOLYCil0rIETP2q7+21VRQCqZMFvnq/8
 Nix/oPxL41kB8qynKrFJWsaVsk2LwFEsBQiEfe8Ca34x4H7JIMxMeGhBFAVVFiMr7nsF
 npGKaV3XGOnZ7vW1nyQUVKYvZjZwmOd8c8su8cJoYKtPWANTLc1EnYIaKEdeKCe8mqgh
 7up/h9dlscWFjpnRXwh/lnGIQi0eOE7Rhn6AB1oRDAUusa5JpG/jvMh1HjIICp/OH6Xz
 mvrw==
X-Gm-Message-State: APjAAAUnN/39EO2vQHcu1DWpt/LH4jF68zrH2GdOUK8sZ2A7VnYt7D7t
 pElLYdjw0td2RFjKxUjlREmNvjBeDN4MVueMhb7rILmSfRq0wbGJj7dx1tGn2beXEXZWQvuprjK
 Yvyz9K4wXaIpYl7Y=
X-Received: by 2002:a37:e0d:: with SMTP id 13mr36370050qko.145.1582583244978; 
 Mon, 24 Feb 2020 14:27:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuB8KLjh6A7Pv4D9YQjEldSSuyfggXMDbCb9c/IQ5R8WfyNxXe0LECDvdRznduBYbq3fb6Tg==
X-Received: by 2002:a37:e0d:: with SMTP id 13mr36370023qko.145.1582583244732; 
 Mon, 24 Feb 2020 14:27:24 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id v7sm6617276qkg.103.2020.02.24.14.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:27:24 -0800 (PST)
Date: Mon, 24 Feb 2020 17:27:22 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 05/13] migration/ram: Handle RAM block resizes during
 precopy
Message-ID: <20200224222722.GB113102@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-6-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221164204.105570-6-david@redhat.com>
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

On Fri, Feb 21, 2020 at 05:41:56PM +0100, David Hildenbrand wrote:
> Resizing while migrating is dangerous and does not work as expected.
> The whole migration code works on the usable_length of ram blocks and doe=
s
> not expect this to change at random points in time.
>=20
> In the case of precopy, the ram block size must not change on the source,
> after syncing the RAM block list in ram_save_setup(), so as long as the
> guest is still running on the source.
>=20
> Resizing can be trigger *after* (but not during) a reset in
> ACPI code by the guest
> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> - hw/i386/acpi-build.c:acpi_ram_update()
>=20
> Use the ram block notifier to get notified about resizes. Let's simply
> cancel migration and indicate the reason. We'll continue running on the
> source. No harm done.
>=20
> Update the documentation. Postcopy will be handled separately.
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


