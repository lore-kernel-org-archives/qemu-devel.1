Received: from eggs.gnu.org ([2001:4830:134:3::10]:57737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyeP2-0003zX-3A
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyeOv-0000of-T6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:07:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eyeOv-0000oH-NP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:07:37 -0400
Date: Wed, 21 Mar 2018 22:07:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180321140734.GB2188@lemon.usersys.redhat.com>
References: <20180216164620.GA53727@humpty.home.comstyle.com>
	<c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
	<85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
	<e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
	<128f62e5-9184-57e5-88c1-d5cc4bf27d4f@redhat.com>
	<20180321081112.GE26017@lemon.usersys.redhat.com>
	<9b247ea1-7a91-6d39-6c80-7c1679c6a098@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b247ea1-7a91-6d39-6c80-7c1679c6a098@redhat.com>
Subject: Re: [Qemu-devel] make vm-test [was: [PATCH] maintainers: Add myself
 as a OpenBSD maintainer]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org

On Wed, 03/21 08:14, Eric Blake wrote:
> On 03/21/2018 03:11 AM, Fam Zheng wrote:
> > > Thanks for this; today was my first day trying the various vm-build-
> > > targets.
> > > 
> > > Question: is this expected behavior?
> > > 
> > > $ make vm-build-ubuntu.i386
> > >      VM-IMAGE ubuntu.i386
> > > ...
> > > Image resized.
> > > debconf: unable to initialize frontend: Dialog
> > > debconf: (TERM is not set, so the dialog frontend is not usable.)
> 
> > > 
> > > I'm wondering if the image initialized incorrectly, and as a result can't do
> > > as much as it's supposed to do, or runs way slower than it needs to?  The
> > > command eventually completed with status 0, but failed to find a 32-bit
> > > compile error in the rdma code, and the output log does not look like it
> > > actually attempted to compile anything in qemu (unless it did compile it,
> > > but the logs were not output to stdout/stderr).
> > > 
> > > make vm-build-freebsd was a lot faster at completing for me (but shows that
> > > we still have a lot of clang warnings about address of a packed struct
> > > member).
> > > 
> > 
> > Was it a clean repo? Did you try "rm -rf ~/.cache/qemu-vm"? This morning the
> > command worked for me from a clean env (on RHEL 7, using a QEMU built from
> > qemu.git), and I didn't see the errors/warnings you pasted. (BTW I don't
> > understand how sudo has anything to do with the dummy host name.)
> 
> I repeated the test twice this morning after 'rm -rf ~/.cache/qemu-vm',
> first after 'rm tests/vm/ubuntu.i386.img' in an incremental tree, and second
> in a fresh git checkout.  Here's a full pastebin of the first try (I hit ^C
> after seeing it look the same as yesterday, even after the fresh redownload
> that took more than 10 minutes):
> https://paste.fedoraproject.org/paste/p8Th7AroLAprGY03ffzGHA
> 
> The results are the same; debconf is somehow unable to connect to the guest,
> and as a result, the guest is not properly initialized with the additional
> packages it needs, and then everything else about the image is broken.
> 
> Then on the second try, I got a dreaded message about my /home being nearly
> full, (having multiple .img files in two different build directories pushed
> me over limits), and it died a much harder death due to ENOSPC.  Let me
> resize my /home and retry (thankfully I still have some disk space free to
> throw at the problem), and I'll report back if that makes a difference.

Now I see the problem. I always use V=1 so stdout is different for the spawned
commands (qemu and ssh) in the script. I will send a patch tomorrow. Thanks!

Fam
