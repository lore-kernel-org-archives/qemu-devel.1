Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05F6C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D4821774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrlINNi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D4821774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacgy-0001Zq-ON
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iacYv-0005b1-D5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iacYn-0003y4-Q4
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:27:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iacYn-0003j1-JY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575019650;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvwYi3qeNOYuPB96TaEF9Y2knAvGAJvAxt6qO8ovC3Q=;
 b=XrlINNi7Pzlyfm4d/sKr2edGdwjZ3EitVTKi4TdnrBX0kDVLVpISQmiNTTurNilCMuNJtn
 SSCo0Z2/5NtG45oKSOKEyaKGX99hbQ+141II2zPqT0P82VvV19MuExeHjGaADfJHMAuFVZ
 lGZAy9excLoeoEz+ehYrLOUTFkGHzI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1--xiIzvHSNIKlWgdjl2ABcw-1; Fri, 29 Nov 2019 04:27:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4004A107ACC4;
 Fri, 29 Nov 2019 09:27:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FAF35D9C5;
 Fri, 29 Nov 2019 09:27:16 +0000 (UTC)
Date: Fri, 29 Nov 2019 09:27:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129092713.GA2260471@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -xiIzvHSNIKlWgdjl2ABcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 11:30:51AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Nov 29, 2019 at 11:03 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi,
> > >
> > > Setting up shared memory for vhost-user is a bit complicated from
> > > command line, as it requires NUMA setup such as: m 4G -object
> > > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don=
 -numa
> > > node,memdev=3Dmem.
> > >
> > > Instead, I suggest to add a -mem-shared option for non-numa setups,
> > > that will make the -mem-path or anonymouse memory shareable.
> >
> > Is it an option to just use memfd by default (if available)?
>=20
> Yes, with a fallback path currently using a temporary file under /tmp
> (we may want to use shm_open() instead, or a different location such
> as XDG_RUNTIME_DIR? - and use O_TMPFILE)

We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is no
where near standard across all OS distros, and even if on tmpfs these
dirs can be size limited to a significant subset of available RAM. IOW
we can't safely use them unless explicitly told to.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


