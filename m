Received: from eggs.gnu.org ([2001:4830:134:3::10]:41557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cb7yC-0000pi-WC
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cb7y9-0007x6-VQ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:46:17 -0500
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<20170202051445.5735-96-david@gibson.dropbear.id.au>
	<922cc254-3d39-c21e-3ac6-7f8bd3b95d90@ilande.co.uk>
	<b8c77dc9-6083-bf26-3750-f0847ad1d6ed@redhat.com>
	<83f44e87-d1aa-3c9f-f383-e06717dfa54c@ilande.co.uk>
	<999b15a2-2388-4397-64f4-06875f7f6d92@redhat.com>
	<824f7332-4893-fa64-d61d-7cb9497e5371@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ff33796b-742b-f54c-a3c7-ee19b9d23759@redhat.com>
Date: Tue, 7 Feb 2017 16:46:06 +0100
MIME-Version: 1.0
In-Reply-To: <824f7332-4893-fa64-d61d-7cb9497e5371@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 095/107] spapr: clock should count only if
 vm is running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org

On 02/02/2017 16:50, Mark Cave-Ayland wrote:
> On 02/02/17 14:20, Laurent Vivier wrote:
> 
>> I think adding the the PPCTimebase field and the VMSTATE_PPC_TIMEBASE_V
>> macro to the PMac machines should fix your issue.
>>
>> Do you have a test case I can try?
>>
>> Laurent
> 
> Hi Laurent,
> 
> Yes I'd say that is required, although I still think you need to migrate
> the decrementer value as per the comments on
> https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg00546.html.
> 
> Here's the reproducer from an off-list email I sent last year:
> 
> 1) Download https://www.ilande.co.uk/tmp/darwin_empty.qcow2.xz and
> decompress the image (it's a pre-partitioned empty Apple Partition Map disk)
> 
> 2) Download https://opensource.apple.com/static/iso/darwinppc-602.cdr.gz
> image, gunzip it and rename with .iso extension
> 
> 3) Start QEMU using the attached "empty" disk like this:
> 
> ./qemu-system-ppc -hda darwin_empty.qcow2 -cdrom darwinppc-602.iso -boot d
> 
> 4) Start the installer in the guest and you'll see lots of files with
> ASCII progress bars as the various files are copied to disk
> 
> Then to see the problem with the progress bar, repeat the following:
> 
> 5) Pause the VM
> 
> 6) Issue "savevm foo" in the monitor
> 
> 7) Exit QEMU
> 
> 8) Start QEMU again as below:
> 
> ./qemu-system-ppc -hda darwin_empty.qcow2 -cdrom darwinppc-602.iso -boot
> d -loadvm foo
> 
> If you do this enough times (maybe 10 or so?) you'll see the progress
> bars stop working correctly and get out of sync, i.e. it will freeze for
> long periods of time and then "jump" to catch-up but not all the way.
> 
> With my above patch applied to include the decrementer in the migration,
> the bug was no longer visible in my tests.

Thank you for all these details.

I've been able to reproduce the problem, and I think the proposition you
did in:

   https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg01114.html

is the good one:

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index df9f7a4..1dc95b8 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -172,6 +172,7 @@ static void cpu_pre_save(void *opaque)
     env->spr[SPR_CFAR] = env->cfar;
 #endif
     env->spr[SPR_BOOKE_SPEFSCR] = env->spe_fscr;
+    env->spr[SPR_DECR] = cpu_ppc_load_decr(env);

     for (i = 0; (i < 4) && (i < env->nb_BATs); i++) {
         env->spr[SPR_DBAT0U + 2*i] = env->DBAT[0][i];
@@ -214,6 +215,7 @@ static int cpu_post_load(void *opaque, int version_id)
     env->cfar = env->spr[SPR_CFAR];
 #endif
     env->spe_fscr = env->spr[SPR_BOOKE_SPEFSCR];
+    cpu_ppc_store_decr(env, env->spr[SPR_DECR]);

     for (i = 0; (i < 4) && (i < env->nb_BATs); i++) {
         env->DBAT[0][i] = env->spr[SPR_DBAT0U + 2*i];


It's interesting because it doesn't break migration between different
qemu releases as the register is already part of the migration stream.
It was just not updated in the case of TCG (KVM is keeping it alive).
And in case of KVM, calling cpu_ppc_load_decr()/cpu_ppc_store_decr()
will not break anything as:

- cpu_ppc_load_decr() returns "env->spr[SPR_DECR]",
- cpu_ppc_store_decr() does nothing.

Could you re-send this patch with your S-o-b, please?

Thanks,
Laurent
