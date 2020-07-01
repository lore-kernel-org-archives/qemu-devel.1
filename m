Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA11C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EB12083E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DbiHv1Mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EB12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqegM-0002UX-Vn
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1jqedH-0008I2-Ky
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:26:43 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com
 ([40.107.69.122]:50240 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1jqedF-00058s-AZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfoCexHqpwWIFgKhnnpH0eqkve7aGZndPaSBcSgZrqHvFU3/+cNzAG2+luQyqlsbX+7A9d2XF92EZRUYU2dqaVLI5rkPhok4anvsfSrUMp/ULeZolh56hkne53xHMgZO1lqALMY2F4M1Q8CxciQ0n+58ZuCfnUx8B+DfGGdhXhBW1cfURnaifu+EcYBA9yOQkMV0CUrmkBbWP2pa8BaAApxX0mHAViKkJE6XppYr1z9P85QVfk4BzM3EP/6kI5rVBCMc3gR2MsH7MXGiIWvS7RJ601ZlsqVrvr+kUn/LZAUcdafR55si8KGz0adQWQP3FzLi8GsE6xVbdOnIrTtsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXeD+JqxheDi2RbuqUCalSAsrII1tG327QkRZgHAnXU=;
 b=DkEf2nc91osLRNTFXVuIemgjb4zi2LOChRBcsmNRuphjR2L09Ekq3p3WA1KBZWSh7G0ScLn3ENO/q+87uGkSuTGZ+7zjrgW7sD1KhcnPMvQqhCOrU4DnDWpbDo25pBPLe4aSzulrvmAbSNP2Uu4b2a496Pfb0qhcWUU6dfLKHdDSILwDaW/NWBLSRTjOUtBVj4U5TGqnWnV2+jJQumoSgaKyq2HPns7TBIAN2SOsBKC4ohOYn+YTnyzRiHtj7H9WQT8cNEOuwYP1c9H7QCUsSsvUDopKOf6NyvxmPw4+hCi4VdUb7jXTabhvXwlSbM8+UNHaOfR7b41MC7BZ+3zGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXeD+JqxheDi2RbuqUCalSAsrII1tG327QkRZgHAnXU=;
 b=DbiHv1Mbsd0bmwuMZ6Fpu51c2aR5iSlTIoz6lmYCNja73PPcW2U9bEBD9keisL73RxXpcB2e+GdtlGPh+B5bE6vrAoXAAdR0oK4ekIiKd5dirBEcYcQsDAHVxnpCD2R2Lm4R1PwJ+xJTogZp/TP3QsmW8/C1OWMli3sj9UM0sbM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from SN6PR01MB4304.prod.exchangelabs.com (2603:10b6:805:a6::23) by
 SN6PR01MB5087.prod.exchangelabs.com (2603:10b6:805:b8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.26; Wed, 1 Jul 2020 15:11:34 +0000
Received: from SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::3daa:94bb:9223:161f]) by SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::3daa:94bb:9223:161f%5]) with mapi id 15.20.3153.020; Wed, 1 Jul 2020
 15:11:34 +0000
Date: Wed, 1 Jul 2020 11:11:24 -0400
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PULL 35/47] target/arm: Send interrupts on PMU counter overflow
Message-ID: <20200701151124.GD2714117@strawberry.localdomain>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
 <20190201160653.13829-36-peter.maydell@linaro.org>
 <CAFEAcA8ZgeGom6wVmCih9wY-s+kJ-yEsty_=S7+KQ_tkidN-Og@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ZgeGom6wVmCih9wY-s+kJ-yEsty_=S7+KQ_tkidN-Og@mail.gmail.com>
