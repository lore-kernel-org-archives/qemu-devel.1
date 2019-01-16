Received: from eggs.gnu.org ([209.51.188.92]:36458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjgdp-0006LH-Ao
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjgdn-00010N-5o
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:33:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
	<403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
	<be75e72a-9f54-c9b5-4a1f-e87e28df8ba5@redhat.com>
Date: Wed, 16 Jan 2019 09:33:06 +0100
In-Reply-To: <be75e72a-9f54-c9b5-4a1f-e87e28df8ba5@redhat.com> (Paolo
	Bonzini's message of "Tue, 15 Jan 2019 19:02:33 +0100")
Message-ID: <87sgxtatod.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 15/01/19 13:56, Thomas Huth wrote:
>> Yes, agreed, removing things from typedefs.h just to add lots of
>> #includes in other files is not really the best idea. I also dropped
>> this patch in v2 of my current PULL request because of this reason.
>> Phil, I suggest to simply drop this patch. What we maybe could do is to
>> split up typedefs.h per subsystem, so that we additionally have a
>> hw/arm/typedefs.h, hw/ppc/typedefs.h etc. in the end, then the
>> target-specific typedefs would not clutter the common qemu/typedefs.h
>> file anymore.
>
> I disagree.  The *inclusions* of target-specific typedefs.h would then
> clutter something.
>
> For the (important, mind) case of circular includes, allowing struct in
> prototypes pretty much solves the issues, and a subsystem-specific
> typedefs.h is another solution according to maintainer's discretion.
>
> In this case, however, keeping subsystems self-contained is a good
> reason to apply the patch.  Having SSIBus in typedefs.h means that the
> next SSI type has a higher chance of being added to typedefs.h even if
> it's not necessary.

typedefs.h churn appars to be a non-problem:

    $ git-log --oneline --since 'one year ago' include/qemu/typedefs.h 
    a98c370c46 typedefs: (Re-)sort entries alphabetically
    aec90730fb numa: Match struct to typedef name
    7cfda775e5 move ObjectClass to typedefs.h
    ea134caa08 typedefs: add QJSON
    201376cb9e typedefs: Remove PcGuestInfo from qemu/typedefs.h
    9f5c734d59 Typedef the subtypes of QObject in qemu/typedefs.h, too
    e70372fcaf lockable: add QemuLockable

> Sometimes we need to take patches that seem unnecessary in order to keep
> the codebase tidy.  Think of the churn that was the introduction of
> hw/SUBSYSTEM.  It was painful and it added all the complexity to the
> Makefiles in order to support recursive Makefile.objs in our
> not-that-recursive makefiles.  However, it made MAINTAINERS usable and
> now, a few years later, few of us would probably be happy to go back to
> the flat hw/ directory.

What problem exactly are we trying to solve here?

To the best of my knowledge, typedefs.h has been working just fine for
us, and I can't see why it shouldn't continue to work just fine.
