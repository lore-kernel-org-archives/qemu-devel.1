Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1DC43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E23A22312
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqDh77g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E23A22312
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWp9j-0001Ez-No
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iWp8K-0000Oq-1o
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iWp8H-0004pu-D7
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:04:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iWp8G-0004oj-HD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574114667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHWgNpgDL4TOac+G5j3mi28DIf8XHB3WmS0SxXB7+I8=;
 b=PqDh77g3XgZRzFYacxgIPxAhTCLbNFNTxvxMEbq2ruolEHq/wPrpZNmgnpL2zsweURA5yF
 1TTFmvOyBPCbuPm8OBvHY1dOugYJBps27l+RfWfSc/FZSptPjPw01um5g1iISJHgSFkmjj
 FTjeKc/8vlGR6D1MdcpjQh+qazG6xps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-RMVwNMQTMGiATYf9G9cTdw-1; Mon, 18 Nov 2019 17:04:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED3CC8018A2;
 Mon, 18 Nov 2019 22:04:22 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF385E243;
 Mon, 18 Nov 2019 22:04:19 +0000 (UTC)
Date: Mon, 18 Nov 2019 19:04:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
Message-ID: <20191118220417.GF3812@habkost.net>
References: <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
 <20191118184906.GB3812@habkost.net>
 <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: RMVwNMQTMGiATYf9G9cTdw-1
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

On Mon, Nov 18, 2019 at 09:19:55PM +0000, Peter Maydell wrote:
> On Mon, 18 Nov 2019 at 18:49, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
> > Be them experimental or deprecated, we need all features included
> > on "max" if we want to make them usable through libvirt.  The
> > fact Peter cares about defaults in "max" when used by humans
> > indicates we have incompatible definitions of "max", and I don't
> > think we can conciliate them.
> >
> > We could rename the CPU model that is intended for humans on arm,
> > or we can document clearly that the semantics of "max" in
> > x86/s390x are completely different from arm.  Peter, what do you
> > prefer?
>=20
> I don't want us to have different definitions of max on different
> architectures if we can avoid it. More importantly, I don't think that
> x- features should ever be enabled by default for *any* CPU type
> on *any* architecture (unless the CPU type itself was experimental,
> I suppose), whatever that architecture's semantics for 'max',
> 'best', etc are.
>=20
> I think the solution to this is to not use 'max' as some odd way of
> letting libvirt do feature detection. I'm not sure how trying to
> use 'max' as a proxy for "all features on" would work for features
> which can't exist on 'max' but do exist on other CPU types
> (for instance for Arm some features make no sense on the
> A-profile 'max' CPU and aren't provided there, but do exist for
> M-profile CPUs like cortex-m4), so I don't see how libvirt
> can usefully use it anyway.

libvirt uses it through query-cpu-model-expansion.

>=20
> Why should it matter whether a feature is enabled
> or disabled by default in the CPU type? It ought to be probeable
> by QMP either way (ie there is a difference between
> "this CPU has this feature switch and it is on by default",
> "this CPU has this feature switch and it is off by default"
> and "this CPU does not have this feature switch at all",
> and presumably libvirt needs to distinguish them).

Its use case is neither "this CPU has this feature switch" or for
"it is on|off by default".  We use it to probe for "this feature
can be enabled in this host hardware+kernel+QEMU combination".

In other words, in x86 and s390x "max" is just a reserved name
for the query-cpu-model-expansion command arguments in s390x and
x86.  The fact that it is visible to users can be considered a
bug, and we can fix that.

If you still don't like how query-cpu-model-expansion works, we
can also discuss that.  But I'm not sure it would be a good use
of our (and libvirt developers') time.

--=20
Eduardo


