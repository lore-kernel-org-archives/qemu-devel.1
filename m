Received: from eggs.gnu.org ([209.51.188.92]:47063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghDf3-00036E-3S
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghDTj-0002qf-Is
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:01:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghDTj-0002qI-CU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:01:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D50CC0669AD
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 13:01:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190109085113.GA23677@paraplu> <20190109110208.GH3998@redhat.com>
Date: Wed, 09 Jan 2019 14:01:00 +0100
In-Reply-To: <20190109110208.GH3998@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Wed, 9 Jan 2019 11:02:08 +0000")
Message-ID: <87k1jef0j7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Should the "props" be documented for QMP
 `object-add`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jan 09, 2019 at 09:51:13AM +0100, Kashyap Chamarthy wrote:
>> I notice that the following QMP command:
>>=20
>>     {
>>       "execute":"object-add",
>>       "arguments":{
>>         "qom-type":"tls-creds-x509",
>>         "id":"objlibvirt_migrate_tls0",
>>         "props":{
>>           "dir":"/etc/pki/qemu",
>>           "endpoint":"server",
>>           "verify-peer":true
>>         }
>>       }
>>     }
>>=20
>> ... is the same as its command-line equivalent:
>>=20
>>     -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserv=
er,verify-peer=3Dyes
>>=20
>> That said, in qapi/misc.json "@object-add" doesn't document any of the
>> "props".  Is it on purpose?  Maybe because it is a 1:1 mapping of the
>> command-line `-object` (which _is_ documented in qemu-doc.texi).
>>=20
>> Is it a good idea to send a patch to document the "props" in
>> qapi/misc.json?  Or would it be needless duplication?
>
> It is not practical at this time because object_add uses QOM object
> properties and these are exclusively defined in code, not QAPI schema.

Correct.  Same for netdev_add and device_add.

Eric posted patches to fix that netdev_add back in 2016[*], but it got
stuck due to (excessive, in my opinion) concern for staying compabile
with incorrectly typed usage.

device_add and object add are harder.

See also my KVM Forum 2015 talk "QEMU interface introspection: From
hacks to solutions", part IV "Future work".

> There's a long term todo item to use QAPI schema to define QOM objects,
> which would then auto-generate the boilerplate QOM code, at which point
> it all becomes self-documenting. That's basically lacking dev resources
> to work on it though...

I'm not sure moving QOM object specification to the QAPI schema is
practical.  Fortunately, it's not the only way to provide introspection.


[*] Subject: [Qemu-devel] [PATCH for-2.7 v9 00/17] qapi netdev_add
     introspection (post-introspection cleanups subset F)
    Message-Id: <1468468228-27827-1-git-send-email-eblake@redhat.com>
    Date: Wed, 13 Jul 2016 21:50:11 -0600 (2 years, 25 weeks, 3 days ago)
[**] http://www.linux-kvm.org/images/7/7a/02x05-Aspen-Markus_Armbruster-QEM=
U_interface_introspection.pdf
