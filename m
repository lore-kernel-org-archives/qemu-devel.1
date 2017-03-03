Received: from eggs.gnu.org ([2001:4830:134:3::10]:55220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjcJI-0005R2-ME
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjcJH-00085Z-Nb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:47:08 -0500
Date: Fri, 3 Mar 2017 09:46:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170303014657.GA7097@lemon.lan>
References: <20170301081504.23595-1-famz@redhat.com>
	<20170301094917.GA4799@noname.redhat.com>
	<20170301123913.GA26744@lemon.lan>
	<20170301151626.GB4799@noname.redhat.com>
	<20170301161023.GA17634@lemon.lan>
	<20170301162221.GD4799@noname.redhat.com>
	<20170302112110.GA21732@lemon.lan>
	<20170302142318.GA5868@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170302142318.GA5868@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: Tolerate existing writers on
 read only BdrvChild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 03/02 15:23, Kevin Wolf wrote:
> Am 02.03.2017 um 12:21 hat Fam Zheng geschrieben:
> > On Wed, 03/01 17:22, Kevin Wolf wrote:
> > > Am 01.03.2017 um 17:10 hat Fam Zheng geschrieben:
> > > > On Wed, 03/01 16:16, Kevin Wolf wrote:
> > > > > > I'm not sure about this because: 1) this is intrusive from a user PoV, many
> > > > > > scripts and upper layer tools will stop working;
> > > > > 
> > > > > Are you sure? I don't expect user scripts or even proper management
> > > > > tools to use qemu-io on running VMs. I do expect that some users are
> > > > > using 'convert -s' with running VMs despite our recommendation against
> > > > > it.
> > > > > 
> > > > > If they are aware that they're doing something that works only in the
> > > > > right circumstances, then breaking it isn't nice. But my gut feeling is
> > > > > that most of them don't know about the implications of accessing a live
> > > > > image. In this case breaking their use case and making them think about
> > > > > whether they want to add something like a --force option sounds like a
> > > > > good thing because they aren't caught by surprise when things go wrong
> > > > > eventually.
> > > > 
> > > > Yes, the use case is poor for qcow2, and your points stand there. But image
> > > > locking will be at the posix level, which has a wider range of users. I cannot
> > > > draw the same conclusion on raw images as easily.
> > > 
> > > Well, with raw, I'm even less concerned about breaking the commands
> > > related to internal snapshots. :-)
> > 
> > Yes, I'm agree with a --force there. For qemu-img map and qemu-io, personally I
> > think it's better to keep the default working. qemu-io is a expert mode tool,
> > whoever using it at all should already know what he's doing, --force doesn't add
> > much protection for the innocent.
> 
> Being an expert doesn't protect you from stupid mistakes like forgetting
> that a VM is still running. --force doesn't prevent you from performing
> your evil action, but it prevents accidents where you didn't even intend
> to be evil for a change.
> 
> I think qemu-io and qemu-img map are tools that only human users should
> be using while a VM is running, so breaking command line syntax
> compatibility by requiring a --force option wouldn't hurt too much.

OK, that sounds fair. I don't know how to implement the option, though, would
you like to take care of it? :)

Fam
