Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6beb-0002RH-Gz
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6beY-0004su-G8
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:48:41 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:47249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1f6beY-0004rp-8L
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:48:38 -0400
Date: Thu, 12 Apr 2018 14:48:34 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180412124834.GA2025@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>
	<20180411073638.GA10940@ruderich.org>
	<6e51f584-b850-9881-a8e1-3dafa85a11df@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <6e51f584-b850-9881-a8e1-3dafa85a11df@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Apr 11, 2018 at 08:02:58AM -0500, Eric Blake wrote:
> You could always add qemu_fopen/qemu_fclose to match the existing
> qemu_open/qemu_close.  But you do have a point that you can't call
> qemu_close/fclose (because fclose would be left with a stale fd that
> might spuriously close something that has been opened in another thread
> during the race window), nor fclose/qemu_close.
>
> The FILE interface may sometimes be easier to work with, but it also
> comes with buffering issues that you don't have to worry about when
> using the fd interface.

Yeah. I'm using plain qemu_open()/qemu_close() and read/write
directly.

> Good point - but yes, ideally it should always be possible to pass in an
> fd instead of having qemu itself open a file, because there are
> execution environments where qemu is intentionally prohibited from
> directly calling open() for security reasons (where the management app,
> such as libvirt, opens and then passes fds to qemu instead).

I've converted qmp_memsave/qmp_pmemsave in extra patches to use
qemu_open() (and some additional cleanup).

> You are correct that we can't really change the existing interface; so
> documenting in the commit message that your choice of names is for
> consistency reasons may be sufficient.

Will do.

Revised patches which should implement all of your suggestions
(and the style issue noticed by the bot) as replies to this mail.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
