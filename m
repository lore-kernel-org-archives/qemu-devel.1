Received: from eggs.gnu.org ([2001:4830:134:3::10]:60723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6XnR-0002TV-39
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6XnQ-0006WD-9d
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:41:33 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-11-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05463f6e-aaef-46c7-5d62-19ac30bbba9c@redhat.com>
Date: Thu, 12 Apr 2018 10:41:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/19] block: Drain recursively with a
 single BDRV_POLL_WHILE()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 11/04/2018 18:39, Kevin Wolf wrote:
> +    if (atomic_read(&bs->in_flight)) {
> +        return true;
> +    }
> +
> +    if (recursive) {
> +        QLIST_FOREACH_SAFE(child, &bs->children, next, next) {

QLIST_FOREACH_SAFE is only safe if child disappears, but not if e.g.
next disappears.  So this loop is only safe because top_level is false
below.  Sounds like another good reason to split the top_level == false
case into a separate function.

Paolo

> +            if (bdrv_drain_poll(child->bs, false, recursive)) {
> +                return true;
> +            }
> +        }
