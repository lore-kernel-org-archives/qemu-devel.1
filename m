Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD13EC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33B120663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwYSdz8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33B120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGL7M-0001Ze-Qv
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mtosatti@redhat.com>) id 1jGL6n-0001B9-Le
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1jGL6m-0001XB-Jc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:19:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58743)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1jGL6m-0001X3-FU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584962344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6iz++xDyWIMkLvemm1M+2robOQPUjlgI3SUvSgLd7o=;
 b=EwYSdz8ZWZEGk5SgUgcUVDnEav+YQaHvMqO/s+Ap8N+K/wTAW4rSEGspaYFEewLutvc/5S
 Wvk6UWQ84vFcZMmB4XdOJcrTsV+BBMWX7Dyvt8xxeSw315PplQDRjXEqtwHm+5waO5w6aX
 EwaUv2S3V7MAhETVzrMCAolPM0p2pOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-dywiY5z6ONeRnMNNQgVxNg-1; Mon, 23 Mar 2020 07:17:57 -0400
X-MC-Unique: dywiY5z6ONeRnMNNQgVxNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6420010CE78A;
 Mon, 23 Mar 2020 11:17:56 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9B3810027AF;
 Mon, 23 Mar 2020 11:17:52 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
 id 7EE8F418CC0C; Mon, 23 Mar 2020 08:04:52 -0300 (-03)
Date: Mon, 23 Mar 2020 08:04:52 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
Message-ID: <20200323110452.GA14031@fuller.cnet>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <20200319114424.5723e777@office.mammed.net>
 <4d42697e-ba84-e5af-3a17-a2cc52cf0dbc@redhat.com>
 <20200319160800.614de5fb@redhat.com>
 <d6c0dc2f-5b0f-2e34-6c12-e9d9cd7402c6@redhat.com>
 <3f70d63d-e9ae-6676-edd5-20613b4b8856@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3f70d63d-e9ae-6676-edd5-20613b4b8856@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 09:05:06AM +0100, Paolo Bonzini wrote:
> On 22/03/20 17:27, Philippe Mathieu-Daud=E9 wrote:
> >>>
> >> That 'ugly' is typically used within QEMU to deal with such things
> >> probably due to its low complexity.
> >=20
> > OK. Can you point me to the documentation for this feature? I can find
> > reference of GPE in the ICH9, but I can't find where this IO address on
> > the PIIX4 comes from:
> >=20
> > #define GPE_BASE 0xafe0
>=20
> It's made up.  The implementation is placed in PIIX4_PM because it is
> referenced by the ACPI tables.  Real hardware would probably place this
> in the ACPI embedded controller or in the BMC.
>=20
> Paolo

Yes, there was nothing at 0xafe0 at the time ACPI support was written.


