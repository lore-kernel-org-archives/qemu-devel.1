Received: from eggs.gnu.org ([2001:4830:134:3::10]:48295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehJ7p-0003US-6V
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehJ7m-0000QA-5D
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:58:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehJ7l-0000Oc-Tk
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:58:14 -0500
Date: Thu, 1 Feb 2018 17:58:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201175802.GK2457@work-vm>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129174132.108925-14-brijesh.singh@amd.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> update 'info kvm' to display the memory encryption support.
> 
> (qemu) info kvm
> kvm support: enabled
> memory encryption: disabled

As Markus said, this should be split qmp/hmp; but something else to
think about is whether this is a boolean or needs to be an enum;  do
you have one version of encryption or are we going to need to flag up
versions or the features of the encryption?

Dave

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
> -- 
> 2.9.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
