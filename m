Received: from eggs.gnu.org ([2001:4830:134:3::10]:51989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSRjQ-0002PO-OO
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSRjM-00078r-EL
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:12:10 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSRjM-00078B-2T
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:12:08 -0500
Received: by mail-oi1-x244.google.com with SMTP id x23so2610627oix.3
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20181129152552.14363-1-liq3ea@163.com>
	<87ftvj4shh.fsf@dusky.pond.sub.org>
In-Reply-To: <87ftvj4shh.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Nov 2018 19:11:55 +0000
Message-ID: <CAFEAcA9LtBfxmaLnwX_ZFoGxZd6fFAkjdqJKiwy-Ztmcs5aM3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Hot-pluggable device without ->unrealize() is
 highly suspect (was: [PATCH] hw: scsi: dc390: add device unrealize
 function)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, fam@euphon.net, Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 29 Nov 2018 at 19:03, Markus Armbruster <armbru@redhat.com> wrote:
>
> Li Qiang <liq3ea@163.com> writes:
>
> > Currently the dc390 device has no unrealize function. This
> > can cause memory leak when hotplug/unplug device. Also more
> > serious, it will trigger an assert when rehotplug.
> [...]
>
> When a hot-pluggable device doesn't have an ->unrealize() method, unplug
> is probably broken.  I think we should track down such devices for
> review.  Any takers?

Add an assert somewhere and catch it with the usual
"instantiate everything" qtest?

More generally, what is causing dc390 to be hotpluggable?
I can't see anything obvious in the class init. If we
have APIs where the default is "you get this weird thing
you weren't thinking about but it's broken because
you weren't thinking about it" then we will have a whole
class of bugs that we then need to squash device by device[*].
I think it would be better for devices to have to explicitly
opt in to implementing things like hotplug -- that way the
failure mode is just "this isn't hotpluggable", we can
report that helpfully to the user, and if anybody cares
they can add the support.

[*] Also currently true for migration support. We should
require devices to either provide a VMState or explicitly
say they have no state needing migration or explicitly
say they don't support migration, and then assert that
they do one or the other of those, rather than having the
default be "we'll allow migration but not migrate any
of the device's state".

thanks
-- PMM
