Received: from eggs.gnu.org ([2001:4830:134:3::10]:35621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPW6q-00076y-U9
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPW6m-00063Y-WA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:16:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPW6m-00061b-Qj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:16:12 -0500
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-2-david@redhat.com>
	<74608eca-34f8-f85f-39ab-ab98a206b0c1@redhat.com>
	<871s7f8qcz.fsf@dusky.pond.sub.org>
	<3c656208-5569-d48f-9555-11d15389fe90@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48522fb7-5d4b-06e1-8994-b1fe46636e0d@redhat.com>
Date: Wed, 21 Nov 2018 11:16:07 -0600
MIME-Version: 1.0
In-Reply-To: <3c656208-5569-d48f-9555-11d15389fe90@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/9] cutils: Add qemu_strtod() and
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

On 11/21/18 4:35 AM, David Hildenbrand wrote:

>>>> +int qemu_strtod_finite(const char *nptr, const char **endptr, double *result)
>>>> +{
>>>> +    double tmp;
>>>> +    int ret;
>>>> +
>>>> +    ret = qemu_strtod(nptr, endptr, &tmp);
>>>> +    if (ret) {
>>>> +        return ret;
>>>
>>> So, if we overflow, we are returning -ERANGE but with nothing stored
>>> into *result.  This is different from qemu_strtod(), where a return of
>>> -ERANGE guarantees that *result is one of 4 values (+/- 0.0/inf).
>>> That seems awkward.
>>
>> Violates the contract's "like qemu_strtod()".
> 
> Right, I missed that. What about something like this:
> 
> int qemu_strtod_finite(const char *nptr, const char **endptr, double
> *result)
> {
>      double tmp;
>      int ret;
> 
>      ret = qemu_strtod(nptr, endptr, &tmp);
>      if (!ret && !isfinite(tmp)) {
>          if (endptr) {
>              *endptr = nptr;
>          }
>          ret = -EINVAL;
>      }
> 
>      if (ret != -EINVAL) {
>          *result = tmp;
>      }
>      return ret;
> }

With that algorithm, v3 can have:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
