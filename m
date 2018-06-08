Received: from eggs.gnu.org ([2001:4830:134:3::10]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fRDdq-00024e-LR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fRDdp-0008Ay-QF
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:25:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fRDdp-0008AF-KZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:25:05 -0400
Date: Fri, 8 Jun 2018 17:24:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180608092457.GG7736@xz-mi>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org> <20180608044235.GA7736@xz-mi>
	<20180608080446.GH29183@stefanha-x1.localdomain>
	<87a7s5snce.fsf@dusky.pond.sub.org> <20180608091154.GF7736@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608091154.GF7736@xz-mi>
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jun 08, 2018 at 05:11:54PM +0800, Peter Xu wrote:

[...]

> Frankly speaking I think this might be an ideal fix as well.  For
> example what if we are executing the dispatcher of a command when we
> received the CLOSED event?  If so, the dispatcher will put the
> response onto the response queue after the CLOSED event, and ideally
> we'd better also deliver that to the filter_output process.

Please ignore this paragraph.  Actually if that happens, we'll queue
the response onto the response queue as usual, then as long as the
output channel is not closed it'll still be delivered to the
filter_output process.

So I think I agree with Markus's solution, we just flush the response
queue when we get CLOSED (but we don't close the output fd; IMHO
that's chardev backend's job).  Would that work?

Regards,

-- 
Peter Xu