X-ClientProxiedBy: CY4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:903:c6::32) To SN6PR01MB4304.prod.exchangelabs.com
 (2603:10b6:805:a6::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from strawberry.localdomain (68.73.113.219) by
 CY4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:903:c6::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Wed, 1 Jul 2020 15:11:33 +0000
X-Originating-IP: [68.73.113.219]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5dbec34-7a02-4c1a-24f7-08d81dd10ae7
X-MS-TrafficTypeDiagnostic: SN6PR01MB5087:
X-Microsoft-Antispam-PRVS: <SN6PR01MB50878E8257BA6E9C25C311148A6C0@SN6PR01MB5087.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjlHAGssiHwa9DcJYVALresx4mOZTeZWfHVrIfSF39Q0E6MUj0Y9nLqseAGiombMGCI1oHf7Hv4ubrF6GGhgwwgH7qDDhdEWjbPL9q4N8AGhkpf/f0VSkGOTVuSiphifiTWb6tyKBQKKobDZDE/ZL3UFM4YqLEfh8bsWNBHm+uhoBen7gYxI+tPRwNsCMoPUY0jKvOzwRFF/4bnEvWaVmt0WQph4TfC0Ig/26zGaPqZ1z4kM/b8RimYaA63nToRkFH/VkC1tcl04VdM2DM69WG/A9jaETHe/gJE8bRg6rxeK8h3go3Dks7VYyaxBQwU2Sui8hnFtrSDXdabCG1sUdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR01MB4304.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39840400004)(376002)(396003)(9686003)(7696005)(55016002)(52116002)(478600001)(6506007)(6666004)(6916009)(956004)(4326008)(1076003)(5660300002)(33656002)(186003)(316002)(66476007)(86362001)(66946007)(83380400001)(8936002)(26005)(16526019)(8676002)(66556008)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3KWEn1UhTR8DQ/6ntzm6h6qjuqAst9Y6BrdhkNBi7Aswx8LUBPwg0Ni9RFKPzeTo5XQM/CDIzHTgQdmDdnQbwVRVfWgZC3JN2rFec25uPc3Q/4Zu7b0r4llJrvta3PJnRGA2/icy5O4Q9SHZTwU92mqNgT1pewiJa7UKnrrpWrgEDVSEB5Z1xyuArluviPk4WOCsyrkpzkL5NSyzGoDw5jDGSlSx8lgqb3szQV7gBkm7ZTU6C2QxxqWuNqUtGkixxIAagnAcgAJmaArQDnOnjURWWPISgH1EV1eJTTTHG5w/lPfUBmR78L238YlDbZzp0MJvIBRIDmIQ1XAbu/sNDluXbQzUqjFz6iivjvIqcPFpC/sHL4i8QpugKvkYe2hkEm40Wyo3pm8j2NWnoJcWNoyut5W/u8qBX4jz5QXHCQ7XPnTq13d8YtwZlH7JwsmqraH+S1BbJiLeg6Ctww6zZHwxxAAEjwg0/EWiDp/3R8k=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dbec34-7a02-4c1a-24f7-08d81dd10ae7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4304.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 15:11:34.2205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah+VZ2GWcsi7C2txlZISa5BXkb9lwzGoIL1qUq0DojElmWbLEgDruRaqaIh3N4e8Xe6Z1OSA3UbTzM056mv6R9fjAquC6FnGpJNjuugtThw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB5087
Received-SPF: pass client-ip=40.107.69.122;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 11:26:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Feb 25 17:08, Peter Maydell wrote:
> On Fri, 1 Feb 2019 at 16:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
> >
> > Whenever we notice that a counter overflow has occurred, send an
> > interrupt. This is made more reliable with the addition of a timer in a
> > follow-on commit.
> >
> > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-id: 20190124162401.5111-2-aaron@os.amperecomputing.com
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Hi Aaron -- I've just noticed a problem with this patch that
> went into QEMU recently. The problem is that we can end up
> calling pmu_update_irq(), which injects an interrupt, from
> a raw-write function for some of the PMU registers. This is
> bad because when we're using KVM the raw-write functions are
> called as part of syncing state to and from the kernel. In
> particular, if using '-cpu host,pmu=off' we don't set up the
> PMU interrupt because we don't want to provide the guest a
> PMU but then we can still find ourselves in this function,
> and then we assert because we try to set a bogus interrupt.
> Here's the backtrace:
> 
> #1  0x0000fffff6be68b4 in __GI_abort () at abort.c:79
> #2  0x0000aaaaaae20820 in kvm_set_irq (s=0xaaaaabf8a020, irq=33554455, level=0)
>     at /home/pm/qemu-bisect/accel/kvm/kvm-all.c:1277
> #3  0x0000aaaaaafb7890 in kvm_arm_set_irq (cpu=0, irqtype=2, irq=23, level=0)
>     at /home/pm/qemu-bisect/target/arm/kvm.c:897
> #4  0x0000aaaaaae729dc in kvm_arm_gic_set_irq (num_irq=288, irq=23, level=0)
>     at /home/pm/qemu-bisect/hw/intc/arm_gic_kvm.c:75
> #5  0x0000aaaaaae72a1c in kvm_arm_gicv2_set_irq
> (opaque=0xaaaaac169ff0, irq=279, level=0)
>     at /home/pm/qemu-bisect/hw/intc/arm_gic_kvm.c:82
> #6  0x0000aaaaab1ba15c in qemu_set_irq (irq=0xaaaaac186090, level=0)
>     at /home/pm/qemu-bisect/hw/core/irq.c:44
> #7  0x0000aaaaaaf86050 in pmu_update_irq (env=0xaaaaac0fa470)
>     at /home/pm/qemu-bisect/target/arm/helper.c:1412
> #8  0x0000aaaaaaf8747c in pmintenclr_write (env=0xaaaaac0fa470,
> ri=0xaaaaac12c3e0, value=2154950974777589790) at
> /home/pm/qemu-bisect/target/arm/helper.c:1903
> #9  0x0000aaaaaaf83e68 in write_raw_cp_reg (env=0xaaaaac0fa470,
> ri=0xaaaaac12c3e0, v=2154950976315703518) at
> /home/pm/qemu-bisect/target/arm/helper.c:206
> #10 0x0000aaaaaaf840d4 in write_cpustate_to_list (cpu=0xaaaaac0f0b90,
> kvm_sync=true)
>     at /home/pm/qemu-bisect/target/arm/helper.c:290
> #11 0x0000aaaaaafbb1ac in kvm_arch_put_registers (cs=0xaaaaac0f0b90, level=3)
>     at /home/pm/qemu-bisect/target/arm/kvm64.c:1108
> #12 0x0000aaaaaae22ea0 in do_kvm_cpu_synchronize_post_init
> (cpu=0xaaaaac0f0b90, arg=...)
>     at /home/pm/qemu-bisect/accel/kvm/kvm-all.c:2223
> #13 0x0000aaaaab107fa0 in process_queued_cpu_work (cpu=0xaaaaac0f0b90)
>     at /home/pm/qemu-bisect/cpus-common.c:338
> #14 0x0000aaaaaadf4ff4 in qemu_wait_io_event_common (cpu=0xaaaaac0f0b90)
>     at /home/pm/qemu-bisect/cpus.c:1175
> #15 0x0000aaaaaadf51a8 in qemu_wait_io_event (cpu=0xaaaaac0f0b90)
>     at /home/pm/qemu-bisect/cpus.c:1215
> #16 0x0000aaaaaadf52cc in qemu_kvm_cpu_thread_fn (arg=0xaaaaac0f0b90)
>     at /home/pm/qemu-bisect/cpus.c:1251
> #17 0x0000aaaaab690268 in qemu_thread_start (args=0xaaaaac14b1d0)
>     at /home/pm/qemu-bisect/util/qemu-thread-posix.c:519
> 
> 
> The point of the 'raw_read/write' accessors is that they're supposed
> to not have side effects but just to be usable to read and write
> any underlying register state. If the regdef doesn't define them
> we fall back to the usual readfn/writefn on the assumption that
> they're side-effect-free. So I think the fix here would be to
> provide a raw_writefn everywhere where we've made
> the normal writefn have a "sets an interrupt" side effect.

Ouch - I'm sorry this slipped through the cracks in my inbox for so
long.

I assume you mean something like:

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc9c29f998..9b917f9425 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2271,13 +2271,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tpm,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write, },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
       .access = PL1_R,

One thing I'm trying to figure out (talking non-KVM here) is whether
skipping calling pmu_update_irq() can mean an interrupt would not be set
when it should have been. It looks like the ARMCPRegInfo's for
PMINTENSET already do `.raw_writefn = raw_write`, so I suppose at least
we would be consistent with this change. But I can never remember - is
it guaranteed that the raw functions are only ever called when the
interrupt state would already be taken care of separately (i.e. when
restoring a checkpoint)?

-Aaron

