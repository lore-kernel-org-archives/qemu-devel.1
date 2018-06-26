Received: from eggs.gnu.org ([2001:4830:134:3::10]:57257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXjS3-0002Se-CF
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXjS2-000631-7l
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:35:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180625164239.13794-1-kwolf@redhat.com>
Date: Tue, 26 Jun 2018 10:35:38 +0200
In-Reply-To: <20180625164239.13794-1-kwolf@redhat.com> (Kevin Wolf's message
	of "Mon, 25 Jun 2018 18:42:39 +0200")
Message-ID: <87h8lqkkrp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] usb-storage: Add rerror/werror properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> The error handling policy was traditionally set with -drive, but with
> -blockdev it is no longer possible to set frontend options. scsi-disk
> (and other block devices) have long supported qdev properties to
> configure the error handling policy, so let's add these options to
> usb-storage as well and just forward them to the internal scsi-disk
> instance.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Let's see whether I remember / figure out how this stuff works.

Not all devices support error handling policy, but scsi-disk does.

The preferred way to configure error handling policy is with qdev
properties rerror, werror.  blkconf_apply_backend_options() propagates
them to the associated BlockBackend.

The outmoded way is with -drive parameters rerror, werror.
blockdev_init() propagates them to the BlockBackend.

If you use both ways, qdev properties win.

usb-storage is a hack: it tries to look like a block device, but it's
really a SCSI controller that can serve only a single scsi-disk device,
which it creates automatically.

We want to deprecate -drive.  We also want to deprecate usb-storage, but
I guess we're still not ready for that (it's a complicated story).

To deprecate -drive without also deprecating usb-storage, we need to
preserve features.

The outmoded way works with usb-storage: the automatically created
scsi-disk is associated with the BlockBackend that got its error
handling policy from -drive.

The preferred way doesn't, because usb-storage lacks the qdev
properties.  This patch adds them.

Kind of sad, but it's either that or deprecating usb-storage.

Patch looks good to me, thus
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Feel free to work whatever parts of my ramblings you find useful into
your commit message.
