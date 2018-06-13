Received: from eggs.gnu.org ([2001:4830:134:3::10]:52989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8ca-00045P-JW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8cX-0002EA-Fv
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:27:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT8cX-0002Cw-9e
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:27:41 -0400
References: <20180605221500.21674-1-juterry@microsoft.com>
	<20180605221500.21674-2-juterry@microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfb2eddc-b582-4175-0109-c752d97ccf34@redhat.com>
Date: Wed, 13 Jun 2018 18:27:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180605221500.21674-2-juterry@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] WHPX: register for unrecognized MSR
 exits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>

On 06/06/2018 00:15, Justin Terry (VM) wrote:
> Some variations of Linux kernels end up accessing MSR's that the Windows
> Hypervisor doesn't implement which causes a GP to be returned to the guest.
> This fix registers QEMU for unimplemented MSR access and globally returns 0 on
> reads and ignores writes. This behavior is allows the Linux kernel to probe the
> MSR with a write/read/check sequence it does often without failing the access.
> 
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> ---
>  target/i386/whpx-all.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)

Hmm, KVM tries to list the MSRs that Linux (or Windows :)) use.  It can
do the full whitelist, but it's opt-in.

Recent Linux kernels also are generally less picky about #GPs from MSRs,
so I don't think a generic whitelist is a good idea.  If the
"non-hosted" Hyper-V is doing the same that would be fine I guess, but
then there should probably be a comment about it in the code.

While this is discussed a bit more, I've queued patch 1.

Thanks,

Paolo
