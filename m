Received: from eggs.gnu.org ([2001:4830:134:3::10]:57962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdgcC-0006tn-Qq
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdgc7-0007NZ-PY
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdgc7-0007NN-Jd
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:10:03 -0500
References: <1487092068-16562-1-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <405d82a8-5507-6dbf-8844-dc4004ea99c9@redhat.com>
Date: Tue, 14 Feb 2017 18:10:03 +0100
MIME-Version: 1.0
In-Reply-To: <1487092068-16562-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/2] Qemu: gdbstub: fix vCont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, palves@redhat.com, alex.bennee@linaro.org

Thanks, I hope to send a pull request this week, including this patch.

Paolo

On 14/02/2017 18:07, Claudio Imbrenda wrote:
> This small patchset fixes the incorrect behaviour of the vCont command
> in the gdb stub. 
> 
> The first patch, as suggested be Paolo, refactors some code. The most
> visible change is that it moves vm_start to cpus.c 
> 
> The second one fixes the incorrect behaviour of the vCont command.
> Previously, continuing or stepping a single thread (CPU) caused all
> other CPUs to be started too, whereas the GDB specification clearly
> states that without a default action all threads not explicitly
> mentioned in the command should stay stopped.
> 
> So if the Qemu gdbstub receives a  vCont;c:1  packet, no other CPU
> should be restarted except the first, and when a  vCont;s:1  is
> received, the first CPU should be stepped without restarting the others.
> With this patchset Qemu now behaves as expected.
> 
> See here for reference material about the packets: 
> https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html
> https://sourceware.org/gdb/onlinedocs/gdb/Packets.html
> 
> v7 -> v8
> * fixed and added some comments
> * fixed vCont a little bit for user mode
> * use cpu->cpu_index directly when possible
> 
> v6 -> v7
> * fixed description of patch 1 to reflect what is actually happening
>   and improved description of patch 2
> * removed leftover header declaration of resume_some_vcpus which had
>   been removed a few versions ago
> * fixed a compilation issue when compiling userspace-mode only
>   (global variable max_cpus is not defined when not in system-mode)
> 
> v4 -> v6
> * rebased on master after target-s390x was moved
> * put qemu_clock_enable back into resume_all_vcpus
> * improved the parsing function of the vCont packet
> * added qemu_clock_enable to gdb_continue_partial
> 
> v3 -> v4
> * rebased on v2.8.0-rc2, no changes needed
> 
> v2 -> v3
> * removed resume_some_vcpus
> * cleared up the code and simplified the implementation in light of the 
>   clarification in the specification of the vCont packet
> 
> Claudio Imbrenda (2):
>   move vm_start to cpus.c
>   gdbstub: Fix vCont behaviour
> 
>  cpus.c                  |  42 ++++++++++
>  gdbstub.c               | 209 +++++++++++++++++++++++++++++++++++++-----------
>  include/sysemu/sysemu.h |   2 +
>  vl.c                    |  30 +------
>  4 files changed, 207 insertions(+), 76 deletions(-)
> 
