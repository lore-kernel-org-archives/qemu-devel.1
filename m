Received: from eggs.gnu.org ([208.118.235.92]:36601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehLCF-0006K9-Mw
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehL6L-0004dp-3y
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:05:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehL6K-0004dA-IV
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:04:52 -0500
Date: Thu, 1 Feb 2018 20:04:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201200442.GQ2457@work-vm>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-14-brijesh.singh@amd.com>
	<20180201175802.GK2457@work-vm>
	<7c3c7a89-04ef-016e-c9a5-4f4d4be1c449@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3c7a89-04ef-016e-c9a5-4f4d4be1c449@amd.com>
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
> 
> 
> On 2/1/18 11:58 AM, Dr. David Alan Gilbert wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >> update 'info kvm' to display the memory encryption support.
> >>
> >> (qemu) info kvm
> >> kvm support: enabled
> >> memory encryption: disabled
> > As Markus said, this should be split qmp/hmp; but something else to
> > think about is whether this is a boolean or needs to be an enum;  do
> > you have one version of encryption or are we going to need to flag up
> > versions or the features of the encryption?
> 
> In future I could see us providing encrypted state status when we
> implement SEV-ES support, something like
> 
> (qemu) info kvm
> kvm support: enabled
> memory encryption: enabled
> cpu register state: encrypted
> 
> but so far I do not see need to provide the version string. If user
> wants to know the SEV version then it can open /dev/sev device to get
> platform status and more.

Yes, I was worried a bit more about how general that was going to be
or whether we're collecting a lot of architecture specific fields here.
So I wondered, if it was an enum, whether that would be come:

memory encryption: none

memory encryption: SEV

memory encryption: SEV-ES

(I'm not too sure whether that's better or not, just a suggestion)

Dave

> 
> > Dave
> >
> >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> Cc: Eric Blake <eblake@redhat.com>
> >> Cc: Markus Armbruster <armbru@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >> ---
> >>  hmp.c            | 2 ++
> >>  qapi-schema.json | 5 ++++-
> >>  qmp.c            | 1 +
> >>  3 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hmp.c b/hmp.c
> >> index 056bf70cf1e2..6ceb6b30af75 100644
> >> --- a/hmp.c
> >> +++ b/hmp.c
> >> @@ -88,6 +88,8 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
> >>      monitor_printf(mon, "kvm support: ");
> >>      if (info->present) {
> >>          monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
> >> +        monitor_printf(mon, "memory encryption: %s\n",
> >> +                       info->mem_encryption ? "enabled" : "disabled");
> >>      } else {
> >>          monitor_printf(mon, "not compiled\n");
> >>      }
> >> diff --git a/qapi-schema.json b/qapi-schema.json
> >> index 5c06745c7927..2046c96669bf 100644
> >> --- a/qapi-schema.json
> >> +++ b/qapi-schema.json
> >> @@ -314,9 +314,12 @@
> >>  #
> >>  # @present: true if KVM acceleration is built into this executable
> >>  #
> >> +# @mem-encryption: true if Memory Encryption is active (since 2.12)
> >> +#
> >>  # Since: 0.14.0
> >>  ##
> >> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> >> +{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool',
> >> +            'mem-encryption' : 'bool'} }
> >>  
> >>  ##
> >>  # @query-kvm:
> >> diff --git a/qmp.c b/qmp.c
> >> index 52cfd2d81c0f..3a527bc8c39c 100644
> >> --- a/qmp.c
> >> +++ b/qmp.c
> >> @@ -69,6 +69,7 @@ KvmInfo *qmp_query_kvm(Error **errp)
> >>  
> >>      info->enabled = kvm_enabled();
> >>      info->present = kvm_available();
> >> +    info->mem_encryption = kvm_memcrypt_enabled();
> >>  
> >>      return info;
> >>  }
> >> -- 
> >> 2.9.5
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
