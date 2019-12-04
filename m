Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B6C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5C9205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWEg9sEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5C9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXzO-0008Mo-Lo
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1icXqN-00028I-LB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1icXqC-0005Bf-UW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:49:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1icXqB-0004ei-Pe
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575478164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wL0/fjrpn43OlemQDy5P81zH6xrq2ZyjSkKpuZ9daQo=;
 b=SWEg9sEiT0a+4HOv8+a5j1WJ0Tkze8Xay0zaslpK2QZS97DjXH83FTnOgJRHmkJNKbcdE5
 Q+pvxrp0Sr9DfFJrDXmJDO9v2VYRYkt8PaUf3XvWJacNXI/PXM+p8DvTDa4imNmPmiRpBn
 lVgGjKxv3HKeJQnxBc3R2oP1k3p3Op8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-F8qb5jgHOL-9Cuujsig4MA-1; Wed, 04 Dec 2019 11:49:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0C1107ACC4;
 Wed,  4 Dec 2019 16:49:19 +0000 (UTC)
Received: from work-vm (ovpn-117-217.ams2.redhat.com [10.36.117.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78CF4691A5;
 Wed,  4 Dec 2019 16:49:17 +0000 (UTC)
Date: Wed, 4 Dec 2019 16:49:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191204164915.GM3325@work-vm>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
 <20191019101223.GD1960@umbus.fritz.box>
 <20191021081444.GA2934@work-vm>
 <20191120214827.iui5rtwyls3r62ns@rascal.austin.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191120214827.iui5rtwyls3r62ns@rascal.austin.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: F8qb5jgHOL-9Cuujsig4MA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> On Mon, Oct 21, 2019 at 09:14:44AM +0100, Dr. David Alan Gilbert wrote:
> > * David Gibson (david@gibson.dropbear.id.au) wrote:
> > > On Fri, Oct 18, 2019 at 10:43:52AM +0100, Dr. David Alan Gilbert wrot=
e:
> > > > * Laurent Vivier (lvivier@redhat.com) wrote:
> > > > > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > > > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > > > > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Prio=
rity
> > > > > >> sorting is maintained by searching from head to tail for a sui=
table
> > > > > >> insertion spot.  Insertion is thus an O(n) operation.
> > > > > >>
> > > > > >> If we instead keep track of the head of each priority's subque=
ue
> > > > > >> within that larger queue we can reduce this operation to O(1) =
time.
> > > > > >>
> > > > > >> savevm_state_handler_remove() becomes slightly more complex to
> > > > > >> accomodate these gains: we need to replace the head of a prior=
ity's
> > > > > >> subqueue when removing it.
> > > > > >>
> > > > > >> With O(1) insertion, booting VMs with many SaveStateEntry obje=
cts is
> > > > > >> more plausible.  For example, a ppc64 VM with maxmem=3D8T has =
40000 such
> > > > > >> objects to insert.
> > > > > >=20
> > > > > > Separate from reviewing this patch, I'd like to understand why =
you've
> > > > > > got 40000 objects.  This feels very very wrong and is likely to=
 cause
> > > > > > problems to random other bits of qemu as well.
> > > > >=20
> > > > > I think the 40000 objects are the "dr-connectors" that are used t=
o plug
> > > > > peripherals (memory, pci card, cpus, ...).
> > > >=20
> > > > Yes, Scott confirmed that in the reply to the previous version.
> > > > IMHO nothing in qemu is designed to deal with that many devices/obj=
ects
> > > > - I'm sure that something other than the migration code is going to
> > > > get upset.
> > >=20
> > > It kind of did.  Particularly when there was n^2 and n^3 cubed
> > > behaviour in the property stuff we had some ludicrously long startup
> > > times (hours) with large maxmem values.
> > >=20
> > > Fwiw, the DRCs for PCI slots, DRCs and PHBs aren't really a problem.
> > > The problem is the memory DRCs, there's one for each LMB - each 256Mi=
B
> > > chunk of memory (or possible memory).
> > >=20
> > > > Is perhaps the structure wrong somewhere - should there be a single=
 DRC
> > > > device that knows about all DRCs?
> > >=20
> > > Maybe.  The tricky bit is how to get there from here without breaking
> > > migration or something else along the way.
> >=20
> > Switch on the next machine type version - it doesn't matter if migratio=
n
> > is incompatible then.
>=20
> 1mo bump.
>=20
> Is there anything I need to do with this patch in particular to make it s=
uitable
> for merging?

Apologies for the delay;  hopefully this will go in one of the pulls
just after the tree opens again.

Please please try and work on reducing the number of objects somehow -
while this migration fix is a useful short term fix, and not too
invasive; having that many objects around qemu is a really really bad
idea so needs fixing properly.

Dave

>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


