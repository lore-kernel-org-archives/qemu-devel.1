Received: from eggs.gnu.org ([2001:4830:134:3::10]:37988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUF5e-0005ri-8k
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUF5a-0004RG-8e
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:06:34 -0500
Date: Tue, 4 Dec 2018 16:06:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181204180607.GB18284@habkost.net>
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
	<65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
	<20181126132731.GJ18284@habkost.net>
	<CAFEAcA8D7ZjO059Sgrx-4i0iT+V3gxT4f=DvdmUAJS7KomtyOg@mail.gmail.com>
	<b8e20686-e5d1-a844-48f7-a4ae471e3fd5@greensocs.com>
	<CAFEAcA8j4xTiS3_ktiA0hm2N4cu5RvxAtYqUHgvY-bUXgcwbjQ@mail.gmail.com>
	<50645862-a638-ad2a-bafe-1b46be42aec4@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50645862-a638-ad2a-bafe-1b46be42aec4@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Mon, Dec 03, 2018 at 03:09:14PM +0100, Luc Michel wrote:
> 
> 
> On 12/3/18 12:23 PM, Peter Maydell wrote:
> > On Mon, 3 Dec 2018 at 11:21, Luc Michel <luc.michel@greensocs.com> wrote:
> >>
> >> On 11/30/18 5:52 PM, Peter Maydell wrote:
> >>> Luc: what are the requirements on boards using CPU cluster
> >>> objects? I assume these are both OK:
> >>>  * does not use cluster objects at all
> >>>    (the gdbstub puts all the CPUs in one process?)
> >> Yes, when no clusters are found, a process with PID 1 is created and
> >> used for all CPUs.
> >>>  * all CPUs created are in some CPU cluster
> >>>    (the gdbstub uses one process per CPU cluster)
> >>> but what about
> >>>  * some CPUs are created in a CPU cluster, but some
> >>>    are "loose", not in any cluster at all> ?
> >>> Is that just invalid, or do the "loose" CPUs end up in
> >>> a default cluster (gdbstub process), or do they get
> >>> one cluster each?
> >> Currently this is valid and the "loose" CPUs end up in the first
> >> available process (which will be PID 1 if we are in your first case,
> >> i.e. no clusters in the machine).
> > 
> > So if there are some defined clusters 1 and 2, and some
> > loose CPUs, the clusters get PID 1 and PID 2, and the
> > loose CPUs end up in PID 3? That seems reasonable.
> No sorry I was not clear, the loose CPUs would end up on PID 1 in that case.
> 
> The current behaviour is as follows:
> During gdb stub initialization:
>   - A process is created per cluster.
>   - If no cluster are found, an unique process is created with PID 1
> 
> When trying to find a CPU PID:
>   - If it is attached to a cluster, return the associated process,
>   - If it is loose, return the first available process.

The behavior described by Peter would be more reasonable to me.
Otherwise what was just an accident (getting the CPU assigned to
the first process) will become expected behavior of the API, and
it will be hard to change it later.

In either case, I'm still missing a clear description of what a
cluster is supposed to represent, exactly (see my previous reply
on this thread).

-- 
Eduardo
