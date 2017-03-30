Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbbi-00024k-Bz
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbbh-0006Qz-A5
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:03:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-8-git-send-email-armbru@redhat.com>
	<b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com>
Date: Thu, 30 Mar 2017 17:03:12 +0200
In-Reply-To: <b3bf3853-d19f-0886-5dd8-166ace2d29ec@redhat.com> (Eric Blake's
	message of "Thu, 30 Mar 2017 09:42:00 -0500")
Message-ID: <87inmqzu1b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 07/10] sockets: New helper
 socket_address_crumple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/30/2017 08:15 AM, Markus Armbruster wrote:
>> SocketAddress is a simple union, and simple unions are awkward: they
>> have their variant members wrapped in a "data" object on the wire, and
>> require additional indirections in C.  I intend to limit its use to
>> existing external interfaces.  New ones should use SocketAddressFlat.
>> I further intend to convert all internal interfaces to
>> SocketAddressFlat.  This helper should go away then.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qemu/sockets.h | 11 +++++++++++
>>  util/qemu-sockets.c    | 29 +++++++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>> 
>> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>> index 5f1bab9..cef05a5 100644
>> --- a/include/qemu/sockets.h
>> +++ b/include/qemu/sockets.h
>> @@ -119,4 +119,15 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
>>   */
>>  char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
>>  
>> +/**
>> + * socket_address_crumple:
>> + * @addr_flat: the socket addres to crumple
>
> s/addres/address/

Fixing...

>> +SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
>> +{
>> +    SocketAddress *addr = g_new(SocketAddress, 1);
>> +
>> +    addr->type = addr_flat->type;
>
> Works only because our enum is defined in the same order as the simple
> union's members.  A bit fragile, so maybe we want to comment in the
> .json file that we can't reorder members of either the enum or the
> simple union's 'data'?  Or it might even tickle a picky compiler to warn
> about assignment between incompatible enum types.  Another option would
> be making it robust by instead doing switch(addr_flat->type) and
> assigning to addr->type in each branch of the switch.

Sold.

>> +    switch (addr->type) {
>> +    case SOCKET_ADDRESS_FLAT_TYPE_INET:
>> +        addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
>> +                                        &addr_flat->u.inet);
>
> Indentation is off.

>> +        break;
>> +    case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
>> +        addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress, &
>> +                                          addr_flat->u.q_unix);
>
> Why is the unary & split from its argument?

Editing accident.

>> +        break;
>> +    case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
>> +        addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
>> +                                         &addr_flat->u.vsock);
>
> More indentation problems.
>
>> +        break;
>> +    case SOCKET_ADDRESS_FLAT_TYPE_FD:
>> +        addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
>> +        break;
>> +    default:
>> +        abort();
>> +    }
>> +
>> +    return addr;
>> +}
>> 

Now looks like this:

SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
{
    SocketAddress *addr = g_new(SocketAddress, 1);

    switch (addr_flat->type) {
    case SOCKET_ADDRESS_FLAT_TYPE_INET:
        addr->type = SOCKET_ADDRESS_KIND_INET;
        addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
                                       &addr_flat->u.inet);
        break;
    case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
        addr->type = SOCKET_ADDRESS_KIND_UNIX;
        addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress,
                                         &addr_flat->u.q_unix);
        break;
    case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
        addr->type = SOCKET_ADDRESS_KIND_VSOCK;
        addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
                                        &addr_flat->u.vsock);
        break;
    case SOCKET_ADDRESS_FLAT_TYPE_FD:
        addr->type = SOCKET_ADDRESS_KIND_FD;
        addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
        break;
    default:
        abort();
    }

    return addr;
}
