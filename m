Received: from eggs.gnu.org ([2001:4830:134:3::10]:57450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fShUY-0000PD-Ar
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fShUV-0007LY-56
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:29:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fShUU-0007LE-Vc
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:29:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFF6F8314C
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 11:29:33 +0000 (UTC)
References: <20180612062430.GA15344@xz-mi>
	<20180612064119.GC29380@lemon.usersys.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <818e1eff-6c10-5a00-c21c-217c2f02f02c@redhat.com>
Date: Tue, 12 Jun 2018 13:29:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180612064119.GC29380@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

Hi Fam,

On 06/12/18 08:41, Fam Zheng wrote:
> On Tue, 06/12 14:24, Peter Xu wrote:
>> Hi,
>>
>> For example, I wanted to compile QEMU once and install it on multiple
>> systems.  What would be the suggested way to do so?
>>
>> Is there something similar to "make bin-rpmpkg" for Linux?
>>
>> Thanks in advance,
> 
> No. The big question is the libraries. Even if you create the rpm, the libraries
> that you have linked against are not necessarily available on the systems you
> install. This means you either list all possible libraries as required in the
> rpm spec, which is a waste, or the list is generated dynamically, which is not
> trivial. For example, you can easily build QEMU against a custom glib, but it's
> very tricky to generate an rpm from it that works on other systems.
> 
> For development, maybe it's easier to combine git and Ansible.

libvirt supports RPM builds out of the upstream git tree:

  ./autogen.sh ...
  make rpm

However, while QEMU doesn't support that, Peter's idea can be solved
quite simply:

* run QEMU's configure with "--prefix=...". For example,
--prefix=/opt/qemu-<version>.

* If you make sure that the prefix configured above is writeable to a
non-root user, then "make install" can be executed without becoming root
first.

* You can then tar up the installed file tree under prefix, and extract
it on other hosts (at the same absolute prefix). If the installation is
no longer needed, you can simply remove the file tree under the prefix.

* The above procedure works basically for all open source packages
nowadays; however in order to actually use packages installed like this,
a number of environment variables may have to be extended so they refer
to various subdirectories under "prefix":

- CPLUS_INCLUDE_PATH
  (so g++ can find include files)
- C_INCLUDE_PATH
  (so gcc can find include files)
- INFOPATH
  (so "info" can find docs)
- LD_LIBRARY_PATH
  (so ld.so can load shared objects at executable startup)
- LIBRARY_PATH
  (so gcc/g++/ld can resolve "-l" options at link editing time)
- MANPATH
  (so "man" can find docs)
- PATH
  (so the shell finds the binary)
- PKG_CONFIG_PATH
  (modern replacement for CPLUS_INCLUDE_PATH, C_INCLUDE_PATH,
  and LIBRARY_PATH)
- PYTHONPATH
  (so python can find python modules)
- ...

On my laptop, I have a bunch of packages installed like this, and I have
a script that traverses /opt and generates another script that assigns
all of the above variables. This latter script is then sourced by my
~/.bashrc.

Considering QEMU specifically, only two of the above variables need to
be extended in practice:

- MANPATH: append <prefix>/share/man
- PATH: append <prefix>/bin

Summary: (1) configure QEMU with option "--prefix", (2) give rwx on
"prefix" to the user that builds and installs QEMU, (3) build and
install QEMU as that user, (3) transfer the tree under prefix to another
host, (4) expand to the same prefix on the target, (5) update MANPATH
and PATH on the target.

Thanks
Laszlo
