Received: from eggs.gnu.org ([2001:4830:134:3::10]:59277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYugL-00059L-Of
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYugI-0004LP-3S
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:19:43 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-5-eblake@redhat.com>
	<20181215141305.GT27120@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09763ed2-ec13-c159-879a-0f081a229280@redhat.com>
Date: Mon, 17 Dec 2018 09:19:26 -0600
MIME-Version: 1.0
In-Reply-To: <20181215141305.GT27120@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/22] qemu-nbd: Enhance man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On 12/15/18 8:13 AM, Richard W.M. Jones wrote:
> On Sat, Dec 15, 2018 at 07:53:06AM -0600, Eric Blake wrote:
>> Document some useful qemu-nbd command lines. Mention some restrictions
>> on particular options, like -p being only for MBR images, or -c/-d
>> being Linux-only.  Update some text given the recent change to no
>> longer serve oldstyle protocol (missed in commit 7f7dfe2a).  Also,
>> consistently use trailing '.' in describing options.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v2: new patch
>> ---
>>   qemu-nbd.texi | 85 +++++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 66 insertions(+), 19 deletions(-)
>>
>> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
>> index 9a84e81eed9..0e24c2801ee 100644
>> --- a/qemu-nbd.texi
>> +++ b/qemu-nbd.texi
>> @@ -8,7 +8,10 @@
>>
>>   @c man begin DESCRIPTION
>>
>> -Export a QEMU disk image using the NBD protocol.
>> +Provide access to various QEMU NBD features.  Most commonly used to
>> +export a QEMU disk image using the NBD protocol as a server, but can
>> +also be used (on Linux) to manage kernel bindings of a /dev/nbdX
>> +block device to a QEMU server.
> 
> This is only a minor quibble, but I thought the original text was a
> good summary, and only needs additional paragraphs describing the more
> minor use cases.  Thus the description would become by the end of the
> patch series:
> 
>    DESCRIPTION
> 
>    Export a QEMU disk image using the NBD protocol.
> 
>    Other uses:
>    * (On Linux) bind /dev/nbdX block device to a QEMU server.
>    * As a client to query exports of a remote NBD server.

Seems reasonable.

> 
>> +@c man begin EXAMPLES
>> +Start a server listening on port 10809 that exposes only the
>> +guest-visible contents of a qcow2 file, with no TLS encryption, and
>> +with the default export name (an empty string). The command will block
>> +until the first successful client disconnects:
> 
> TBH I'd always include the -t option in every example.  I don't
> understand (except for backwards compatibility) why it isn't the
> default since it's something I always trip over when using qemu-nbd.

I'd still like one example without -t, to call out specifically that it 
creates a one-shot server that goes away after the first client, but 
don't mind fixing the rest of the examples to use -t.

Using -e for read-only connections makes sense, using -e for writable 
exports is a bit more questionable - we _don't_ advertise the 
NBD_FLAG_CAN_MULTI_CONN which states that caches are kept consistent 
between simultaneous write connections, although maybe we should see if 
qemu-nbd can start promising multi-write consistency in future patches?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
