Received: from eggs.gnu.org ([209.51.188.92]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2CQf-0003dZ-KY
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2CQe-0001eX-JO
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:08:37 -0500
Date: Fri, 8 Mar 2019 11:08:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190308100826.GB5339@localhost.localdomain>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307084405.GB26350@byw>
	<20190307112505.GB5786@linux.fritz.box> <20190308072230.GA9529@byw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308072230.GA9529@byw>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>, Fam Zheng <fam@euphon.net>, stefanha <stefanha@redhat.com>

Am 08.03.2019 um 08:22 hat Yaowei Bai geschrieben:
> > > > * The first priority should be adding an in-process iscsi target that
> > > >   can be managed with QMP, similar to the built-in NBD server.
> > > 
> > > Well, people used to manage iscsi targets through targetcli, a command
> > > line utility. Our intention is, with targetcli and qemu-tcmu, user can
> > > create/remove targets and backstores totally in just one place, so you
> > > don't need to create targets in targetcli and then turn to configure
> > > backstores in qemu-tcmu with QMP or command line, it's convenient.  So
> > > we decide to implement QMP in the future release but it's definitely
> > > in our plan.
> > 
> > I think QMP needs to come first to result in a clean design, because the
> > command line tool should only be a wrapper around the QMP code.
> 
> Yeah, i agree this makes more sense from this point. Ok, i'll try to
> implement it in v2 as your suggestion. Thanks.
> 
> > But anyway, I still think the change I had in mind is necessary. Maybe
> > you can see the difference best in an example. Your documentation says
> > to use this:
> > 
> >     # qemu-tcmu
> >     # targetcli /backstores/user:qemu create qemulun 1G @id=test@file=/root/test.file
> 
> Let's call this one case1.
> 
> > 
> > I think it should work more like this:
> > 
> >     # qemu-tcmu -blockdev driver=file,filename=/root/test.file,node-name=my_file \
> >                 -export my_export,node=my_file
> >     # targetcli /backstores/user:qemu create qemulun 1G my_export
> 
> And this one case2.
> 
> > 
> > In fact, something like this is probably required if we want to export
> > existing block nodes (that may be in use by a guest) from a running QEMU
> > instance. In this case, you don't want to open a new image file, but
> > export the already opened image file.
> 
> I think the main difference between these two cases is just how the configuration
> of exported image file is passed to qemu-tcmu. Case1 uses cfgstr while case2
> uses command line. Case2 still needs one way to check whether the passed-in
> image file was opened, right? If so, case1 should also be able to use the same
> way to check that after extracting cfgstr. 

I'm not sure what check you mean. Case 2 would need to find an existing
export with the given name, of course, and would return an error if no
such export exists yet.

But for care 1, isn't the image explicitly opened when the target is
configured? And if it can't be opened, -1 is returned to libtcmu?

> Actually we thought about qemu-tcmu working like case2, but felt is's quite less
> flexible. With case2, e.g. when we want to export another new image file with
> one qemu-tcmu already running, we have to run another qemu-tcmu with
> the configuration of the new image file in commandline, or through QMP of the
> running qemu-tcmu, and then configure it with targetcli. So anyway,
> there's one more step for case2 to export a new image file. While for case1 
> you just need to run qemu-tcmu once and all other operations will be done
> within targetcli, which is more friendly to users i think.

Some users may call it more convenient (even though it's really the
same, just moved to a different command, in the simple case that case 2
supports). But it's actually not very flexible.

If we implement case 1, you can define your configuration exactly as
with QEMU, including multiple -blockdev and -object options, and select
the exact block node that you want to export.

In case 2, you only have a single string, which comes with many
downsides:

* You cannot get the semantics of block nodes defined individually with
  separate -blockdev options, but only a single tree that is managed as
  a single unit.

* Additional objects such as iothreads or secrets cannot be included in
  the config string, so you must split the configuration and pass some
  parts directly to qemu-tcmu and other parts to targetcli. This is
  inconsistent.

* You need a way to represent a possible options of a node in a string.
  QEMU -drive already caused trouble by giving commas a special meaning.
  This patch adds @ as a special character, without an option to escape
  it. If you have a filename that contains @, there is no way to use it.

* For the not yet implemented QMP part: You can export only images that
  are newly opened. You cannot export images that are already opened and
  in use. But exporting images that are in use by the VM is the main use
  of even having a QMP interface.

If I think a bit longer, I'm sure I can come up with more points. Case 2
just doesn't feel right, it is like drives were configured in QEMU 0.10,
not in 4.0, and we moved away from it for many reasons, most of which
probably apply here, too.

> So i think qemu-tcmu's quite different from qemu-nbd at this point. We can
> export a image file by NBD protocol just with qemu-nbd itself. While for
> qemu-tcmu we still need targetcli to complete other ISCSI target
> configurations to export a image file. So moving the configuration of image
> file from cmdline to targetcli should be reasonable in my opinion.

Yes, it is different. But the restriction to configure everything in a
single string is what makes moving the configuration to targetcli a
problem.

Kevin
