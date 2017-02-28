Received: from eggs.gnu.org ([2001:4830:134:3::10]:56025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cinhf-0007Fe-2O
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cinha-0006BL-3f
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:44:55 -0500
Received: from mail-ve1eur01on0122.outbound.protection.outlook.com
	([104.47.1.122]:43517
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cinhZ-0006Ar-EC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:44:50 -0500
References: <20170227201456.31814-1-berrange@redhat.com>
	<739c3a03-fffe-46d0-0ba6-a328a9a18eb2@redhat.com>
	<20170228100907.GD2762@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a0920e25-3bb6-c917-f9ec-fde74ad02fe6@openvz.org>
Date: Tue, 28 Feb 2017 13:12:47 +0300
MIME-Version: 1.0
In-Reply-To: <20170228100907.GD2762@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>

On 02/28/2017 01:09 PM, Daniel P. Berrange wrote:
> On Mon, Feb 27, 2017 at 03:20:37PM -0600, Eric Blake wrote:
>> On 02/27/2017 02:14 PM, Daniel P. Berrange wrote:
>>> According to RFC7230 Section 3.2, header field name is case-insensitive.
>>> Convert the header data into all lowercase before doing string matching
>>> on the headers.
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>  io/channel-websock.c | 14 +++++++++-----
>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> @@ -223,7 +223,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
>>>  static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>>>                                                Error **errp)
>>>  {
>>> -    char *handshake_end;
>>> +    char *handshake_end, *tmp;
>>>      ssize_t ret;
>>>      /* Typical HTTP headers from novnc are 512 bytes, so limiting
>>>       * total header size to 4096 is easily enough. */
>> Drive-by grammar nit: s/easily/easy/
>>
>>> @@ -249,9 +249,13 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>>>          }
>>>      }
>>>  
>>> +    for (tmp = (char *)ioc->encinput.buffer; tmp < handshake_end; tmp++) {
>>> +        *tmp = g_ascii_tolower(*tmp);
>>> +    }
>>> +
>>>      if (qio_channel_websock_handshake_process(ioc,
>>>                                                (char *)ioc->encinput.buffer,
>>> -                                              ioc->encinput.offset,
>>> +                                              handshake_end - (char *)ioc->encinput.buffer,
>> I'm not sure why this change is here; nothing else in the patch changed
>> ioc->encinput.offset.
> It is a related bug. The ioc->encinput buffer contains upto 4096
> bytes, but that data may cover both the header & payload. The
> handshake_end pointer refers to the end of the header region.
> So if we just pass encinput.offset, then handshake_process()
> will be searching part of the payload as well as the header.
> This might cause it do match the wrong data. I guess I should
> have made that clear in the commit, or even tput it in a
> separate commit
>
> Regards,
> Daniel
with this comment this is obviously correct :)

Reviewed-by: Denis V. Lunev <den@openvz.org>
