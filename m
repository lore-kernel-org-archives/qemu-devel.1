Received: from eggs.gnu.org ([2001:4830:134:3::10]:39156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpzT3-00013w-1y
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpzT1-0001YI-Gu
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpzT1-0001Y2-Aj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:31 -0400
References: <20170320153441.2181-1-alex.bennee@linaro.org>
	<20170320153441.2181-2-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb507927-7be0-9901-8657-02455e0af46d@redhat.com>
Date: Mon, 20 Mar 2017 16:43:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170320153441.2181-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/3] cputlb: ensure tbl_set_dirty1
 updates addr_write atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>



On 20/03/2017 16:34, Alex Benn=C3=A9e wrote:
>  static inline void tlb_set_dirty1(CPUTLBEntry *tlb_entry, target_ulong=
 vaddr)
>  {
> +#if TCG_OVERSIZED_GUEST
>      if (tlb_entry->addr_write =3D=3D (vaddr | TLB_NOTDIRTY)) {
>          tlb_entry->addr_write =3D vaddr;
>      }
> +#else
> +    uintptr_t orig_addr =3D atomic_mb_read(&tlb_entry->addr_write);

atomic_read is enough, since we don't care at all about cases where the
address doesn't match.  Otherwise

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> +    if (orig_addr =3D=3D (vaddr | TLB_NOTDIRTY)) {
> +        atomic_cmpxchg(&tlb_entry->addr_write, orig_addr, vaddr);
> +    }
> +#endif
>  }
