Received: from eggs.gnu.org ([2001:4830:134:3::10]:51495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3dwG-0003h6-V3
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3dwG-0000db-3e
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:34:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-7-git-send-email-armbru@redhat.com>
	<2b5e5672-bedd-bbf6-52b2-31e8812ce2dc@redhat.com>
	<87d1byjoq1.fsf@dusky.pond.sub.org>
Date: Thu, 27 Apr 2017 09:33:58 +0200
In-Reply-To: <87d1byjoq1.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 27 Apr 2017 09:26:14 +0200")
Message-ID: <8760hqi9sp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/7] sockets: Limit SocketAddressLegacy
 except to external interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 04/26/2017 02:36 AM, Markus Armbruster wrote:
>>
>> I think it reads fine if you shorten the subject via s/except //
>
> It doesn't unless.  Will fix, thanks!
>
>>> SocketAddressLegacy is a simple union, and simple unions are awkward:
>>> they have their variant members wrapped in a "data" object on the
>>> wire, and require additional indirections in C.  SocketAddress is the
>>> equivalent flat union.  Convert all users of SocketAddressLegacy to
>>> SocketAddress, except for existing external interfaces.
>>> 
>>> See also commit fce5d53..9445673 and 85a82e8..c5f1ae3.
>>> 
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>>> +++ b/blockdev-nbd.c
>>> @@ -99,9 +99,8 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
>>>  }
>>>  
>>>  
>>> -void qmp_nbd_server_start(SocketAddressLegacy *addr,
>>> -                          bool has_tls_creds, const char *tls_creds,
>>> -                          Error **errp)
>>> +void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>>> +                      Error **errp)
>>>  {
>> ...
>>> @@ -145,6 +144,16 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
>>>      nbd_server = NULL;
>>>  }
>>>  
>>> +void qmp_nbd_server_start(SocketAddressLegacy *addr,
>>> +                          bool has_tls_creds, const char *tls_creds,
>>> +                          Error **errp)
>>> +{
>>> +    SocketAddress *addr_flat = socket_address_flatten(addr);
>>> +
>>> +    nbd_server_start(addr_flat, tls_creds, errp);
>>
>> We didn't always guarantee that tls_creds was initialized when
>> has_tls_creds was false, but it's been quite some time that we fixed
>> that.  So what you have works, and I'm not sure if it's worth using the
>> longer:
>> has_tls_creds ? tls_creds : NULL

Forgot to fill in the blank here: the conditional operator adds neither
readability nor robustness.  All it adds is noise.

I still hope to get rid of the has_ flag for pointers.
