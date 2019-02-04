Received: from eggs.gnu.org ([209.51.188.92]:56252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcjk-0007BQ-T1
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqccj-0000QM-0m
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:41:13 -0500
Date: Mon, 4 Feb 2019 12:41:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204124105.0abb9b44.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-12-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-12-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/15] s390-bios: cio error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:18 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add verbose error output for when unexpected i/o errors happen. This eases the
> burden of debugging and reporting i/o errors. No error information is printed
> in the success case, here is an example of what is output on error:
> 
> vfio-ccw device I/O error - Interrupt Response Block Data:
>     Function Ctrl : [Start]
>     Activity Ctrl : [Start-Pending]
>     Status Ctrl : [Alert] [Primary] [Secondary] [Status-Pending]
>     Device Status : [Unit-Check]
>     Channel Status :
>     cpa=: 0x0000000001e67098
>     prev_ccw=: 0x0000000000000000
>     this_ccw=: 0x0000000000000000
> 
> Sense Data (fmt 32-bytes):
>     Sense Condition Flags : [Equipment-Check]
>     Residual Count     =: 0x0000000000000000
>     Phys Drive ID      =: 0x000000000000009e
>     low cyl address    =: 0x0000000000000000
>     head addr & hi cyl =: 0x0000000000000000
>     format/message     =: 0x0000000000000008
>     fmt-dependent[0-7] =: 0x0000000000000004
>     fmt-dependent[8-15]=: 0xe561282305082fff
>     prog action code   =: 0x0000000000000016
>     Configuration info =: 0x00000000000040e0
>     mcode / hi-cyl     =: 0x0000000000000000
>     cyl & head addr [0]=: 0x0000000000000000
>     cyl & head addr [1]=: 0x0000000000000000
>     cyl & head addr [2]=: 0x0000000000000000

Looks cool.

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> 
> # Conflicts:
> #	pc-bios/s390-ccw/cio.c

You probably don't want to keep that :)

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c  | 225 ++++++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/libc.h |  11 +++
>  2 files changed, 236 insertions(+)
> 

(...)

> +static void print_irb_err(Irb *irb)
> +{
> +    Ccw0 *this_ccw = u32toptr(irb->scsw.cpa);
> +    Ccw0 *prev_ccw = u32toptr(irb->scsw.cpa - 8);

I don't think you can cast this conditionally to format 0 -- I'd pass
in the format from do_cio and handle it accordingly.

> +    char msgline[256];
> +
> +    sclp_print("vfio-ccw device I/O error - Interrupt Response Block Data:\n");

If you call this from the generic function, you shouldn't talk about
vfio-ccw here; but it might make sense to print subchannel/devno and
the cu type.

(...)

> @@ -148,6 +370,9 @@ int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
>              continue;
>          }
>  
> +        print_irb_err(&irb);
> +        basic_sense(schid, &sd, sizeof(sd));
> +        print_eckd_dasd_sense_data(&sd);

I think this should only be printed for actual dasds (and maybe only
print it if there is actually sense data available)?

>          break;
>      }
>  
