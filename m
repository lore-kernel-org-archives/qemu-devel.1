Received: from eggs.gnu.org ([209.51.188.92]:35432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gji2k-00017r-3U
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gji2g-00089v-HV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:03:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gji2d-0007zy-18
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:03:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so1310103wmj.1
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 02:03:20 -0800 (PST)
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
	<403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
	<be75e72a-9f54-c9b5-4a1f-e87e28df8ba5@redhat.com>
	<87sgxtatod.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b24723e-5a27-f25f-76c1-f2f4e94757ba@redhat.com>
Date: Wed, 16 Jan 2019 11:03:15 +0100
MIME-Version: 1.0
In-Reply-To: <87sgxtatod.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 16/01/19 09:33, Markus Armbruster wrote:
> What problem exactly are we trying to solve here?
> To the best of my knowledge, typedefs.h has been working just fine for
> us, and I can't see why it shouldn't continue to work just fine.

Patches don't have to solve problems.  They can just help long-term
maintainability, highlight code smells, etc.  Nobody is saying
typedefs.h doesn't work.  But it's a tool, and including headers from
headers is also a tool.  Each tool has its purpose and it is useful to
question what are the exact purposes of the tools.

typedefs.h is useful to avoid rebuilding the world too often if a type
is used many times as a pointer, but rarely as a struct and rarely has
functions called on its instances.  This is already a relatively rare
case, but here we're talking about files that are included less than 20
times; many of which also already include hw/ssi/ssi.h for their own
business.  So we're hardly rebuilding anything more often, also because
hw/ssi/ssi.h is not really changing fast.

typedefs.h is also useful to avoid circular header inclusions.  Here
hw/ssi/ssi.h is clearly a toplevel include for the SSI subsystem.  I
agree that includes in a headers _can_ be painful, but sometimes they
also tell you a hierarchy of what uses what.  typedefs.h doesn't;
forward struct declarations also do, and I all but dislike using them in
headers (Thomas, can you send v2 of the HACKING patch?).

Therefore, typedefs.h is not particularly useful for SSIBus.  It doesn't
hurt much, if at all, to leave it in.  On the other hand, it also
doesn't hurt much if at all to remove it; it makes the SSI code a very
tiny little bit more self contained.

It may be that it's not particularly useful just because SSI is small;
for example I2CBus is also in typedefs.h and it's used a lot more, maybe
one day SSIBus will be the same.  In doubt, let's drop the patch---but I
think it's useful to have the discussion and there are cases that are
not controversial at all in Philippe's series.

Paolo
