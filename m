Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09860C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57362067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3e4ytS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57362067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSQxC-0004tE-Ul
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 14:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iSQwR-0004N4-MX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iSQwP-00007t-TY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:26:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iSQwP-00007f-QR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573068365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxHI/aLNLsKgnqMQDVfhxBHabN+6WMoUWTXa8Ttbt7I=;
 b=h3e4ytS62eercEiJcRMb+P7iQpWMWg4bb3G0zUTHNDdLjv071jb8KRFMsiM/+Zgk9Pbbbk
 RlxiGS3idcBmhxgf2xG0hkGbQ0goB0IgUi7Ksyu3WXBeO3Xcy9IsdFTXj8E0aOt2nASg/j
 rvyW/Ci79gtqhY4odr6Wm0EzlMVjXuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-vJ7kuUBUNDqUc4l6tWFo7Q-1; Wed, 06 Nov 2019 14:26:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2B981800D6B;
 Wed,  6 Nov 2019 19:25:59 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DA821001B11;
 Wed,  6 Nov 2019 19:25:58 +0000 (UTC)
Subject: Re: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-7-kwolf@redhat.com>
 <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1bcb5419-183e-fd7b-e53c-fbb315f29703@redhat.com>
Date: Wed, 6 Nov 2019 13:25:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vJ7kuUBUNDqUc4l6tWFo7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 6:51 AM, Max Reitz wrote:
> On 17.10.19 15:01, Kevin Wolf wrote:
>> Add a --nbd-server option to qemu-storage-daemon to start the built-in
>> NBD server right away. It maps the arguments for nbd-server-start to the
>> command line.
>=20
> Well, it doesn=E2=80=99t quite, because nbd-server-start takes a
> SocketAddressLegacy, and this takes a SocketAddress.
>=20
> On one hand I can understand why you would do it differently (especially
> for command-line options), but on the other I find it a bit problematic
> to have --nbd-server be slightly different from nbd-server-start when
> both are intended to be the same.
>=20
> My biggest problem though lies in the duplication in the QAPI schema.
> If NbdServerOptions.addr were a SocketAddressLegacy, we could let
> nbd-server-start=E2=80=99s options just be of type NbdServerOptions and t=
hus get
> rid of the duplication.

I would love to somehow deprecate the use of SocketAddressLegacy and get=20
QMP nbd-server-start to accept SocketAddress instead.  Maybe it could be=20
done by adding a new nbd-server-begin command in 5.0 with a saner wire=20
layout, and deprecating nbd-server-start at that time; by the 5.2=20
release, we could then drop nbd-server-start.  But we're too late for 4.2.

