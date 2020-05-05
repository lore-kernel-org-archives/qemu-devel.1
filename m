Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02408C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1095206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ0HoxKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1095206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzhH-0000M0-TY
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVzYf-00079a-4I
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:32:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVzYe-0004GD-38
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HvOSoBycwoN9Q2CscQbOVaQtnkcRGRkD2bQulkJJ14=;
 b=eQ0HoxKTpnsj+fZyAO/+YMYGKF1Pwdub7fZj9pbRuZnv/LIGAuLMdzLJKjiwMDxWlA/k7J
 4hgmpF20AUT7O7PaKrJrE5Sdgy18JSsjgOA6CdZp5WchUveKeeNCQtp0R2DBZF4KvJt33O
 bdDdiAsrQTpVODVvOYEOkriw8DJGA2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-QCEONEwmNSe020Bp7YOhyw-1; Tue, 05 May 2020 11:32:29 -0400
X-MC-Unique: QCEONEwmNSe020Bp7YOhyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A090239352;
 Tue,  5 May 2020 15:32:28 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E22DC64431;
 Tue,  5 May 2020 15:32:22 +0000 (UTC)
Date: Tue, 5 May 2020 16:32:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200505153219.GS764268@redhat.com>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <CAJ+F1CJsBRp+9yf=kGZt18APXskO8NWyQ1YEqauLYhiNmcW39Q@mail.gmail.com>
 <20200505152359.GG381978@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200505152359.GG381978@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Colin Walters <walters@verbum.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 04:23:59PM +0100, Stefan Hajnoczi wrote:
> On Mon, May 04, 2020 at 04:07:22PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > On Fri, May 1, 2020 at 8:29 PM Colin Walters <walters@verbum.org> wrote=
:
> > >
> > > I'd like to make use of virtiofs as part of our tooling in
> > > https://github.com/coreos/coreos-assembler
> > > Most of the code runs as non-root today; qemu also runs as non-root.
> > > We use 9p right now.
> > >
> > > virtiofsd's builtin sandboxing effectively assumes it runs as
> > > root.
> > >
> > > First, change the code to use `clone()` and not `unshare()+fork()`.
> > >
> > > Next, automatically use `CLONE_NEWUSER` if we're running as non root.
> > >
> > > This is similar logic to that in https://github.com/containers/bubble=
wrap
> > > (Which...BTW, it could make sense for virtiofs to depend on bubblewra=
p
> > >  and re-exec itself rather than re-implementing the containerization
> > >  itself)
> > >
> >=20
> > Now that systemd-nspawn works without privileges, isn't that also a
> > solution? One that would fit both system and session level
> > permissions, and integration with other services?
>=20
> Does systemd-nspawn work inside containers?
>=20
> I think virtiofsd will need to run inside containers in the future and
> remember systemd being difficult to use in containers.

It can be made to work, but my gut tells me people won't be happy if
system were a mandatory requirement for virtiofsd usage. Also there
are current Linux distros which don't even use systemd.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


