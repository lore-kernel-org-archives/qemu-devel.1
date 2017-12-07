Received: from eggs.gnu.org ([2001:4830:134:3::10]:49595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eMuuF-00024Y-Bx
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eMuuB-0002PC-Dn
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:03:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eMuuB-0002Of-7F
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:03:55 -0500
Date: Thu, 7 Dec 2017 12:03:49 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171207120349.GH2450@redhat.com>
References: <20171205063313.GB4102@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205063313.GB4102@yangzhon-Virtual>
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: pbonzini@redhat.com, stefanha@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

I did a bit of work on this back in early 2016 and wrote a paper which
analyzes what Intel were doing with Clear Containers back then, and
how it fitted with the more distribution-centric view of Fedora and
Red Hat, ie that we ideally want a single qemu binary, a single
kernel, a single SeaBIOS, etc.

You can read the paper here:

  http://oirase.annexia.org/tmp/paper.pdf

and the source is here:

  http://git.annexia.org/?p=libguestfs-talks.git;a=tree;f=2016-eng-talk;h=5a0a29ceb1e9db39539669717ec06e4f94eba086;hb=HEAD

To address a few points from this thread:

* As Paolo mentioned one problem is we link qemu to so many libraries,
  and glibc / ELF dynamic loading is very slow.  Modularizing qemu
  could help here.  Reducing symbol interposition
  (-fvisibility=hidden) in more libraries would help a bit.  Linker
  security features enabled in downstream distros don't help.
  Rewriting ELF to be less crazy would help a lot but good luck there :-)

* As Stefan & Paolo mentioned, it would be nice if SeaBIOS was faster
  in the default configuration.  I ended up compiling a special
  minimal SeaBIOS which saved a load of time, mainly not probing PCI
  unnecessarily IIRC.

* Considerable time is taken in booting the kernel, and that's mostly
  in running all the initcall functions.  We wanted to use a Fedora
  distro kernel, but unfortunately many subsystems do loads of
  initcall work which is run even when that subsystem is not used.
  This is why compiling a custom kernel (compiling out these
  subsystems) is enticing.  Parallelizing initialization could help
  here (however at the moment using -smp slows things down), also
  parallelizing was rejected upstream IIRC.

* PCI config space probing is really slow.  Unfortunately accelerating
  it in the kernel doesn't seem either very easy or very acceptable to
  KVM upstream: the use case is rather narrow & the implementation
  seems like it would be very complex.  I also write a parallelizing
  PCI probe for Linux which helped a bit but wasn't upstream material.

* udev is another huge problem.  It's slow, it's monolithic, it
  resists modifications such as modularization or removing parts.

* Debugging over the UART is slow.

libguestfs also ships with benchmarking tools which can be very useful
to actually measure boot time:

  https://github.com/libguestfs/libguestfs/tree/master/utils

HTH,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
