Received: from eggs.gnu.org ([2001:4830:134:3::10]:50271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2wij-0003mQ-CC
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2wig-0007ro-9N
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2wif-0007r6-Vl
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E82EC83F3E
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:57:28 +0000 (UTC)
Date: Fri, 13 Oct 2017 10:57:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171013095724.GE20515@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171013081450.29647-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013081450.29647-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/11] Ui 20171013 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Oct 13, 2017 at 10:14:39AM +0200, Gerd Hoffmann wrote:
> The following changes since commit bac960832015bf4c4c1b873011612e2675e4464c:
> 
>   Merge remote-tracking branch 'remotes/elmarco/tags/vus-pull-request' into staging (2017-10-11 13:10:36 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kraxel.org/qemu tags/ui-20171013-pull-request
> 
> for you to fetch changes up to 942a35335b2efa2f2997d51eb5142fc9903efe43:
> 
>   gtk: fix wrong id between texture and framebuffer (2017-10-13 10:10:36 +0200)
> 
> ----------------------------------------------------------------
> ui: use keycodemapdb for key code mappings, part one (v2)
> ui: add qemu-keymap, update reverse keymaps (for qemu -k $map)
> ui: fix for vte 0.50
> ui: gtk texture fix
> 
> ----------------------------------------------------------------

I'm afraid this is quite likely to fail build smoke test again. I've
just tried a build on OpenBSD with the bash -> sh fix in it, and I
found that it still tried to build the keycodemap files in parallel
with checking out the GIT submodules. It also tried to run the
mkdir -p dtc/libfdt in parallel and this caused git to refuse to
checkout the dtc module due to that empty dir existing. So there's
still some deps problems in here I think that let make build in
the wrong order :-(

  GEN     config-host.h
  GEN     module_block.h
  GEN     ui/input-keymap-linux-to-qcode.c
  GEN     ui/input-keymap-qcode-to-qnum.c
  GEN     ui/input-keymap-qnum-to-qcode.c
python: can't open file '/home/berrange/src/virt/qemu/ui/keycodemapdb/tools/keymap-gen': [Errno 2] No such file or directory
python: can't open file '/home/berrange/src/virt/qemu/ui/keycodemapdb/tools/keymap-gen': [Errno 2] No such file or directory
python: can't open file '/home/berrange/src/virt/qemu/ui/keycodemapdb/tools/keymap-gen': [Errno 2] No such file or directory
mkdir -p dtc/libfdt
  GIT     ui/keycodemapdb dtc
mkdir -p dtc/tests

This should be impossible because ui/input-keymap-* depends on the
tools/keymap-gen, and that depends on the submodule status file,
which in turn should trigger the checkout, but the build log
showed that isn't working as we expect.

In all my debugging the one thing I've seen work correctly is the
re-running of configure (via config.status), which always happens
earlier and is serialized wrt everything else. So I wonder if we
should change direction slightly, and have configure checkout the
submodules. Then just make sure that config.status is triggered
when submodules are out of date.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
