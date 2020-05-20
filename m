Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AB2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A18A207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjUVHqat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A18A207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQ8C-0002YQ-Dp
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbQ7A-0001Dr-89
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:54:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbQ79-00044A-Hk
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589986474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gxR9wrBePD9HaKzYcUSypT0/jp3PBnMeuYGfT3cdJI=;
 b=YjUVHqaty7mGyIPRt07RgngQLBUMbQRk/zUGnCb50aG3wEpa1QjKA4t5nzpRNvbLe6hGQn
 OJGV68r4z088lc3mT37+vNoYwxcRRhhhDuZvKw4OHLkZVVBwKI3QATZQzAtrS100Ga6i3i
 0Scy7F2H1FA6W+21gXpEZRusfotK+gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416--HweE70ZOGmjWvjbSt-3_Q-1; Wed, 20 May 2020 10:54:33 -0400
X-MC-Unique: -HweE70ZOGmjWvjbSt-3_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38CF7EC1B4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 14:54:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0801C60C05;
 Wed, 20 May 2020 14:54:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8700B11358BC; Wed, 20 May 2020 16:54:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 40/55] hw/arm/armsse: Pass correct child size to
 sysbus_init_child_obj()
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-41-armbru@redhat.com>
 <cf2296d8-13dd-8a6a-2d12-5d852ef8d3e8@redhat.com>
Date: Wed, 20 May 2020 16:54:30 +0200
In-Reply-To: <cf2296d8-13dd-8a6a-2d12-5d852ef8d3e8@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 20 May 2020 13:51:56
 +0200")
Message-ID: <87pnaypsgp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/19/20 4:55 PM, Markus Armbruster wrote:
>> armsse_init() initializes s->armv7m[i] for all i.  It passes the size
>> of the entire array instead of the array element to
>> sysbus_init_child_obj().  Harmless, but fix it anyway.
>
> Harmless because the size used to initialize the object is the one
> declared by its TypeInfo::instance_size. In this case for TYPE_ARMV7M
> it is:
>
> static const TypeInfo armv7m_info =3D {
>     .name =3D TYPE_ARMV7M,
>     .parent =3D TYPE_SYS_BUS_DEVICE,
>     .instance_size =3D sizeof(ARMv7MState),

Yes.  object_initialize_with_type() checks @size is at least
.instance_size, and writes only up to .instance_size.

> How did you notice btw?

Transform the common, obviously sane patterns with Coccinelle, examine
the untransformed remainder.  I found quite a few the bugs this way.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!


