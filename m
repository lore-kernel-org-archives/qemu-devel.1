Received: from eggs.gnu.org ([2001:4830:134:3::10]:58954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=452428aa2=ross.lagerwall@citrix.com>)
	id 1e2vTC-0006S0-WB
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=452428aa2=ross.lagerwall@citrix.com>)
	id 1e2vT8-0004Nj-34
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:37:27 -0400
Received: from smtp.citrix.com ([66.165.176.89]:44749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=452428aa2=ross.lagerwall@citrix.com>)
	id 1e2vT7-0004MK-Qr
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:37:22 -0400
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-4-git-send-email-ian.jackson@eu.citrix.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <b749ee6c-591b-4f31-7fd3-b0fa03f5f98b@citrix.com>
Date: Fri, 13 Oct 2017 09:37:02 +0100
MIME-Version: 1.0
In-Reply-To: <1507564902-9000-4-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On 10/09/2017 05:01 PM, Ian Jackson wrote:
> We need to restrict *all* the control fds that qemu opens.  Looking in
> /proc/PID/fd shows there are many; their allocation seems scattered
> throughout Xen support code in qemu.
> 
> We must postpone the restrict call until roughly the same time as qemu
> changes its uid, chroots (if applicable), and so on.
> 
> There doesn't seem to be an appropriate hook already.  The RunState
> change hook fires at different times depending on exactly what mode
> qemu is operating in.
> 
> And it appears that no-one but the Xen code wants a hook at this phase
> of execution.  So, introduce a bare call to a new function
> xen_setup_post, just before os_setup_post.  Also provide the
> appropriate stub for when Xen compilation is disabled.
> 
> We do the restriction before rather than after os_setup_post, because
> xen_restrict may need to open /dev/null, and os_setup_post might have
> called chroot.
> 
This works for normally starting a VM but doesn't seem to work when 
resuming/migrating.

Here is the order of selected operations when starting a VM normally:
     VNC server running on 127.0.0.1:5901
     xen_change_state_handler()
     xenstore_record_dm_state: running
     xen_setup_post()
     xentoolcore_restrict_all: rc = 0
     os_setup_post()
     main_loop()

Here is the order of selected operations when starting QEMU with 
-incoming fd:... :
     VNC server running on 127.0.0.1:5902
     migration_fd_incoming()
     xen_setup_post()
     xentoolcore_restrict_all: rc = 0
     os_setup_post()
     main_loop()
     migration_set_incoming_channel()
     migrate_set_state()
     xen_change_state_handler()
     xenstore_record_dm_state: running
     error recording dm state
     qemu exited with code 1

The issue is that QEMU needs xenstore access to write "running" but this 
is after it has already been restricted. Moving xen_setup_post() into 
xen_change_state_handler() works fine. The only issue is that in the 
migration case, it executes after os_setup_post() so QEMU might be 
chrooted in which case opening /dev/null to restrict fds doesn't work 
(unless its new root has a /dev/null).

-- 
Ross Lagerwall
