Received: from eggs.gnu.org ([2001:4830:134:3::10]:49054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3dom-00068A-VO
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3dol-00024U-Mw
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:26:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-7-git-send-email-armbru@redhat.com>
	<2b5e5672-bedd-bbf6-52b2-31e8812ce2dc@redhat.com>
Date: Thu, 27 Apr 2017 09:26:14 +0200
In-Reply-To: <2b5e5672-bedd-bbf6-52b2-31e8812ce2dc@redhat.com> (Eric Blake's
	message of "Wed, 26 Apr 2017 14:45:10 -0500")
Message-ID: <87d1byjoq1.fsf@dusky.pond.sub.org>
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

Eric Blake <eblake@redhat.com> writes:

> On 04/26/2017 02:36 AM, Markus Armbruster wrote:
>
> I think it reads fine if you shorten the subject via s/except //

It doesn't unless.  Will fix, thanks!

>> SocketAddressLegacy is a simple union, and simple unions are awkward:
>> they have their variant members wrapped in a "data" object on the
>> wire, and require additional indirections in C.  SocketAddress is the
>> equivalent flat union.  Convert all users of SocketAddressLegacy to
>> SocketAddress, except for existing external interfaces.
>> 
>> See also commit fce5d53..9445673 and 85a82e8..c5f1ae3.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/blockdev-nbd.c
>> @@ -99,9 +99,8 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
>>  }
>>  
>>  
>> -void qmp_nbd_server_start(SocketAddressLegacy *addr,
>> -                          bool has_tls_creds, const char *tls_creds,
>> -                          Error **errp)
>> +void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>> +                      Error **errp)
>>  {
> ...
>> @@ -145,6 +144,16 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
>>      nbd_server = NULL;
>>  }
>>  
>> +void qmp_nbd_server_start(SocketAddressLegacy *addr,
>> +                          bool has_tls_creds, const char *tls_creds,
>> +                          Error **errp)
>> +{
>> +    SocketAddress *addr_flat = socket_address_flatten(addr);
>> +
>> +    nbd_server_start(addr_flat, tls_creds, errp);
>
> We didn't always guarantee that tls_creds was initialized when
> has_tls_creds was false, but it's been quite some time that we fixed
> that.  So what you have works, and I'm not sure if it's worth using the
> longer:
> has_tls_creds ? tls_creds : NULL



>> +++ b/chardev/char-socket.c
>> @@ -52,7 +52,7 @@ typedef struct {
>>      int *write_msgfds;
>>      size_t write_msgfds_num;
>>  
>> -    SocketAddressLegacy *addr;
>> +    SocketAddress *addr;
>>      bool is_listen;
>>      bool is_telnet;
>>  
>> @@ -337,30 +337,30 @@ static void tcp_chr_free_connection(Chardev *chr)
>>      s->connected = 0;
>>  }
>>  
>> -static char *SocketAddress_to_str(const char *prefix, SocketAddressLegacy *addr,
>> +static char *SocketAddressto_str(const char *prefix, SocketAddress *addr,
>>                                    bool is_listen, bool is_telnet)
>
> Is this rename(s/_to/to/) intentional? If it is, your indentation is now
> off.  If not, you've got a couple of fixes to make to restore the _.

Editing accident; I'll restore the '_'.

>> @@ -380,7 +380,7 @@ static void tcp_chr_disconnect(Chardev *chr)
>>          s->listen_tag = qio_channel_add_watch(
>>              QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NULL);
>>      }
>> -    chr->filename = SocketAddress_to_str("disconnected:", s->addr,
>> +    chr->filename = SocketAddressto_str("disconnected:", s->addr,
>>                                           s->is_listen, s->is_telnet);
>
> Again, either restore the _ or fix the indentation.
>
>
>> @@ -864,18 +864,18 @@ static void qmp_chardev_open_socket(Chardev *chr,
>>          }
>>      }
>>  
>> -    s->addr = QAPI_CLONE(SocketAddressLegacy, sock->addr);
>> +    s->addr = addr = socket_address_flatten(sock->addr);
>>  
>>      qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
>>      /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
>> -    if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX) {
>> +    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX) {
>>          qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
>>      }
>>  
>>      /* be isn't opened until we get a connection */
>>      *be_opened = false;
>>  
>> -    chr->filename = SocketAddress_to_str("disconnected:",
>> +    chr->filename = SocketAddressto_str("disconnected:",
>>                                           addr, is_listen, is_telnet);
>
> and again
>
>
>> @@ -131,4 +131,15 @@ char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp);
>>   */
>>  SocketAddressLegacy *socket_address_crumple(SocketAddress *addr);
>>  
>> +/**
>> + * socket_address_flatten:
>> + * @addr: the socket address to flatten
>> + *
>> + * Convert SocketAddressLegacy to SocketAddress.  Caller is responsible
>> + * for freeing with qapi_free_SocketAddress().
>> + *
>> + * Returns: the argument converted to SocketAddressLegacy.
>
> s/SocketAddressLegacy/SocketAddress/

Oops!

>> + */
>> +SocketAddress *socket_address_flatten(SocketAddressLegacy *addr);
>> +
>>  #endif /* QEMU_SOCKETS_H */
>
>> +++ b/qapi-schema.json
>> @@ -4126,7 +4126,12 @@
>>  #
>>  # Captures the address of a socket, which could also be a named file descriptor
>>  #
>> -# Note: This type is deprecated in favor of SocketAddress.
>> +# Note: This type is deprecated in favor of SocketAddress.  The
>> +# difference to SocketAddress is that SocketAddress is a flat union
>> +# rather than a simple union.  Flat is nicer because it avoids nesting
>> +# on the wire, i.e. this form has fewer {}.
>
> This comment doesn't read correctly.  I think you want:
>
> The difference between SocketAddressLegacy and SocketAddress is that the
> latter is a flat union rather than a simple union. Flat is nicer because
> it avoids nesting on the wire, i.e. that form has fewer {}.

Works for me.

>> +++ b/util/qemu-sockets.c
>
>> @@ -1371,3 +1366,34 @@ SocketAddressLegacy *socket_address_crumple(SocketAddress *addr_flat)
>>  
>>      return addr;
>>  }
>> +
>> +SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
>> +{
>> +    SocketAddress *addr = g_new(SocketAddress, 1);
>> +
>> +    switch (addr_legacy->type) {
>> +    case SOCKET_ADDRESS_LEGACY_KIND_INET:
>> +        addr->type = SOCKET_ADDRESS_TYPE_INET;
>> +        QAPI_CLONE_MEMBERS(InetSocketAddress, &addr->u.inet,
>> +                           addr_legacy->u.inet.data);
>> +        break;
>
> Works nicely.
>
> I've pointed out some minor issues, but if you are comfortable changing
> those as maintainer rather than posting a v2, feel free to add:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
