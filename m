Received: from eggs.gnu.org ([2001:4830:134:3::10]:33924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceNiS-0000ko-5o
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceNiM-0007re-Hg
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:11:28 -0500
Date: Thu, 16 Feb 2017 16:11:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170216161114.220260cf@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA_NgmdDCfbPy+DnHQBmNGmQ4tj1z4ci+OP7+x4tHLLCxg@mail.gmail.com>
References: <1487253461-269218-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA_NgmdDCfbPy+DnHQBmNGmQ4tj1z4ci+OP7+x4tHLLCxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix cpu object reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 16 Feb 2017 14:18:05 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 16 February 2017 at 13:57, Igor Mammedov <imammedo@redhat.com> wrote:
> > object_new(FOO) returns an object with ref_cnt == 1
> > and following
> >   object_property_set_bool(cpuobj, true, "realized", NULL)
> > set parent of cpuobj to '/machine/unattached' which makes
> > ref_cnt == 2.
> >
> > Since machvirt_init() doesn't take ownership of cpuobj
> > returned by object_new() it should explicitly drop
> > reference to cpuobj when dangling pointer is about to
> > go out of scope like it's done pc_new_cpu() to avoid
> > object leak.  
> 
> I've always found the object reference semantics somewhat
> confusing (why does realizing a device add a reference,
> for instance?). Do we document them anywhere?
I'm not aware of a place where it's documented.

currently device_realize() sets parent thus increasing
ref counter only if device creator haven't set parent
explicitly.

> 
> thanks
> -- PMM
> 
