Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXUlA-0006c6-Ib
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXUl5-0006nh-J1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:26:52 -0500
Date: Thu, 13 Dec 2018 18:26:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181213182642.410f5fb5.cohuck@redhat.com>
In-Reply-To: <1544623878-11248-12-git-send-email-jjherne@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-12-git-send-email-jjherne@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 12 Dec 2018 09:11:14 -0500
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

Even though we currently only support eckd dasd passed through via
vfio-ccw, it is probably not a good idea to hardcode this?

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c  | 225 ++++++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/libc.h |  11 +++
>  2 files changed, 236 insertions(+)
