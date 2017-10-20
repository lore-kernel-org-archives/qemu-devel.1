Received: from eggs.gnu.org ([2001:4830:134:3::10]:50047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e5VBd-00055o-6Y
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e5VBa-0002ss-2s
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:09:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:41198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1e5VBZ-0002sA-SV
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:09:54 -0400
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<67132f0e-cc4d-312f-140a-1966f0d877c6@suse.de>
	<7a65ad71-9c6d-ee0a-851c-ab6bd9806180@de.ibm.com>
	<b4a828b6-b563-55f0-2952-8a3447a8a30a@de.ibm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <c7c0eb1e-4d56-f5ba-0ce6-778713720da2@suse.de>
Date: Fri, 20 Oct 2017 13:09:51 +0200
MIME-Version: 1.0
In-Reply-To: <b4a828b6-b563-55f0-2952-8a3447a8a30a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>



On 20.10.17 13:02, Christian Borntraeger wrote:
> 
> 
> On 10/20/2017 12:41 PM, Christian Borntraeger wrote:
> [...]
>>>> @@ -76,17 +76,28 @@ static int _strlen(const char *str)
>>>>  long write(int fd, const void *str, size_t len)
>>>>  {
>>>>      WriteEventData *sccb = (void *)_sccb;
>>>> +    const char *p;
>>>> +    size_t data_len = 0;
>>>>  
>>>>      if (fd != 1 && fd != 2) {
>>>>          return -EIO;
>>>>      }
>>>>  
>>>> -    sccb->h.length = sizeof(WriteEventData) + len;
>>>> +    for (p = str; *p; ++p) {
>>>> +        if (data_len > SCCB_DATA_LEN - 1) {
>>>> +            return -EFBIG;
>>>> +        }
>>>> +        if (*p == '\n') {
>>>> +            sccb->data[data_len++] = '\r';
>>>> +        }
>>>> +        sccb->data[data_len++] = *p;
>>>> +    }
>>>> +
>>>> +    sccb->h.length = sizeof(WriteEventData) + data_len;
>>>
>>> This subtly changes the semantics of the write() function from an
>>> explicitly passed in "len" argument to NULL termination determined
>>> sizing, no?
>>>
>>> In that case, wouldn't it make sense to either remove the len argument
>>> altogether or keep respecting it?
>>
>> Yes, well spotted.
>> The write function is used in other code (SLOF related network boot),
>> so we should change it to respect the length, I think.
> 
> Something like this on top?
> 

I think that basically gets you back to the original semantics. I'm not
terribly thrilled about the readability of the function though, but
that's your call :)


Alex

> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -83,7 +83,7 @@ long write(int fd, const void *str, size_t len)
>          return -EIO;
>      }
>  
> -    for (p = str; *p; ++p) {
> +    for (p = str; len ; ++p, len--) {
>          if (data_len > SCCB_DATA_LEN - 1) {
>              return -EFBIG;
>          }
> 
> 
