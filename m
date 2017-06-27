Received: from eggs.gnu.org ([2001:4830:134:3::10]:50354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasha.tatashin@oracle.com>) id 1dPumV-00056Q-Ft
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasha.tatashin@oracle.com>) id 1dPumQ-0005Pp-Hz
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:00:07 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:40715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasha.tatashin@oracle.com>)
	id 1dPumQ-0005O6-7v
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:00:02 -0400
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id v5RHxv4Q013690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 17:59:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v5RHxvgl023570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 17:59:57 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v5RHxva1013137
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 17:59:57 GMT
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <4e41c60b-53b8-b917-108a-7cea8cb9e591@oracle.com>
Date: Tue, 27 Jun 2017 13:59:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] SPARC64 supported processors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I am trying to evaluate the current qemu support for sparc64 processors. 
First, it seems -smp is not supported for any processor, is this 
correct? When I set -smp greater than 1, I am getting:

qemu-system-sparc64: Number of SMP CPUs requested (2) exceeds max CPUs 
supported by machine 'sun4u' (1)

I've done some testing for all available sparc64 cpus + latest linux kernel:

Fujitsu Sparc64	    Working
Fujitsu Sparc64 III Exception 0x30 (DAE_side_effect_page) in OpenBios
Fujitsu Sparc64 IV  Working
Fujitsu Sparc64 V   Working
TI UltraSparc I     Working
TI UltraSparc II    Working
TI UltraSparc IIi   Working
TI UltraSparc IIe   Exception 0x28 (division_by_zero) in init_tick_ops
   Can make it to work if is_hummingbird() is changed
   to return 0. The IO stick, and OpenBios stick properties
   are absent, so we have to default to %tick for now.

Sun UltraSparc III  Illegal instruction in cheetah_boot():
   wr  %g0, %g1, %dcr
   It appears dispatch control register is not implemented.

Sun UltraSparc IIIi
Sun UltraSparc IV
Sun UltraSparc IV+
Sun UltraSparc IIIi+
  In these four CPUs, I am getting exception 0x32 in
  cheetah_generic_boot: stxa  %g0, [ %g3 ] #ASI_DMMU

Sun UltraSparc T1
Sun UltraSparc T2

Both of the above boot pretty far but fail in this function when tmpfs 
is mounted:
	direct_pcr_write(unsigned long reg_num, u64 val)
	__asm__ __volatile__("wr %0, 0x0, %%pcr" : : "r" (val));

	Seems like performance counter registers are not supported.

	needed to add these to kernel parameters:
	keep_bootcon -> to see where we are panicking
	lpj=1000 -> jiffers could not calculate for some reason.

NEC UltraSparc I    Working

Does this look right or may be I have missed something, and we can get 
some of the Sun UltraSparc to work for example?

Thank you,
Pasha
