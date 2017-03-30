Received: from eggs.gnu.org ([2001:4830:134:3::10]:43325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTiy-0001Xx-MC
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTix-0005le-O3
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:38:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-4-git-send-email-armbru@redhat.com>
	<58b223ea-7e67-e5f9-9631-1b3c0dc79835@redhat.com>
Date: Thu, 30 Mar 2017 08:38:13 +0200
In-Reply-To: <58b223ea-7e67-e5f9-9631-1b3c0dc79835@redhat.com> (Max Reitz's
	message of "Wed, 29 Mar 2017 21:13:24 +0200")
Message-ID: <87r31ffewa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for-2.9 3/8] io vnc sockets: Clean up
 SocketAddressKind switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Max Reitz <mreitz@redhat.com> writes:

> On 29.03.2017 18:45, Markus Armbruster wrote:
>> We have quite a few switches over SocketAddressKind.  Some have case
>> labels for all enumeration values, others rely on a default label.
>> Some abort when the value isn't a valid SocketAddressKind, others
>> report an error then.
>> 
>> Unify as follows.  Always provide case labels for all enumeration
>> values, to clarify intent.  Abort when the value isn't a valid
>> SocketAddressKind, because the program state is messed up then.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  io/dns-resolver.c   |  6 ++++--
>>  ui/vnc.c            | 10 ++++++++--
>>  util/qemu-sockets.c |  4 +---
>>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!

> Nit-picks below, as can be expected of me.

Bring 'em on!

>> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
>> index 0ac6b23..00fb575 100644
>> --- a/io/dns-resolver.c
>> +++ b/io/dns-resolver.c
>> @@ -164,9 +164,11 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
>>                                                  addrs,
>>                                                  errp);
>>  
>> +    case SOCKET_ADDRESS_KIND_FD:
>> +        error_setg(errp, "Unsupported socket address type 'fd'");
>> +        return -1;
>
> Could do with an empty line here like the other cases have.

Indeed.

>>      default:
>> -        error_setg(errp, "Unknown socket address kind");
>> -        return -1;
>> +        abort();
>>      }
>>  }
>>  
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index fe0a46a..b6b58c4 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -129,10 +129,13 @@ static void vnc_init_basic_info(SocketAddress *addr,
>>          info->family = NETWORK_ADDRESS_FAMILY_UNIX;
>>          break;
>>  
>> -    default:
>> +    case SOCKET_ADDRESS_KIND_VSOCK:
>> +    case SOCKET_ADDRESS_KIND_FD:
>>          error_setg(errp, "Unsupported socket kind %d",
>>                     addr->type);
>
> Pre-existing, but: %s and SocketAddressKind_lookup[addr->type] would be
> nicer.

Can do.

>>          break;
>> +    default:
>> +        abort();
>>      }
>>  
>>      return;
>> @@ -411,10 +414,13 @@ VncInfo *qmp_query_vnc(Error **errp)
>>              info->family = NETWORK_ADDRESS_FAMILY_UNIX;
>>              break;
>>  
>> -        default:
>> +        case SOCKET_ADDRESS_KIND_VSOCK:
>> +        case SOCKET_ADDRESS_KIND_FD:
>>              error_setg(errp, "Unsupported socket kind %d",
>>                         addr->type);
>
> Same here.

Yup.

> Max
>
>>              goto out_error;
>> +        default:
>> +            abort();
>>          }
>>  
>>          info->has_host = true;
>> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
>> index 9b73681..4ae37bd 100644
>> --- a/util/qemu-sockets.c
>> +++ b/util/qemu-sockets.c
>> @@ -1337,9 +1337,7 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
>>          break;
>>  
>>      default:
>> -        error_setg(errp, "socket family %d unsupported",
>> -                   addr->type);
>> -        return NULL;
>> +        abort();
>>      }
>>      return buf;
>>  }
>> 
