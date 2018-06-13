Received: from eggs.gnu.org ([2001:4830:134:3::10]:37032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwjl-0000ez-2T
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwjg-0003kX-CP
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:46:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSwjg-0003kF-5f
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D33F287A7C
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 03:46:14 +0000 (UTC)
Date: Wed, 13 Jun 2018 11:46:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180613034610.GG15344@xz-mi>
References: <20180612062430.GA15344@xz-mi>
	<20180612064119.GC29380@lemon.usersys.redhat.com>
	<818e1eff-6c10-5a00-c21c-217c2f02f02c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <818e1eff-6c10-5a00-c21c-217c2f02f02c@redhat.com>
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Tue, Jun 12, 2018 at 01:29:32PM +0200, Laszlo Ersek wrote:
> Hi Fam,
> 
> On 06/12/18 08:41, Fam Zheng wrote:
> > On Tue, 06/12 14:24, Peter Xu wrote:
> >> Hi,
> >>
> >> For example, I wanted to compile QEMU once and install it on multiple
> >> systems.  What would be the suggested way to do so?
> >>
> >> Is there something similar to "make bin-rpmpkg" for Linux?
> >>
> >> Thanks in advance,
> > 
> > No. The big question is the libraries. Even if you create the rpm, the libraries
> > that you have linked against are not necessarily available on the systems you
> > install. This means you either list all possible libraries as required in the
> > rpm spec, which is a waste, or the list is generated dynamically, which is not
> > trivial. For example, you can easily build QEMU against a custom glib, but it's
> > very tricky to generate an rpm from it that works on other systems.
> > 
> > For development, maybe it's easier to combine git and Ansible.
> 
> libvirt supports RPM builds out of the upstream git tree:
> 
>   ./autogen.sh ...
>   make rpm
> 
> However, while QEMU doesn't support that, Peter's idea can be solved
> quite simply:
> 
> * run QEMU's configure with "--prefix=...". For example,
> --prefix=/opt/qemu-<version>.
> 
> * If you make sure that the prefix configured above is writeable to a
> non-root user, then "make install" can be executed without becoming root
> first.
> 
> * You can then tar up the installed file tree under prefix, and extract
> it on other hosts (at the same absolute prefix). If the installation is
> no longer needed, you can simply remove the file tree under the prefix.
> 
> * The above procedure works basically for all open source packages
> nowadays; however in order to actually use packages installed like this,
> a number of environment variables may have to be extended so they refer
> to various subdirectories under "prefix":
> 
> - CPLUS_INCLUDE_PATH
>   (so g++ can find include files)
> - C_INCLUDE_PATH
>   (so gcc can find include files)
> - INFOPATH
>   (so "info" can find docs)
> - LD_LIBRARY_PATH
>   (so ld.so can load shared objects at executable startup)
> - LIBRARY_PATH
>   (so gcc/g++/ld can resolve "-l" options at link editing time)
> - MANPATH
>   (so "man" can find docs)
> - PATH
>   (so the shell finds the binary)
> - PKG_CONFIG_PATH
>   (modern replacement for CPLUS_INCLUDE_PATH, C_INCLUDE_PATH,
>   and LIBRARY_PATH)
> - PYTHONPATH
>   (so python can find python modules)
> - ...
> 
> On my laptop, I have a bunch of packages installed like this, and I have
> a script that traverses /opt and generates another script that assigns
> all of the above variables. This latter script is then sourced by my
> ~/.bashrc.
> 
> Considering QEMU specifically, only two of the above variables need to
> be extended in practice:
> 
> - MANPATH: append <prefix>/share/man
> - PATH: append <prefix>/bin

These steps might be a bit heavy-weighted for debugging purpose of
mine, but please take my sincere thanks on all these steps!  I believe
I could use the idea somewhere, for example, this marco list is really
a good thing to know when debugging libraries with old versions.
Also, the "tar + pipe" magic you offered in the other thread with Fam
is nice and more light-weighted to me.

I'm considering maybe I'll read about how to "make binrpm" for QEMU
some day in case it'll ease some of us.

> 
> Summary: (1) configure QEMU with option "--prefix", (2) give rwx on
> "prefix" to the user that builds and installs QEMU, (3) build and
> install QEMU as that user, (3) transfer the tree under prefix to another
> host, (4) expand to the same prefix on the target, (5) update MANPATH
> and PATH on the target.

And... you even provided a summary for all the steps!

Thanks again, Laszlo!

-- 
Peter Xu
