Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E58EC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0382070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZSPrRSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0382070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqaC-0003TU-71
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iwqZW-000314-Ha
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iwqZV-0005N8-20
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:52:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iwqZU-0005M8-Ua
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580316728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqQVLwbvzPyqTHaSTizsALCa2Mf6mVPs/3IzaAUyra4=;
 b=eZSPrRSbMVT4sjAzZSpAzrnJacFTyg3smPJLaovnC/z96TYk7BgfaIysbQqS/CS0y9hpmi
 9/r8LTHwMrEfw1riUvitHpWdM/zgn4OCe8yIiuGrn27hD2Fz3wVCy7K1H5EhihHTvR2lMk
 s0NgaNP6Zl4YNJPcKuYX4jsW7f0t5vU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197--_Mszf_KOUSXUL8RBEJVsg-1; Wed, 29 Jan 2020 11:52:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92D231085982;
 Wed, 29 Jan 2020 16:52:01 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5794787B32;
 Wed, 29 Jan 2020 16:51:34 +0000 (UTC)
Date: Wed, 29 Jan 2020 11:51:33 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
Message-ID: <20200129165133.GR18770@habkost.net>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
 <20200129101458.6a108431@redhat.com>
 <49869aff-011a-9ab9-6aeb-09c8009b7eb6@amd.com>
MIME-Version: 1.0
In-Reply-To: <49869aff-011a-9ab9-6aeb-09c8009b7eb6@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: -_Mszf_KOUSXUL8RBEJVsg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Wed, Jan 29, 2020 at 10:32:01AM -0600, Babu Moger wrote:
>=20
>=20
> On 1/29/20 3:14 AM, Igor Mammedov wrote:
> > On Tue, 28 Jan 2020 13:45:31 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >=20
> >> On 1/28/20 10:29 AM, Igor Mammedov wrote:
> >>> On Tue, 03 Dec 2019 18:37:42 -0600
> >>> Babu Moger <babu.moger@amd.com> wrote:
> >>>  =20
> >>>> Add a new function init_apicid_fn in MachineClass to initialize the =
mode
> >>>> specific handlers to decode the apic ids.
> >>>>
> >>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >>>> ---
> >>>>  include/hw/boards.h |    1 +
> >>>>  vl.c                |    3 +++
> >>>>  2 files changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >>>> index d4fab218e6..ce5aa365cb 100644
> >>>> --- a/include/hw/boards.h
> >>>> +++ b/include/hw/boards.h
> >>>> @@ -238,6 +238,7 @@ struct MachineClass {
> >>>>                                                           unsigned c=
pu_index);
> >>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *mac=
hine);
> >>>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int =
idx);
> >>>> +    void (*init_apicid_fn)(MachineState *ms); =20
> >>> it's x86 specific, so why it wasn put into PCMachineClass? =20
> >>
> >> Yes. It is x86 specific for now. I tried to make it generic function s=
o
> >> other OSes can use it if required(like we have done in
> >> possible_cpu_arch_ids). It initializes functions required to build the
> >> apicid for each CPUs. We need these functions much early in the
> >> initialization. It should be initialized before parse_numa_opts or
> >> machine_run_board_init(in v1.c) which are called from generic context.=
 We
> >> cannot use PCMachineClass at this time.
> >=20
> > could you point to specific patches in this series that require
> > apic ids being initialized before parse_numa_opts and elaborate why?
> >=20
> > we already have possible_cpu_arch_ids() which could be called very
> > early and calculates APIC IDs in x86 case, so why not reuse it?
>=20
> Forgot to respond to this. The possible_cpu_arch_ids does not use the num=
a
> information to build the apic id. We cannot re-use it without changing it
> drastically.

I don't get it.  I see multiple patches in this series changing
pc_possible_cpu_arch_ids() (which is really expected, if you are
changing how APIC IDs are generated).

--=20
Eduardo


