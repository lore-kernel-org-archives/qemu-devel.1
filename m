Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDF1C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBD620650
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0Mwosk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBD620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT9gY-0006WK-7c
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iT9f7-0005JR-7i
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iT9f4-0002pu-4Q
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:11:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iT9f3-0002p2-6j
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573240267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAa9gWFuK2b6rapyozx1lzxnVzmieI134Z7tXTfEt0E=;
 b=O0Mwosk7ERpbdwgC3EIcl/uFWVgkSmbrVPcWcirxarcAteYvTHcTaeDgsG4RqILGYv7smz
 9lHvHoIu9oVkNFHgtzuOh2PXlINJHk89EUAqU8THQ73NaVzi2Yiyopt8OzWb5TR0HX7GtP
 7naT+fzWViturFhOfGXLmO6KWB9KGj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-jYn5YO5GNYSzFk-KaLJkrA-1; Fri, 08 Nov 2019 14:11:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A1A1005500;
 Fri,  8 Nov 2019 19:11:02 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7C9C600C9;
 Fri,  8 Nov 2019 19:10:58 +0000 (UTC)
Date: Fri, 8 Nov 2019 16:10:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
Message-ID: <20191108191057.GZ3812@habkost.net>
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jYn5YO5GNYSzFk-KaLJkrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 01:02:28PM +0000, Peter Maydell wrote:
> On Fri, 8 Nov 2019 at 12:46, David Hildenbrand <david@redhat.com> wrote:
> > There is a small but important difference between "max"/"host" and
> > "best". Max really means "all features", including deprecated ones.
> > "best", however, can disable experimental or deprecated features. Or an=
y
> > other features we don't want to be enabled when somebody selects a mode=
l
> > manually.

On x86, this is implemented by "host".  "max" gives you the full
set of features that can be enabled by the user.  "host" gives
you a reasonable set of features you will want to see enabled by
default when the user says "use the host CPU".

> >
> > On s390x, the feature "csske" is deprecated. New HW still has it, but w=
e
> > want new guests to run without this facility. Dropping it from "max"
> > would affect existing setups. We already changed the default model
> > (e.g., -cpu z13) to disable it with never QEMU machines.
> >
> > E.g., nested virtualization features on some architectures could be a
> > feature set you want to disable, although contained in the "max" model.
> > (e.g., no migration support yet).
> >
> >
> > I am not completely against calling these "max" models instead of "best=
"
> > models, but I think this makes it clearer that there is indeed a differ=
ence.
>=20
> Hmm. I see the distinction, but is it one that's sufficiently
> worth making that we want to expose it to our users, possibly
> try to add it to the other architectures, etc ? How bad is it
> if the CPU provides some legacy deprecated feature that the
> guest just doesn't use ?
>=20

"max" isn't something we want to expose to end users.  It is
something we need to expose to other software components.

> 'max' already shouldn't include experimental features, at least
> for Arm -- those should be off by default, because they're
> experimental and you only want users to get them if they
> explicitly opt in via '-cpu something,+x-my-feature'.

The whole point of "max" is to tell management software which
features are valid to be enabled in a host.  If "+x-my-feature"
works, "x-my-feature" must be included in "max".

--=20
Eduardo


