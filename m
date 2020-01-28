Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9E1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DF620708
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaGZ38R7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DF620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwXEG-0001BA-MX
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iwXDY-00007V-Ra
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iwXDW-00062M-II
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:12:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iwXDW-00061k-DK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580242329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDI3a729Ba74N5OXJ+rWZzpeVwbPoD+JAMo+l+0rEBg=;
 b=QaGZ38R71unxuIlzBr+lH2VEfoTF3LG2+V7rKWPR5iPsY6IuvxYmiPTOglnb+u4snWmQvU
 RAoQ8BB+OsG5cWL1lZ7LzVkrG4F4JEAsX5HXOW7CA6M1bZxYprgJGK0TsL4EtP49ByL+r8
 Bcqo6zUAvqkdksuihB9InDgT7q8vOrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-HTQPd9XFMeWOy_l2S7PV4A-1; Tue, 28 Jan 2020 15:12:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9419A107ACC9;
 Tue, 28 Jan 2020 20:12:05 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF95F100194E;
 Tue, 28 Jan 2020 20:12:02 +0000 (UTC)
Date: Tue, 28 Jan 2020 15:12:02 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
Message-ID: <20200128201202.GK18770@habkost.net>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
MIME-Version: 1.0
In-Reply-To: <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HTQPd9XFMeWOy_l2S7PV4A-1
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
Cc: mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 01:45:31PM -0600, Babu Moger wrote:
>=20
>=20
> On 1/28/20 10:29 AM, Igor Mammedov wrote:
> > On Tue, 03 Dec 2019 18:37:42 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >=20
> >> Add a new function init_apicid_fn in MachineClass to initialize the mo=
de
> >> specific handlers to decode the apic ids.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  include/hw/boards.h |    1 +
> >>  vl.c                |    3 +++
> >>  2 files changed, 4 insertions(+)
> >>
> >> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >> index d4fab218e6..ce5aa365cb 100644
> >> --- a/include/hw/boards.h
> >> +++ b/include/hw/boards.h
> >> @@ -238,6 +238,7 @@ struct MachineClass {
> >>                                                           unsigned cpu=
_index);
> >>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machi=
ne);
> >>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int id=
x);
> >> +    void (*init_apicid_fn)(MachineState *ms);
> > it's x86 specific, so why it wasn put into PCMachineClass?
>=20
> Yes. It is x86 specific for now. I tried to make it generic function so
> other OSes can use it if required(like we have done in
> possible_cpu_arch_ids). It initializes functions required to build the
> apicid for each CPUs. We need these functions much early in the
> initialization. It should be initialized before parse_numa_opts or
> machine_run_board_init(in v1.c) which are called from generic context. We
> cannot use PCMachineClass at this time.

Even if the only user of the new hook will be x86, you are
introducing a generic API, so a x86-specific name doesn't seem
appropriate.

I suggest using a generic name and documenting its rules and
intended usage explicitly.  Something like "pre_init" might be
good enough, as long as the rules documented clearly (e.g. it
will be called before NUMA initialization, but after CPU model
lookup).

However, I believe we can implement the same functionality
without a new generic initialization hook.  See my reply to patch
16/18.

>=20
> >=20
> >=20
> >>  };
> >> =20
> >>  /**
> >> diff --git a/vl.c b/vl.c
> >> index a42c24a77f..b6af604e11 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
> >>      current_machine->cpu_type =3D machine_class->default_cpu_type;
> >>      if (cpu_option) {
> >>          current_machine->cpu_type =3D parse_cpu_option(cpu_option);
> >> +        if (machine_class->init_apicid_fn) {
> >> +            machine_class->init_apicid_fn(current_machine);
> >> +        }
> >>      }
> >>      parse_numa_opts(current_machine);
> >> =20
> >>
> >>
> >=20
>=20

--=20
Eduardo


