Received: from eggs.gnu.org ([2001:4830:134:3::10]:54597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cMHia-0004sn-9y
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cMHiX-0001pf-5b
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:08:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cMHiW-0001pS-W5
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:08:45 -0500
Date: Wed, 28 Dec 2016 15:08:42 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161228170842.GB23551@thinpad.lan.raisama.net>
References: <1479466974-249781-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479466974-249781-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] numa: make -numa parser
 dynamically allocate CPUs masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <gkurz@linux.vnet.ibm.com>

On Fri, Nov 18, 2016 at 12:02:54PM +0100, Igor Mammedov wrote:
> so it won't impose an additional limits on max_cpus limits
> supported by different targets.
> 
> It removes global MAX_CPUMASK_BITS constant and need to
> bump it up whenever max_cpus is being increased for
> a target above MAX_CPUMASK_BITS value.
> 
> Use runtime max_cpus value instead to allocate sufficiently
> sized node_cpu bitmasks in numa parser.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

As the cpu_index assignment code isn't obviously safe against
setting cpu_index > max_cpus, I would like to squash this into
the patch. Is that OK for you?

diff --git a/numa.c b/numa.c
index 1b6fa78..33f2fd4 100644
--- a/numa.c
+++ b/numa.c
@@ -401,6 +401,7 @@ void numa_post_machine_init(void)
 
     CPU_FOREACH(cpu) {
         for (i = 0; i < nb_numa_nodes; i++) {
+            assert(cpu->cpu_index < max_cpus);
             if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
                 cpu->numa_node = i;
             }
@@ -559,6 +560,8 @@ int numa_get_node_for_cpu(int idx)
 {
     int i;
 
+    assert(idx < max_cpus);
+
     for (i = 0; i < nb_numa_nodes; i++) {
         if (test_bit(idx, numa_info[i].node_cpu)) {
             break;

-- 
Eduardo
