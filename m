Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNumG-0001LT-BV
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNumC-0000VW-Do
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:40:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNumC-0000VM-9I
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:40:04 -0400
Date: Wed, 30 May 2018 14:39:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180530063955.GA27442@xz-mi>
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-2-peterx@redhat.com>
	<20180530074400-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180530074400-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, May 30, 2018 at 07:47:32AM +0300, Michael S. Tsirkin wrote:
> On Thu, May 24, 2018 at 12:44:53PM +0800, Peter Xu wrote:
> > There are many error_report()s that can be used in frequently called
> > functions, especially on IO paths.  That can be unideal in that
> > malicious guest can try to trigger the error tons of time which might
> > use up the log space on the host (e.g., libvirt can capture the stderr
> > of QEMU and put it persistently onto disk).
> 
> I think the problem is real enough but I think the API
> isn't great as it stresses the mechanism. Which fundamentally does
> not matter - we can print once or 10 times, or whatever.
> 
> What happens here is a guest bug as opposed to hypervisor
> bug. So I think a better name would be guest_error.

For me error_report_once() is okay since after all it's only a way to
dump something for the hypervisor management software (or the person
who manages the QEMU instance), and I don't have a strong opinion to
introduce a new guest_error() API.

> 
> Internally we can still have something similar to this
> mechanism.
> 
> Another idea is to reset these guest error counters on guest reset.
> Device reset too? I'm not 100% sure as guest can trigger device resets.

Yes maybe we can, but I don't know whether that's necessary.  If we
consider the possiblility of a malicious guest here, resetting the
counter after system reset might be dangerous too, since the guest can
still flush the host log by the sequence of system reset, trigger the
error, system reset, ...

Thanks,

-- 
Peter Xu
