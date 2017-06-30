Received: from eggs.gnu.org ([2001:4830:134:3::10]:59090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR3mh-0001Oz-Qy
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR3mg-0005aQ-Rx
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:49:03 -0400
Date: Fri, 30 Jun 2017 17:48:55 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170630214855.GC26034@localhost.localdomain>
References: <20170621133023.27627-1-mreitz@redhat.com>
	<20170621133023.27627-2-mreitz@redhat.com>
	<748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
	<6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
	<7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
	<f1395eb6-46a4-9982-d625-626faac61ae3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1395eb6-46a4-9982-d625-626faac61ae3@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 1/2] iotests: Use absolute
 paths for executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Fri, Jun 30, 2017 at 02:45:46PM -0500, Eric Blake wrote:
> On 06/30/2017 02:41 PM, Eric Blake wrote:
> 
> > +++ 068.out.bad	2017-06-30 14:35:28.720241398 -0500
> > @@ -1,4 +1,5 @@
> >  QA output created by 068
> > +realpath: '': No such file or directory
> > 
> > The culprit? $QEMU_VXHS_PROG is empty for me, which means `set_prog_path
> > qnio_server` found nothing to use.  You'll have to add in a safety valve
> > that only calls 'type' if operating on a non-empty path in the first place.
> 
> I'm using this locally, in the meantime:
> 
> diff --git i/tests/qemu-iotests/common.config
> w/tests/qemu-iotests/common.config
> index c1dc425..6f97331 100644
> --- i/tests/qemu-iotests/common.config
> +++ w/tests/qemu-iotests/common.config
> @@ -107,7 +107,9 @@ export QEMU_PROG=$(realpath -- "$(type -p
> "$QEMU_PROG")")
>  export QEMU_IMG_PROG=$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
>  export QEMU_IO_PROG=$(realpath -- "$(type -p "$QEMU_IO_PROG")")
>  export QEMU_NBD_PROG=$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
> -export QEMU_VXHS_PROG=$(realpath -- "$(type -p "$QEMU_VXHS_PROG")")
> +if [ -n "$QEMU_VXHS_PROG" ]; then
> +    export QEMU_VXHS_PROG=$(realpath -- "$(type -p "$QEMU_VXHS_PROG")")
> +fi
> 
>  _qemu_wrapper()
>  {
> 
> 
> Is qnio_server easily available for Fedora?
>

Depends on your definition of "easily".  It needs to be built from the
upstream project github [1].  Most developers will likely not have it
installed.

https://github.com/VeritasHyperScale/libqnio
