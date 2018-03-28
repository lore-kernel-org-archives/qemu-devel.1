Received: from eggs.gnu.org ([2001:4830:134:3::10]:57664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f1BR9-00047I-Ui
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f1BR5-0007z8-A0
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:48:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f1BR5-0007yN-5w
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:48:19 -0400
Received: by mail-it0-f68.google.com with SMTP id r19-v6so3874287itc.0
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 06:48:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a74de730-cf65-056c-dfa1-2fcc9361b9a1@redhat.com>
References: <20180328130723.20831-1-marcandre.lureau@redhat.com>
	<20180328130723.20831-3-marcandre.lureau@redhat.com>
	<a74de730-cf65-056c-dfa1-2fcc9361b9a1@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Mar 2018 15:48:17 +0200
Message-ID: <CAMxuvayFZiYwf99mbMVFVwFZR2Bnqfv4rYS1O2SpDT1mhFtAEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qobject: introduce QObjectCommon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>, "Bonzini,
	Paolo" <pbonzini@redhat.com>

Hi

On Wed, Mar 28, 2018 at 3:45 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/28/2018 08:07 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> By moving the common fields to a QObjectCommon, QObject can be a type
>> which also has a 'base' QObjectCommon field. This allows to write a
>> generic QOBJECT() macro that will work with any QObject type,
>> including QObject itself. The container_of() macro ensures that the
>> object to cast has a QObjectCommon base field, give me some type
>> safety guarantees. However, for it to work properly, all QObject types
>> must have 'base' at offset 0 (which is ensured by static checking from
>> previous patch)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>
>
>> +++ b/include/qapi/qmp/qbool.h
>> @@ -17,7 +17,7 @@
>>   #include "qapi/qmp/qobject.h"
>>     struct QBool {
>> -    QObject base;
>> +    struct QObjectCommon base;
>
>
> Why no 'typedef struct QObjectCommon QObjectCommon' in scope to make this
> simpler?

We could (not having the typedef enforces the feeling that
QObjectCommon is internal in my mind, but ymmv)

>> -/* Get the 'base' part of an object */
>> -#define QOBJECT(obj) (&(obj)->base)
>> +struct QObject {
>> +    struct QObjectCommon base;
>> +};
>> +
>> +#define QOBJECT(x) \
>> +   container_of(&(x)->base, QObject, base)
>
>
> If I understand correctly, this still causes clang complaints when called=
 as
> QOBJECT(NULL).  As long as we are touching this, should we improve this
> macro to be friendly to NULL conversion?

I don't see much need for allowing NULL (literally) to be passed to
QOBJECT(). If it's a null pointer, as long as it has the right type,
it should be fine, shouldn't it?

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
