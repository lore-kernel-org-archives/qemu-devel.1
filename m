Received: from eggs.gnu.org ([2001:4830:134:3::10]:54841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cqOvs-0006ar-OR
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cqOvq-0003Vn-51
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:55:00 -0400
Received: from mail.kernel.org ([198.145.29.136]:38804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cqOvp-0003Vb-Rq
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:54:58 -0400
Date: Tue, 21 Mar 2017 11:54:46 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <da852b5f-2490-c483-984d-c7be4f83b9a7@suse.com>
Message-ID: <alpine.DEB.2.10.1703211152240.11679@sstabellini-ThinkPad-X260>
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-3-jgross@suse.com>
	<alpine.DEB.2.10.1703161306380.15430@sstabellini-ThinkPad-X260>
	<214bc24d-1c0c-16d6-9c33-e20962b150d2@suse.com>
	<alpine.DEB.2.10.1703171123520.22036@sstabellini-ThinkPad-X260>
	<da852b5f-2490-c483-984d-c7be4f83b9a7@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/2] configure: use pkg-config for
 obtaining xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, kraxel@redhat.com, paul.durrant@citrix.com

On Tue, 21 Mar 2017, Juergen Gross wrote:
> On 17/03/17 19:33, Stefano Stabellini wrote:
> > On Fri, 17 Mar 2017, Juergen Gross wrote:
> >> On 16/03/17 21:20, Stefano Stabellini wrote:
> >>> On Thu, 16 Mar 2017, Juergen Gross wrote:
> >>>> Instead of trying to guess the Xen version to use by compiling various
> >>>> test programs first just ask the system via pkg-config. Only if it
> >>>> can't return the version fall back to the test program scheme.
> >>>
> >>> That's OK, but why did you remove the Xen unstable test?
> >>
> >> >From Xen 4.9 on pkg-config will return the needed information. There is
> >> no longer a need for a test program to determine the Xen version. After
> >> all this was the main objective of my series adding the pkg-config
> >> files to Xen.
> > 
> > I was going to say something like "yeah, but is pkg-config always
> > available?" In reality, QEMU already has pkg-config as build
> > dependency, so I guess there is no problem with that.
> > 
> > Please add a note about this to the commit message.
> > 
> 
> Okay.

Sorry to point this out only now, and I realize that it might be
unimportant for production builds, but it is important to me, and
developers in general, to be able to test a single QEMU tree against a
number of Xen trees (all releases from 4.3 onward).

With this change (specifically dropping the 4.9 build test), out of tree
builds don't work anymore. I would like to be able to do:

./configure --enable-xen --target-list=i386-softmmu \
                --extra-cflags="-I$DIR/tools/include \
                -I$DIR/tools/libs/toollog/include \
                -I$DIR/tools/libs/evtchn/include \
                -I$DIR/tools/libs/gnttab/include \
                -I$DIR/tools/libs/foreignmemory/include \
                -I$DIR/tools/libs/devicemodel/include \
                -I$DIR/tools/libxc/include \
                -I$DIR/tools/xenstore/include \
                -I$DIR/tools/xenstore/compat/include" \
                --extra-ldflags="-L$DIR/tools/libxc \
                -L$DIR/tools/xenstore \
                -L$DIR/tools/libs/evtchn \
                -L$DIR/tools/libs/gnttab \
                -L$DIR/tools/libs/foreignmemory \
                -L$DIR/tools/libs/devicemodel \
                -Wl,-rpath-link=$DIR/tools/libs/toollog \
                -Wl,-rpath-link=$DIR/tools/libs/evtchn \
                -Wl,-rpath-link=$DIR/tools/libs/gnttab \
                -Wl,-rpath-link=$DIR/tools/libs/call \
                -Wl,-rpath-link=$DIR/tools/libs/foreignmemory \
                -Wl,-rpath-link=$DIR/tools/libs/devicemodel" \
            --disable-kvm 
make

And the make should succeed. Is there a way to do that with pkg-config?
If not, I think we should keep the existing tests (and only add
pkg-config tests in addition to them, not in alternative).
