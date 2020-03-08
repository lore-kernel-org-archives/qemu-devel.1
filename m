Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70D820828
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gowmXYJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70D820828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAvwv-0002yP-QL
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAvwJ-0002Ym-Cg
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAvwH-0003Hp-Mf
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:25:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49335
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAvwH-0003HS-IK
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583673952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7K3EeefFiCvfXyQXPWUavRtyXjgAJA4zwdU3ec2RzlE=;
 b=gowmXYJf1NNxb9oH3bUk3W1MSjSUhljNtwySICDF3Rj1/tM9QZIAYToV8wJzVCNHmNmQ14
 YsDV67QC4+pfiit9AN7+Zlcd7DllBSTLzLXiEMgRDiXnGhOJ1tcicbEcZdSUCryFWo1KUC
 8V0utTMp2Xp6t42grFIhwilrT2tA/NU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-P8JzpBRyN_2eu9n2hhtT8A-1; Sun, 08 Mar 2020 09:25:46 -0400
X-MC-Unique: P8JzpBRyN_2eu9n2hhtT8A-1
Received: by mail-qv1-f71.google.com with SMTP id j15so4952402qvp.21
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=U1G5K2zzl7Q8p0dM7LXSQjoarRIzv8eYtqvhcA87k2Y=;
 b=UMH8KIKippcC3vSZA5TwaypBz4Izi+2obkwWJ/R340gKU1MgfUil43IQFghM+kMZJI
 pzssVn29T//TLCTb459BfWGo2SZ6LUn4ZnqnaVdJ4F+MGBy+GH6IOcPQ1rgfGXGPfPI2
 vBu1GpgKkFIftSI0xHbQ4QYF+kawih1HvHtXMfM/A0xeotNTebgkrv36quH8IVi1xoGa
 nz8WXDqr0D02/THladpGbEMJ7FyGrexGYMxuw7VzCzB5myOcL9CjFiGfQt9gWnhqRcxA
 8qX9Ga0qYaoMX0GWXFCu5bPlyuLGSxJ6PJCXCRTJClHfKpVdtAlszpagA5C6U8GFMTxj
 njvg==
X-Gm-Message-State: ANhLgQ0Wz8iQcZ69ccXnBVFnn2PH6qEepWBQV6lxl3/WJ7unscUCg+0C
 VQ4ZyyFbBx0GYHPjF5+4+O5vpHVkick7lq2T47ryQMaqTxoN2drEeBxRVx3CUZhr+bIoBEkvXJf
 BDQaOVekt94h0OJg=
X-Received: by 2002:a05:6214:1627:: with SMTP id
 e7mr10997882qvw.43.1583673945813; 
 Sun, 08 Mar 2020 06:25:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubK1KzQx+NQxeaWDpbc2PWuLg65vqov71YKuYJQpU6nIrWZ+RSemg0Y95o9NKOsKTUsx8GvA==
X-Received: by 2002:a05:6214:1627:: with SMTP id
 e7mr10997864qvw.43.1583673945478; 
 Sun, 08 Mar 2020 06:25:45 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id x44sm19931830qtc.88.2020.03.08.06.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 06:25:44 -0700 (PDT)
Date: Sun, 8 Mar 2020 09:25:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 00/16] APIC ID fixes for AMD EPYC CPU model
Message-ID: <20200308092458-mutt-send-email-mst@kernel.org>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 03, 2020 at 01:56:51PM -0600, Babu Moger wrote:
> This series fixes APIC ID encoding problem reported on AMD EPYC cpu model=
s.
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166
>=20
> Currently, the APIC ID is decoded based on the sequence
> sockets->dies->cores->threads. This works for most standard AMD and other
> vendors' configurations, but this decoding sequence does not follow that =
of
> AMD's APIC ID enumeration strictly. In some cases this can cause CPU topo=
logy
> inconsistency.  When booting a guest VM, the kernel tries to validate the
> topology, and finds it inconsistent with the enumeration of EPYC cpu mode=
ls.
>=20
> To fix the problem we need to build the topology as per the Processor
> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> Processors. The documentation is available from the bugzilla Link below.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>=20
> Here is the text from the PPR.
> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSize=
], the
> number of least significant bits in the Initial APIC ID that indicate cor=
e ID
> within a processor, in constructing per-core CPUID masks.
> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of cor=
es
> (MNC) that the processor could theoretically support, not the actual numb=
er of
> cores that are actually implemented or enabled on the processor, as indic=
ated
> by Core::X86::Cpuid::SizeId[NC].
> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> =E2=80=A2 ApicId[6] =3D Socket ID.
> =E2=80=A2 ApicId[5:4] =3D Node ID.
> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Lo=
gicalCoreID[1:0]}


