Received: from eggs.gnu.org ([209.51.188.92]:50086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjA9p-000756-KA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjA9o-0005KA-UU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:52:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gjA9m-0005IW-Rq
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:52:31 -0500
Date: Mon, 14 Jan 2019 19:52:25 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114215225.GA16760@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Meaning of "-smp threads" on mips_malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Igor Mammedov <imammedo@redhat.com>

Hi,

I'm trying to refactor the SMP topology code in QEMU and I found
some suspicious code on mips_malta.c:

static void malta_mips_config(MIPSCPU *cpu)
{
    CPUMIPSState *env = &cpu->env;
    CPUState *cs = CPU(cpu);

    env->mvp->CP0_MVPConf0 |= ((smp_cpus - 1) << CP0MVPC0_PVPE) |
                         ((smp_cpus * cs->nr_threads - 1) << CP0MVPC0_PTC);
}


The (smp_cpus * cs->nr_threads) expression here doesn't make
sense to me (because smp_cpus is already supposed to be a
multiple of smp_threads), and seems to indicate that the code has
some unusual assumptions about the semantics of the -smp option.

So, I'd like to know: do all the examples below make sense for
Malta?

 -smp 1
 -smp 2
 -smp 2,threads=1
 -smp 2,threads=2
 -smp 1,threads=2 [*]
 -smp 2,threads=3 [*]

The generic -smp parsing code considers the last 2 entries
above[*] to be invalid.  If they make sense for Malta, we need to
find a way to fix that.  Replacing "-smp threads=..." with a
"-cpu" or "-machine" option seems like the best alternative.

-- 
Eduardo
