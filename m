Received: from eggs.gnu.org ([209.51.188.92]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjOHA-0004CU-PE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjOH8-0003kv-Ql
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:57:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjOH7-0003ge-7m
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:57:02 -0500
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
Date: Tue, 15 Jan 2019 13:56:40 +0100
MIME-Version: 1.0
In-Reply-To: <875zuqjea7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] hw/ssi: Remove SSIBus from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 2019-01-15 13:28, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> There are only three files requiring this typedef, let them
>> include "hw/ssi/ssi.h" directly to simplify "qemu/typedefs.h".
>>
>> To clean "qemu/typedefs.h", move the forward declaration
>> to "hw/ssi/ssi.h".
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/arm/strongarm.h      | 1 +
>>  include/hw/arm/pxa.h    | 1 +
>>  include/hw/ssi/pl022.h  | 1 +
>>  include/hw/ssi/ssi.h    | 1 +
>>  include/qemu/typedefs.h | 1 -
>>  5 files changed, 4 insertions(+), 1 deletion(-)
>=20
> When typedefs.h changes, we recompile the world, but it pretty much onl=
y
> ever changes when new typedefs are added.  Thus, *keeping* a typedef
> there is therefore pretty cheap.
>=20
> Nevertheless, we shouldn't keep typedefs there without a real reason.
> Being able to move one away without having to add any new #include
> directives is a strong sign for "no real reason".  I like patches doing
> that.
>=20
> What I don't like is adding #include directives just so you can move
> typedefs out of typedefs.h: it slows down the build.  Granted, the four
> added by this patch are a drop in the bucket.  The point I'm trying to
> make is typedefs.h's purpose: it's for avoiding #include directives.
> Circular ones in particular, but others, too.

Yes, agreed, removing things from typedefs.h just to add lots of
#includes in other files is not really the best idea. I also dropped
this patch in v2 of my current PULL request because of this reason.
Phil, I suggest to simply drop this patch. What we maybe could do is to
split up typedefs.h per subsystem, so that we additionally have a
hw/arm/typedefs.h, hw/ppc/typedefs.h etc. in the end, then the
target-specific typedefs would not clutter the common qemu/typedefs.h
file anymore.

 Thomas
