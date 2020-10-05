Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8347AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFB920774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hysPRBCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFB920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTYT-0002w4-KM
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPTXH-0001tL-Vr
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPTXE-00009A-TL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601916023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OK4Zm+CDihcj7rnMnXkHEuEcrJFYNjGqyRUOrY+EdNY=;
 b=hysPRBCD27yf1Bpx6fCocayKnriida6f7faLtIFZhPL78axJpVWx/PGcwl9tL3rqcrNk3F
 48JK1pGtm3AkSkPNaQd/yucDRHsvWk+Q0wikLKq35Ky3tVvewDExqNLuUiAsoIqPxpkhYJ
 FQwE7YnZfiWuXS6GaJFpQ8MzjLdcWuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-3hj0ReY8O5OU_QQPhm2HCA-1; Mon, 05 Oct 2020 12:40:21 -0400
X-MC-Unique: 3hj0ReY8O5OU_QQPhm2HCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 737CFE0040;
 Mon,  5 Oct 2020 16:40:19 +0000 (UTC)
Received: from localhost (unknown [10.40.208.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49D545C221;
 Mon,  5 Oct 2020 16:40:11 +0000 (UTC)
Date: Mon, 5 Oct 2020 18:40:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 01/16] hw/core/cpu: Let CPU object have a clock source
Message-ID: <20201005184009.493629b0@redhat.com>
In-Reply-To: <da7248f7-5098-188b-d274-e122c87bb498@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-2-f4bug@amsat.org>
 <20200930094313.1120a040@redhat.com>
 <da7248f7-5098-188b-d274-e122c87bb498@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Sep 2020 12:16:53 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> +arm/ppc/riscv folks
>=20
> On 9/30/20 9:43 AM, Igor Mammedov wrote:
> > On Mon, 28 Sep 2020 19:15:24 +0200
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> Let CPUState have a clock source (named 'clk') and CPUClass
> >> have a clock_update() callback. The clock can be optionally
> >> set Using qdev_connect_clock_in() from the Clock API.
> >> If the clock changes, the optional clock_update() will be
> >> called. =20
> >=20
> > the sole user of it is mips cpu, so question is why
> > you are making it part of generic CPUm instead of
> > MIPSCPUClass/MIPSCPU? =20
>=20
> This is a feature of the CPU, regardless its architecture.
>=20
> I expect the other archs to start using it soon.

if there aren't any plans to actually to do that,
I'd keep it to MIPS class and generalize later when there is demand.
=20
>=20
> >  =20
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  include/hw/core/cpu.h |  5 +++++
> >>  hw/core/cpu.c         | 12 ++++++++++++
> >>  2 files changed, 17 insertions(+)
> >>
> >> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> >> index 6c34798c8b3..6989d90c193 100644
> >> --- a/include/hw/core/cpu.h
> >> +++ b/include/hw/core/cpu.h
> >> @@ -31,6 +31,7 @@
> >>  #include "qemu/thread.h"
> >>  #include "qemu/plugin.h"
> >>  #include "qom/object.h"
> >> +#include "hw/clock.h"
> >> =20
> >>  typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
> >>                                       void *opaque);
> >> @@ -155,6 +156,7 @@ struct TranslationBlock;
> >>   * @disas_set_info: Setup architecture specific components of disasse=
mbly info
> >>   * @adjust_watchpoint_address: Perform a target-specific adjustment t=
o an
> >>   * address before attempting to match it against watchpoints.
> >> + * @clock_update: Callback for input clock changes
> >>   *
> >>   * Represents a CPU family or model.
> >>   */
> >> @@ -176,6 +178,7 @@ struct CPUClass {
> >>                                    unsigned size, MMUAccessType access=
_type,
> >>                                    int mmu_idx, MemTxAttrs attrs,
> >>                                    MemTxResult response, uintptr_t ret=
addr);
> >> +    void (*clock_update)(CPUState *cpu);
> >>      bool (*virtio_is_big_endian)(CPUState *cpu);
> >>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
> >>                             uint8_t *buf, int len, bool is_write);
> >> @@ -316,6 +319,7 @@ struct qemu_work_item;
> >>   *   QOM parent.
> >>   * @nr_cores: Number of cores within this CPU package.
> >>   * @nr_threads: Number of threads within this CPU.
> >> + * @clock: this CPU source clock (an output clock of another device)
> >>   * @running: #true if CPU is currently running (lockless).
> >>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_=
end;
> >>   * valid under cpu_list_lock.
> >> @@ -400,6 +404,7 @@ struct CPUState {
> >>      int num_ases;
> >>      AddressSpace *as;
> >>      MemoryRegion *memory;
> >> +    Clock *clock;
> >> =20
> >>      void *env_ptr; /* CPUArchState */
> >>      IcountDecr *icount_decr_ptr;
> >> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> >> index c55c09f734c..37fcff3ec64 100644
> >> --- a/hw/core/cpu.c
> >> +++ b/hw/core/cpu.c
> >> @@ -30,6 +30,7 @@
> >>  #include "qemu/qemu-print.h"
> >>  #include "sysemu/tcg.h"
> >>  #include "hw/boards.h"
> >> +#include "hw/qdev-clock.h"
> >>  #include "hw/qdev-properties.h"
> >>  #include "trace/trace-root.h"
> >>  #include "qemu/plugin.h"
> >> @@ -247,6 +248,16 @@ void cpu_reset(CPUState *cpu)
> >>      trace_guest_cpu_reset(cpu);
> >>  }
> >> =20
> >> +static void cpu_clk_update(void *opaque)
> >> +{
> >> +    CPUState *cpu =3D opaque;
> >> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> >> +
> >> +    if (cc->clock_update) {
> >> +        cc->clock_update(cpu);
> >> +    }
> >> +}
> >> +
> >>  static void cpu_common_reset(DeviceState *dev)
> >>  {
> >>      CPUState *cpu =3D CPU(dev);
> >> @@ -367,6 +378,7 @@ static void cpu_common_initfn(Object *obj)
> >>      /* the default value is changed by qemu_init_vcpu() for softmmu *=
/
> >>      cpu->nr_cores =3D 1;
> >>      cpu->nr_threads =3D 1;
> >> +    cpu->clock =3D qdev_init_clock_in(DEVICE(obj), "clk", cpu_clk_upd=
ate, cpu);
> >> =20
> >>      qemu_mutex_init(&cpu->work_mutex);
> >>      QSIMPLEQ_INIT(&cpu->work_list); =20
> >  =20
>=20


