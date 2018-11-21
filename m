Received: from eggs.gnu.org ([2001:4830:134:3::10]:34109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gPUri-0002s8-HG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gPUrf-0001od-T1
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gPUrf-0001m5-Nd
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:56:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F02D8BD20
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 15:56:30 +0000 (UTC)
Date: Wed, 21 Nov 2018 13:56:00 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20181121155559.GB32503@localhost.localdomain>
References: <20181120165300.18993-1-wainersm@redhat.com>
	<20181120190238.GR4755@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120190238.GR4755@habkost.net>
Subject: Re: [Qemu-devel] [PATCH] scripts/qemu.py: allow to launch the VM
 without a monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com

Hello Wainer and Eduardo,

On Tue, Nov 20, 2018 at 05:02:38PM -0200, Eduardo Habkost wrote:
> On Tue, Nov 20, 2018 at 11:53:00AM -0500, Wainer dos Santos Moschetta wrote:
> > QEMUMachine launches the VM with a monitor enabled, afterwards
> > a qmp connection is attempted on _post_launch(). In case
> > the QEMU process exits with an error, qmp.accept() reaches
> > timeout and raises an exception.
> > 
> > But sometimes you don't need that monitor. As an example,
> > when a test launches the VM expects its immediate crash,
> > and only intend to check the process's return code. In this
> > case the fact that launch() tries to establish the qmp
> > connection (ending up in an exception) is troublesome.
> > 
> > So this patch adds the disable_qmp() that allow to
> > launch the VM without creating the monitor machinery.
> > 
{...}
> > +
> > +        self._args.extend(['-chardev', moncdev, '-mon', 'chardev=mon,mode=control'])
> 
> This will extend self._args multiple times if making a
> .shutdown()/.launch() cycle:
> 
{...}
> 
> Why did you move this code outside _base_args(), where it already
> worked without relying on method side-effects and required no
> extra state to be kept inside self._args?

Eduardo, I think the purpose was to get a way to set up the monitor
conditionally. So the arguments related with monitor was moved out
_base_args() method and put into the _setup_qmp(). However, as you
showed, this implementation has undesired side-effects.

Wainer, probably the most straightforward way to add this capability to
QEMUMachine is to change the _base_args() method to only include monitor
arguments when necessary. Something like this:

```
    # create a proper method to get moncdev_args
    def _get_moncdev_args():
        if isinstance(self._monitor_address, tuple):
            return "socket,id=mon,host=%s,port=%s" % (
                self._monitor_address[0],
                self._monitor_address[1])
        else:
            return 'socket,id=mon,path=%s' % self._vm_monitor

    # update _base_args method to use new attribute _with_qmp
    def _base_args(self):
        args = ['-display', 'none', '-vga', 'none']
        if self._with_qmp:
            args.extend(['-chardev', self._get_moncdev_args(),
                         '-mon', 'chardev=mon,mode=control'])
        if self._machine is not None:
```

Does it make sense?

> 
{...}
> 
> -- 
> Eduardo

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
