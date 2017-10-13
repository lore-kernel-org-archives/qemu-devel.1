Received: from eggs.gnu.org ([2001:4830:134:3::10]:33400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=45279cac4=Ian.Jackson@citrix.com>)
	id 1e2xRf-0003n8-OK
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=45279cac4=Ian.Jackson@citrix.com>)
	id 1e2xRc-0002Cb-K5
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:43:59 -0400
Received: from smtp.citrix.com ([66.165.176.89]:50227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=45279cac4=Ian.Jackson@citrix.com>)
	id 1e2xRc-000228-Cg
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:43:56 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23008.39143.424586.342064@mariner.uk.xensource.com>
Date: Fri, 13 Oct 2017 11:43:51 +0100
In-Reply-To: <b749ee6c-591b-4f31-7fd3-b0fa03f5f98b@citrix.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-4-git-send-email-ian.jackson@eu.citrix.com>
	<b749ee6c-591b-4f31-7fd3-b0fa03f5f98b@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] xen: defer call to xen_restrict until
 just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Ross Lagerwall writes ("Re: [PATCH 3/8] xen: defer call to xen_restrict until just before os_setup_post"):
> This works for normally starting a VM but doesn't seem to work when 
> resuming/migrating.
> 
> Here is the order of selected operations when starting a VM normally:
>      VNC server running on 127.0.0.1:5901
>      xen_change_state_handler()
>      xenstore_record_dm_state: running
>      xen_setup_post()
>      xentoolcore_restrict_all: rc = 0
>      os_setup_post()
>      main_loop()
> 
> Here is the order of selected operations when starting QEMU with 
> -incoming fd:... :
>      VNC server running on 127.0.0.1:5902
>      migration_fd_incoming()
>      xen_setup_post()
>      xentoolcore_restrict_all: rc = 0
>      os_setup_post()
>      main_loop()
>      migration_set_incoming_channel()
>      migrate_set_state()
>      xen_change_state_handler()
>      xenstore_record_dm_state: running
>      error recording dm state
>      qemu exited with code 1
> 
> The issue is that QEMU needs xenstore access to write "running" but this 
> is after it has already been restricted. Moving xen_setup_post() into 
> xen_change_state_handler() works fine. The only issue is that in the 
> migration case, it executes after os_setup_post() so QEMU might be 
> chrooted in which case opening /dev/null to restrict fds doesn't work 
> (unless its new root has a /dev/null).

Thanks for the extensive diagnosis.

We do in fact want the restriction to occur before the migration
stream is read.  This is because we are trying to defend against a
guest which can exploit a bug in qemu.  That means that the sending
qemu must be assumed to be compromised.  In this context I don't think
qemu's migration stream receiver can be regarded as hardened against
hostile input; it's far too complicated, even if efforts have been
made in that direction (I haven't checked).  So to avoid the receiving
qemu being compromised while still unrestricted, we should restrict
before starting to read the migration stream.

The correct fix is to use a different technique to notify the
toolstack that qemu is up and running.  That obviously requires
changes on the Xen tools side.  I will look into that for the Xen 4.11
release cycle.

Ian.
