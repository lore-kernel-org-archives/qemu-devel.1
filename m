Received: from eggs.gnu.org ([2001:4830:134:3::10]:53516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXZXq-0001g9-Iv
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXZXp-0005VY-5W
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:28:54 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:39655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXZXo-0005VB-VE
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:28:53 -0500
Received: by mail-it0-x231.google.com with SMTP id 68so3129071ite.4
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 13:28:52 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
	<58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 5 Jan 2018 18:28:51 -0300
Message-ID: <CAAdtpL6jRV5J+0w07tFOuWcOet3vTky22Az8edV58eds5U1GFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi Eric,

On Fri, Jan 5, 2018 at 12:29 PM, Eric Blake <eblake@redhat.com> wrote:
> On 01/03/2018 03:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
>> +        if (ambiguous) {
>> +            error_setg(errp, "Path '%s' is ambiguous", qom_path);
>> +        } else {
>> +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
>> +                      "Device '%s' not found", qom_path);
>> +        }
>> +        return NULL;
>> +    }
>> +    sdbus =3D (SDBus *)object_dynamic_cast(obj, TYPE_SD_BUS);
>
> Is the cast still necessary, or does object_dynamic_cast() return void*
> so that you can omit the cast?

Apparently the cast is necessary, since the object_dynamic_cast()
returns an Object pointer,
and the SD_BUS() macro uses object_dynamic_cast_assert() which
generates a runtime assert.

without casting:
hw/sd/sdbus-qmp.c:37:11: error: assignment from incompatible pointer
type [-Werror=3Dincompatible-pointer-types]
     sdbus =3D object_dynamic_cast(obj, TYPE_SD_BUS);
           ^

>
>> +    if (sdbus =3D=3D NULL) {
>> +        error_set(errp, ERROR_CLASS_GENERIC_ERROR,
>> +                  "Device '%s' not a sd-bus", qom_path);
>> +        return NULL;
>> +    }
