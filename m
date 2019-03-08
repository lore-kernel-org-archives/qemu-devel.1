Received: from eggs.gnu.org ([209.51.188.92]:41478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1h29qL-0000zf-8T
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1h29qK-0003qG-4W
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:22:57 -0500
Date: Fri, 8 Mar 2019 15:22:30 +0800
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-ID: <20190308072230.GA9529@byw>
Reply-To: baiyaowei@cmss.chinamobile.com
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307084405.GB26350@byw>
	<20190307112505.GB5786@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307112505.GB5786@linux.fritz.box>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>, Fam Zheng <fam@euphon.net>, stefanha <stefanha@redhat.com>

> > > * The first priority should be adding an in-process iscsi target that
> > >   can be managed with QMP, similar to the built-in NBD server.
> > 
> > Well, people used to manage iscsi targets through targetcli, a command
> > line utility. Our intention is, with targetcli and qemu-tcmu, user can
> > create/remove targets and backstores totally in just one place, so you
> > don't need to create targets in targetcli and then turn to configure
> > backstores in qemu-tcmu with QMP or command line, it's convenient.  So
> > we decide to implement QMP in the future release but it's definitely
> > in our plan.
> 
> I think QMP needs to come first to result in a clean design, because the
> command line tool should only be a wrapper around the QMP code.

Yeah, i agree this makes more sense from this point. Ok, i'll try to
implement it in v2 as your suggestion. Thanks.

> But anyway, I still think the change I had in mind is necessary. Maybe
> you can see the difference best in an example. Your documentation says
> to use this:
> 
>     # qemu-tcmu
>     # targetcli /backstores/user:qemu create qemulun 1G @id=test@file=/root/test.file

Let's call this one case1.

> 
> I think it should work more like this:
> 
>     # qemu-tcmu -blockdev driver=file,filename=/root/test.file,node-name=my_file \
>                 -export my_export,node=my_file
>     # targetcli /backstores/user:qemu create qemulun 1G my_export

And this one case2.

> 
> In fact, something like this is probably required if we want to export
> existing block nodes (that may be in use by a guest) from a running QEMU
> instance. In this case, you don't want to open a new image file, but
> export the already opened image file.

I think the main difference between these two cases is just how the configuration
of exported image file is passed to qemu-tcmu. Case1 uses cfgstr while case2
uses command line. Case2 still needs one way to check whether the passed-in
image file was opened, right? If so, case1 should also be able to use the same
way to check that after extracting cfgstr. 

Actually we thought about qemu-tcmu working like case2, but felt is's quite less
flexible. With case2, e.g. when we want to export another new image file with
one qemu-tcmu already running, we have to run another qemu-tcmu with
the configuration of the new image file in commandline, or through QMP of the
running qemu-tcmu, and then configure it with targetcli. So anyway,
there's one more step for case2 to export a new image file. While for case1 
you just need to run qemu-tcmu once and all other operations will be done
within targetcli, which is more friendly to users i think.

So i think qemu-tcmu's quite different from qemu-nbd at this point. We can
export a image file by NBD protocol just with qemu-nbd itself. While for
qemu-tcmu we still need targetcli to complete other ISCSI target
configurations to export a image file. So moving the configuration of image
file from cmdline to targetcli should be reasonable in my opinion.

> 
> (Also, can we somehow get rid of the 1G in the command line? qemu-tcmu
> knows how big the image is and can provide this value.)

Currently this size option is mandatory in targetcli, not all tools are
so smart as QEMU. But maybe we could change it optional in the future.
