Received: from eggs.gnu.org ([2001:4830:134:3::10]:46207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eZGzI-0001j8-C1
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eZGzE-0000hn-9u
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:04:16 -0500
Date: Wed, 10 Jan 2018 15:03:49 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180110140349.6ehnffp6hlkyncss@eukaryote>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108144136.GF8052@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-img: Let "info" warn and go ahead
 without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, Jan 08, 2018 at 03:41:36PM +0100, Kevin Wolf wrote:
> Am 05.01.2018 um 07:55 hat Fam Zheng geschrieben:
> > Management and users are accustomed to "qemu-img info" to query status of
> > images even when they are used by guests. Since image locking was added, the -U
> > (--force-share) option is needed for that to work. The reason has been that due
> > to possible race with image header update, the output can be misleading.
> > 
> > But what are likely to happen after we emit the error are that, for interactive
> > users, '-U' will be used and the command retried; for management (nova, RHV,
> > etc.), the operation is broken with no knob to workaround this.
> > 
> > This series changes that error to a warning so that it doesn't get in the way.
> 
> Are management tools actually doing this? There is no good reason to
> call 'qemu-img info' for an image that is in use by a VM.

Yes, Nova does use 'qemu-img info' in a few places (haven't audited them
all) for a running guest.  From a quick look at the code, at-least
during Nova's live snaphot (as part of libvirt's "shallow rebase") it is
used.

> If no, NACK. Automatically disabling locking because it can be
> inconvenient defeats the purpose of locking.
> 
> If yes, clearly indicate that this usage is deprecated and we'll turn
> this into an error again with 2.13. Then management tools can be fixed
> in time.

Yes, for completness' sake, Nova upstream is already patched to use the
`qemu-img` '--force-share' flag that comes with QEMU >= 2.10.

-- 
/kashyap
