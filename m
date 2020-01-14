Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E098FC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DB8222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDkQc8Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DB8222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNbS-00028T-IW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1irNa2-0000VG-MV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1irNZz-0005hh-3x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:54:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mrezanin@redhat.com>) id 1irNZy-0005fn-UV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579013642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKgigP54SL43CtyF/jAhJ4IH5ElgPPlLuQnne56miYk=;
 b=FDkQc8UnmR2jVHyFj5oPgvZDG7peTjEOE3jrJM8TDRCFNlNwP5Vz91/WViZk2KDhnm5fUP
 NfMt0aJYDugZM9HT1qiPjffWK4DKE2Z81xf+rlAgvXM7fJ6NQxvUEjWLZzPPdzDJ5jQsfM
 wLdcLzUsOf+HvCcoAeU7aKiEgbq/vUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42--42MYvS5OHuC9gXXGJxkFw-1; Tue, 14 Jan 2020 09:52:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3F67107ACFA;
 Tue, 14 Jan 2020 14:52:41 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAB6119756;
 Tue, 14 Jan 2020 14:52:41 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 98CE9845C1;
 Tue, 14 Jan 2020 14:52:41 +0000 (UTC)
Date: Tue, 14 Jan 2020 09:52:41 -0500 (EST)
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1592123957.1925031.1579013561355.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA_Y83T1n6q6sJoc9JSDGGqtGbnaAJuavuBon5rTepxw=Q@mail.gmail.com>
References: <20190828093447.12441-1-thuth@redhat.com>
 <CAFEAcA_Y83T1n6q6sJoc9JSDGGqtGbnaAJuavuBon5rTepxw=Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Do not hard-code the name of the
 QEMU binary
MIME-Version: 1.0
X-Originating-IP: [10.40.206.14, 10.4.195.28]
Thread-Topic: qemu-doc: Do not hard-code the name of the QEMU binary
Thread-Index: QTov8JH60cuqWORDfotTjj9Yqee8ew==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -42MYvS5OHuC9gXXGJxkFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Thomas Huth" <thuth@redhat.com>
> Cc: "QEMU Developers" <qemu-devel@nongnu.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "QEMU Trivial"
> <qemu-trivial@nongnu.org>, "Miroslav Rezanina" <mrezanin@redhat.com>, "Eduardo Habkost" <ehabkost@redhat.com>,
> "Qemu-block" <qemu-block@nongnu.org>, "Richard Henderson" <rth@twiddle.net>
> Sent: Tuesday, January 14, 2020 3:34:22 PM
> Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Do not hard-code the name of the QEMU binary
> 
> On Wed, 28 Aug 2019 at 10:37, Thomas Huth <thuth@redhat.com> wrote:
> >
> > In our documentation, we use a mix of "$QEMU", "qemu-system-i386" and
> > "qemu-system-x86_64" when we give examples to the users how to run
> > QEMU. Some more consistency would be good here. Also some distributions
> > use different names for the QEMU binary (e.g. "qemu-kvm" in RHEL), so
> > providing more flexibility here would also be good. Thus let's define
> > some variables for the names of the QEMU command and use those in the
> > documentation instead: @value{qemu_system} for generic examples, and
> > @value{qemu_system_x86} for examples that only work with the x86
> > binaries.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  docs/qemu-block-drivers.texi |  72 ++++++++++----------
> >  docs/qemu-cpu-models.texi    |  10 +--
> >  qemu-doc.texi                |  81 +++++++++++-----------
> >  qemu-options.hx              | 128 +++++++++++++++++------------------
> >  4 files changed, 149 insertions(+), 142 deletions(-)
> >
> > diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> > index c02547e28c..2c7ea49c32 100644
> > --- a/docs/qemu-block-drivers.texi
> > +++ b/docs/qemu-block-drivers.texi
> > @@ -2,6 +2,8 @@
> >  QEMU block driver reference manual
> >  @c man end
> >
> > +@set qemu_system qemu-system-x86_64
> > +
> >  @c man begin DESCRIPTION
> >
> >  @node disk_images_formats
> > @@ -405,7 +407,7 @@ QEMU can automatically create a virtual FAT disk image
> > from a
> >  directory tree. In order to use it, just type:
> >
> >  @example
> > -qemu-system-i386 linux.img -hdb fat:/my_directory
> > +@value{qemu_system} linux.img -hdb fat:/my_directory
> >  @end example
> 
> Do you use the ability to change the text being substituted
> here downstream ? If so, heads-up that I'm working on a
> conversion of this texi file to rst. I'll put in a
> similar rst substitution-reference, which will look like
> this:
> 
> .. |qemu_system| replace:: qemu-system-x86_64
> 
> but you'll need to update your downstream processes if
> you're changing the value in the texi currently.
> 

Yes we are using it and it make our changes much more simple.

Mirek

> thanks
> -- PMM
> 
> 

-- 
Miroslav Rezanina
Software Engineer - Virtualization Team Maintainer


