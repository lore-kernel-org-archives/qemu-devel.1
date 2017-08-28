Received: from eggs.gnu.org ([2001:4830:134:3::10]:41795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmL0w-0004q8-Td
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmL0s-0004YX-0s
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:27:42 -0400
Date: Mon, 28 Aug 2017 22:27:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170828142728.GC18194@lemon.lan>
References: <1503928405-19960-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503928405-19960-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu crashes when a negative number
 used for 'maxcpus'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com

Hi Seeteena, thanks for sending the patch and fixing the coding style!

I suggest to change subject to "vl: exit if maxcpus is negative". The subject of
a patch email is going to be the summary of the commit message when applied,
therefore it should be worded to summarize the change. Commonly there is a
"subsystem prefix" followed by a colon, like "vl:", "net:". While there is no
hard rule, the most suitable prefix can be guessed by inspecting the log of the
changed files. In the case of this patch: "git log vl.c".

A more detailed guide on submitting "perfect" QEMU patches can be found here,
in case for your future reference:

https://wiki.qemu.org/Contribute/SubmitAPatch

On Mon, 08/28 19:23, Seeteena Thoufeek wrote:
> ---Steps to Reproduce---
> 
> When passed a negative number to 'maxcpus' parameter, Qemu aborts
> with a core dump.
> 
> Run the following command with maxcpus argument as negative number
> 
> ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
> pseries,accel=kvm,kvm-type=HV -m size=200g -device virtio-blk-pci,
> drive=rootdisk -drive file=/home/images/pegas-1.0-ppc64le.qcow2,
> if=none,cache=none,id=rootdisk,format=qcow2 -monitor telnet
> :127.0.0.1:1234,server,nowait -net nic,model=virtio -net
> user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=1,
> threads=1,maxcpus=-12
> 
> (process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
>  18446744073709550568 bytes
> 
> Trace/breakpoint trap
> 
> Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---

Would be good if there is a comment below a "---" line on how current revision
differs from the previous one, like:

---

v3: Fix coding style pointed out by patchew.


>  vl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 8e247cc..fb45b6d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1244,7 +1244,10 @@ static void smp_parse(QemuOpts *opts)
>          }
>  
>          max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> -
> +        if (max_cpus <= 0) {
> +            error_report("Invalid max_cpus : %d", max_cpus);

The space before ":" can be dropped, I think.

> +            exit(1);
> +        }
>          if (max_cpus < cpus) {
>              error_report("maxcpus must be equal to or greater than smp");
>              exit(1);
> -- 
> 1.8.3.1
> 

Fam
