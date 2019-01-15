Received: from eggs.gnu.org ([209.51.188.92]:42831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjT3R-0005ta-92
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjT3P-00044Z-Pm
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:13 -0500
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
	<403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be75e72a-9f54-c9b5-4a1f-e87e28df8ba5@redhat.com>
Date: Tue, 15 Jan 2019 19:02:33 +0100
MIME-Version: 1.0
In-Reply-To: <403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 15/01/19 13:56, Thomas Huth wrote:
> Yes, agreed, removing things from typedefs.h just to add lots of
> #includes in other files is not really the best idea. I also dropped
> this patch in v2 of my current PULL request because of this reason.
> Phil, I suggest to simply drop this patch. What we maybe could do is to
> split up typedefs.h per subsystem, so that we additionally have a
> hw/arm/typedefs.h, hw/ppc/typedefs.h etc. in the end, then the
> target-specific typedefs would not clutter the common qemu/typedefs.h
> file anymore.

I disagree.  The *inclusions* of target-specific typedefs.h would then
clutter something.

For the (important, mind) case of circular includes, allowing struct in
prototypes pretty much solves the issues, and a subsystem-specific
typedefs.h is another solution according to maintainer's discretion.

In this case, however, keeping subsystems self-contained is a good
reason to apply the patch.  Having SSIBus in typedefs.h means that the
next SSI type has a higher chance of being added to typedefs.h even if
it's not necessary.

Sometimes we need to take patches that seem unnecessary in order to keep
the codebase tidy.  Think of the churn that was the introduction of
hw/SUBSYSTEM.  It was painful and it added all the complexity to the
Makefiles in order to support recursive Makefile.objs in our
not-that-recursive makefiles.  However, it made MAINTAINERS usable and
now, a few years later, few of us would probably be happy to go back to
the flat hw/ directory.

Paolo
