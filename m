Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0092C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD322173E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRBQQFbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD322173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iex0l-00058p-UA
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 03:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iewzr-0004ZC-RM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iewzp-0005YL-M7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:05:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iewzp-0005X3-Gs
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576051520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTKBMZDk32UkkryTA+Q7Rc3mbAQXBtKxRdJKmfJRLjU=;
 b=SRBQQFbiuKChXDQdzKtxJPwhOsawbNqc8f4QGD+LLj3iWdWyBYKXlaWE8us2bL0O5Y6Na6
 CVPZPy8XzCXQr5TAJ5QlCFZMHEy/s4Xw5nRT2nPkZoZJeZFsYfPrL7SRgvp/Bh0agTRA0J
 e15bzsQkjaltMEUg5ETH03oHav0VT7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-IqySaA7CPHKKsIeALjIaGA-1; Wed, 11 Dec 2019 03:05:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF8D8107ACE4;
 Wed, 11 Dec 2019 08:05:15 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD1E5C1BB;
 Wed, 11 Dec 2019 08:05:11 +0000 (UTC)
Date: Wed, 11 Dec 2019 09:05:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] spapr: Add NVDIMM device support
Message-ID: <20191211090509.1845b913@redhat.com>
In-Reply-To: <1c24857f-64d4-a14d-1b66-cae2113d53a2@linux.ibm.com>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
 <20191122043045.GD5582@umbus.fritz.box>
 <CAGZKiBo4bdTTbJ82YV92RtTqbhuj_-GRxt6GceWyPbWdr9LGFA@mail.gmail.com>
 <20191206015255.GL5031@umbus.fritz.box>
 <1c24857f-64d4-a14d-1b66-cae2113d53a2@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: IqySaA7CPHKKsIeALjIaGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>,
 Bharata B Rao <bharata.rao@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Dec 2019 09:44:11 +0530
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> On 12/06/2019 07:22 AM, David Gibson wrote:
> > On Wed, Nov 27, 2019 at 09:50:54AM +0530, Bharata B Rao wrote: =20
> >> On Fri, Nov 22, 2019 at 10:42 AM David Gibson
> >> <david@gibson.dropbear.id.au> wrote: =20
> >>> Ok.  A number of queries about this.
> >>>
> >>> 1) The PAPR spec for ibm,dynamic-memory-v2 says that the first word i=
n
> >>> each entry is the number of LMBs, but for NVDIMMs you use the
> >>> not-necessarily-equal scm_block_size instead.  Does the NVDIMM
> >>> amendment for PAPR really specify to use different block sizes for
> >>> these cases?  (In which case that's a really stupid spec decision, bu=
t
> >>> that wouldn't surprise me at this point). =20
> >> SCM block sizes can be different from LMB sizes, but here we enforce
> >> that SCM device size (excluding metadata) to multiple of LMB size so
> >> that we don't end up memory range that is not aligned to LMB size. =20
> > Right, but it still doesn't make sense to use scm_block_size when you
> > create the dynamic-memory-v2 property. =20
>=20
> Right, I should use LMB size here as I will be creating holes here to=20
> disallow DIMMs
> to claim those LMBs marking them INVALID as Bharata Suggested before.
>=20
> >   As far as the thing
> > interpreting that goes, it *must* be LMB size, not SCM block size.  If
> > those are required to be the same at this point, you should use an
> > assert(). =20
>=20
> SCM block size should be a multiple for LMB size, need not be equal.=20
> I'll add an assert
> for that, checking if equal. There is no benefit I see as of now having=
=20
> higher
> SCM block size as the bind/unbind are already done before the bind hcall.
>=20
> >>> 2) Similarly, the ibm,dynamic-memory-v2 description says that the
> >>> memory block described by the entry has a whole batch of contiguous
> >>> DRCs starting at the DRC index given and continuing for #LMBs DRCs.
> >>> For NVDIMMs it appears that you just have one DRC for the whole
> >>> NVDIMM.  Is that right? =20
> >> One NVDIMM has one DRC, In our case, we need to mark the LMBs
> >> corresponding to that address range in ibm,dynamic-memory-v2 as
> >> reserved and invalid. =20
> > Ok, that fits very weirdly with the DRC allocation for the rest of
> > pluggable memory, but I suppose that's PAPR for you.
> >
> > Having these in together is very inscrutable though, and relies on a
> > heap of non-obvious constraints about placement of DIMMs and NVDIMMs
> > relative to each other.  I really wonder if it would be better to have
> > a completely different address range for the NVDIMMs. =20
>=20
> The backend object for both DIMM and NVDIMM are memory-backend-*
> and they use the address from the same space. Separating it would mean
> using/introducing different backend object. I dont think we have a=20
> choice here.

What address-space(s) are are talking about here exactly?
From my point of view memory-backend-* provides RAM block at
some HVA, which shouldn't not have anything to do with how NVDIMM
partitions and maps it to GPA.


> >>> 3) You're not setting *any* extra flags on the entry.  How is the
> >>> guest supposed to know which are NVDIMM entries and which are regular
> >>> DIMM entries?  AFAICT in this version the NVDIMM slots are
> >>> indistinguishable from the unassigned hotplug memory (which makes the
> >>> difference in LMB and DRC numbering even more troubling). =20
> >> For NVDIMM case, this patch should populate the LMB set in
> >> ibm,dynamic-memory-v2 something like below:
> >>              elem =3D spapr_get_drconf_cell(size /lmb_size, addr,
> >>                                           0, -1,
> >> SPAPR_LMB_FLAGS_RESERVED | SPAPR_LMB_FLAGS_DRC_INVALID);
> >>
> >> This will ensure that the NVDIMM range will never be considered as
> >> valid memory range for memory hotplug. =20
> > Hrm.  Ok so we already have code that does that for any gaps between
> > DIMMs.  I don't think there's actually anything that that code will do
> > differently than the code you have for NVDIMMs, so you could just skip
> > over the NVDIMMs here and it should do the right thing.
> >
> > The *interpretation* of those entries will become different: for space
> > into which a regular DIMM is later inserted, we'll assume the DRC
> > index given is a base and there are more DRCs following it, but for
> > NVDIMMs we'll assume the same DRC throughout.  This is nuts, but IIUC
> > that's what PAPR says and we can't do much about it. =20
>=20
> My current patch is buggy as Bharata pointed out. The NVDIMM DRCs
> are not to be populated here, but mark the LMB DRCs as RESERVED and INVAL=
ID
> so that no malicious attempts to online those LMBs at those NVDIMM addres=
s
> ranges are attempted.
>=20
> > =20
> >>> 4) AFAICT these are _present_ NVDIMMs, so why is
> >>> SPAPR_LMB_FLAGS_ASSIGNED not set for them?  (and why is the node
> >>> forced to -1, regardless of di->node).
> >>> =20
> >>>>           QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> >>>>           nr_entries++;
> >>>>           cur_addr =3D addr + size;
> >>>> @@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprMachineS=
tate *spapr, void *fdt)
> >>>>       }
> >>>>   }
> >>>>
> >>>> +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *sp=
apr)
> >>>> +{
> >>>> +    MachineState *machine =3D MACHINE(spapr);
> >>>> +    int i;
> >>>> +
> >>>> +    for (i =3D 0; i < machine->ram_slots; i++) {
> >>>> +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, =
i); =20
> >>> What happens if you try to plug an NVDIMM to one of these slots, but =
a
> >>> regular DIMM has already taken it? =20
> >> NVDIMM hotplug won't get that occupied slot. =20
> > Ok.
> > =20
>=20


