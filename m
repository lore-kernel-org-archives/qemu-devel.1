Received: from eggs.gnu.org ([2001:4830:134:3::10]:47182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e0TCN-0002u0-4C
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e0TCM-0000E4-51
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:01:55 -0400
Date: Fri, 6 Oct 2017 15:01:37 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171006140137.GH26575@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
	<CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, Oct 06, 2017 at 09:58:33AM -0400, Doug Gale wrote:
> I tried to get tracing to work before and I have never gotten it
> working. I'll give it another try and redo the patch with tracing
> infrastructure if necessary. The printf are nice because the dev can
> just look at the terminal where qemu is running. Can you view the
> trace output in realtime? When their code is sitting at a breakpoint
> in their driver, can they see the last thing that was traced right
> there? Or do they have to go run some cumbersome command and wade
> through it after an entire test run after the vm shut down?

There's a variety of trace backends available. By default QEMU enables
the 'log' backend these days. So with a default build of QEMU you can
use the '-d' arg to turn on printing: eg.:

   qemu-system-x86_64 ...args...    -d trace:qio*

and that'll turn on every tracepoint with 'qio' as a prefix. The
trace messages will be printed straight to the console. eg:

$ qemu-system-x86_64 -d trace:qio* -serial unix:/tmp/foo,server
15774@1507298448.842745:qio_channel_socket_new Socket new ioc=0x5598b0565d60
15774@1507298448.842757:qio_channel_socket_listen_sync Socket listen sync ioc=0x5598b0565d60 addr=0x5598b0565c50
15774@1507298448.842803:qio_channel_socket_listen_complete Socket listen complete ioc=0x5598b0565d60 fd=16
qemu-system-x86_64: -serial unix:/tmp/foo,server: info: QEMU waiting for connection on: disconnected:unix:/tmp/foo,server
15774@1507298448.842818:qio_channel_socket_new Socket new ioc=0x5598b0564060
15774@1507298448.842820:qio_channel_socket_accept Socket accept start ioc=0x5598b0565d60


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
