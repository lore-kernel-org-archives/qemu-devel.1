Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D6C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90292086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUtyJvTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90292086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaahT-0002xU-Qf
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 02:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iaaJ1-0002Ew-QY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iaaIw-00061V-UA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:03:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iaaIw-0005vA-M6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575010981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2XHTASMnNH0Loh1s/hx6+fJsEOls944Fh9INrY8qw4=;
 b=TUtyJvTxKCpzWsHgJL764VhoRW5oM3GtrIXWbw4qLKGKs/UplUtydJjf2/J2co0jYlNefl
 7UMnxm+X8AO6x2ACUAoGE/l3ipYq6tHS5s7Kk8iuLzwZxzy3UJdBBNd9BXuepKzYLjqFbr
 rWI/5v2rtD3Bm8xfIA8PpMdgZ2fSK58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-_NtBWrDROSC-Cm2sKCRw1g-1; Fri, 29 Nov 2019 02:03:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CA5A107ACC4;
 Fri, 29 Nov 2019 07:02:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFDF95D6D4;
 Fri, 29 Nov 2019 07:02:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CB77D16E08; Fri, 29 Nov 2019 08:02:53 +0100 (CET)
Date: Fri, 29 Nov 2019 08:02:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128141518.628245-1-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _NtBWrDROSC-Cm2sKCRw1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, stefanha@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> Setting up shared memory for vhost-user is a bit complicated from
> command line, as it requires NUMA setup such as: m 4G -object
> memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -nu=
ma
> node,memdev=3Dmem.
>=20
> Instead, I suggest to add a -mem-shared option for non-numa setups,
> that will make the -mem-path or anonymouse memory shareable.

Is it an option to just use memfd by default (if available)?

cheers,
  Gerd


