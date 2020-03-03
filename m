Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DFFC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC84420848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7vfY7UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC84420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9CZZ-0008LY-2N
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 13:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j9CYY-0007CA-1Q
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j9CYW-0006Xv-Gr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:46:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j9CYW-0006XK-DI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583261171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdaek6mH06AiyslCL6zYAbFOzmlp52saOdk1aO6RPWk=;
 b=L7vfY7UHWwrNrLeyR6NjXBWUcF1S3idPp/wcDznkPD7FOzhyqxPf7rEaNuyU/ANh9FdLCD
 1ydvEHUNz015qw977PFVeW814L8eCUJJQMCcWYh9H1BuomnCTUeFXcPkatZWZBpfz1p1zC
 VPGlivHfO7cVwJZMl18aFU+5hnSARFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-VEHNHEayPreLKV5sshcqLA-1; Tue, 03 Mar 2020 13:46:07 -0500
X-MC-Unique: VEHNHEayPreLKV5sshcqLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B88F101FC64;
 Tue,  3 Mar 2020 18:46:03 +0000 (UTC)
Received: from localhost (ovpn-122-157.rdu2.redhat.com [10.10.122.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D69A5C1D4;
 Tue,  3 Mar 2020 18:45:58 +0000 (UTC)
Date: Tue, 3 Mar 2020 13:45:57 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] cpu: Use DeviceClass reset instead of a special CPUClass
 reset
Message-ID: <20200303184557.GV4440@habkost.net>
References: <20200303100511.5498-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200303100511.5498-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 03, 2020 at 10:05:11AM +0000, Peter Maydell wrote:
> The CPUClass has a 'reset' method.  This is a legacy from when
> TYPE_CPU used not to inherit from TYPE_DEVICE.  We don't need it any
> more, as we can simply use the TYPE_DEVICE reset.  The 'cpu_reset()'
> function is kept as the API which most places use to reset a CPU; it
> is now a wrapper which calls device_cold_reset() and then the
> tracepoint function.
>=20
> This change should not cause CPU objects to be reset more often
> than they are at the moment, because:
>  * nobody is directly calling device_cold_reset() or
>    qdev_reset_all() on CPU objects
>  * no CPU object is on a qbus, so they will not be reset either
>    by somebody calling qbus_reset_all()/bus_cold_reset(), or
>    by the main "reset sysbus and everything in the qbus tree"
>    reset that most devices are reset by
>=20
> Note that this does not change the need for each machine or whatever
> to use qemu_register_reset() to arrange to call cpu_reset() -- that
> is necessary because CPU objects are not on any qbus, so they don't
> get reset when the qbus tree rooted at the sysbus bus is reset, and
> this isn't being changed here.
>=20
> All the changes to the files under target/ were made using the
> included Coccinelle script, except:
>=20
> (1) the deletion of the now-inaccurate and not terribly useful
> "CPUClass::reset" comments was done with a perl one-liner afterwards:
>   perl -n -i -e '/ CPUClass::reset/ or print' target/*/*.c
>=20
> (2) this bit of the s390 change was done by hand, because the
> Coccinelle script is not sophisticated enough to handle the
> parent_reset call being inside another function:
>=20
> | @@ -96,8 +96,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_typ=
e type)
> |     S390CPU *cpu =3D S390_CPU(s);
> |     S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
> |     CPUS390XState *env =3D &cpu->env;
> |+    DeviceState *dev =3D DEVICE(s);
> |
> |-    scc->parent_reset(s);
> |+    scc->parent_reset(dev);
> |     cpu->env.sigp_order =3D 0;
> |     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Queued, thanks.

However, if you want to do additional arch-specific work on top
of this patch, feel free to merge it through your tree.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo


