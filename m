Received: from eggs.gnu.org ([2001:4830:134:3::10]:53179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUa3b-0001xK-Hc
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUa3a-0002cb-Q7
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:29:51 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-6-eblake@redhat.com>
	<130d5198-ae09-03d6-65fc-b829b990bb29@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4477052f-329a-ee6d-034a-d76e7858ea29@redhat.com>
Date: Wed, 5 Dec 2018 10:29:39 -0600
MIME-Version: 1.0
In-Reply-To: <130d5198-ae09-03d6-65fc-b829b990bb29@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/14] nbd/client: Drop pointless buf
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/5/18 9:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> There's no need to read into a temporary buffer (oversized
>> since commit 7d3123e1) followed by a byteswap into a uint64_t
>> to check for a magic number via memcmp(), when the code
>> immediately below demonstrates reading into the uint64_t then
>> byteswapping in place and checking for a magic number via
>> integer math.  What's more, having a different error message
>> when the server's first reply byte is 0 is unusual - it's no
>> different from any other wrong magic number, and we already
>> detected short reads.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>    nbd/nbd-internal.h |  1 +
>>    nbd/client.c       | 14 +++-----------
>>    2 files changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
>> index eeff78d3c98..306a533dcd1 100644
>> --- a/nbd/nbd-internal.h
>> +++ b/nbd/nbd-internal.h
>> @@ -46,6 +46,7 @@
>>    /* Size of oldstyle negotiation */
>>    #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
>>
>> +#define NBD_INIT_MAGIC              0x4e42444d41474943LL
> 
> Worth add comment /* "NBDMAGIC" */

Maybe.  But if so,

> 
>>    #define NBD_REQUEST_MAGIC           0x25609513
>>    #define NBD_OPTS_MAGIC              0x49484156454F5054LL

this should also get a comment "IHAVEOPT".

>>    #define NBD_CLIENT_MAGIC            0x0000420281861253LL
>> diff --git a/nbd/client.c b/nbd/client.c
>> index 0be89f9e641..17ee24492a4 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -731,7 +731,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>>                              QIOChannel **outioc, NBDExportInfo *info,
>>                              Error **errp)
>>    {
>> -    char buf[256];
>>        uint64_t magic;
>>        int rc;
>>        bool zeroes = true;
>> @@ -752,21 +751,14 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>>            goto fail;
>>        }
>>
>> -    if (nbd_read(ioc, buf, 8, errp) < 0) {
>> +    if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
>>            error_prepend(errp, "Failed to read data: ");
> 
> may be, change to "Failed to read magic: ", as in code below

Argument for: consistency sake. Argument against: having distinct 
messages lets you debug which of the two magic strings was wrong.  I'm 
not sure I have a strong preference.

> 
>>            goto fail;
>>        }
>> -
>> -    buf[8] = '\0';
>> -    if (strlen(buf) == 0) {
>> -        error_setg(errp, "Server connection closed unexpectedly");
>> -        goto fail;
>> -    }
>> -
>> -    magic = ldq_be_p(buf);
>> +    magic = be64_to_cpu(magic);
> 
> Isn't it better to use be64_to_cpus?

No. We're intentionally getting rid of that because of clang; see commit 
80c7c2b0.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
