Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096E0C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CB52067C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7+WB4Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CB52067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHu8-0004DP-JM
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iiHrl-0001wY-NO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iiHrj-0006Uz-TL
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:58:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57313
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iiHrh-0006TS-Tw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576846725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLHxKGr2UEw6E/iraGih8eeeqrJW0mKEUGOzGly03os=;
 b=E7+WB4Y5eGfyEcSGJf3fHlLwDydGXY3cL5li4A0T5Pn8wdA47vhP9eNP6VrA0D2hcHrW8C
 jgwFPtMDJER76oSA1RbSbSkH06ID+H2lUCrR7ja10XfzQLsoHder+a/syjXjQ17X9zy4QP
 Y+wcFRIVCrpo3uNJZQnrQsBUqSF97Ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-DCmT0yVxMFCg3NViDowRww-1; Fri, 20 Dec 2019 07:58:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 304DE1883522;
 Fri, 20 Dec 2019 12:58:41 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46D3860BF3;
 Fri, 20 Dec 2019 12:58:40 +0000 (UTC)
Date: Fri, 20 Dec 2019 13:58:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
Message-ID: <20191220125839.GG4019@dhcp-200-226.str.redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
 <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
 <20191220112402.GE4019@dhcp-200-226.str.redhat.com>
 <87pngjgo2h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87pngjgo2h.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DCmT0yVxMFCg3NViDowRww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.12.2019 um 13:48 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 20.12.2019 um 11:48 hat Max Reitz geschrieben:
> >> So if we kept writable and growable in the common base, then the schem=
a
> >> would give no information about what exports actually support them.
> >>=20
> >> On one hand, I don=E2=80=99t know whether it=E2=80=99s important to ha=
ve this
> >> information in a static form, or whether it=E2=80=99s sufficient to le=
arn at
> >> runtime.
> >>=20
> >> On the other, I don=E2=80=99t know whether it=E2=80=99s important to h=
ave those fields
> >> in the base or not.  Would it make a difference on the wire?
> >
> > Not for the command itself, so I think we're free to change it later. I=
t
> > might make a difference for introspection, though, not sure. Markus?
>=20
> QAPI schema introspection is designed to hide the difference between
> local members and base members.  You can move members to or from a base
> type freely without affecting introspection.  Even if that creates or
> deletes the base type.

Good, that's helpful. So I can split the nbd-server-add argument type
into a base that is reused as a union branch and the rest without
potentially breaking anything.

I suppose moving a field between a union base and all variants does
still result in different introspection even though the accepted inputs
are the same. Is this kind of movement still allowed unconditionally or
should we be more careful with something like this?

Kevin


