Received: from eggs.gnu.org ([2001:4830:134:3::10]:44700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dziAi-0004hJ-0Z
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dziAd-0005hu-1L
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dziAc-0005gp-RA
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:48:58 -0400
References: <20171004105751.24655-1-borntraeger@de.ibm.com>
	<20171004105751.24655-3-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <284e46bd-52ac-34d9-81ab-c3b8c364a2ea@redhat.com>
Date: Wed, 4 Oct 2017 13:48:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171004105751.24655-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390/kvm: make TOD setting failures
 fatal for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 04.10.2017 12:57, Christian Borntraeger wrote:
> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> 
> If we fail to set a proper TOD clock on the target system,  this can
> already result in some problematic cases. We print several warn messages
> on source and target in that case.
> 
> If kvm fails to set a nonzero epoch index, then we must ultimately fail
> the migration as this will result in a giant time leap backwards. This
> patch lets the migration fail if we can not set the guest time on the
> target.
> 
> On failure the guest will resume normally on the original host machine.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [split failure change from epoch index change, minor fixups]
> ---
>  hw/s390x/s390-virtio-ccw.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fafbc6d..b7adb93 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -213,13 +213,10 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
>  
>      r = s390_set_clock(&tod_high, &tod_low);
>      if (r) {
> -        warn_report("Unable to set guest clock for migration: %s",
> -                    strerror(-r));
> -        error_printf("Guest clock will not be restored "
> -                     "which could cause the guest to hang.");
> +        error_report("Unable to set KVM guest TOD clock: %s", strerror(-r));
>      }
>  
> -    return 0;
> +    return r;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>

(and I wonder whether we should fail the S390_TOD_CLOCK_VALUE_MISSING
case with returning an error instead of 0, too?)
