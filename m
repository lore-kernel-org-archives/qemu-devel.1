Received: from eggs.gnu.org ([2001:4830:134:3::10]:53677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnpxj-0008Su-5b
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnpxg-0008Qp-BT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:10:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cnpxg-0008Qg-6E
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:10:16 -0400
Date: Tue, 14 Mar 2017 14:10:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170314171013.GR4694@thinpad.lan.raisama.net>
References: <20170314140807.6061-1-git@kirschju.re>
	<20170314140807.6061-2-git@kirschju.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314140807.6061-2-git@kirschju.re>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] X86: Move rdmsr/wrmsr functionality
 to standalone functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Mar 14, 2017 at 03:08:06PM +0100, Julian Kirsch wrote:
[...]
> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
> +{
> +    return 0ULL;
> +}
> +
> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid)
> +{
> +}

These implementations don't set *valid...

[...]
> +    bool res_valid;
[...]
> +    x86_cpu_wrmsr(env, (uint32_t)env->regs[R_ECX], val, &res_valid);
[...]
> +    bool res_valid;
[...]
> +    val = x86_cpu_rdmsr(env, (uint32_t)env->regs[R_ECX], &res_valid);

...while these callers don't initialize res_valid.

I suggest setting *valid = false on the CONFIG_USER_ONLY stubs.

-- 
Eduardo
