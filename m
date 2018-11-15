Received: from eggs.gnu.org ([2001:4830:134:3::10]:60384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNIZB-0004Di-TH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNIYx-0008Kw-ID
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:24:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNIYx-0008KJ-BW
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:24:07 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-2-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e2769ed-f017-d684-da9e-115d31c3189b@redhat.com>
Date: Thu, 15 Nov 2018 08:23:59 -0600
MIME-Version: 1.0
In-Reply-To: <20181115140501.7872-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/9] cutils: add qemu_strtod() and
 qemu_strtod_finite()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/15/18 8:04 AM, David Hildenbrand wrote:
> Let's provide a wrapper for strtod().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/qemu/cutils.h |  2 ++
>   util/cutils.c         | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 


> +
> +/**
> + * Convert string @nptr to a finite double.
> + *
> + * Works like qemu_strtoul(), except it stores +/-HUGE_VAL on
> + * overflow/underflow. "NaN" or "inf" are rejcted with -EINVAL.

s/rejcted/rejected/

> + */
> +int qemu_strtod_finite(const char *nptr, const char **endptr, double *result)
> +{
> +    int ret = qemu_strtod(nptr, endptr, result);

On overflow, result is set to HUGE_VAL (aka "inf") with ret set to 
-ERANGE.  (The C standard uses HUGE_VAL rather than directly requiring 
infinity on overflow, in order to cater to museum platforms where the 
largest representable double is still finite; but no one develops qemu 
on a non-IEEE machine these days so we know that HUGE_VAL == INF).

> +
> +    if (!ret && !isfinite(*result)) {
> +        return -EINVAL;
> +    }

This check means that overflow ("1e9999") fails with -ERANGE, while 
actual infinity ("inf") fails with -EINVAL, letting the user distinguish 
between the two.  Still, I wonder if assigning a non-finite value into 
result on -ERANGE is the wisest course of action.  We'll just have to 
see in the next patches that use this.

With the typo fix,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
