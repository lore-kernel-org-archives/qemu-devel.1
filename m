Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9728EC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610C020732
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vcsvyt+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610C020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKSb-0001Fq-Ir
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOKS1-0000qi-BN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOKS0-0006mK-D3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:14:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jOKS0-0006m5-9P
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586866439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSVCGfs5KM5K8zljaKMEuTXbmnjFicB42LTErqpl1YE=;
 b=Vcsvyt+7fczYaO1s0DNxs+MY7Hy3wp/VL+TYpnf8+wK9Il0qv7a1J5hOEYVF5yggar0cGm
 1p9ZqLG5g12JNmVYHVMCGh4GJ8a9/o5f+vw2lB4QtasFds3OLUMU809pT0uybkulVq0M4c
 NVTcCFmlq5lmWVdFdFTNv5OeYZfNAGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-gTunFxCHMDu_T6ZbkEvNgA-1; Tue, 14 Apr 2020 08:13:55 -0400
X-MC-Unique: gTunFxCHMDu_T6ZbkEvNgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7822107B26F;
 Tue, 14 Apr 2020 12:13:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A975C1B2;
 Tue, 14 Apr 2020 12:13:47 +0000 (UTC)
Date: Tue, 14 Apr 2020 14:13:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Replace GSource with AioContext for chardev
Message-ID: <20200414121345.GB7747@linux.fritz.box>
References: <20200409124601.toh6jpbfcwiwzb6z@r>
 <CAMxuvayJjHH_dqyoPCweQDysubzv=bKnJqgp9TxZNcNKnLTJhw@mail.gmail.com>
 <20200409132441.GS1202384@redhat.com>
 <87imi2zfy1.fsf@dusky.pond.sub.org>
 <20200414102753.GJ1338838@redhat.com>
 <802d831b-e13a-7256-77d8-03c7a064522a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <802d831b-e13a-7256-77d8-03c7a064522a@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.04.2020 um 12:54 hat Paolo Bonzini geschrieben:
> On 14/04/20 12:27, Daniel P. Berrang=E9 wrote:
> > Ignoring back compat, what would be our ideal CLI syntax ?
> >=20
> > Current syntax is
> >=20
> >   -chardev socket,id=3Dcharnet1,path=3D/tmp/vhost1.sock
> >   -netdev vhost-user,chardev=3Dcharnet1,id=3Dhostnet1=20
> >=20
> > Should we have an option that expresses a "SocketAddress" struct on the
> > CLI ?
> >=20
> >    -socket type=3Dunix,path=3D/tmp/vhost1.sock,id=3Dsock0
> >    -netdev vhost-user,socket=3Dsock0,id=3Dhostnet1
>=20
> I think this should be just a "-object socket" that under the covers
> creates a QIOChannel.  There are also ideas of switching "-chardev" to
> "-object"; we could do the reverse of Marc-Andr=E9's suggestion, and have
> "chardev=3D" take both a "chardev-foo" object or a QIOChannel object
> (converting the latter to a socket-based chardev).

Is this just an attempt to avoid nesting on the command line? Because I
don't see much use in socket objects that need to be managed separately
and require separate object-add/del commands.

While dotted syntax can make SocketAddress specifications a bit lengthy,
the obvious syntax is:

-netdev vhost-user,socket.type=3Dunix,socket.path=3D/tmp/vhost1.sock,id=3Dh=
ostnet1

Assuming that this would be a QAPIfied -netdev, JSON is a readily
available alternative syntax.

Kevin


