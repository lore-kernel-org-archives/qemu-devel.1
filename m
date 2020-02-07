Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98727C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639C920726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTfiEoh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639C920726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00VJ-0002xh-Jo
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j00Ug-0002WV-Gi
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j00Ue-0003EO-Sl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:04:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j00Ue-0003CZ-Oq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581069851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wd3VVIn2Cg5Lx8EL/fcabqug1FxAvnJAMcMDKwmtwJ0=;
 b=aTfiEoh5bl4dx7xeu/7g9D36uP0/0fY8N9uLIsjflZJE985tgBkovuWDkaU7GNiEqHOCBa
 ITEhQixj/frXDqfTmSHaCnoRv69Wz9tfIkDDmQ4TrHTGHQkchRBX0vUIyamdJSfUgDADao
 uPecOr0+U6qEMUDRC/QbOFY/CQ6dXoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-D_9-N9N1NdaErRoDnHsr5A-1; Fri, 07 Feb 2020 05:04:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78801101FC6D;
 Fri,  7 Feb 2020 10:04:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B3DC857BF;
 Fri,  7 Feb 2020 10:04:04 +0000 (UTC)
Date: Fri, 7 Feb 2020 11:04:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Igor =?UTF-8?B?S290cmFzacWEc2tp?= <i.kotrasinsk@partner.samsung.com>
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
Message-ID: <20200207110403.08a8a7cc@redhat.com>
In-Reply-To: <91d3f574-3a4f-8291-040e-520c5c58e77e@partner.samsung.com>
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
 <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <20200205143911.GG58062@stefanha-x1.localdomain>
 <1e872eb3-a21b-0f9b-e6a4-54843a028bed@siemens.com>
 <91d3f574-3a4f-8291-040e-520c5c58e77e@partner.samsung.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: D_9-N9N1NdaErRoDnHsr5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>,
 pbonzini@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 10:00:50 +0100
Igor Kotrasi=C5=84ski <i.kotrasinsk@partner.samsung.com> wrote:

> On 2/5/20 3:49 PM, Jan Kiszka wrote:
> > On 05.02.20 15:39, Stefan Hajnoczi wrote: =20
> >> On Tue, Feb 04, 2020 at 12:30:42PM +0100,=20
> >> i.kotrasinsk@partner.samsung.com wrote: =20
> >>> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> >>>
> >>> This patchset adds a "memory exposing" device that allows two QEMU
> >>> instances to share arbitrary memory regions. Unlike ivshmem, it does =
not
> >>> create a new region of memory that's shared between VMs, but instead
> >>> allows one VM to access any memory region of the other VM we choose t=
o
> >>> share.
> >>>
> >>> The motivation for this device is a sort of ARM Trustzone "emulation"=
,
> >>> where a rich system running on one machine (e.g. x86_64 linux) is abl=
e
> >>> to perform SMCs to a trusted system running on another (e.g. OpTEE on
> >>> ARM). With a device that allows sharing arbitrary memory between VMs,
> >>> this can be achieved with minimal changes to the trusted system and i=
ts
> >>> linux driver while allowing the rich system to run on a speedier x86
> >>> emulator. I prepared additional patches for linux, OpTEE OS and OpTEE
> >>> build system as a PoC that such emulation works and passes OpTEE test=
s;
> >>> I'm not sure what would be the best way to share them.
> >>>
> >>> This patchset is my first foray into QEMU source code and I'm certain
> >>> it's not yet ready to be merged in. I'm not sure whether memory shari=
ng
> >>> code has any race conditions or breaks rules of working with memory
> >>> regions, or if having VMs communicate synchronously via chardevs is t=
he
> >>> right way to do it. I do believe the basic idea for sharing memory
> >>> regions is sound and that it could be useful for inter-VM communicati=
on. =20
> >>
> >> Hi,
> >> Without having looked into the patches yet, I'm already wondering if y=
ou
> >> can use the existing -object
> >> memory-backend-file,size=3D512M,mem-path=3D/my/shared/mem feature for =
your
> >> use case?
> >>
> >> That's the existing mechanism for fully sharing guest RAM and if you
> >> want to share all of memory then maybe a device is not necessary - jus=
t
> >> share the memory. =20
>=20
> That option adds memory in addition to the memory allocated with the=20
> '-m' flag, doesn't it? I looked into that option, and it seemed to me=20
> you can't back all memory this way.
with current QEMU you play with memory sharing using numa workaround

-m 512 \
-object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared/mem =
feature,share=3Don \
-numa node,memdev=3Dmem

also on the list there is series that allows to share main ram
without numa workaround, see
  "[PATCH v4 00/80] refactor main RAM allocation to use hostmem backend"

with it applied you can share main RAM with following CLI:

-object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared/mem =
feature,share=3Don \
-m 512 \
-M virt,memory-backend=3Dmem

> Apart from that, the only advantage my solution has is that it's aware=20
> of any memory overlaying the memory-backed regions (i.e. memory backed=20
> by accessor functions). Maybe I don't need this for my use case, I'd=20
> have to test that.
>=20
> >=20
> > I suspect it's about sharing that memory in a discoverable way. Maybe i=
t=20
> > is also about the signalling channel defined in the device.
> >=20
> > OTOH, when it's really about sharing everything, even bidirectional,=20
> > that rather looks like a pragmatic shortcut, not a generic model.
> >=20
> > The patches should clarify their use case a bit further, I think. The=
=20
> > title suggests a generic sharing solution, but my impression is that it=
=20
> > rather caters a specific case under specific boundary conditions.
> >=20
> > Jan
> >  =20
>=20
> The solution does stem from a specific use case, the ARM Trustzone=20
> forwarding described in the cover letter. Normally both OSes can pass=20
> data around by sharing physical addresses (potentially from anywhere in=
=20
> memory), so giving VMs an ability to access one another's memory no=20
> matter how it's backed allows for minimal trusted OS modification, just=
=20
> offsetting physical addresses. The interrupt functionality also reflects=
=20
> this, it's intended to pass around SMC data.
>=20
> I realize that this kind of total memory sharing couples the two VMs=20
> tightly - this is why I'm asking for comments on this, perhaps there's a=
=20
> better solution for this specific scenario.
>=20
> For what it's worth, the extent of this sharing can be reduced by using=
=20
> a limited MemoryRegion like it's done for secure and non-secure memory=20
> views on ARM.
>=20
> Igor
>=20


