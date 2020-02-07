Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B97C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B84922464
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq8TZUg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B84922464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Zh-0005ay-R3
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j05Z5-00053a-NV
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j05Z4-0000HY-19
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:29:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j05Z3-0000Fe-KK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581089345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pi1okzEXVffEvyXwBNHQH32Xg7nmD6MJp7QmhmTnms8=;
 b=bq8TZUg1FnY6quPbIhz972zEKYFgTaP+aHbVYVR7Gl+ho4Itlbyd+Yu+jb920alB+bG/59
 h92TdPLp8BDTX5MQwuSh4Xl2l9nC/KHMYm5mJlJ1FQJxWrQwyOL+OGMYHjJ00bVohjMH1l
 8GQ594zDQd/U6UvdJ4J1G62zdB5/7vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-C8r5FaMpOHys1cqnMdSZzQ-1; Fri, 07 Feb 2020 10:29:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72E21083E80;
 Fri,  7 Feb 2020 15:28:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17AF35DA81;
 Fri,  7 Feb 2020 15:28:49 +0000 (UTC)
Date: Fri, 7 Feb 2020 15:28:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 00/13] Ram blocks with resizable anonymous allocations
 under POSIX
Message-ID: <20200207152847.GG3302@work-vm>
References: <20200206201121.GM3655@work-vm>
 <13585E49-B84C-41D8-8825-F96841F475D0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <13585E49-B84C-41D8-8825-F96841F475D0@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: C8r5FaMpOHys1cqnMdSZzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
>=20
>=20
> > Am 06.02.2020 um 21:11 schrieb Dr. David Alan Gilbert <dgilbert@redhat.=
com>:
> >=20
> > =EF=BB=BF* David Hildenbrand (david@redhat.com) wrote:
> >> We already allow resizable ram blocks for anonymous memory, however, t=
hey
> >> are not actually resized. All memory is mmaped() R/W, including the me=
mory
> >> exceeding the used_length, up to the max_length.
> >>=20
> >> When resizing, effectively only the boundary is moved. Implement actua=
lly
> >> resizable anonymous allocations and make use of them in resizable ram
> >> blocks when possible. Memory exceeding the used_length will be
> >> inaccessible. Especially ram block notifiers require care.
> >>=20
> >> Having actually resizable anonymous allocations (via mmap-hackery) all=
ows
> >> to reserve a big region in virtual address space and grow the
> >> accessible/usable part on demand. Even if "/proc/sys/vm/overcommit_mem=
ory"
> >> is set to "never" under Linux, huge reservations will succeed. If ther=
e is
> >> not enough memory when resizing (to populate parts of the reserved reg=
ion),
> >> trying to resize will fail. Only the actually used size is reserved in=
 the
> >> OS.
> >>=20
> >> E.g., virtio-mem [1] wants to reserve big resizable memory regions and
> >> grow the usable part on demand. I think this change is worth sending o=
ut
> >> individually. Accompanied by a bunch of minor fixes and cleanups.
> >>=20
> >> [1] https://lore.kernel.org/kvm/20191212171137.13872-1-david@redhat.co=
m/
> >=20
> > There's a few bits I've not understood from skimming the patches:
> >=20
>=20
> Thanks for having a look!
>=20
> >  a) Am I correct in thinking you PROT_NONE the extra space so you can
> > gkrow/shrink it?
>=20
> Yes!
>=20
> >  b) What does kvm see - does it have a slot for the whole space or for
> > only the used space?
>=20
> Only the used space. Resizing triggers a resize of the memory region. Tha=
t triggers memory notifiers, which remove the old kvm memslot and re-add th=
e new kvm memslot. (That=E2=80=98s existing handling, so nothing new).
>=20
> So KVM will not see PROT_NONE when creating a slot.

OK, that's easy then.

> >     I ask because we found with virtiofs/DAX experiments that on Power,
> > kvm gets upset if you give it a mapping with PROT_NONE.
> >     (That maybe less of an issue if you change the mapping after the
> > slot is created).
>=20
> That should work as expected. Resizing *while* kvm is running is tricky, =
but that=E2=80=98s not part of this series and a different story :) right n=
ow, resizing is only valid on reboot/incoming migration.

Hmm 'when' during an incoming migration; I ask because of userfaultfd
setup for postcopy.  Also note those things can combine - i.e. a reboot
that happens during a migration (we've already got a pile of related
bugs).

> >=20
> >  c) It's interesting this is keyed off the RAMBlock notifiers - do
> >     memory_listener's on the address space the block is mapped into get
> >    triggered?  I'm wondering how vhost (and vhost-user) in particular
> >    see this.
>=20
> Yes, memory listeners get triggered. Old region is removed, new one is ad=
ded. Nothing changed on that front.
>=20
> The issue with ram block notifiers is that they did not do a =E2=80=9Erem=
ove old, add new=E2=80=9C on resizes. They only added the full ram block. B=
ad. E.g., vfio wants to pin all memory - which would fail on PROT_NONE.
>=20
> E.g., for HAX, there is no kernel ioctl to remove a ram block ... for SEV=
 there is, but I am not sure about the implications when converting back an=
d forth between encrypted/unencrypted. So SEV and HAX require legacy handli=
ng.

I guess for a memory listener it just sees a new layout after the commit
and then can figure out what changed.

Dave

> Cheers!
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


