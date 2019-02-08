Received: from eggs.gnu.org ([209.51.188.92]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9vX-0003f8-2F
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gs9vV-0003gB-9D
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:26:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gs9vT-0003bc-If
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:26:57 -0500
References: <20181214025849.84274-1-aik@ozlabs.ru>
	<8727c6e5-006c-20e5-cb6b-be525154e184@redhat.com>
	<bda42f7c-9068-3c4d-d839-7f6c52561cc9@ozlabs.ru>
	<69a29694-b777-721a-eafd-4ff38c457f6d@redhat.com>
	<db36d006-3bdc-47fe-9987-519440446c4e@ozlabs.ru>
	<20190103173753.GJ2316@work-vm>
	<d4b8695c-3d37-ba92-d62b-e067b77274c8@ozlabs.ru>
	<20190207114953.GB2773@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16486ff4-eb62-b4f2-78f8-a1ec7e3fbb0b@redhat.com>
Date: Fri, 8 Feb 2019 18:26:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190207114953.GB2773@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] hmp: Print if memory section is
 registered with an accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>

On 07/02/19 12:49, Dr. David Alan Gilbert wrote:
>  //#define DEBUG_UNASSIGNED
> @@ -2924,6 +2926,8 @@ struct FlatViewInfo {
>      int counter;
>      bool dispatch_tree;
>      bool owner;
> +    AccelClass *ac;
> +    const char *ac_name;
>  };
>  
>  static void mtree_print_flatview(gpointer key, gpointer value,
> @@ -2939,6 +2943,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>      int n = view->nr;
>      int i;
>      AddressSpace *as;
> +    bool system_as = false;
>  
>      p(f, "FlatView #%d\n", fvi->counter);
>      ++fvi->counter;
> @@ -2950,6 +2955,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>              p(f, ", alias %s", memory_region_name(as->root->alias));
>          }
>          p(f, "\n");
> +        if (as == &address_space_memory) {
> +            system_as = true;
> +        }
>      }
>  
>      p(f, " Root memory region: %s\n",
> @@ -2985,6 +2993,13 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>          if (fvi->owner) {
>              mtree_print_mr_owner(p, f, mr);
>          }
> +
> +        if (system_as && fvi->ac &&
> +            fvi->ac->has_memory(current_machine,
> +                                int128_get64(range->addr.start),
> +                                MR_SIZE(range->addr.size) + 1)) {
> +            p(f, " %s", fvi->ac_name);

I don't understand this.  This doesn't check that the memory range
actually matches the memory registered with the accelerator, only that
there is something in that range.  Why isn't it enough to use "info
mtree" and look at the KVM address space?

Perhaps you could add instead an argument to "info mtree" that prints
only the AddressSpace with a given name?

Paolo
