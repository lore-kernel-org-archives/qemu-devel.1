Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4AAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748B620732
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf+j82Iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748B620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8sqv-0001DI-LP
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j8sqJ-0000mo-2b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j8sqI-0007sh-4y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:43:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j8sqI-0007sR-1Y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583185393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbRzsVW3LB5oagdbdu+12w637SV9/gGraO/FspF9z64=;
 b=Uf+j82IvjVejtRiasTHyCWcHwBkl1qtFxSq0JWkgH8ucFUrRb8bzcHoD7rYL72LR6PInQ+
 /xsSzPcvSAlNa1Fg0+Tcyf8MEUxcSiD0e4gkTPTXWTxpYPhHW7VAAV/xONwUdiVc9K1v2R
 2K03uC0ojPw8CwCJqPyildF7iaokMbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-V_Jb18SRN7S544ZzsmAqcQ-1; Mon, 02 Mar 2020 16:43:02 -0500
X-MC-Unique: V_Jb18SRN7S544ZzsmAqcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF825800D4E;
 Mon,  2 Mar 2020 21:43:00 +0000 (UTC)
Received: from localhost (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE54A90CF6;
 Mon,  2 Mar 2020 21:43:00 +0000 (UTC)
Date: Mon, 2 Mar 2020 16:42:59 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: CPU reset vs DeviceState reset
Message-ID: <20200302214259.GP4440@habkost.net>
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
 <20200302174551.GK4440@habkost.net>
 <c73a059c-6d6f-607d-0cdb-fbc515b45edf@redhat.com>
 <CAFEAcA-GwNG0rvw3gVZMs2Nz05FUjzoiT-H+-FkwQAZzgC2tAw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-GwNG0rvw3gVZMs2Nz05FUjzoiT-H+-FkwQAZzgC2tAw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 06:42:18PM +0000, Peter Maydell wrote:
> On Mon, 2 Mar 2020 at 18:19, Philippe Mathieu-Daud=E9 <philmd@redhat.com>=
 wrote:
> > Without verifying the code base/commits, my understanding is that was
> > required to use cpu object with linux-user before Markus added support
> > for anonymous object container for QOM objects on linux-user. So now we
> > could make CPUClass inherits of DeviceClass.
>=20
> CPUClass already does inherit from DeviceClass...

When CPUClass::reset was created, it didn't.  See commit
dd83b06ae61c ("qom: Introduce CPU class").

The "historical legacy" hypothesis seems accurate.

--=20
Eduardo


