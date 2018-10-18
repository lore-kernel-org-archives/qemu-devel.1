Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD61t-0000st-Iz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD61p-0001JM-IS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD61p-0001Ia-9K
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:59:45 -0400
References: <20181017205848.2525-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8f2f7c5-936f-9949-a6b3-55988482cab3@redhat.com>
Date: Thu, 18 Oct 2018 12:59:40 +0200
MIME-Version: 1.0
In-Reply-To: <20181017205848.2525-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bt: use size_t type for length parameters
 instead of signed int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Arash TC <tohidi.arash@gmail.com>, Philippe Mathieu Daude <pmathieu@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 17/10/2018 22:58, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> The length parameter values are not negative, thus use an unsigned
> type 'size_t' for them. Many routines pass 'len' values to memcpy(3)
> calls. If it was negative, it could lead to memory corruption issues.

You are not fixing anything here; if the length was negative before, it
would still overflow and it would now be a huge positive value.

So you have to first find out all places where something is subtracted
from the length, and ensure it's okay or add assertions.

Then you have to check a much more important issue: places that use a
fixed-size buffer such as vhci_host_send should range check len first,
again with an assertion if needed.

Only then it makes sense to use size_t.

Paolo
