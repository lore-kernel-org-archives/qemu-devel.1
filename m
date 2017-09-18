Received: from eggs.gnu.org ([2001:4830:134:3::10]:49443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtult-0002SZ-4Z
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtulp-0001gr-6T
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtulp-0001fY-1l
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:03:25 -0400
References: <20170918085542.13265-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <33493193-b9fc-e76f-f30e-c23d68e34289@redhat.com>
Date: Mon, 18 Sep 2017 14:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170918085542.13265-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390x/ccw: create s390 phb for compat
 reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 18.09.2017 10:55, Cornelia Huck wrote:
> d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
> registering the s390 pci host bridge conditional on presense
> of the zpci facility bit. Sadly, that breaks migration from
> machines that did not use the cpu model (2.7 and previous).
> 
> Create the s390 phb for pre-cpu model machines as well: We can
> tweak s390_has_feat() to always indicate the zpci facility bit
> when no cpu model is available (on 2.7 and previous compat machines).
> 
> Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> v2->v3:
> - no longer RFC (I tested a bit more)
> - removed unrelated hunk
> - more verbose patch description
> 
> I'll wait a bit for more acks/reviews and will probably send a pull
> request for s390x tomorrow or so before the amount of queued patches
> gets out of hand...
> 
> ---
>  target/s390x/cpu_models.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index c295e641e6..5169379db5 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -196,6 +196,9 @@ bool s390_has_feat(S390Feat feat)
>              }
>          }
>  #endif
> +        if (feat == S390_FEAT_ZPCI) {
> +            return true;
> +        }
>          return 0;
>      }
>      return test_bit(feat, cpu->model->features);
> 

1. cpu->model will always be set for QEMU, so you can move that into the
ifdef, next do the other checks. You can even send a cleanup to remove
the if (kvm_enabled()) check.

2. "return pci_available" ?

-- 

Thanks,

David
