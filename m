Received: from eggs.gnu.org ([2001:4830:134:3::10]:52771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9FSO-00036a-5j
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9FSJ-0003KX-Ba
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9FSJ-0003JF-28
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:42:55 -0400
Date: Thu, 19 Apr 2018 16:42:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180419194251.GZ29865@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<87zi21apkh.fsf@dusky.pond.sub.org>
	<20180417142739.GV29865@localhost.localdomain>
	<20180417174110.1a7f1daf@redhat.com>
	<20180417204135.GB29865@localhost.localdomain>
	<87d0yx2dqp.fsf@dusky.pond.sub.org>
	<20180419100004.0b560c85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419100004.0b560c85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Thu, Apr 19, 2018 at 10:00:04AM +0200, Igor Mammedov wrote:
> On Wed, 18 Apr 2018 09:08:30 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> > 
> > > On Tue, Apr 17, 2018 at 05:41:10PM +0200, Igor Mammedov wrote:  
> > >> On Tue, 17 Apr 2018 11:27:39 -0300
> > >> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >>   
> > >> > On Tue, Apr 17, 2018 at 04:13:34PM +0200, Markus Armbruster wrote:  
> > >> > > Igor Mammedov <imammedo@redhat.com> writes:
> > >> > > 
> > >> > > [...]    
> > >> > > > Series allows to configure NUMA mapping at runtime using QMP
> > >> > > > interface. For that to happen it introduces a new '-preconfig' CLI option
> > >> > > > which allows to pause QEMU before machine_init() is run and
> > >> > > > adds new set-numa-node QMP command which in conjunction with
> > >> > > > query-hotpluggable-cpus allows to configure NUMA mapping for cpus.
> > >> > > >
> > >> > > > Later we can modify other commands to run early, for example device_add.
> > >> > > > I recall SPAPR had problem when libvirt started QEMU with -S and, while it's
> > >> > > > paused, added CPUs with device_add. Intent was to coldplug CPUs (but at that
> > >> > > > stage it's considered hotplug already), so SPAPR had to work around the issue.    
> > >> > > 
> > >> > > That instance is just stupidity / laziness, I think: we consider any
> > >> > > plug after machine creation a hot plug.  Real machines remain cold until
> > >> > > you press the power button.  Our virtual machines should remain cold
> > >> > > until they start running, i.e. with -S until the first "cont".  
> > >> It probably would be too risky to change semantics of -S from hotplug to coldplug.
> > >> But even if we were easy it won't matter in case if dynamic configuration
> > >> done properly. More on it below.
> > >>   
> > >> > > I vaguely remember me asking this before, but your answer didn't make it
> > >> > > into this cover letter, which gives me a pretext to ask again instead of
> > >> > > looking it up in the archives: what exactly prevents us from keeping the
> > >> > > machine cold enough for numa configuration until the first "cont"?    
> > >> > 
> > >> > I also think this would be better, but it seems to be difficult
> > >> > in practice, see:
> > >> > http://mid.mail-archive.com/20180323210532.GD28161@localhost.localdomain  
> > >> 
> > >> In addition to Eduardo's reply, here is what I've answered back
> > >> when you've asked question the 1st time (v2 late at -S pause point reconfig):
> > >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg504140.html
> > >> 
> > >> In short:
> > >> I think it's wrong in general doing fixups after machine is build
> > >> instead of getting correct configuration before building machine.
> > >> That's going to be complex and fragile and might be hard to do at
> > >> all depending on what we are fixing up.  
> > >
> > > What "building the machine" should mean, exactly, for external
> > > users?
> under "building machine", I've meant machine_run_board_init()
> and all follow up steps to machine_done stage.
> 
> > > The main question I'd like to see answered is: why exactly we
> > > must "build" the machine before the first "cont" is issued when
> > > using -S?  Why can't we delay everything to "cont" when using -S?  
> Nor sure what question is about,
> Did you mean if it were possible to postpone machine_run_board_init()
> and all later steps to -S/cont time?

Exactly.  In other words, what exactly must be done before the
monitor is available when using -S, and what exactly can be
postponed after "cont" when using -S?

>  
> > > Is it just because it's a long and complex task?  Does that mean
> > > we might still do that eventually, and eliminate the
> > > prelaunch/preconfig distinction in the distant future?  
> > 
> > Why would anyone want to use -S going forward?  For reasons other "we've
> > always used -S, and can't be bothered to change".
> We should be able to deprecate/remove -S once we can do all
> initial configuration that's possible to do there at
> preconfig time.

If the plan is to deprecate -S, what are the important
user-visible differences between -S and -preconfig today?  Do we
plan to eliminate all those differences before
deprecating/removing -S?

>  
> > > Even if we follow your approach, we need to answer these
> > > questions.  I'm sure we will try to reorder initialization steps
> > > between the preconfig/prelaunch states in the future, and we
> > > shouldn't break any expectations from external users when doing
> > > that.
> As minimum I expect -preconfig to be a runtime equivalent to CLI,
> with difference that it will be interactive and use QMP interface.
> As long as it sits between CLI parsing and the rest of initialization
> it shouldn't break that.

What prevents us from making -S a runtime equivalent to CLI?

> 
> > Moreover, the questions need to be answered in Git.  Commit message,
> > comments, docs/, use your judgement.
> I've thought that commit messages/patches were describing introduced
> changes sufficiently. But I've been sitting on these patches for
> a long time and what's obvious to me might be not so clear to others.
> I might just not see what's missing. Any suggestions to improve it
> are welcome.

I miss something that documents why both -S and -preconfig need
to exist, what are the differences between them today, and what
we plan to do about the differences between them in the future.

-- 
Eduardo
