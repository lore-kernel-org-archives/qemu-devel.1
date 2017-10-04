Received: from eggs.gnu.org ([2001:4830:134:3::10]:46026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzf7t-0003Iq-45
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzf7p-0005Nn-9U
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzf7p-0005Mv-0g
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:33:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 385DDC04AC6B
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 08:33:51 +0000 (UTC)
Date: Wed, 4 Oct 2017 09:33:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171004083329.GB17517@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
	<1505824179-21541-45-git-send-email-pbonzini@redhat.com>
	<20171003160706.2671a6ea@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003160706.2671a6ea@t450s.home>
Subject: Re: [Qemu-devel] [PULL 44/50] scripts: let checkpatch.pl process an
 entire GIT branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, Oct 03, 2017 at 04:07:06PM -0600, Alex Williamson wrote:
> On Tue, 19 Sep 2017 14:29:33 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> > 
> > Currently before submitting a series, devs should run checkpatch.pl
> > across each patch to be submitted. This can be automated using a
> > command such as:
> > 
> >   git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'
> > 
> > This is rather long winded to type, so this patch introduces a way
> > to tell checkpatch.pl to validate a series of GIT revisions.
> > 
> > There are now three modes it can operate in 1) check a patch 2) check a source
> > file, or 3) check a git branch.
> > 
> > If no flags are given, the mode is determined by checking the args passed to
> > the command. If the args contain a literal ".." it is treated as a GIT revision
> > list. If the args end in ".patch" or equal "-" it is treated as a patch file.
> > Otherwise it is treated as a source file.
> > 
> > This automatic guessing can be overridden using --[no-]patch --[no-]file or
> > --[no-]branch
> > 
> > For example to check a GIT revision list:
> > 
> >     $ ./scripts/checkpatch.pl master..
> >     total: 0 errors, 0 warnings, 297 lines checked
> > 
> >     b886d352a2bf58f0996471fb3991a138373a2957 has no obvious style problems and is ready for submission.
> >     total: 0 errors, 0 warnings, 182 lines checked
> > 
> >     2a731f9a9ce145e0e0df6d42dd2a3ce4dfc543fa has no obvious style problems and is ready for submission.
> >     total: 0 errors, 0 warnings, 102 lines checked
> > 
> >     11844169bcc0c8ed4449eb3744a69877ed329dd7 has no obvious style problems and is ready for submission.
> > 
> > If a genuine patch filename contains the characters '..' it is
> > possible to force interpretation of the arg as a patch
> > 
> >   $ ./scripts/checkpatch.pl --patch master..
> > 
> > will force it to load a patch file called "master..", or equivalently
> > 
> >   $ ./scripts/checkpatch.pl --no-branch master..
> > 
> > will simply turn off guessing of GIT revision lists.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > Message-Id: <20170913091000.9005-1-berrange@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  scripts/checkpatch.pl | 138 ++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 111 insertions(+), 27 deletions(-)
> 
> 
> This introduces the following regression for me:
> 
> $ ./scripts/checkpatch.pl patches-next/vfio-pci-add-virtual
> ERROR: trailing whitespace
> #44: FILE: vfio-pci-add-virtual:44:

IIUC, it is treating 'patches-next/vfio-pci-add-virtual' as a plain
source file, rather than a patch file because its filename doesn't
include .patch at the end.

I the heuristic based on the idea that there's always be a .patch
at the end of patch files. git format-patch at least will do this
by default - is there a particular reason you've not got any file
extension ?

BTW, assuming this diagnosis is correct, if you use --patch
it should work. eg try

./scripts/checkpatch.pl --patch patches-next/vfio-pci-add-virtual

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
