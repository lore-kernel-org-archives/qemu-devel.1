Received: from eggs.gnu.org ([2001:4830:134:3::10]:36416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amc96@hermes.cam.ac.uk>) id 1e2vpE-0000Hx-H5
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amc96@hermes.cam.ac.uk>) id 1e2vpA-0004dB-Ji
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:00:12 -0400
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:58708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amc96@hermes.cam.ac.uk>)
	id 1e2vpA-0004bj-CO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:00:08 -0400
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-4-git-send-email-ian.jackson@eu.citrix.com>
	<b749ee6c-591b-4f31-7fd3-b0fa03f5f98b@citrix.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <c53296d6-d962-c786-d04d-053dfe35920c@citrix.com>
Date: Fri, 13 Oct 2017 09:59:59 +0100
MIME-Version: 1.0
In-Reply-To: <b749ee6c-591b-4f31-7fd3-b0fa03f5f98b@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: Andrew Cooper <amc96@hermes.cam.ac.uk>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 3/8] xen: defer call to
 xen_restrict until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>, Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On 13/10/2017 09:37, Ross Lagerwall wrote:
> On 10/09/2017 05:01 PM, Ian Jackson wrote:
>> We need to restrict *all* the control fds that qemu opens.  Looking in
>> /proc/PID/fd shows there are many; their allocation seems scattered
>> throughout Xen support code in qemu.
>>
>> We must postpone the restrict call until roughly the same time as qemu
>> changes its uid, chroots (if applicable), and so on.
>>
>> There doesn't seem to be an appropriate hook already.  The RunState
>> change hook fires at different times depending on exactly what mode
>> qemu is operating in.
>>
>> And it appears that no-one but the Xen code wants a hook at this phase
>> of execution.  So, introduce a bare call to a new function
>> xen_setup_post, just before os_setup_post.  Also provide the
>> appropriate stub for when Xen compilation is disabled.
>>
>> We do the restriction before rather than after os_setup_post, because
>> xen_restrict may need to open /dev/null, and os_setup_post might have
>> called chroot.
>>
> This works for normally starting a VM but doesn't seem to work when
> resuming/migrating.
>
> Here is the order of selected operations when starting a VM normally:
>     VNC server running on 127.0.0.1:5901
>     xen_change_state_handler()
>     xenstore_record_dm_state: running
>     xen_setup_post()
>     xentoolcore_restrict_all: rc = 0
>     os_setup_post()
>     main_loop()
>
> Here is the order of selected operations when starting QEMU with
> -incoming fd:... :
>     VNC server running on 127.0.0.1:5902
>     migration_fd_incoming()
>     xen_setup_post()
>     xentoolcore_restrict_all: rc = 0
>     os_setup_post()
>     main_loop()
>     migration_set_incoming_channel()
>     migrate_set_state()
>     xen_change_state_handler()
>     xenstore_record_dm_state: running
>     error recording dm state
>     qemu exited with code 1
>
> The issue is that QEMU needs xenstore access to write "running" but
> this is after it has already been restricted. Moving xen_setup_post()
> into xen_change_state_handler() works fine. The only issue is that in
> the migration case, it executes after os_setup_post() so QEMU might be
> chrooted in which case opening /dev/null to restrict fds doesn't work
> (unless its new root has a /dev/null).
>

Wasn't the agreement in the end to remove all use of xenstore from the
device mode?  This running notification can and should be QMP, at which
point we break a causal dependency.

For safety reasons, qemu needs to have restricted/dropped/etc all
permissions before it looks at a single byte of incoming migration data,
to protect against buggy or malicious alterations to the migration stream.

~Andrew
