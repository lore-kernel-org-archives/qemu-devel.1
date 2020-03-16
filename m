Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1047C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 06:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B042720663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 06:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ+GM5By"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B042720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDjFh-0004Ul-I4
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 02:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDj9r-0003mp-El
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDj9o-000054-Or
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:23:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDj9o-0008NH-EI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584339803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+V2hK660HNV6UCkepU9E9k2ANFV0ky5fWjbRRTq9a4=;
 b=gZ+GM5ByF/8yDBo+cBarUgysqEWb8o3sa+vKBM3Kw8Ql5fFJpqTcDxhMoB51IyHQL3X2A3
 uNYBO0bzNgvLO1sF348ZW1WKBhS797Ri805oBdmiz6XOZKnB9w91odCFys1154+qvOAFqV
 n0qWF07WteH4IcvYOBKhWoS4w1zu+Fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-ju6oA4QKPlWzbZYjMaun3g-1; Mon, 16 Mar 2020 02:23:19 -0400
X-MC-Unique: ju6oA4QKPlWzbZYjMaun3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC6F1005509;
 Mon, 16 Mar 2020 06:23:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26CCB8FC17;
 Mon, 16 Mar 2020 06:23:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8475F1138404; Mon, 16 Mar 2020 07:23:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/8] hw/ide: Do ide_drive_get() within
 pci_ide_create_devs()
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <49bf646a9419c3b20125187a26f8a4fd5f35f399.1584134074.git.balaton@eik.bme.hu>
 <alpine.BSF.2.22.395.2003132307280.85181@zero.eik.bme.hu>
 <cb660aa6-6bb6-b75e-ebe3-8fc0e59fb1da@redhat.com>
Date: Mon, 16 Mar 2020 07:23:12 +0100
In-Reply-To: <cb660aa6-6bb6-b75e-ebe3-8fc0e59fb1da@redhat.com> (Paolo
 Bonzini's message of "Sat, 14 Mar 2020 11:01:29 +0100")
Message-ID: <87d09c3jjj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 philmd@redhat.com, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/03/20 23:16, BALATON Zoltan wrote:
>>>
>>> +=C2=A0=C2=A0=C2=A0 pci_dev =3D pci_create_simple(pci_bus, -1, "cmd646-=
ide");
>>> +=C2=A0=C2=A0=C2=A0 pci_ide_create_devs(pci_dev);
>>=20
>> Additionally, I think it may also make sense to move pci_ide_create_devs
>> call into the realize methods of these IDE controllers so boards do not
>> need to do it explicitely. These calls always follow the creation of the
>> device immediately so could just be done internally in IDE device and
>> simplify it further. I can attempt to prepare additional patches for
>> that but first I'd like to hear if anyone has anything against that to
>> avoid doing useless work.
>
> No, it's better to do it separately.  I think that otherwise you could
> add another IDE controller with -device, and both controllers would try
> to add the drives.

Correct.

Creating device frontends for -drive if=3Dide is the board's job.  Boards
may delegate to suitable helpers.  I'd very much prefer these helpers
not to live with device model code.  Board and device model code should
be cleanly separated to to reduce the temptation to muddle their
responsibilities.  It's separation of concerns.

I actually wish we had separate sub-trees for boards and devices instead
of keeping both in hw/.

> Basically, separating the call means that only automatically added
> controllers obey "if=3Dide".


