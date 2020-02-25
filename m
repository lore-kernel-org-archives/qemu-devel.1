Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ABEC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DDE21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDO3i6Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DDE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cD9-0007y8-1J
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j6cCG-0006nF-UL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j6cCF-0003uf-18
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:32:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j6cCE-0003u0-SI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582644749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIqrJ2qe6A+CeUiIs7vju11pF2XCbFshG6bZiKgEZaY=;
 b=UDO3i6Nb6+w3opEJ+P8pOPpQUygA13ovbaZ9BLvHmRT/HuBOTTsFHg1mSrk0KbbYUG5b/O
 5Un0YAm3hbqjlz3S6eUMg8TtWc8mCs5d7AoyAHwNz/MTZRcCkF5/CgF9EnQNO83IZvg9sm
 IO6wzRclBdTc39TLbYEG4cUYDhHi58Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-W1oYUBHRPzOi0_FFfyaVbQ-1; Tue, 25 Feb 2020 10:32:27 -0500
X-MC-Unique: W1oYUBHRPzOi0_FFfyaVbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73651078D60;
 Tue, 25 Feb 2020 15:32:26 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0941001DC2;
 Tue, 25 Feb 2020 15:32:23 +0000 (UTC)
Date: Tue, 25 Feb 2020 10:32:23 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
Message-ID: <20200225153223.GJ4440@habkost.net>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
 <20200224181903.19790bad@redhat.com>
 <1a7b1dae-9600-1d29-d4d4-4fdfb6832b6f@amd.com>
 <20200224223149.GF4440@habkost.net>
 <5931c329-79ea-1f9c-5df7-db06d930a0e4@amd.com>
MIME-Version: 1.0
In-Reply-To: <5931c329-79ea-1f9c-5df7-db06d930a0e4@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 05:13:18PM -0600, Babu Moger wrote:
>=20
>=20
> On 2/24/20 4:31 PM, Eduardo Habkost wrote:
> > On Mon, Feb 24, 2020 at 11:58:09AM -0600, Babu Moger wrote:
> >>
> >>
> >> On 2/24/20 11:19 AM, Igor Mammedov wrote:
> >>> On Thu, 13 Feb 2020 12:17:46 -0600
> >>> Babu Moger <babu.moger@amd.com> wrote:
> >>>
> >>>> Check and Load the apicid handlers from X86CPUDefinition if availabl=
e.
> >>>> Update the calling convention for the apicid handlers.
> >>>
> >>> Previous and this patch look too complicated for the task at the hand=
.
> >>> In particular, cpu_x86_init_apicid_fns() from previous patch adds 1 m=
ore
> >>> reference to Machine into i386/cpu.c (even though it's just a helper =
function)
> >>> and I think un-necessary hooks to X86CPUDefinition (it's not really C=
PU's
> >>> businesses to make up APIC-IDs).
> >>>
> >>> I'd rather do opposite and get rid of the last explicit dependency to
> >>> ms->smp.cpus from cpu.c. But well, it's out of scope of this series,
> >>> so for this series I'd just try to avoid adding more Machine dependen=
cies.
> >>>
> >>> All 11/16 does is basically using hooks as a switch "I'm EPYC" to
> >>> set epyc specific encoding topo routines.
> >>>
> >>> It could be accomplished by a simple Boolean flag like
> >>>  X86CPUDefinition::use_epyc_apic_id_encoding
> >>>
> >>> and then cpu_x86_init_apicid_fns() could be replaced with trivial
> >>> helper like:
> >>>
> >>>   x86_use_epyc_apic_id_encoding(char *cpu_type)
> >>>   {
> >>>       X86CPUClass *xcc =3D ... cpu_type ...
> >>>       return xcc->model->cpudef->use_epyc_apic_id_encoding
> >>>   }
> >>>
> >>> then machine could override default[1] hooks using this helper
> >>> as the trigger
> >>>   x86_cpus_init()
> >>>   {
> >>>       // no need in dedicated function as it's the only instance it's=
 going to be called ever
> >>>       if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> >>>             x86ms->apicid_from_cpu_idx =3D ...epyc...
> >>>             x86ms->topo_ids_from_apicid =3D ...epyc...
> >>>             x86ms->apicid_from_topo_ids =3D ...epyc...
> >>>             x86ms->apicid_pkg_offset =3D ...epyc...
> >>>       }
> >>>   }
> >>>
> >>> That would be less invasive and won't create non necessary dependenci=
es.
> >>
> >> Yes. We can achieve the task here with your approach mentioned above. =
But,
> >> we still will have a scaling issue. In future if a "new cpu model" com=
es
> >> up its own decoding, then we need to add another bolean flag use_new
> >> _cpu_apic_id_encoding. And then do that same check again. In that sens=
e,
> >> the current approach is bit generic. Lets also hear from Eduardo.
> >=20
> > To be honest, I really hope the number of APIC ID initialization
> > variations won't grow in the future.
> >=20
> > In either case, X86MachineState really doesn't seem to be the
> > right place to save the function pointers.  Whether we choose a
> > boolean flag or a collection of function pointers, model-specific
> > information belong to x86CPUClass and/or X86CPUDefinition, not
> > MachineState.
>=20
> My bad. I completely missed that part. Yes. You mentioned that earlier.
> I can move the functions pointers to X86CPUClass and initialize the
> pointers from X86CPUDefinition. Thanks

See my reply to Igor before doing that.

Summary is: if the function implementations are provided by the
CPU, the pointers belong to X86CPUClass.  If the APIC ID
calculation logic lives in pc.c, the pointers probably can stay
in X86MachineState.

--=20
Eduardo


