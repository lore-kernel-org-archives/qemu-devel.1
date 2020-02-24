Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A2C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B8020726
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boXRTrr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B8020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MPM-0006Tx-HS
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j6MGj-0003uI-R2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j6MGi-0001oO-CC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:32:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j6MGi-0001nK-7g
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582583523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7Skd501lmEb3avkvn4ACx1L250ApO1JQYLnKgPpLN4=;
 b=boXRTrr4PcGOAqvUChuHo/Esqh+lVRGBclTNB4C0O5WESxcGpEv6ZPdmi7/s1C51GuuHwU
 MlPvX6NbJh4Gn+iIwZ1lHgnttHgBgRUCRVFnuqfnfj4r4Uws3wVJi42a7srLP2g4pcq0yV
 B1dxiRxgkOzkYHOgLnm6lrodpBwPkDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-5BSYg1evNV6lZz2jW4jKcw-1; Mon, 24 Feb 2020 17:31:58 -0500
X-MC-Unique: 5BSYg1evNV6lZz2jW4jKcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAF698010C7;
 Mon, 24 Feb 2020 22:31:56 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D85A60CCC;
 Mon, 24 Feb 2020 22:31:49 +0000 (UTC)
Date: Mon, 24 Feb 2020 17:31:49 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
Message-ID: <20200224223149.GF4440@habkost.net>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
 <20200224181903.19790bad@redhat.com>
 <1a7b1dae-9600-1d29-d4d4-4fdfb6832b6f@amd.com>
MIME-Version: 1.0
In-Reply-To: <1a7b1dae-9600-1d29-d4d4-4fdfb6832b6f@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 11:58:09AM -0600, Babu Moger wrote:
>=20
>=20
> On 2/24/20 11:19 AM, Igor Mammedov wrote:
> > On Thu, 13 Feb 2020 12:17:46 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >=20
> >> Check and Load the apicid handlers from X86CPUDefinition if available.
> >> Update the calling convention for the apicid handlers.
> >=20
> > Previous and this patch look too complicated for the task at the hand.
> > In particular, cpu_x86_init_apicid_fns() from previous patch adds 1 mor=
e
> > reference to Machine into i386/cpu.c (even though it's just a helper fu=
nction)
> > and I think un-necessary hooks to X86CPUDefinition (it's not really CPU=
's
> > businesses to make up APIC-IDs).
> >=20
> > I'd rather do opposite and get rid of the last explicit dependency to
> > ms->smp.cpus from cpu.c. But well, it's out of scope of this series,
> > so for this series I'd just try to avoid adding more Machine dependenci=
es.
> >=20
> > All 11/16 does is basically using hooks as a switch "I'm EPYC" to
> > set epyc specific encoding topo routines.
> >=20
> > It could be accomplished by a simple Boolean flag like
> >  X86CPUDefinition::use_epyc_apic_id_encoding
> >=20
> > and then cpu_x86_init_apicid_fns() could be replaced with trivial
> > helper like:
> >=20
> >   x86_use_epyc_apic_id_encoding(char *cpu_type)
> >   {
> >       X86CPUClass *xcc =3D ... cpu_type ...
> >       return xcc->model->cpudef->use_epyc_apic_id_encoding
> >   }
> >=20
> > then machine could override default[1] hooks using this helper
> > as the trigger
> >   x86_cpus_init()
> >   {
> >       // no need in dedicated function as it's the only instance it's g=
oing to be called ever
> >       if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> >             x86ms->apicid_from_cpu_idx =3D ...epyc...
> >             x86ms->topo_ids_from_apicid =3D ...epyc...
> >             x86ms->apicid_from_topo_ids =3D ...epyc...
> >             x86ms->apicid_pkg_offset =3D ...epyc...
> >       }
> >   }
> >=20
> > That would be less invasive and won't create non necessary dependencies=
.
>=20
> Yes. We can achieve the task here with your approach mentioned above. But=
,
> we still will have a scaling issue. In future if a "new cpu model" comes
> up its own decoding, then we need to add another bolean flag use_new
> _cpu_apic_id_encoding. And then do that same check again. In that sense,
> the current approach is bit generic. Lets also hear from Eduardo.

To be honest, I really hope the number of APIC ID initialization
variations won't grow in the future.

In either case, X86MachineState really doesn't seem to be the
right place to save the function pointers.  Whether we choose a
boolean flag or a collection of function pointers, model-specific
information belong to x86CPUClass and/or X86CPUDefinition, not
MachineState.

See the reply I sent at:
https://lore.kernel.org/qemu-devel/20200128200438.GJ18770@habkost.net/

] If you need a CPU model to provide special behavior,
] you have two options:
]=20
] * Add a method pointer to X86CPUClass and/or X86CPUDefinition
] * Add a QOM property to enable/disable special behavior, and
]   include the property in the CPU model definition.
]=20
] The second option might be preferable long term, but might
] require more work because the property would become visible in
] query-cpu-model-expansion and in the command line.  The first
] option may be acceptable to avoid extra user-visible complexity
] in the first version.
]=20
]=20
]=20
] > +        pcms->apicid_from_cpu_idx =3D x86_apicid_from_cpu_idx_epyc;
] > +        pcms->topo_ids_from_apicid =3D x86_topo_ids_from_apicid_epyc;
] > +        pcms->apicid_from_topo_ids =3D x86_apicid_from_topo_ids_epyc;
]=20
] Why do you need to override the function pointers in
] PCMachineState instead of just looking up the relevant info at
] X86CPUClass?

--=20
Eduardo


