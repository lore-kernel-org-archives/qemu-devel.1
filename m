Received: from eggs.gnu.org ([2001:4830:134:3::10]:33854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNLyl-0007Ke-IW
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNLyg-0006JP-Hu
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:02:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNLyg-0005qx-BN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:02:54 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-2-david@redhat.com>
	<5e2769ed-f017-d684-da9e-115d31c3189b@redhat.com>
	<874lcicntp.fsf@dusky.pond.sub.org>
	<2464ddd5-24b3-396b-7ea7-c3e9cf36ffc9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b47def2f-4c4c-4639-3337-3005a0548b94@redhat.com>
Date: Thu, 15 Nov 2018 12:02:41 -0600
MIME-Version: 1.0
In-Reply-To: <2464ddd5-24b3-396b-7ea7-c3e9cf36ffc9@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 11/15/18 11:25 AM, David Hildenbrand wrote:

>> Also, just overflow.  Floating-point underflow is when a computation's
>> mathematical result is too close to zero to be represented without
>> extraordinary rounding error.
> 

>> works like qemu_strtoul().  I'd prefer longhand for qemu_strtod().  It
>> costs us a few lines, but it results in a clearer contract.
> 
> /**
>   * Convert string @nptr to a double.
>    *
>   * This is a wrapper around strtod() that is harder to misuse.
>   * Semantics of @nptr and @endptr match strtod() with differences
>   * noted below.
>   *
>   * @nptr may be null, and no conversion is performed then.
>   *
>   * If no conversion is performed, store @nptr in *@endptr and return
>   * -EINVAL.
>   *
>   * If @endptr is null, and the string isn't fully converted, return
>   * -EINVAL.  This is the case when the pointer that would be stored in
>   * a non-null @endptr points to a character other than '\0'.
>   *
>   * If the conversion overflows @result, store +/-HUGE_VAL, depending on
>   * the sign, in @result and return -ERANGE.

Fails to mention underflow. Maybe add:

If the conversion underflows, store +/-0.0 in @result, depending on the 
sign, and return -ERANGE.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
