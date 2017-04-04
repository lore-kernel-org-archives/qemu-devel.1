Received: from eggs.gnu.org ([2001:4830:134:3::10]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cvMAZ-0006xp-9t
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cvMAW-00067u-2I
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:58:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cvMAV-00067W-Mp
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:58:36 -0400
References: <20170403235636.5647-1-laurent@vivier.eu>
	<20170403235636.5647-2-laurent@vivier.eu>
	<457a5d7f-8ff7-b4e0-9ea0-0ff8b4e17527@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a14367df-ad16-0b69-d7f6-f52de6df734a@vivier.eu>
Date: Tue, 4 Apr 2017 12:58:22 +0200
MIME-Version: 1.0
In-Reply-To: <457a5d7f-8ff7-b4e0-9ea0-0ff8b4e17527@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

Le 04/04/2017 à 12:05, Philippe Mathieu-Daudé a écrit :
> Hi Laurent,

Hi Philippe,

> I waited this feature for long and excited to try it soon :)
> 
> Please find some comments inline.
> 
> On 04/03/2017 08:56 PM, Laurent Vivier wrote:
>> When the VM is used behind a firewall, This allows
>> the use of a SOCKS5 proxy server to connect the VM IP stack
>> directly to the Internet.
>>
>> This implementation doesn't manage UDP packets, so they
>> are simply dropped (as with restrict=on), except for
>> the localhost as we need it for DNS.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  net/slirp.c         |  39 ++++++-
>>  qapi-schema.json    |   9 ++
>>  qemu-options.hx     |  11 ++
>>  slirp/Makefile.objs |   2 +-
>>  slirp/ip_icmp.c     |   2 +-
>>  slirp/libslirp.h    |   3 +
>>  slirp/slirp.c       |  68 ++++++++++-
>>  slirp/slirp.h       |   6 +
>>  slirp/socket.h      |   4 +
>>  slirp/socks5.c      | 328
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  slirp/socks5.h      |  24 ++++
>>  slirp/tcp_subr.c    |  22 +++-
>>  slirp/udp.c         |   9 ++
>>  slirp/udp6.c        |   8 ++
>>  14 files changed, 524 insertions(+), 11 deletions(-)
>>  create mode 100644 slirp/socks5.c
>>  create mode 100644 slirp/socks5.h
>>
...
>> diff --git a/slirp/socks5.c b/slirp/socks5.c
>> new file mode 100644
>> index 0000000..813c3db
>> --- /dev/null
>> +++ b/slirp/socks5.c
>> @@ -0,0 +1,328 @@
>> +/* based on RFC 1928
>> + *   SOCKS Protocol Version 5
>> + * based on RFC 1929
>> + *   Username/Password Authentication for SOCKS V5
>> + * TODO:
>> + *   - RFC 1961 GSS-API Authentication Method for SOCKS Version 5
>> + *   - manage buffering on recv()
>> + *   - IPv6 connection to proxy
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/sockets.h"
>> +
>> +#include "socks5.h"
>> +
>> +#define SOCKS_LEN_MAX                  0xff
> 
> I can't find 0xFF in the RFC1928, I prefer a self-explanatory UINT8_MAX
> but that's up to you (RFC1929 uses 255 for UNAME/PASSWD but not
> explicitly for FQDN).

I agree UINT8_MAX looks better.

...
>> +static int socks5_recv_connect(int fd)
>> +{
>> +    uint8_t reply[7 + SOCKS_LEN_MAX]; /* can contains a FQDN */
>> +
>> +    /*
>> +     * reply[0] is protocol version: 5
>> +     * reply[1] is reply field
>> +     * reply[2] is reserved
>> +     * reply[3] is address type */
>> +
>> +    if (recv(fd, reply, 4, 0) != 4) {
>> +        return -1;
>> +    }
>> +
>> +    if (reply[0] != SOCKS_VERSION_5) {
>> +        errno = EINVAL;
>> +        return -1;
>> +    }
>> +
>> +    if (reply[1] != SOCKS5_CMD_SUCCESS) {
>> +        errno = EINVAL;
> 
> Here the failure reason is lost! It should be notified to the user, can
> you add some function to display it?

Yes, I ignore it because I don't know what to do with result.

Perhaps I can add a log...

> 
>> +        return -1;
>> +    }
>> +
>> +    switch (reply[3]) {
>> +    case SOCKS5_ATYPE_IPV4:
>> +        if (recv(fd, reply + 4, 6, 0) != 6) {
> 
> Can we avoid this magic using sizeof(struct in_addr) + sizeof(in_port_t)
> or a #define?

I have put the number directly here because in the RFC we have directly
the number, but I agree the sizeof() is a better solution.

> 
>> +            return -1;
>> +        }
>> +        break;
>> +    case SOCKS5_ATYPE_IPV6:
>> +        if (recv(fd, reply + 4, 18, 0) != 18) {
> 
> same with sizeof(struct in6_addr) + sizeof(in_port_t)

OK

>> +            return -1;
>> +        }
>> +        break;
>> +    case SOCKS5_ATYPE_FQDN:
>> +        if (recv(fd, reply + 4, 1, 0) != 1) {
>> +            return -1;
>> +        }
>> +        if (recv(fd, reply + 5,
>> +                 reply[4], 0) != reply[4]) {
> 
> Would be nice/useful to log the FQDN (but it needs to be sanitized in
> case of nasty invalid data). Let it be a /* TODO */ at least.

Yes, I can add a log.

...
>> +void socks5_recv(int fd, socks5_state_t *state)
>> +{
>> +    int ret;
>> +
>> +    switch (*state) {
>> +    case SOCKS5_STATE_NEGOCIATING:
>> +        switch (socks5_recv_negociate(fd)) {
>> +        case SOCKS5_AUTH_METHOD_NONE: /* no authentification */
>> +            *state = SOCKS5_STATE_ESTABLISH;
>> +            break;
>> +        case SOCKS5_AUTH_METHOD_PASSWORD: /* username/password */
>> +            *state = SOCKS5_STATE_AUTHENTICATE;
>> +            break;
>> +        default:
>> +            break;
> 
> Reading the RFC1928 the server can reply SOCKS5_AUTH_METHOD_GSSAPI or
> SOCKS5_AUTH_METHOD_REJECTED which are valid. RFC states:
> 
>    Compliant implementations MUST support GSSAPI and SHOULD support
>    USERNAME/PASSWORD authentication methods.

Yes, I know, GSSAPI is in the TODO of the file header ;)
For instance, neither ncat nor TOR implement it... so I think it can
wait someone really needs it.

> 
> I wonder if this could lead to and infinite negociation and being
> paranoid an evil server could keep DDoS'ing this client :)
> Anyway I think this function has to handle this (eventually reporting
> some Unsupported/Invalid protocol issue) as state the RFC for
> SOCKS5_AUTH_METHOD_REJECTED:
> 
>    If the selected METHOD is X'FF', none of the methods listed by the
>    client are acceptable, and the client MUST close the connection.

I agree error case is not correctly managed. I will fix.

>> +        }
>> +        break;
>> +    case SOCKS5_STATE_AUTHENTICATING:
>> +        ret = socks5_recv_password(fd);
>> +        if (ret >= 0) {
>> +            *state = SOCKS5_STATE_ESTABLISH;
>> +        }
>> +        break;
>> +    case SOCKS5_STATE_ESTABLISHING:
>> +        ret = socks5_recv_connect(fd);
>> +        if (ret >= 0) {
>> +            *state = SOCKS5_STATE_NONE;
>> +        }
>> +        break;
>> +    default:
>> +        break;
> 
> I think only the case SOCKS5_STATE_NONE can break, all other states
> should be handled as error in protocol.
> 

I agree.

Thanks,
Laurent
