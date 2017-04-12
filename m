Received: from eggs.gnu.org ([2001:4830:134:3::10]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cyEvw-0005EI-1k
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cyEvv-0004cv-5O
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:51:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170412091819.GB4955@noname.str.redhat.com>
References: <20170412091819.GB4955@noname.str.redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 12 Apr 2017 17:51:23 +0800
Message-ID: <CAOGPPbfkZ5qJC-YkeBs+LLdn88VTvij_Xk8_FEpaNmg_pyXVVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] migrate -b problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, dgilbert@redhat.com, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, quintela@redhat.com

it this bug?
https://bugs.launchpad.net/qemu/+bug/1681688

On Wed, Apr 12, 2017 at 5:18 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Hi all,
>
> after getting assertion failure reports for block migration in the last
> minute, we just hacked around it by commenting out op blocker assertions
> for the 2.9 release, but now we need to see how to fix things properly.
> Luckily, get_maintainer.pl doesn't report me, but only you. :-)
>
> The main problem I see with the block migration code (on the
> destination) is that it abuses the BlockBackend that belongs to the
> guest device to make its own writes to the image file. If the guest
> isn't allowed to write to the image (which it now isn't during incoming
> migration since it would conflict with the newer style of block
> migration using an NBD server), writing to this BlockBackend doesn't
> work any more.
>
> So what should really happen is that incoming block migration creates
> its own BlockBackend for writing to the image. Now we don't want to do
> this anew for every incoming block, but ideally we'd just create all
> necessary BlockBackends upfront and then keep using them throughout the
> whole migration. Is there a way to get some setup/teardown callbacks
> at the start/end of the migration that could initialise and free such
> global data?
>
> The other problem with block migration is that is uses a BlockBackend
> name to identify which device is migrated. However, there can be images
> that are not attached to any BlockBackend, or if it is, the BlockBackend
> might be anonymous, so this doesn't work. I suppose changing the field
> to "device name if available, node-name otherwise" would solve this.
>
> Kevin
>
