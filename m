Received: from eggs.gnu.org ([2001:4830:134:3::10]:34311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgD0C-0007ai-UJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgD0B-0004UN-UO
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:09:20 -0500
Date: Tue, 21 Feb 2017 13:01:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170221160113.GE2778@thinpad.lan.raisama.net>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
	<20170217200522.0e8db60b@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217200522.0e8db60b@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] cpu: Implement cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Fri, Feb 17, 2017 at 08:05:22PM +0100, Igor Mammedov wrote:
> On Mon, 13 Feb 2017 14:28:15 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > This patchset adds a new function cpu_generic_new()
> > which is similar to cpu_generic_init() except that it
> > does not realize the created CPU object. This means that
> > board code can do a "new cpu; set QOM properties; realize"
> > sequence without having to do all the work of splitting
> > the CPU model string and calling parse_features by hand.
> > 
> > Patch 2 clarifies a TODO comment, hopefully correctly,
> > based on an email conversation I had with Eduardo a
> > little while back.
> > 
> > Patches 3 and 4 change the ARM boards which currently
> > call parse_features by hand to use the new function.
> > 
> > 
> > If there's consensus that this is the right general
> > direction to go in, then I think that some other
> > architectures could also make cleanups to use this:
> >  * cpu_s390x_create() is almost exactly this function,
> >    give or take some fine detail of error handling
> >  * ppc_cpu_parse_features is almost the same thing,
> >    except that it doesn't actually create the CPU object,
> >    it only calls parse_features
> >  * hw/i386/pc.c does a manual parse_features
> > 
> > I'm not strongly attached to this particular approach
> > (though it seems like a reasonable one, especially given
> > the proliferation of different arch-specific helpers
> > listed above and the bugs in boards which don't call
> > parse_features when they should), but I would like us to
> > figure out and document what the right way for a board
> > to create and configure its CPU objects is...
> 
> series looks like a step back adding yet another way
> to create CPU and makes code even more inconsistent,
> instead of removing TODO item by doing proper generalization.
> So I'm sort of object to it.
> 
> I'll just posted RFC which show idea how generalization of
> cpu_model/features parsing should be implemented.
> 
> However I don't have cycles to complete it, only
> virt-arm/spapr/pc are converted as example.
> One who would pick the task up should complete it for
> all boards to make code consistent.

If conversion of the code will take a while and this wrapper
removes code duplication of the current boards, I believe this
series is stlil a step in the right direction, even if the plan
is to replace the wrapper one day. But I will take a look at your
RFC first, before giving my opinion on which approach to take.

-- 
Eduardo
