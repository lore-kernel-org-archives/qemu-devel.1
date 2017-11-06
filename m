Received: from eggs.gnu.org ([2001:4830:134:3::10]:50329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eBqiI-0005lK-Ez
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 18:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eBqiH-0006YQ-IX
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 18:21:54 -0500
Date: Mon, 6 Nov 2017 18:21:45 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171106232145.GA25246@flamenco>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
	<20171103200233.GI3111@localhost.localdomain>
	<20171103222407.GA22411@flamenco>
	<20171106141022.GO3111@localhost.localdomain>
	<20171106215454.GB2152@flamenco>
	<CAKmqyKOSOHdpzfu_WMPWo6Mh_kfmYhem0nR=BD3_hUws0tGEww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKOSOHdpzfu_WMPWo6Mh_kfmYhem0nR=BD3_hUws0tGEww@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw: add .min_cpus and .default_cpus fields
 to machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On Mon, Nov 06, 2017 at 14:32:35 -0800, Alistair Francis wrote:
> Sorry for the silence here, I noticed these were broken just before I
> went on holidays but didn't get a chance to fix anything.
> 
> For the Xilinx case I was thinking of patching the machine code to
> sanely follow the -smp option.
> 
> -smp 1 -> Only create 1 A53
> -smp 4 -> Create 4 A53s
> -smp 6 -> Create all the CPUs
> 
> I see a lot of advantages in not forcing the smallest number of CPUs
> to be 4 unless we really have to.
> 
> I do see a nice advantage in being able to set the default smp option
> to something not 1 so the default closely matches hardware, but users
> can override that if they want to.
> 
> So for the patch below I like the default_cpus option, but for Xilinx
> at least I would like to patch the logic to follow the -smp option
> instead of force a minimum.

Agreed, honouring -smp would be the right fix.
Just note that since this is a regression we need the fix to
be in for 2.11.

I just took a look at the non-Xilinx boards. It seems simple enough to
substitute the hard-coded value for smp_cpus, but yet again
I see "Property" structs that I'm not sure what to do with.
For instance, bcm2836.c:152:

static Property bcm2836_props[] = {
    DEFINE_PROP_UINT32("enabled-cpus", BCM2836State, enabled_cpus, BCM2836_NCPUS),
    DEFINE_PROP_END_OF_LIST()
};

What is the purpose here? To enable/disable CPUs with -global args,
just like it's done for the Xilinx boards? Shouldn't we just use
-smp for that?

Also, note that I don't have a way to test these boards, which
explains why I'm reluctant to change board code. But of
course if board maintainers step in, I'm all for it :-)

Thanks,

		Emilio
