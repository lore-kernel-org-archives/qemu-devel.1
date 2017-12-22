Received: from eggs.gnu.org ([2001:4830:134:3::10]:56470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eSJ7E-0003Yj-2w
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eSJ7B-0000Ag-4s
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:55:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eSJ7A-00009Y-OK
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:55:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91878821C7
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 08:55:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171221155905.3793-1-berrange@redhat.com>
	<20171221155905.3793-2-berrange@redhat.com>
	<cf30232b-8674-134a-38fa-0c6cb9f9af3e@redhat.com>
Date: Fri, 22 Dec 2017 09:55:29 +0100
In-Reply-To: <cf30232b-8674-134a-38fa-0c6cb9f9af3e@redhat.com> (Eric Blake's
	message of "Thu, 21 Dec 2017 12:47:17 -0600")
Message-ID: <87o9mrrvjy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] io: move fd_is_socket() into common
 sockets code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 12/21/2017 09:59 AM, Daniel P. Berrange wrote:
>> The fd_is_socket() helper method is useful in a few places, so put it in
>> the common sockets code.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>   include/qemu/sockets.h |  1 +
>>   io/channel-util.c      | 13 -------------
>>   util/qemu-sockets.c    | 13 +++++++++++++
>>   3 files changed, 14 insertions(+), 13 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> But while you are touching this...
>
>> +++ b/util/qemu-sockets.c
>> @@ -91,6 +91,19 @@ NetworkAddressFamily inet_netfamily(int family)
>>       return NETWORK_ADDRESS_FAMILY_UNKNOWN;
>>   }
>>   +bool fd_is_socket(int fd)
>> +{
>> +    int optval;
>> +    socklen_t optlen;
>> +    optlen = sizeof(optval);
>> +    return qemu_getsockopt(fd,
>> +                           SOL_SOCKET,
>> +                           SO_TYPE,
>> +                           (char *)&optval,
>
> This cast is pointless (although you are just moving it from the old
> code).  qemu_getsockopt() already takes care of casting for mingw
> (where the signature is not POSIX-compliant), and on all other
> platforms, the argument is already prototyped as void*; and since
> void* accepts anything, you don't have to go through an intermediate
> char*.

If we're tweaking, then I'd like it tweaked so:

    bool fd_is_socket(int fd)
    {
        int optval;
        socklen_t optlen = sizeof(optval);

        return !qemu_getsockopt(fd, SOL_SOCKET, SO_TYPE, &optval, &optlen);
    }

With or without such tweaks:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
