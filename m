Received: from eggs.gnu.org ([2001:4830:134:3::10]:52783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehG93-0004XS-GS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehG8z-00058m-Ga
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:47:21 -0500
Date: Thu, 1 Feb 2018 15:47:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201154705.604d8dd9.cohuck@redhat.com>
In-Reply-To: <20180131181742.2037-2-cohuck@redhat.com>
References: <20180131181742.2037-1-cohuck@redhat.com>
	<20180131181742.2037-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, david@redhat.com

On Wed, 31 Jan 2018 19:17:41 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> +void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
> +{
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r = css_do_sic(env, r1 & 0xffff, (r3 >> 27) & 0x7);

Here, the arguments have to be swapped around...

> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());

...and here we have to pass -r instead of PGM_OPERATION. (Thanks to
David for spotting those!)

> +    }
> +}

With that fixed (and rebased upon current s390-next, which contains
David's latest changes), I can also turn on ais for tcg (which means
pre-4.15 kernels can see pci devices as well.)
