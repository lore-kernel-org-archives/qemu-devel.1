Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CB1C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAA0206E1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJyBlLZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAA0206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsrg-0000BZ-2U
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ibsoo-0007Kt-3x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ibsol-0001hw-HQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:01:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20861
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ibsoj-0001fI-DQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575320467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6y/EuSSyYz1/XHfDFoP7Ofq/cY5irbE2G+NZwQHgWM=;
 b=YJyBlLZDPYG51Ri4ZRZrqKYJkQDMVk3GNqOq+3b70ZlI7VX9lBkNABs/ckT4UqAqykPyYm
 YbIynJ7FZiNgelUV9OsZyubdqf/5AsKrcMl8gNft5B0yTTx/NQxjVokpos3djc70BUdYM3
 9zSFsUapKJK3ZU1vkzjIjGzLOivp7iE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-oHR8nB7KM56PiFC7d2tXPg-1; Mon, 02 Dec 2019 16:01:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66F9A1005502;
 Mon,  2 Dec 2019 21:01:02 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB7910013A7;
 Mon,  2 Dec 2019 21:00:59 +0000 (UTC)
Date: Mon, 2 Dec 2019 18:00:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
Message-ID: <20191202210057.GQ14595@habkost.net>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128141518.628245-3-marcandre.lureau@redhat.com>
 <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
 <20191129110703.2b15c541@redhat.com>
 <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
 <20191129131652.6683b769@redhat.com>
 <528bb183-3d44-e541-8765-9c0e01f23157@redhat.com>
 <20191202083948.3e8bb134@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191202083948.3e8bb134@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: oHR8nB7KM56PiFC7d2tXPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 02, 2019 at 08:39:48AM +0100, Igor Mammedov wrote:
> On Fri, 29 Nov 2019 18:46:12 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> > On 29/11/19 13:16, Igor Mammedov wrote:
> > > As for "-m", I'd make it just an alias that translates
> > >  -m/mem-path/mem-prealloc =20
> >=20
> > I think we should just deprecate -mem-path/-mem-prealloc in 5.0.  CCing
> > Thomas as mister deprecation. :)
>=20
> I'll add that to my series

Considering that the plan is to eventually reimplement those
options as syntactic sugar for memory backend options (hopefully
in less than 2 QEMU releases), what's the point of deprecating
them?

--=20
Eduardo


