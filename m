Received: from eggs.gnu.org ([2001:4830:134:3::10]:44357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f3Mzl-0004VH-Q5
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f3Mzh-0005Mc-T1
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:33:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f3Mzh-0005ML-NT
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:33:05 -0400
Date: Tue, 3 Apr 2018 16:32:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180403163253.1d13633f@redhat.com>
In-Reply-To: <20180329162409.GX5046@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
	<20180323212508.GF28161@localhost.localdomain>
	<20180327170541.295fc29a@redhat.com>
	<20180328134835.04f95535@redhat.com>
	<20180328192148.GR5046@localhost.localdomain>
	<20180329134303.548a864b@redhat.com>
	<20180329162409.GX5046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/9] cli: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Thu, 29 Mar 2018 13:24:09 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Mar 29, 2018 at 01:43:03PM +0200, Igor Mammedov wrote:
> > On Wed, 28 Mar 2018 16:21:48 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Wed, Mar 28, 2018 at 01:48:35PM +0200, Igor Mammedov wrote:  
> > > > On Tue, 27 Mar 2018 17:05:41 +0200
> > > > Igor Mammedov <imammedo@redhat.com> wrote:
> > > >     
> > > > > On Fri, 23 Mar 2018 18:25:08 -0300
> > > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
[...]
> > > This doesn't make sense to me.  Why would we enter
> > > RUN_STATE_PRECONFIG state if -preconfig is not used at all?  
> > because of RUN_STATE_PRECONFIG becomes new initial state of
> > our state machine where we start of (used to be RUN_STATE_PRELAUNCH)  
> 
> Oh, I missed that part.
> 
> > Lets call it variant 1:
> > 
> > with this we have 2 possible transitions:
> >  RUN_STATE_PRECONFIG -> RUN_STATE_PRELAUNCH (machine_init)
> > 
> > and
> > 
> >  RUN_STATE_PRECONFIG -> RUN_STATE_INMIGRATE
> >    ugly but it was the same with RUN_STATE_PRELAUNCH initial transition  
[...]
> 
> Thanks, now variant 1 makes more sense to me.  But I really miss
> here are very clear and explicit descriptions of what each state
> really mean, and what are the differences between them.
> 
> It looks like the existing description for `prelaunch` isn't
> accurate:
> 
> # @prelaunch: QEMU was started with -S and guest has not started
> 
> This is false, as QEMU can be in `prelaunch` state even if -S is
> not used.
> 
> 
> Also, this is the description you proposed for `preconfig`:
> 
> # @preconfig: QEMU is paused before board specific init callback is executed.
> #             The state is reachable only if -preconfig CLI option is used.
> #             (Since 2.12)
> 
> This seems wrong as well: the `prelaunch` state is reachable even
> if `-preconfig` isn't used in the command-line (because it is the
> initial state).
I'm not sure we should describe transitions/initial state here
(it's not the case now).

I think descriptions 'almost' match 'end' result of what QMP client
cloud see and the initial state is not something that QMP user could
observe.

[...]
