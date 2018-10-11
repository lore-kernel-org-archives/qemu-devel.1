Received: from eggs.gnu.org ([2001:4830:134:3::10]:41749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAerf-0002Pm-HB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAerb-0002Kt-EH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:35:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAerb-0002Kd-5O
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:35:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-13-armbru@redhat.com>
	<CAJ+F1C+henpMSEboS5iKpqDemS-oEFwFHXxXuMhgs6vz7Jdijw@mail.gmail.com>
Date: Thu, 11 Oct 2018 19:35:04 +0200
In-Reply-To: <CAJ+F1C+henpMSEboS5iKpqDemS-oEFwFHXxXuMhgs6vz7Jdijw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 Oct 2018
	13:32:57 +0400")
Message-ID: <87d0sgz8s7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/31] l2tpv3: Improve
 -netdev/netdev_add/-net/... error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
> On Mon, Oct 8, 2018 at 9:54 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> When -netdev l2tpv3 fails, it first reports a specific error, then a
>> generic one, like this:
>>
>>     $ qemu-system-x86_64 -netdev l2tpv3,id=3Dfoo,src=3D,dst=3D,txsession=
=3D1
>>     qemu-system-x86_64: -netdev l2tpv3,id=3Dfoo,src=3D,dst=3D,txsession=
=3D1: l2tpv3_open : could not resolve src, errno =3D Name or service not kn=
own
>>     qemu-system-x86_64: Device 'l2tpv3' could not be initialized
>>
>> With the command line, the messages go to stderr.  In HMP, they go to
>> the monitor.  In QMP, the second one becomes the error reply, and the
>> first one goes to stderr.
>>
>> Convert net_init_tap() to Error.  This suppresses the unwanted second
>> message, and makes the specific error the QMP error reply.
>>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  net/l2tpv3.c | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/net/l2tpv3.c b/net/l2tpv3.c
>> index 6745b78990..0c5dd22ef7 100644
>> --- a/net/l2tpv3.c
>> +++ b/net/l2tpv3.c
>> @@ -28,6 +28,7 @@
>>  #include <netdb.h>
>>  #include "net/net.h"
>>  #include "clients.h"
>> +#include "qapi/error.h"
>>  #include "qemu-common.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/option.h"
>> @@ -528,7 +529,6 @@ int net_init_l2tpv3(const Netdev *netdev,
>>                      const char *name,
>>                      NetClientState *peer, Error **errp)
>>  {
>> -    /* FIXME error_setg(errp, ...) on failure */
>>      const NetdevL2TPv3Options *l2tpv3;
>>      NetL2TPV3State *s;
>>      NetClientState *nc;
>> @@ -555,7 +555,7 @@ int net_init_l2tpv3(const Netdev *netdev,
>>      }
>>
>>      if ((l2tpv3->has_offset) && (l2tpv3->offset > 256)) {
>> -        error_report("l2tpv3_open : offset must be less than 256 bytes"=
);
>> +        error_setg(errp, "l2tpv3_open : offset must be less than 256 by=
tes");
>>          goto outerr;
>>      }
>>
>> @@ -563,6 +563,8 @@ int net_init_l2tpv3(const Netdev *netdev,
>>          if (l2tpv3->has_rxcookie && l2tpv3->has_txcookie) {
>>              s->cookie =3D true;
>>          } else {
>> +            error_setg(errp,
>> +                       "require both 'rxcookie' and 'txcookie' or neith=
er");
>
> maybe for consistency it would be a good idea to remove the
> "l2tpv3_open : " prefix from the other messages while touching it?

Good idea, not least since the other net_init_FOO() don't use such
prefixes.

> looks good otherwise:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
