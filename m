Received: from eggs.gnu.org ([2001:4830:134:3::10]:54472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhF9y-0008Hx-HB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhF9v-0002Ib-9i
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:11:58 -0400
Date: Mon, 14 Aug 2017 15:11:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170814151150.415977c9@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA-Jac8wFzQ9vRyKjcEwDKYBdXysNyDP7ERFfXFhVcF56w@mail.gmail.com>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
	<a808c0865b720e22ca2929ec3d362d4610fbad51.1502708830.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA-Jac8wFzQ9vRyKjcEwDKYBdXysNyDP7ERFfXFhVcF56w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 7/7] hw/misc/mmio_interface: Return after
 error_setg() to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 14 Aug 2017 12:45:16 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 14 August 2017 at 12:07, Michael Tokarev <mjt@tls.msk.ru> wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >
> > QEMU currently abort()s if the user tries to specify the mmio_interface
> > device without parameters:
> >
> > x86_64-softmmu/qemu-system-x86_64 -nographic -device mmio_interface
> > qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
> >  Assertion `*errp == ((void *)0)' failed.
> > Aborted (core dumped)
> >
> > This happens because the realize function is trying to set the errp
> > twice in this case. After setting an error, the realize function
> > should immediately return instead.  
> 
> It seems like it should be an error to permit this to be
> created from the command line at all -- the device is intended
> only as an internal implementation detail of the memory system,
> and it has a PROP_PTR property which can't be sensibly set
> from the command line.
> 
> This patch is a correct fix for an immediate problem, but we should disable
> using this via -device somehow.

Setting DeviceClass::user_creatable to false should prevent creating device
with device_add interface. See: qdev_get_device_class()

> 
> thanks
> -- PMM
> 