>=20
> I suspect in practice it=E2=80=99s all not that big of a problem.  I can=
=E2=80=99t call
> it bad if --nbd-server is just nicer to use.  And the biggest problem
> with duplication in the QAPI schema is that nbd-server-start and
> --nbd-server might get out of sync.  But realistically, I don=E2=80=99t s=
ee that
> happen, because if nbd-server-start changes, nbd_server_start() will
> change, too, so we=E2=80=99ll get compile errors in nbd_server_start_opti=
ons().
>=20
> *shrug*
>=20
> But I do think the commit message should explain why we can=E2=80=99t jus=
t use
> NbdServerOptions for nbd-server-start.
>=20
> Max
>=20
>> Example (only with required options):
>>
>>      --nbd-server addr.type=3Dinet,addr.host=3Dlocalhost,addr.port=3D108=
09
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>   qapi/block.json       | 18 ++++++++++++++++++
>>   include/block/nbd.h   |  1 +
>>   blockdev-nbd.c        |  5 +++++
>>   qemu-storage-daemon.c | 26 +++++++++++++++++++++++++-
>>   Makefile.objs         |  2 +-
>>   5 files changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 145c268bb6..7fe0cf6538 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -215,6 +215,24 @@
>>               '*id': 'str',
>>               '*force': 'bool' } }
>>  =20
>> +##
>> +# @NbdServerOptions:
>> +#
>> +# @addr: Address on which to listen.
>> +# @tls-creds: ID of the TLS credentials object (since 2.6).
>> +# @tls-authz: ID of the QAuthZ authorization object used to validate
>> +#             the client's x509 distinguished name. This object is
>> +#             is only resolved at time of use, so can be deleted and
>> +#             recreated on the fly while the NBD server is active.
>> +#             If missing, it will default to denying access (since 4.0)=
.
>> +#
>> +# Since: 4.2
>> +##
>> +{ 'struct': 'NbdServerOptions',
>> +  'data': { 'addr': 'SocketAddress',
>> +            '*tls-creds': 'str',
>> +            '*tls-authz': 'str'} }
>> +
>>   ##
>>   # @nbd-server-start:
>>   #
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index 316fd705a9..2a7441491a 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -353,6 +353,7 @@ void nbd_client_put(NBDClient *client);
>>  =20
>>   void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>>                         const char *tls_authz, Error **errp);
>> +void nbd_server_start_options(NbdServerOptions *arg, Error **errp);
>>  =20
>>   /* nbd_read
>>    * Reads @size bytes from @ioc. Returns 0 on success.
>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>> index 6a8b206e1d..d4c1fd4166 100644
>> --- a/blockdev-nbd.c
>> +++ b/blockdev-nbd.c
>> @@ -132,6 +132,11 @@ void nbd_server_start(SocketAddress *addr, const ch=
ar *tls_creds,
>>       nbd_server =3D NULL;
>>   }
>>  =20
>> +void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
>> +{
>> +    nbd_server_start(arg->addr, arg->tls_creds, arg->tls_authz, errp);
>> +}
>> +
>>   void qmp_nbd_server_start(SocketAddressLegacy *addr,
>>                             bool has_tls_creds, const char *tls_creds,
>>                             bool has_tls_authz, const char *tls_authz,
>> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
>> index 904e3c3a46..51882452f3 100644
>> --- a/qemu-storage-daemon.c
>> +++ b/qemu-storage-daemon.c
>> @@ -25,11 +25,14 @@
>>   #include "qemu/osdep.h"
>>  =20
>>   #include "block/block.h"
>> +#include "block/nbd.h"
>>   #include "crypto/init.h"
>>  =20
>>   #include "qapi/error.h"
>> -#include "qapi/qapi-visit-block-core.h"
>> +#include "qapi/qapi-commands-block.h"
>>   #include "qapi/qapi-commands-block-core.h"
>> +#include "qapi/qapi-visit-block.h"
>> +#include "qapi/qapi-visit-block-core.h"
>>   #include "qapi/qobject-input-visitor.h"
>>  =20
>>   #include "qemu-common.h"
>> @@ -64,6 +67,12 @@ static void help(void)
>>   "             [,driver specific parameters...]\n"
>>   "                         configure a block backend\n"
>>   "\n"
>> +"  --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port>\=
n"
>> +"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
>> +"  --nbd-server addr.type=3Dunix,addr.path=3D<path>\n"
>> +"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
>> +"                         start an NBD server for exporting block nodes=
\n"
>> +"\n"
>>   "  --object <properties>  define a QOM object such as 'secret' for\n"
>>   "                         passwords and/or encryption keys\n"
>>   "\n"
>> @@ -74,6 +83,7 @@ QEMU_HELP_BOTTOM "\n",
>>   enum {
>>       OPTION_OBJECT =3D 256,
>>       OPTION_BLOCKDEV,
>> +    OPTION_NBD_SERVER,
>>   };
>>  =20
>>   static QemuOptsList qemu_object_opts =3D {
>> @@ -95,6 +105,7 @@ static int process_options(int argc, char *argv[], Er=
ror **errp)
>>           {"help", no_argument, 0, 'h'},
>>           {"object", required_argument, 0, OPTION_OBJECT},
>>           {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
>> +        {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
>>           {"version", no_argument, 0, 'V'},
>>           {"trace", required_argument, NULL, 'T'},
>>           {0, 0, 0, 0}
>> @@ -152,6 +163,19 @@ static int process_options(int argc, char *argv[], =
Error **errp)
>>                   qapi_free_BlockdevOptions(options);
>>                   break;
>>               }
>> +        case OPTION_NBD_SERVER:
>> +            {
>> +                Visitor *v;
>> +                NbdServerOptions *options;
>> +
>> +                v =3D qobject_input_visitor_new_str(optarg, NULL, &erro=
r_fatal);
>> +                visit_type_NbdServerOptions(v, NULL, &options, &error_f=
atal);
>> +                visit_free(v);
>> +
>> +                nbd_server_start_options(options, &error_fatal);
>> +                qapi_free_NbdServerOptions(options);
>> +                break;
>> +            }
>>           }
>>       }
>>       if (optind !=3D argc) {
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 00fdf54500..cc262e445f 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -42,7 +42,7 @@ io-obj-y =3D io/
>>   # used for system emulation, too, but specified separately there)
>>  =20
>>   storage-daemon-obj-y =3D block/
>> -storage-daemon-obj-y +=3D blockdev.o iothread.o
>> +storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
>>  =20
>>   ######################################################################
>>   # Target independent part of system emulation. The long term path is t=
o
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


