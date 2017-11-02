Received: from eggs.gnu.org ([2001:4830:134:3::10]:34640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eAOGg-0006I5-M5
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eAOGd-0007xM-Fc
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:47:22 -0400
Received: from mailrelay.quantumachine.net ([37.59.103.225]:53474)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eAOGd-0007wn-5z
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:47:19 -0400
Received: from mail.quantumachine.net (unknown [185.48.86.222])
	by mailrelay.quantumachine.net (Postfix) with ESMTP id 462E165
	for <qemu-devel@nongnu.org>; Thu,  2 Nov 2017 23:47:14 +0100 (CET)
Date: Thu, 02 Nov 2017 22:47:10 +0000
Message-ID: <20171102224710.Horde.un6xiancuv3-V_s6uvEtdpP@www.quantumachine.net>
From: Antonio Huete =?utf-8?b?Smltw6luZXo=?= <tuxillo@quantumachine.net>
References: <20171102165629.Horde.3vL2RJXzulVHv5PiXG00Bz4@www.quantumachine.net>
	<20171102170903.GY32533@redhat.com>
In-Reply-To: <20171102170903.GY32533@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sockets: Normalize test for addrinfo flag
 AI_V4MAPPED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


"Daniel P. Berrange" <berrange@redhat.com> escribi=C3=B3:

> On Thu, Nov 02, 2017 at 04:56:29PM +0000, Antonio Huete Jim=C3=A9nez wr=
ote:
>> From 2b4d9d8cb617445af8f3b062f917dfea42dbdc27 Mon Sep 17 00:00:00 2001
>> From: Antonio Huete Jimenez <tuxillo@quantumachine.net>
>> Date: Thu, 2 Nov 2017 17:46:24 +0100
>> Subject: [PATCH] sockets: Normalize test for addrinfo flag AI_V4MAPPED
>
> Can you explain why you're making this change....

Hi Daniel,

Thanks for reviewing the patch. I am trying to fix 'make check' for =20
DragonFly BSD and this is the first issue I encountered.

With help from people in #qemu we found that it may be necessary to =20
consistently check for the availability of this flag so I thought it =20
would be a good idea to do it like this.

>
>>
>> Signed-off-by: Antonio Huete Jimenez <tuxillo@quantumachine.net>
>> ---
>>  util/qemu-sockets.c | 54
>> +++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 34 insertions(+), 20 deletions(-)
>>
>> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
>> index b47fb45885..ce35b6a998 100644
>> --- a/util/qemu-sockets.c
>> +++ b/util/qemu-sockets.c
>> @@ -44,7 +44,6 @@
>>  # define AI_NUMERICSERV 0
>>  #endif
>>
>> -
>>  static int inet_getport(struct addrinfo *e)
>>  {
>>      struct sockaddr_in *i4;
>> @@ -149,6 +148,31 @@ int =20
>> inet_ai_family_from_address(InetSocketAddress *addr,
>>      return PF_UNSPEC;
>>  }
>>
>> +static int
>> +check_ai_v4mapped(const char *host, const char *port, struct addrinfo=
 *ai,
>> +               struct addrinfo *res)
>> +{
>> +    static int useV4Mapped =3D -1;
>> +    int rc;
>> +
>> +    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
>> +     * then don't implement it in their getaddrinfo().
>> +     * Unconditionally deselect AI_V4MAPPED option upon
>> +     * getaddrinfo() failure, the next call to it will have to
>> +     * do the error handling.
>> +     */
>> +    if (atomic_read(&useV4Mapped) =3D=3D -1) {
>> +        rc =3D getaddrinfo(host, port, ai, &res);
>> +        if (rc =3D=3D 0 && (ai->ai_flags & AI_V4MAPPED)) {
>> +            atomic_set(&useV4Mapped, 1);
>> +        } else {
>> +            atomic_set(&useV4Mapped, 0);
>> +        }
>> +    }
>> +
>> +    return useV4Mapped;
>> +}
>> +
>>  static int create_fast_reuse_socket(struct addrinfo *e)
>>  {
>>      int slisten =3D qemu_socket(e->ai_family, e->ai_socktype, =20
>> e->ai_protocol);
>> @@ -378,14 +402,10 @@ static struct addrinfo
>> *inet_parse_connect_saddr(InetSocketAddress *saddr,
>>      struct addrinfo ai, *res;
>>      int rc;
>>      Error *err =3D NULL;
>> -    static int useV4Mapped =3D 1;
>>
>>      memset(&ai, 0, sizeof(ai));
>>
>> -    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
>> -    if (atomic_read(&useV4Mapped)) {
>> -        ai.ai_flags |=3D AI_V4MAPPED;
>> -    }
>> +    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG | AI_V4MAPPED;
>>      ai.ai_family =3D inet_ai_family_from_address(saddr, &err);
>>      ai.ai_socktype =3D SOCK_STREAM;
>>
>> @@ -399,21 +419,11 @@ static struct addrinfo
>> *inet_parse_connect_saddr(InetSocketAddress *saddr,
>>          return NULL;
>>      }
>>
>> -    /* lookup */
>> -    rc =3D getaddrinfo(saddr->host, saddr->port, &ai, &res);
>> -
>> -    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
>> -     * then don't implement it in their getaddrinfo(). Detect
>> -     * this and retry without the flag since that's preferrable
>> -     * to a fatal error
>> -     */
>> -    if (rc =3D=3D EAI_BADFLAGS &&
>> -        (ai.ai_flags & AI_V4MAPPED)) {
>> -        atomic_set(&useV4Mapped, 0);
>> +    if ((check_ai_v4mapped(saddr->host, saddr->port, &ai, res)) =3D=3D=
 0) {
>>          ai.ai_flags &=3D ~AI_V4MAPPED;
>> -        rc =3D getaddrinfo(saddr->host, saddr->port, &ai, &res);
>>      }
>> -    if (rc !=3D 0) {
>> +
>> +    if ((rc =3D getaddrinfo(saddr->host, saddr->port, &ai, &res)) !=3D=
 0) {
>>          error_setg(errp, "address resolution failed for %s:%s: %s",
>>                     saddr->host, saddr->port, gai_strerror(rc));
>>          return NULL;
>> @@ -469,7 +479,7 @@ static int inet_dgram_saddr(InetSocketAddress *sra=
ddr,
>>
>>      /* lookup peer addr */
>>      memset(&ai,0, sizeof(ai));
>> -    ai.ai_flags =3D AI_CANONNAME | AI_V4MAPPED | AI_ADDRCONFIG;
>> +    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG | AI_V4MAPPED;
>
> Gratuitous re-ordering of code with no functional change.

Agree, can change it.

>
>>      ai.ai_family =3D inet_ai_family_from_address(sraddr, &err);
>>      ai.ai_socktype =3D SOCK_DGRAM;
>>
>> @@ -488,6 +498,10 @@ static int inet_dgram_saddr(InetSocketAddress *sr=
addr,
>>          goto err;
>>      }
>>
>> +    if ((check_ai_v4mapped(addr, port, &ai, &peer)) =3D=3D 0) {
>> +        ai.ai_flags &=3D ~AI_V4MAPPED;
>> +    }
>> +
>>      if ((rc =3D getaddrinfo(addr, port, &ai, &peer)) !=3D 0) {
>>          error_setg(errp, "address resolution failed for %s:%s: %s", a=
ddr,
>> port,
>>                     gai_strerror(rc));
>> --
>> 2.14.1
>>
>>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    =20
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =20
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =20
> https://www.instagram.com/dberrange :|
