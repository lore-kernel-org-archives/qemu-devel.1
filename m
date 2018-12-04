Received: from eggs.gnu.org ([2001:4830:134:3::10]:40424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUGdc-0004tX-3U
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUGdb-0001dN-9e
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:45:43 -0500
Date: Tue, 4 Dec 2018 17:45:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181204194532.GJ18284@habkost.net>
References: <65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
	<20181126132731.GJ18284@habkost.net>
	<CAFEAcA8D7ZjO059Sgrx-4i0iT+V3gxT4f=DvdmUAJS7KomtyOg@mail.gmail.com>
	<b8e20686-e5d1-a844-48f7-a4ae471e3fd5@greensocs.com>
	<CAFEAcA8j4xTiS3_ktiA0hm2N4cu5RvxAtYqUHgvY-bUXgcwbjQ@mail.gmail.com>
	<50645862-a638-ad2a-bafe-1b46be42aec4@greensocs.com>
	<20181204180607.GB18284@habkost.net>
	<CAFEAcA9JXeRGfKzouYJQKxgXuw_Z-up0a1ijZX9hZvXbdkwiuA@mail.gmail.com>
	<20181204190548.GH18284@habkost.net>
	<CAFEAcA9M3akT7sF-kjCg41ucuUhv2PxKaCBmkN3eacvqvf_w9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9M3akT7sF-kjCg41ucuUhv2PxKaCBmkN3eacvqvf_w9Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Luc Michel <luc.michel@greensocs.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 04, 2018 at 07:16:39PM +0000, Peter Maydell wrote:
> On Tue, 4 Dec 2018 at 19:05, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Dec 04, 2018 at 06:24:19PM +0000, Peter Maydell wrote:
> > > A cluster is a group of CPUs which are all identical and have
> > > the same view of the rest of the system.
> 
> > With that definition in mind, why can't QEMU cluster CPUs
> > automatically by looking at CPU models and address space objects?
> 
> That sounds like it is in theory feasible and in practice
> quite tricky. You would have to look not just at the CPU
> model name but also introspect all its properties for
> ones which change features of the CPU and are set differently
> on different CPUs (and I don't think there's any way to
> automatically tell which properties are ones which make
> the CPU different for which-cluster purposes and which aren't).
> And if we automatically checked whether address space objects
> were the same it would rule out implementing devices with
> per-cpu banked memory mapped registers by mapping different
> things into the AS for each CPU (though that's a hypothetical
> at the moment -- I've thought about implementing stuff that
> way but we tend to implement that sort of thing by looking
> at current_cpu->cpu_index at the moment).

I see.

Can't we at least do something to make sure the cluster objects
make sense?  e.g. by ensuring at least QOM CPU type is the same,
and that cpu->address_space somehow points to
cpu->cluster->address_space?

CCing Paolo, so he can correct me if this doesn't make sense.

-- 
Eduardo
