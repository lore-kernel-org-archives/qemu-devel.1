Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9C4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4881C21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew6wkgkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4881C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhN2-0003Fo-Ef
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izhLw-0001td-D0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izhLv-0006VS-CX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:37:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izhLv-0006TV-8S
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580996274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hae5PYKk+AjoFBIxQ3ZfcWV6vduRxZUs5/edxsxEqUI=;
 b=Ew6wkgkqRhYX6UGASLB5FHNT/bYwuWVmWVLLR2XlWTtAB6ywz7fr4BysUrlgGiETj6Zira
 oeTC1fwyleCHuR5Su6P/r4BfiJyz7WU20jtJN3ArqOtjd2WMw1jqLL5VlFVznETGcYIgwX
 fFfjC+XLLRjKsTmQBw9uvt1OL7Tin94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-HbbyZbNCOZmzgAzNZ_DD2w-1; Thu, 06 Feb 2020 08:37:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EFE792211;
 Thu,  6 Feb 2020 13:37:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2FAB100032E;
 Thu,  6 Feb 2020 13:37:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 75B779D7F; Thu,  6 Feb 2020 14:37:48 +0100 (CET)
Date: Thu, 6 Feb 2020 14:37:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
Message-ID: <20200206133748.rs3ocu4jf3lorvdj@sirius.home.kraxel.org>
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
 <CAFEAcA_8-0wqQX8KEK_zFRufoaEQkaeaXu4DLx08KazxTZ5fxQ@mail.gmail.com>
 <1686aa04-0dc8-c08b-bdee-565979f19023@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1686aa04-0dc8-c08b-bdee-565979f19023@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HbbyZbNCOZmzgAzNZ_DD2w-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 09:38:39PM +0100, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2020-02-03 11:00, Peter Maydell wrote:
> > On Sun, 2 Feb 2020 at 19:39, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.=
ice.hu@gmail.com> wrote:
> > >=20
> > > This adds proper support for float samples in mixeng by adding a new
> > > audio format for it.
> > >=20
> > > Limitations: only native endianness is supported.
> >=20
> > Could you explain a bit more what this limitation means, please?
> > In general QEMU behaviour shouldn't depend on the endianness
> > of the host, ie we should byteswap where necessary.
>=20
> None of the virtual sound cards support float samples (it looks like most=
 of
> them only support 8 and 16 bit, only hda supports 32 bit), it is only use=
d
> for the audio backends (i.e. host side).

Queued patch & added this to the commit message.

thanks,
  Gerd


