Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7KP-0000CO-5c
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7KL-0005QC-8i
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:48:05 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:51173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1et7KL-0005Px-3m
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:48:01 -0500
Received: by mail-it0-x241.google.com with SMTP id d13so12673372itf.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 23:48:00 -0800 (PST)
References: <20180305083655.6186-1-pbonzini@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <36ea5e9f-a6c8-fc36-34c6-4295f441c5eb@ozlabs.ru>
Date: Tue, 6 Mar 2018 18:47:56 +1100
MIME-Version: 1.0
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] memory: address_space_to_flatview
 needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 05/03/18 19:36, Paolo Bonzini wrote:
> I noticed that the introduction of flatview_{read,write} placed
> address_space_to_flatview outside the RCU lock.  This is wrong and has
> to be fixed, because address_space_to_flatview does an atomic_rcu_read.
> These patches fix this one function at a time.


out of curiosity - has this caused any actual bug? should be hard to
reproduce, I suppose...


> 
> Paolo Bonzini (7):
>   openpic_kvm: drop address_space_to_flatview call
>   memory: inline some performance-sensitive accessors
>   address_space_write: address_space_to_flatview needs RCU lock
>   address_space_read: address_space_to_flatview needs RCU lock
>   address_space_access_valid: address_space_to_flatview needs RCU lock
>   address_space_map: address_space_to_flatview needs RCU lock
>   address_space_rw: address_space_to_flatview needs RCU lock
> 
>  exec.c                         | 90 +++++++++++++++++++++++++-----------------
>  hw/intc/openpic_kvm.c          |  4 --
>  include/exec/memory-internal.h | 13 ++++--
>  include/exec/memory.h          | 47 ++++++++++++++--------
>  memory.c                       | 30 --------------
>  5 files changed, 93 insertions(+), 91 deletions(-)
> 


-- 
Alexey
