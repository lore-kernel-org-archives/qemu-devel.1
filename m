Received: from eggs.gnu.org ([2001:4830:134:3::10]:58967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJbSl-0003Hb-Hv
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJbSg-0003Qu-LC
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:37:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cJbSg-0003Qq-Ez
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:37:18 -0500
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c272490e-1c26-d47e-e9b1-d96ae3bed5c6@redhat.com>
Date: Wed, 21 Dec 2016 08:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/7] Move accel, KVM, Xen,
 qtest files to accel/ subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org, xen-devel@lists.xensource.com, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On 20.12.2016 18:43, Eduardo Habkost wrote:
> This moves the KVM and Xen files to the an accel/ subdir.
>=20
> Instead of moving the *-stubs.c file to accel/ as-is, I tried to
> move most of the stub code to libqemustub.a. This way the obj-y
> logic for accel/ is simpler: obj-y includes accel/ only if
> CONFIG_SOFTMMU is set.
>=20
> The Xen stubs could be moved completely to stubs/, but some of
> the KVM stubs depend on cpu.h. So most of the kvm-stub.c code was
> moved to stubs/kvm.c, but some of that code was kept in
> accel/kvm-stub.c.

Thanks for cleaning this up!

> About other CONFIG_SOFTMMU top-level files:
> -------------------------------------------
>=20
> I would like to know what we should do with the top-level
> CONFIG_SOFTMMU-only files that don't belong to hw/. Some
> candidates: arch_init.c cpus.c monitor.c gdbstub.c balloon.c
> ioport.c bootdevice.c memory.c cputlb.c memory_mapping.c dump.c.

arch_init.c is a potpourri of various topics, I think we should rather
split this file up and move the parts to other (new?) files, e.g. the
sound specific parts to the audio/ directory.

I think somebody (Paolo?) also suggested a monitor/ directory already,
so monitor.c and gdbstub.c could go into that directory?

> Maybe a sysemu/ subdir? In that case, should we still create an
> accel/ subdir, or move xen-*, kvm-* and friends to sysemu/ too?

IMHO the separate accel/ directory is fine. After your patch series,
there are already quite a bunch of files in it, and if Stefan Weil is
right, we'll soon get acceleration for Windows and macOS, too, so the
separate directory is justified.

 Thomas
