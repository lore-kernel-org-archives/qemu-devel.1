Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4926C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC9F2186D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mkyf21Yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC9F2186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9PZ-0004qr-Me
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iX9On-0004OM-9J
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iX9Ok-0008HX-Di
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:42:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iX9Ok-0008Gw-09
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574192568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhnGpK6gdoGtS9EoOeoUoe1KxZ5DQuaMfH6rzaAT/Lk=;
 b=Mkyf21YrAlKQF0QIo0brS6vPTKeM04tKiXsP7jCflAj6ZrPo/+xVdR4ZZsJwivEq94F5Bu
 3LLri+QBugr/xJwL1TPOukz+xl5s//gKgs4I4N07wPwXuWyyqZYej/DPpDd7MKLi16R+XR
 hSQ5/b+RDlFt/BozKB265GudC2oUNu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-W1SOps04N6avHGvZ_tnCuQ-1; Tue, 19 Nov 2019 14:42:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F0D918C5381;
 Tue, 19 Nov 2019 19:42:43 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC6EB9CD3;
 Tue, 19 Nov 2019 19:42:40 +0000 (UTC)
Date: Tue, 19 Nov 2019 16:42:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
Message-ID: <20191119194238.GJ3812@habkost.net>
References: <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
 <20191118184906.GB3812@habkost.net>
 <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
 <20191118220417.GF3812@habkost.net>
 <CAFEAcA8XoyeAfHuKe0AEvecCzo748Yk1VD1+VD=C3ACZdfzwsw@mail.gmail.com>
 <ca517ad9-46bb-c0ac-2227-a64ab8fe5e15@redhat.com>
 <CAFEAcA-egL5kbo81eBT+FVBz7vSaWqUVzFUF3MNOttnzY6vZMQ@mail.gmail.com>
 <1fd9876d-5ad9-15e9-a2dc-6e5e747f9ca8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1fd9876d-5ad9-15e9-a2dc-6e5e747f9ca8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: W1SOps04N6avHGvZ_tnCuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

On Tue, Nov 19, 2019 at 12:00:14PM +0100, David Hildenbrand wrote:
> On 19.11.19 11:36, Peter Maydell wrote:
> > On Tue, 19 Nov 2019 at 09:59, David Hildenbrand <david@redhat.com> wrot=
e:
> > >=20
> > > On 19.11.19 10:22, Peter Maydell wrote:
> > > > I don't hugely care about query-cpu-model-expansion. I
> > > > just don't want it to have bad effects on the semantics
> > > > of user-facing stuff like x- properties.
> > >=20
> > > IMHO, max should really include all features (yes, also the bad
> > > x-features on arm :) ) and we should have a way to give users the
> > > opportunity to specify "just give me the best model independent of th=
e
> > > accelerator" - something like a "best" model, but I don't care about =
the
> > > name.

I'm in agreement with Peter, here: if "max" is user-visible, it's
better to make it provide more usable defaults.


> >=20
> > How would "max includes all features" work if we have two
> > x- features (or even two normal features!) which are incompatible
> > with each other? How does it work for features which are
>=20
> I assume the "max" model should at least be consistent, see below.
>=20
> > valid for some other CPU type but not for 'max'? The design
> > seems to assume a rather simplified system where every
> > feature is independent and can always be applied to every
> > CPU, which I don't think is guaranteed to be the case.
>=20
> I do agree that the use case of "max" for detecting which features can be
> enabled for any CPU model is quite simplified and would also not work lik=
e
> this on s390x. It really means "give me the maximum/latest/greatest you
> can". Some examples on s390x:
>=20
> On s390x, we don't allow to enable new features for older CPU generation.
> "vx" was introduced with a z13. If "max" is a z13, it can include "vx", i=
f
> available. However, if you select a z12 (zEC12), you cannot enable "vx":
>=20
> "Feature '%s' is not available for CPU model '%s', it was introduced with
> later models."
>=20
> Also, we have dependency checks
> (target/s390x/cpu_models.c:check_consistency()), that at least warn on
> inconsistencies between features (feature X requires feature Y).
>=20
> We would need more fine-grained "max" models. E.g., z13-max vs. z13-best =
vs.
> z13-base.
>=20
> - z13-max: Maximum features that can be enabled on the current
>            accel/host for a z13.
> - z13-best: Best features that can be enabled on the current
>            accel/host for a z13.
> - z13-base: base feature set, independent of current
>            accel/host for a z13. (we do have this already on s390x)

We don't need to create new CPU types for that, do we?  These
different modes could be configured by a CPU option (e.g.
"z13,features=3Dmax"[1], "z13,features=3Dbest").

If we do add new CPU options to tune feature defaults, libvirt
can start using these options on query-cpu-model-expansion, and
everybody will be happy.  No need to change defaults in the "max"
CPU model in a way that makes it less usable just to make
query-cpu-model-expansion work.

[1] Probably we need to call it something else instead of
    "features=3Dmax", just to avoid confusion with the "max" CPU
    model.  Maybe "experimental-features=3Don",
    "recommended-features=3Don"?

--=20
Eduardo


