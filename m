Received: from eggs.gnu.org ([2001:4830:134:3::10]:46569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtrtJ-0007Lv-Bg
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtrtG-0003ty-Ag
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:58:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36950
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dtrtG-0003tu-49
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:58:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8I8sDNa104305
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 04:58:53 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d27strxrd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 04:58:52 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Sep 2017 09:58:51 +0100
References: <20170918085542.13265-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Sep 2017 10:58:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170918085542.13265-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ebbeb89f-73d2-cb41-048d-a62ac574a65f@de.ibm.com>
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
Cc: agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com



On 09/18/2017 10:55 AM, Cornelia Huck wrote:
> d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
> registering the s390 pci host bridge conditional on presense
> of the zpci facility bit. Sadly, that breaks migration from
> machines that did not use the cpu model (2.7 and previous).
> 
> Create the s390 phb for pre-cpu model machines as well: We can
> tweak s390_has_feat() to always indicate the zpci facility bit
> when no cpu model is available (on 2.7 and previous compat machines).

Looks better now. Thanks
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

I have a small amount of patches pending, but then I got sick last week
so I still have to sort out things. Lets do the pull request and we can
then queue the other patches after they have received proper review.

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
