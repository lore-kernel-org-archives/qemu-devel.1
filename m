Received: from eggs.gnu.org ([2001:4830:134:3::10]:45309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dme3P-0001pv-4O
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dme3O-0002UE-8s
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:47:31 -0400
Date: Tue, 29 Aug 2017 18:47:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170829104726.GB8146@lemon>
References: <1503985539-7205-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503985539-7205-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4] vl: exit if maxcpus is negative
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

On Tue, 08/29 11:15, Seeteena Thoufeek wrote:
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
> ---
> v1 -> v2:
>   - Fix the error check in vl.c to make it generic.
> v2 -> v3:
>   - Fix coding style pointed out by patchew.
>   - Fix check for "<= 0" instead of just "< 0".
> v3 -> v4:
>   - Fix subject line.
>   - Removed space before ":" from vl.c:1248
>   - Removed Reviewed-by: flag.
> ---
>  vl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 8e247cc..2d9e73d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1244,7 +1244,10 @@ static void smp_parse(QemuOpts *opts)
>          }
>  
>          max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> -
> +        if (max_cpus <= 0) {
> +            error_report("Invalid max_cpus: %d", max_cpus);
> +            exit(1);
> +        }
>          if (max_cpus < cpus) {
>              error_report("maxcpus must be equal to or greater than smp");
>              exit(1);
> -- 
> 1.8.3.1
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