Looks reasonable:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

belongs in Eduardo's tree I guess.

> v5:
>  Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-=
next).
>  Changes from v4.
>  1. Re-arranged the patches 2 and 4 as suggested by Igor.
>  2. Kept the apicid handler functions inside X86MachineState as discussed=
.
>     These handlers are loaded from X86CPUDefinitions.
>  3. Removed unnecessary X86CPUstate initialization from x86_cpu_new. Sugg=
ested
>     by Igor.
>  4. And other minor changes related to patch format.
>=20
> v4:
>  https://lore.kernel.org/qemu-devel/158161767653.48948.105780644828783995=
56.stgit@naples-babu.amd.com/
>  Changes from v3.
>  1. Moved the arch_id calculation inside the function x86_cpus_init. With=
 this change,
>     we dont need to change common numa code.(suggested by Igor)
>  2. Introduced the model specific handlers inside X86CPUDefinitions.
>     These handlers are loaded into X86MachineState during the init.
>  3. Removed llc_id from x86CPU.
>  4. Removed init_apicid_fn hanlder from MachineClass. Kept all the code c=
hanges
>     inside the x86.
>  5. Added new handler function apicid_pkg_offset for pkg_offset calculati=
on.
>  6. And some Other minor changes.
>=20
> v3:
>   https://lore.kernel.org/qemu-devel/157541968844.46157.17994918142533791=
313.stgit@naples-babu.amd.com/=20
>   1. Consolidated the topology information in structure X86CPUTopoInfo.
>   2. Changed the ccx_id to llc_id as commented by upstream.
>   3. Generalized the apic id decoding. It is mostly similar to current ap=
ic id
>      except that it adds new field llc_id when numa configured. Removes a=
ll the
>      hardcoded values.
>   4. Removed the earlier parse_numa split. And moved the numa node initia=
lization
>      inside the numa_complete_configuration. This is bit cleaner as comme=
nted by=20
>      Eduardo.
>   5. Added new function init_apicid_fn inside machine_class structure. Th=
is
>      will be used to update the apic id handler specific to cpu model.
>   6. Updated the cpuid unit tests.
>   7. TODO : Need to figure out how to dynamically update the handlers usi=
ng cpu models.
>      I might some guidance on that.
>=20
> v2:
>   https://lore.kernel.org/qemu-devel/156779689013.21957.16315515729506762=
12.stgit@localhost.localdomain/
>   1. Introduced the new property epyc to enable new epyc mode.
>   2. Separated the epyc mode and non epyc mode function.
>   3. Introduced function pointers in PCMachineState to handle the
>      differences.
>   4. Mildly tested different combinations to make things are working as e=
xpected.
>   5. TODO : Setting the epyc feature bit needs to be worked out. This fea=
ture is
>      supported only on AMD EPYC models. I may need some guidance on that.
>=20
> v1:
>   https://lore.kernel.org/qemu-devel/20190731232032.51786-1-babu.moger@am=
d.com/
>=20
> ---
>=20
> Babu Moger (16):
>       hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
>       hw/i386: Consolidate topology functions
>       machine: Add SMP Sockets in CpuTopology
>       hw/i386: Remove unnecessary initialization in x86_cpu_new
>       hw/i386: Update structures to save the number of nodes per package
>       hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids
>       hw/386: Add EPYC mode topology decoding functions
>       target/i386: Cleanup and use the EPYC mode topology functions
>       hw/i386: Introduce apicid functions inside X86MachineState
>       target/i386: Load apicid model specific handlers from X86CPUDefinit=
ion
>       hw/i386: Use the apicid handlers from X86MachineState
>       target/i386: Add EPYC model specific handlers
>       hw/i386: Move arch_id decode inside x86_cpus_init
>       i386: Fix pkg_id offset for EPYC cpu models
>       tests: Update the Unit tests
>=20
>=20
>  hw/core/machine.c          |    1=20
>  hw/i386/pc.c               |   54 ++++++-----
>  hw/i386/x86.c              |   72 ++++++++++----
>  include/hw/boards.h        |    2=20
>  include/hw/i386/topology.h |  215 ++++++++++++++++++++++++++++++--------=
----
>  include/hw/i386/x86.h      |   12 ++
>  target/i386/cpu.c          |  224 +++++++++++++++++---------------------=
------
>  target/i386/cpu.h          |    3 +
>  tests/test-x86-cpuid.c     |  115 +++++++++++++----------
>  vl.c                       |    1=20
>  10 files changed, 403 insertions(+), 296 deletions(-)
>=20
> --
> Signature


