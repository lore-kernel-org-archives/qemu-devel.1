Received: from eggs.gnu.org ([2001:4830:134:3::10]:60273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVLIs-0005GE-9g
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVLIp-0001GW-4C
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:19:58 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:37543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dVLIo-0001Fc-UG
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:19:55 -0400
Received: from player738.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0C4E730D8A
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 19:19:51 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <03821688-88ac-ca87-6cc4-85999fe4c1fc@kaod.org>
Date: Wed, 12 Jul 2017 19:19:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] CPU hotplug on POWER9 (TCG) fails in
 ppc_radix64_handle_mmu_fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sjitindarsingh@gmail.com
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

Hi, 

Today, if you try to hotplug a CPU on a POWER9 guest (TCG), it fails
with an assert on the LPCR_UPRT bit missing in ppc_radix64_handle_mmu_fault()

  (qemu) device_add POWER9_v1.0-spapr-cpu-core,core-id=4,id=foo
  (qemu) [   12.766102] pseries-hotplug-cpu: Attempting to add CPU, drc index: 10000004
  qemu-system-ppc64: ./target/ppc/mmu-radix64.c:204: ppc_radix64_handle_mmu_fault: Assertion `ppc64_use_proc_tbl(cpu)' failed.
  Aborted (core dumped)

The LPCR SPR is incorrectly set. I have hacked my way through to make 
it work, by changing cpu_ppc_set_papr(), but this is really ugly and 
certainly wrong. 

I would happy to cook the fix, as I need it for XIVE development. What
would be the correct approach ?    

Thanks,

C.
