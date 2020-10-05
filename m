Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E4FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A50F20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxkX0ekT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A50F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTKk-0006CH-3B
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPTIe-0004ZM-VQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPTIc-0006LB-2e
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601915115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZI+1ORyaGKDJkownlU7L2YNLxIF0skIUSBsxrZtf1ng=;
 b=RxkX0ekT+Bpc2m/C4HUXffRo8B+l0XbVQGjonAgKlYlxBFAp2xptR2pqZZKGzkQPRLye+I
 jruNLteWWfPiUFwo5GD89ZFhQoLWvh7mP3oG15eAkoCWNcB4JkQ82UIHJH3GEbJDaCI1Gx
 Dfxnr9I/lMN2qwfCkQNiex5pu7fD6M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574--xAXl0aAP9iuAben2Z7Fgw-1; Mon, 05 Oct 2020 12:25:14 -0400
X-MC-Unique: -xAXl0aAP9iuAben2Z7Fgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 377B7801ADD;
 Mon,  5 Oct 2020 16:25:12 +0000 (UTC)
Received: from localhost (unknown [10.40.208.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63D9A60CD0;
 Mon,  5 Oct 2020 16:25:04 +0000 (UTC)
Date: Mon, 5 Oct 2020 18:25:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 15/16] target/mips/cpu: Do not allow system-mode use
 without input clock
Message-ID: <20201005182502.00da41f4@redhat.com>
In-Reply-To: <35db3210-8165-6fe8-c835-22970fb31c93@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-16-f4bug@amsat.org>
 <20200929150154.04f77949@redhat.com>
 <35db3210-8165-6fe8-c835-22970fb31c93@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 16:40:24 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 9/29/20 3:01 PM, Igor Mammedov wrote:
> > On Mon, 28 Sep 2020 19:15:38 +0200
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> Now than all QOM users provides the input clock, do not allow
> >> using a CPU core without its input clock connected on system-mode
> >> emulation. For user-mode, keep providing a fixed 200 MHz clock,
> >> as it used by the RDHWR instruction (see commit cdfcad788394).
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >>
> >> We need the qtest check for tests/qtest/machine-none-test.c
> >> which instanciate a CPU with the none machine. Igor, is it
> >> better to remove the MIPS targets from the test cpus_map[]?
it will help to pass test but,

> >=20
> > I don't get idea, could you rephrase/elaborate? =20
>=20
> cpu_class_init sets:
>=20
>     /*
>      * Reason: CPUs still need special care by board code: wiring up
>      * IRQs, adding reset handlers, halting non-first CPUs, ...
>      */
>     dc->user_creatable =3D false;
>=20
> but the CPUs are created via another path in vl.c:
>=20
>         current_machine->cpu_type =3D parse_cpu_option(cpu_option);
>=20
> The machine-none-test assumes CPU objects are user-creatable.

user_creatable -> able to create using -device,=20
so test doesn't make this assumption.

problem is that enforcing would make machine-none not usable
for probing CPU features which is used by mgmt,
so that would break.

>=20
> With this patch I enforce MIPS CPU to have an input clock
> connected, so they are not user-creatable anymore.
>=20
> I tried this code ...:
>=20
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -229,7 +229,11 @@ static const TypeInfo mips_cpu_type_info =3D {
>  static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
>  {
>      MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(oc);
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
>      mcc->cpu_def =3D data;
> +    /* Reason: clock need to be wired up */
> +    dc->user_creatable =3D false;
>  }
>=20
> ... but it is ignored, the CPU can still be created.
>=20
> Not sure how to handle this.
>=20
> >  =20
> >> ---
> >>  target/mips/cpu.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> >> index 2f75216c324..cc4ee75af30 100644
> >> --- a/target/mips/cpu.c
> >> +++ b/target/mips/cpu.c
> >> @@ -25,6 +25,7 @@
> >>  #include "kvm_mips.h"
> >>  #include "qemu/module.h"
> >>  #include "sysemu/kvm.h"
> >> +#include "sysemu/qtest.h"
> >>  #include "exec/exec-all.h"
> >>  #include "hw/qdev-clock.h"
> >>  #include "hw/qdev-properties.h"
> >> @@ -159,11 +160,18 @@ static void mips_cpu_realizefn(DeviceState *dev,=
 Error **errp)
> >>      Error *local_err =3D NULL;
> >> =20
> >>      if (!clock_get(cs->clock)) {
> >> +#ifdef CONFIG_USER_ONLY
> >>          /*
> >>           * Initialize the frequency to 200MHz in case
> >>           * the clock remains unconnected.
> >>           */
> >>          clock_set_hz(cs->clock, 200000000);
> >> +#else
> >> +        if (!qtest_enabled()) {
> >> +            error_setg(errp, "CPU clock must be connected to a clock =
source");
> >> +            return;
> >> +        }
> >> +#endif
> >>      }
> >>      mips_cpu_clk_update(cs);
> >>   =20
> >  =20
>=20


