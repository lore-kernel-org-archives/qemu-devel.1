Received: from eggs.gnu.org ([2001:4830:134:3::10]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSrgL-0005Hu-OF
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSrgK-00033x-MT
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:54:45 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-6-eblake@redhat.com>
	<20181130223025.GC27120@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b31ae83-e619-bd9c-b674-4ae9aef433a2@redhat.com>
Date: Fri, 30 Nov 2018 16:54:35 -0600
MIME-Version: 1.0
In-Reply-To: <20181130223025.GC27120@redhat.com>
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On 11/30/18 4:30 PM, Richard W.M. Jones wrote:
> On Fri, Nov 30, 2018 at 04:03:34PM -0600, Eric Blake wrote:
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

>> -
>> -    buf[8] = '\0';
>> -    if (strlen(buf) == 0) {
>> -        error_setg(errp, "Server connection closed unexpectedly");
>> -        goto fail;
>> -    }
>> -
>> -    magic = ldq_be_p(buf);
>> +    magic = be64_to_cpu(magic);
>>       trace_nbd_receive_negotiate_magic(magic);
>>
>> -    if (memcmp(buf, "NBDMAGIC", 8) != 0) {
>> +    if (magic != NBD_INIT_MAGIC) {
>>           error_setg(errp, "Invalid magic received");
>>           goto fail;
>>       }
> 
> The original code is really odd.  What's the whole strlen about?

Looks like it was added in commit 1d45f8b4 in 2010 in "nbd: Introduce 
NBD named exports." but with no good explanation why it was added in the 
context of the larger patch. Leftover debugging code that should have 
been nuked years ago?

> Anyway this is an obvious improvement so:
> 
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> 
> Rich.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
