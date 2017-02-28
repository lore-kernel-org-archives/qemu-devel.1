Received: from eggs.gnu.org ([2001:4830:134:3::10]:57872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cickn-0004ty-9e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cicki-0002Zt-3l
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:03:25 -0500
Received: from mail-db5eur01on0115.outbound.protection.outlook.com
	([104.47.2.115]:9952
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cickh-0002Zo-Ek
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:03:20 -0500
References: <20170227201456.31814-1-berrange@redhat.com>
	<739c3a03-fffe-46d0-0ba6-a328a9a18eb2@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e4470b32-a66e-a32b-986f-ce5e2183c04e@openvz.org>
Date: Tue, 28 Feb 2017 10:29:15 +0300
MIME-Version: 1.0
In-Reply-To: <739c3a03-fffe-46d0-0ba6-a328a9a18eb2@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] io: ignore case when matching websockets
 HTTP headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

On 02/28/2017 12:20 AM, Eric Blake wrote:
> On 02/27/2017 02:14 PM, Daniel P. Berrange wrote:
>> According to RFC7230 Section 3.2, header field name is case-insensitive.
>> Convert the header data into all lowercase before doing string matching
>> on the headers.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  io/channel-websock.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> @@ -223,7 +223,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
>>  static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>>                                                Error **errp)
>>  {
>> -    char *handshake_end;
>> +    char *handshake_end, *tmp;
>>      ssize_t ret;
>>      /* Typical HTTP headers from novnc are 512 bytes, so limiting
>>       * total header size to 4096 is easily enough. */
> Drive-by grammar nit: s/easily/easy/
>
>> @@ -249,9 +249,13 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>>          }
>>      }
>>  
>> +    for (tmp = (char *)ioc->encinput.buffer; tmp < handshake_end; tmp++) {
>> +        *tmp = g_ascii_tolower(*tmp);
>> +    }
>> +
>>      if (qio_channel_websock_handshake_process(ioc,
>>                                                (char *)ioc->encinput.buffer,
>> -                                              ioc->encinput.offset,
>> +                                              handshake_end - (char *)ioc->encinput.buffer,
> I'm not sure why this change is here; nothing else in the patch changed
> ioc->encinput.offset.
>
yep. The rest seems fine to me.

Usage of g_ascii_strdown () seems overkill now. We do not need
the header anymore after this call.

Den
