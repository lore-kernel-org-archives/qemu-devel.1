Received: from eggs.gnu.org ([2001:4830:134:3::10]:34008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpWJm-0008VP-Pu
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpWJi-0005T8-QK
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:08:18 -0400
Date: Wed, 6 Sep 2017 11:08:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906090801.GC3753@dhcp-200-186.str.redhat.com>
References: <c749629a-3352-e2fc-812a-0a2489593c25@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c749629a-3352-e2fc-812a-0a2489593c25@oracle.com>
Subject: Re: [Qemu-devel] query-block io-status display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: lcapitulino@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

[ Cc: qemu-block ]

Am 05.09.2017 um 06:59 hat Jack Schwartz geschrieben:
> Hi Luiz, Markus and everyone.
> 
> I am working on a qemu enhancement to display io-status in each query-block
> command, not just those for devices which have werror and/or rerror set to
> stop on error.
> 
> I'd like to verify the reasons behind the query-block command not reporting
> io-status if errors were reported to the guest or ignored.  A clue may come
> from the original code review email[1] for when this code was implemented:
> 
>   "In case of multiple errors being triggered in sequence only the first
>    one is stored. The I/O status is always reset to BDRV_IOS_OK when the
>    'cont' command is issued."
> 
> From this I infer:
> - io-status is shown when qemu is stopped onerror so errors can be seen in
> cases where a guest does not handle them.
> - io-status is not shown when errors are already being handled by a guest
> - io-status is not shown when errors are ignored
> 
> Is this correct?  Are there other subtleties/reasons as well?

I think that covers it more or less, except maybe for one missing piece
of information: io-status reports the error while the guest is stopped
for an I/O error. It is reset (i.e. returns 'ok' again) as soon as the
VM is continued, so that you don't see an old error later while the VM
is running just fine at that moment.

This is also why there is no io-status when errors are ignored or
reported to the guest: The VM is immediately resumed (or actually not
even stopped), so it would either always return 'ok' or you wouldn't
know whether the error is old or new.

Kevin
