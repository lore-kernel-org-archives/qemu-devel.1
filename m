Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37138C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0609D20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONUApIrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0609D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHGG-0003sW-6B
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEHFJ-0002ww-6U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEHFG-0001Ky-Gh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:47:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEHFG-00019F-69
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584470837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hb/jeQrMCW50m/+UIP6st28TnpAt97WjUAjdWDevMeo=;
 b=ONUApIrZomnlpYoEqZ5n2x5+VYsw3pAMXwaUKLr9nfQw7WLAAyZaGOmxof/IZNWXfrahx5
 3TPF1D8PvecypAKiN5bPbvQPBDtDTsi/mO2AgGBJ29kuxpDnGamXJKvcWcbj+N+BwUqxq6
 ZQTgV40sNUf//J2GjPE1YtssWCNbxds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ZOQbi3LRPM-hrDooL8S4xw-1; Tue, 17 Mar 2020 14:47:12 -0400
X-MC-Unique: ZOQbi3LRPM-hrDooL8S4xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2230800D5C;
 Tue, 17 Mar 2020 18:47:11 +0000 (UTC)
Received: from work-vm (ovpn-114-234.ams2.redhat.com [10.36.114.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EB305E242;
 Tue, 17 Mar 2020 18:47:06 +0000 (UTC)
Date: Tue, 17 Mar 2020 18:47:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] tools/virtiofsd: add support for --socket-group
Message-ID: <20200317184704.GG3369@work-vm>
References: <20200312104142.21259-1-alex.bennee@linaro.org>
 <20200312104913.GB4089516@redhat.com>
 <CAJ+F1CJWy2gEHHjzqyqnvHFf6EP4mEGABLt4aA7xptkXDwPGiw@mail.gmail.com>
 <20200316103331.GC1528804@redhat.com>
 <20200317095414.GC492272@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200317095414.GC492272@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Mon, Mar 16, 2020 at 10:33:31AM +0000, Daniel P. Berrang=E9 wrote:
> > On Sat, Mar 14, 2020 at 02:33:25PM +0100, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >=20
> > > On Thu, Mar 12, 2020 at 11:49 AM Daniel P. Berrang=E9 <berrange@redha=
t.com> wrote:
> > > >
> > > > On Thu, Mar 12, 2020 at 10:41:42AM +0000, Alex Benn=E9e wrote:
> > > > > If you like running QEMU as a normal user (very common for TCG ru=
ns)
> > > > > but you have to run virtiofsd as a root user you run into connect=
ion
> > > > > problems. Adding support for an optional --socket-group allows th=
e
> > > > > users to keep using the command line.
> > > >
> > > > If we're going to support this, then I think we need to put it in
> > > > the vhost-user.rst specification so we standardize across backends.
> > > >
> > > >
> > >=20
> > > Perhaps. Otoh, I wonder if the backend spec should be more limited to
> > > arguments/introspection that are used by programs.
> > >=20
> > > In this case, I even consider --socket-path to be unnecessary, as a
> > > management layer can/should provide a preopened & setup fd directly.
> > >=20
> > > What do you think?
> >=20
> > I think there's value in standardization even if it is an option target=
ted
> > at human admins, rather than machine usage. You are right though that
> > something like libvirt would never use --socket-group, or --socket-path=
.
> > Even admins would benefit if all programs followed the same naming for
> > these.  We could document such options as "SHOULD" rather than "MUST"
> > IOW, we don't mandate --socket-group, but if you're going to provide a
> > way to control socket group, this option should be used.
>=20
> I agree.  It's still useful to have a convention that most vhost-user
> backend programs follow.

Alex:
  Can you add the doc entry that Stefan and Marc-Andr=E9 are asking
for;  it's probably good they go together.

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


