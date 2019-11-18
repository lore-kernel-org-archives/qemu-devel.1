Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B46EC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48602222AA
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URqEwFlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48602222AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWm9n-0005VO-GZ
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iWm5O-0002EY-4q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iWm5M-0003Bj-Em
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:49:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iWm5M-0003BJ-AP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574102955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExWW4YNuUOPzvlxgCCqomNTWv+hnULmGjwhTXuStWOg=;
 b=URqEwFlAUp857n4pcQLvJRataKpixxqJBQrD+gv6VyFJUSmZdpzSoI0wfgNg72ob3TSoY0
 Wh0HvDZewRQjPLMy+zDcb+Nt1BG8Szi6FRB0mEQ1vwPKP+whjSZUMQSqNVhqq2117YrXZO
 XjAt3FPShV2eNGILp5fiqqDWWMzXuzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-RBCLp9_rPG-AB0Rt2zjLlA-1; Mon, 18 Nov 2019 13:49:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB158107ACC4;
 Mon, 18 Nov 2019 18:49:10 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38A8362671;
 Mon, 18 Nov 2019 18:49:07 +0000 (UTC)
Date: Mon, 18 Nov 2019 15:49:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
Message-ID: <20191118184906.GB3812@habkost.net>
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: RBCLp9_rPG-AB0Rt2zjLlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 18, 2019 at 11:56:43AM +0100, David Hildenbrand wrote:
> On 18.11.19 11:53, Peter Maydell wrote:
> > On Mon, 18 Nov 2019 at 10:47, David Hildenbrand <david@redhat.com> wrot=
e:
> > > My personal opinion: "max" really means "all features". If we want an
> > > automatic way to specify something you requested ("give me something
> > > that's going to work") we either have to change the definition of the
> > > max model for alla rchitectures or introduce something that really
> > > matches the "no -cpu specified" - e.g., "best".
> >=20
> > I don't strongly object to 'max' including deprecated features,
> > but I do definitely object to 'max' including by default any
> > experimental (x- prefix) features. Those should never be
> > enabled (whatever the '-cpu foo' name) unless the user has
> > specifically opted into them: that's the point of the x- prefix.
> > We need to be able to tell from the command line whether it's
> > got any non-standard weirdness enabled.
>=20
> I'll let Eduardo respond to that, as we don't really have experimental
> features on s390x, especially under KVM ("host" corresponds to "max").

Be them experimental or deprecated, we need all features included
on "max" if we want to make them usable through libvirt.  The
fact Peter cares about defaults in "max" when used by humans
indicates we have incompatible definitions of "max", and I don't
think we can conciliate them.

We could rename the CPU model that is intended for humans on arm,
or we can document clearly that the semantics of "max" in
x86/s390x are completely different from arm.  Peter, what do you
prefer?

--=20
Eduardo


