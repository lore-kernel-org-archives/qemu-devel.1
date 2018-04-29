Received: from eggs.gnu.org ([2001:4830:134:3::10]:44477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fCnU8-0003Fp-Cs
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fCnU5-00013W-0u
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:39:28 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:42567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fCnU4-00013Q-SR
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:39:24 -0400
Received: by mail-io0-x231.google.com with SMTP id a10-v6so7582432ioc.9
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 07:39:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180428082908.32351-1-lvivier@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <caa4f33e-3493-f881-1da3-42eb50141a5d@twiddle.net>
Date: Sun, 29 Apr 2018 09:39:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180428082908.32351-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2] tcg: workaround branch instruction
 overflow in tcg_out_qemu_ld/st
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org

On 04/28/2018 03:29 AM, Laurent Vivier wrote:
> ppc64 uses a BC instruction to call the tcg_out_qemu_ld/st
> slow path. BC instruction uses a relative address encoded
> on 14 bits.
> 
> The slow path functions are added at the end of the generated
> instructions buffer, in the reverse order of the callers.
> So more we have slow path functions more the distance between
> the caller (BC) and the function increases.
> 
> This patch changes the behavior to generate the functions in
> the same order of the callers.
> 
> Fixes: 15fa08f845 ("tcg: Dynamically allocate TCGOps")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>     v2:
>       - add a pointer to the tail of the list to add new element
>         at the end and keep the original ordering
>       - remove the recursive call

A much better approach.

Elsewhere in TCG I have used the QTAILQ macros for manipulating a double-linked
list.  Perhaps using QSIMPLEQ for the single-linked list with tail access would
be the thing here?  I'm not 100% sure it's cleaner, but maybe worth a look.


r~
