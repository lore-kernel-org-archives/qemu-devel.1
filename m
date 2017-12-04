Received: from eggs.gnu.org ([2001:4830:134:3::10]:48697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eLpWS-0001wm-M6
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eLpWR-0004G0-RJ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:06:56 -0500
Date: Mon, 4 Dec 2017 13:06:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171204120646.GB872@localhost.localdomain>
References: <20171201234943.14695-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201234943.14695-1-klim.kireev@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-img: add the simplest format
 recognition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org, vsementsov@virtuozzo.com

Am 02.12.2017 um 00:49 hat Klim Kireev geschrieben:
> Now, if you type something like
> 
> qemu-img create disk.qcow2 1G
> or
> qemu-img dd if=/dev/sda of=disk.qcow2
> 
> it creates a raw image and if you need you should
> manually specify an image format with -f qcow2. It would
> be more convenient if it could be assumed from an extension.
> 
> This patch adds a simple heuristic to recognize the image format
> for qcow, qcow2, vmdk, vhdx, vdi
> 
> It warns users about guessed format and informs them about '-f' option.
> 
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>

This is an incompatible change.

If we want to go there, we must introduce a deprecation warning now
without any other change in behaviour. We need to warn users for two
releases that the behaviour will change in the future, and only then we
can switch over (i.e. in qemu 2.14 the earliest if we introduce the
warning in 2.12).

I'm not sure if we even want to automatically guess the format from the
filename, or if a warning/error would be enough even in the long term.

The behaviour I have in mind is like this:

* qemu-img create x.raw 4G            => works, possibly warning
* qemu-img create -f raw x.raw 4G     => works
* qemu-img create x.qcow2 4G          => error, need -f for non-raw
* qemu-img create -f qcow2 x.qcow2 4G => works
* qemu-img create -f raw x.qcow2 4G   => works, possibly warning

Kevin
