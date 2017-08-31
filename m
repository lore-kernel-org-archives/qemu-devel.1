Received: from eggs.gnu.org ([2001:4830:134:3::10]:52719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnLXq-00005N-Es
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnLXn-0006A0-5O
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnLXm-00069g-VV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:13:47 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-5-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <782fdf4f-084e-9fcb-f788-d2f0c7f5340c@redhat.com>
Date: Thu, 31 Aug 2017 11:13:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170830170601.15855-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/11] s390x: get rid of s390-virtio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 19:05, David Hildenbrand wrote:
> It is a leftover from the days where we had still the !ccw virtio
> machine. As this one is long gone, let's move everything to
> s390-virtio-ccw.c.
> 
> Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index ffd56af834..41a9e976dc 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
[...]
> +static int gtod_load(QEMUFile *f, void *opaque, int version_id)
> +{
> +    uint64_t tod_low;
> +    uint8_t tod_high;
> +    int r;
> +
> +    if (qemu_get_byte(f) == S390_TOD_CLOCK_VALUE_MISSING) {
> +        fprintf(stderr, "WARNING: Guest clock was not migrated. This could "
> +                        "cause the guest to hang.\n");
> +        return 0;
> +    }
> +
> +    tod_high = qemu_get_byte(f);
> +    tod_low = qemu_get_be64(f);
> +
> +    r = s390_set_clock(&tod_high, &tod_low);
> +    if (r) {
> +        fprintf(stderr, "WARNING: Unable to set guest clock value. "
> +                        "s390_get_clock returned error %d. This could cause "
> +                        "the guest to hang.\n", r);
> +    }
> +
> +    return 0;
> +}
> +
> +

Nit: One empty line should be enough here.

Reviewed-by: Thomas Huth <thuth@redhat.com>
