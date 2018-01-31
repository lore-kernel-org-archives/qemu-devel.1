Received: from eggs.gnu.org ([2001:4830:134:3::10]:45723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egwQL-000070-Fp
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egwQK-0003LO-Ig
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:43:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egwQK-0003Km-Ar
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:43:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-14-brijesh.singh@amd.com>
Date: Wed, 31 Jan 2018 18:43:47 +0100
In-Reply-To: <20180129174132.108925-14-brijesh.singh@amd.com> (Brijesh Singh's
	message of "Mon, 29 Jan 2018 11:41:22 -0600")
Message-ID: <87r2q5vs8c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 13/23] hmp: display memory encryption
 support in 'info kvm'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Brijesh Singh <brijesh.singh@amd.com> writes:

> update 'info kvm' to display the memory encryption support.
>
> (qemu) info kvm
> kvm support: enabled
> memory encryption: disabled
>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  hmp.c            | 2 ++
>  qapi-schema.json | 5 ++++-
>  qmp.c            | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hmp.c b/hmp.c
> index 056bf70cf1e2..6ceb6b30af75 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -88,6 +88,8 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
>      monitor_printf(mon, "kvm support: ");
>      if (info->present) {
>          monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
> +        monitor_printf(mon, "memory encryption: %s\n",
> +                       info->mem_encryption ? "enabled" : "disabled");
>      } else {
>          monitor_printf(mon, "not compiled\n");
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 5c06745c7927..2046c96669bf 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -314,9 +314,12 @@
>  #
>  # @present: true if KVM acceleration is built into this executable
>  #
> +# @mem-encryption: true if Memory Encryption is active (since 2.12)
> +#
>  # Since: 0.14.0
>  ##
> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> +{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool',
> +            'mem-encryption' : 'bool'} }

This extends QMP's query-kvm.  Your commit message claims the patch
affects only HMP.  Needs fixing.  The cleanest way is to split the patch
into its QMP part (hunks #2 and #3) and its HMP part (hunk #1).

>  
>  ##
>  # @query-kvm:
> diff --git a/qmp.c b/qmp.c
> index 52cfd2d81c0f..3a527bc8c39c 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -69,6 +69,7 @@ KvmInfo *qmp_query_kvm(Error **errp)
>  
>      info->enabled = kvm_enabled();
>      info->present = kvm_available();
> +    info->mem_encryption = kvm_memcrypt_enabled();
>  
>      return info;
>  }
