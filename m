Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4B7C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9803D20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1KOgJvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9803D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyrWs-0005pE-P8
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 01:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyrW5-0005QR-Sr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyrW3-0001ub-Te
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:16:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyrW3-0001pv-HY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580797014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=nPNphcsFfpOPkbjI7mRdEurkvu2+BLbpS3usTYZoYY0=;
 b=i1KOgJvjPoS4eEuzBhLcAoxEHPkbYMX9kbB2V0LamVb9WqW9bIxOFuoqU2whN41erof0zj
 Vo58nubV3Pp1LasTU0kBJ8hIhSYu0O3kk1al+sHMgmXdvTHIYni7hZOjwnwO1Hr2eoUcBm
 QKJLPSfbwIhh5ut7dgvzd8E/Z+sH9o0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-eNzkYEBxMfuuoghCUs3Ifw-1; Tue, 04 Feb 2020 01:16:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFD91DB23;
 Tue,  4 Feb 2020 06:16:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-39.ams2.redhat.com [10.36.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E9A90F4D;
 Tue,  4 Feb 2020 06:16:47 +0000 (UTC)
Subject: Re: VW ELF loader
To: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
Date: Tue, 4 Feb 2020 07:16:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eNzkYEBxMfuuoghCUs3Ifw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/02/2020 00.26, Paolo Bonzini wrote:
>=20
>=20
> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru
> <mailto:aik@ozlabs.ru>> ha scritto:
>=20
>     Speaking seriously, what would I put into the guest?
>=20
> Only things that would be considered drivers. Ignore the partitions
> issue for now so that you can just pass the device tree services to QEMU
> with hypercalls.
>=20
>     Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another SLOF,
>     smaller but adhoc with only a couple of people knowing it.
>=20
>=20
> You can generalize and reuse the s390 code. All you have to write is the
> PCI scan and virtio-pci setup.

Well, for netbooting, the s390-ccw bios uses the libnet code from SLOF,
so re-using this for a slim netboot client on ppc64 would certainly be
feasible (especially since there are also already virtio drivers in SLOF
that are written in C), but I think it is not very future proof. The
libnet from SLOF only supports UDP, and no TCP. So for advanced boot
scenarios like booting from HTTP or even HTTPS, you need something else
(i.e. maybe grub is the better option, indeed).

 Thomas


