Received: from eggs.gnu.org ([2001:4830:134:3::10]:57678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQAKu-0003zK-Lz
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQAKr-0007D5-JW
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:41:12 -0400
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-3-git-send-email-thuth@redhat.com>
	<9b84d9e4-f7b8-dd5b-3180-551047879eab@linux.ibm.com>
	<0eaa6943-57a8-3dec-18e5-5e498dd06e6a@redhat.com>
	<2489ce83-a622-2f63-e9d1-50b3298596cb@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a890c257-63f9-ca49-cc6f-fbd5e2bddf5b@redhat.com>
Date: Tue, 5 Jun 2018 13:41:04 +0200
MIME-Version: 1.0
In-Reply-To: <2489ce83-a622-2f63-e9d1-50b3298596cb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] pc-bios/s390-ccw/net: Add support for
 pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

On 01.06.2018 22:19, Farhan Ali wrote:
> 
> 
> On 05/31/2018 11:21 PM, Thomas Huth wrote:
>>> Just a question do we want to clear cfgbuf here, before calling
>>> pxelinux_load_parse_cfg?
>> That's theoretically not necessary. The buffer either gets populated
>> with data, or the function errors out. The code also makes sure that
>> there is a final NUL-character in the buffer:
>>
>> https://github.com/aik/SLOF/blob/64c526a/lib/libnet/pxelinux.c#L169
>>
>> ... but I think I've got to double check that there is also a
>> NUL-character immediately at the end of the downloaded data ... so
>> there's indeed a change required, but likely rather in the SLOF code
>> than here.
> 
> Can't we do that in net_try_direct_tftp_load, or it is better to put
> that in SLOF code?

I've now submitted a patch to SLOF to fix two issues with regards to the
NUL-termination handling there:

https://lists.ozlabs.org/pipermail/slof/2018-June/002201.html

Now it's the duty of the caller to take care of proper NUL-termination.
There is already this line in net_try_direct_tftp_load():

  cfgbuf[rc] = 0;    /* Make sure that it is NUL-terminated */

... so I think we should be fine there.

 Thomas
