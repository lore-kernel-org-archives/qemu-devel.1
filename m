Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721CCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5152064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+j/vlDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5152064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNBuk-00083c-IA
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNBqL-0005wH-2A
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNBqG-0006Mw-0C
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:18:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNBqF-0006Kv-SP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571818681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ep2OfG4bk83EHlogHYeN5tVky9pYuKGNBE432rs1UQ=;
 b=Q+j/vlDVC6La6/hjIzKrmOw1GdnhEsANjwpKa0uCzqMJhpKeN5UyECiF6mxH42zl/uKFul
 YiV+i5m6a3lb0GrF6pmp4vLDZ5td/nEwBUlVEkHKO6FHIzWeGuE6rfYkV04jmgtPKINtU9
 h23cmIRM33ehRfW45vgnAJryXl7FAYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-InZQlKawMUi0vmNNpZ6PVQ-1; Wed, 23 Oct 2019 04:18:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0617B476;
 Wed, 23 Oct 2019 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-192.ams2.redhat.com
 [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42433600CC;
 Wed, 23 Oct 2019 08:17:51 +0000 (UTC)
Date: Wed, 23 Oct 2019 10:17:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 0/4] apic: Fix migration breakage of >255 vcpus
Message-ID: <20191023081750.GA6177@localhost.localdomain>
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016144001.GE4084@habkost.net> <20191019034153.GB9478@xz-x1>
 <20191023075701.GA18443@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20191023075701.GA18443@xz-x1>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: InZQlKawMUi0vmNNpZ6PVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Block List <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 jsnow@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.10.2019 um 09:57 hat Peter Xu geschrieben:
> On Sat, Oct 19, 2019 at 11:41:53AM +0800, Peter Xu wrote:
> > On Wed, Oct 16, 2019 at 11:40:01AM -0300, Eduardo Habkost wrote:
> > > On Wed, Oct 16, 2019 at 10:29:29AM +0800, Peter Xu wrote:
> > > > v2:
> > > > - use uint32_t rather than int64_t [Juan]
> > > > - one more patch (patch 4) to check dup SaveStateEntry [Dave]
> > > > - one more patch to define a macro (patch 1) to simplify patch 2
> > > >=20
> > > > Please review, thanks.
> > >=20
> > > I wonder how hard it is to write a simple test case to reproduce
> > > the original bug.  We can extend tests/migration-test.c or
> > > tests/acceptance/migration.py.  If using -device with explicit
> > > apic-id, we probably don't even need to create >255 VCPUs.
> >=20
> > I can give it a shot next week. :)
>=20
> When trying this, I probably noticed a block layer issue: q35 seems to
> have problem on booting from a very small block device (like 512B,
> which is the image size that currently used for migration-test.c).
> For example, this cmdline can boot successfully into the test image:
>=20
> $qemu -M pc -m 200m -accel kvm -nographic \
>       -drive file=3D$image,id=3Ddrive0,index=3D0,format=3Draw \
>       -device ide-hd,drive=3Ddrive0
>=20
> While this cannot:
>=20
> $qemu -M q35 -m 200m -accel kvm -nographic \
>       -drive file=3D$image,id=3Ddrive0,index=3D0,format=3Draw \
>       -device ide-hd,drive=3Ddrive0

The important difference here is legacy IDE (which works) vs. AHCI
(which doesn't work). If you add a -device ahci to the -M pc case, it
starts failing, too.

Not sure why AHCI fails, but I'll just CC John who is the lucky
maintainer of this device. :-)

Kevin

> With error (BIOS debug messages on):
>=20
> Booting from Hard Disk..invalid basic_access:143:
>    a=3D00000201  b=3D00000000  c=3D00000001  d=3D00000080 ds=3D0000 es=3D=
07c0 ss=3Dd980
>   si=3D00000000 di=3D00000000 bp=3D00000000 sp=3D0000fd8e cs=3Df000 ip=3D=
cb81  f=3D0202
> invalid basic_access:144:
>    a=3D00000201  b=3D00000000  c=3D00000001  d=3D00000080 ds=3D0000 es=3D=
07c0 ss=3Dd980
>   si=3D00000000 di=3D00000000 bp=3D00000000 sp=3D0000fd8e cs=3Df000 ip=3D=
cb81  f=3D0202
> .
> Boot failed: could not read the boot disenter handle_18:
>   NULL
> k
>=20
> This corresponds to this SeaBIOS check error:
>=20
> static void noinline
> basic_access(struct bregs *regs, struct drive_s *drive_fl, u16 command)
> {
>     ...
>     // sanity check on cyl heads, sec
>     if (cylinder >=3D nlc || head >=3D nlh || sector > nls) {
>         warn_invalid(regs);
>         disk_ret(regs, DISK_RET_EPARAM);
>         return;
>     }
>     ...
> }
>=20
> And... below cmdline will work even for q35 (as suggested by Fam when
> we talked offline):
>=20
> $qemu -M q35 -m 200m -accel kvm -nographic \
>       -drive file=3D$image,id=3Ddrive0,index=3D0,format=3Draw \
>       -device ide-hd,drive=3Ddrive0,secs=3D1,cyls=3D1,heads=3D1
>=20
> I think for migration test we can workaround like above, but I'm also
> curious whether this is a real bug somewhere because I don't see a
> reason for q35 to refuse to boot on a one-sector image.
>=20
> Thanks,
>=20
> --=20
> Peter Xu
>=20


