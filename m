Received: from eggs.gnu.org ([2001:4830:134:3::10]:48383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFgk0-0002ZE-Rw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFgjw-0005Xq-UR
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFgjw-0005Xi-On
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:03:44 -0400
Date: Mon, 7 May 2018 11:03:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507140329.GW25013@localhost.localdomain>
References: <20180420181951.7252-1-ehabkost@redhat.com>
	<20180420181951.7252-14-ehabkost@redhat.com>
	<20180430130246.GB10576@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430130246.GB10576@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC 13/24] avocado_qemu: Functional test for
 RHBZ#1431939
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Amador Pahim <apahim@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

On Mon, Apr 30, 2018 at 02:02:46PM +0100, Stefan Hajnoczi wrote:
> On Fri, Apr 20, 2018 at 03:19:40PM -0300, Eduardo Habkost wrote:
> > +    def test_hotplug_memory_default_policy(self):
> > +        """
> > +        According to the RHBZ1431939, the issue is 'host nodes'
> > +        returning '128'. It should return empty value when memory
> > +        hotplug default policy is used.
> > +
> > +        Fixed in commit d81d857f4421d205395d55200425daa6591c28a5.
> > +        :avocado: tags=RHBZ1431939
> > +        """
> > +
> > +        cmd = 'object_add memory-backend-ram,id=mem1,size=1G'
> > +        res = self.vm.qmp('human-monitor-command', command_line=cmd)
> > +        self.assertEqual('', res['return'])
> 
> General question about QMP test coding style:
> 
> What happens if res['return'] does not exist because the QMP command
> failed?
> 
> I tend to use dict.get() to prevent KeyError.  That way the
> assertEqual() will fail instead of an unhandled KeyError in the test
> code.

It looks like vm.command() would be appropriate on most cases, as
it will check for errors and return res['result'] automatically.

vm.qmp() seems to be useful only if you really don't want an
exception to be raised in case of QMP errors.

Maybe we should rename .qmp() to .raw_qmp() to discourage people
from using it.

-- 
Eduardo
