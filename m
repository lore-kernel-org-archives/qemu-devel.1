Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1doxD8-0001C1-3B
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1doxD3-00064L-FK
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:39:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1doxD3-00063o-9D
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:39:01 -0400
Date: Mon, 4 Sep 2017 21:38:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170904213851.107ed8c8@Igors-MacBook-Pro.local>
In-Reply-To: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
References: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qdev_get_machine() can return something non-NULL
 but not TYPE_MACHINE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 4 Sep 2017 17:36:59 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> I just got bitten by qdev_get_machine()'s behaviour on the user-only
> emulators, where it can return something that isn't NULL and isn't
> an instance of TYPE_MACHINE either.
user-only shouldn't get to qdev_get_machine() at all,
issue probably in container_get().
I'd try to fix wrong user if possible and maybe add ifdef build failure
to qdev_get_machine() so it would not build in user mode.
 
> It looks like maybe this can happen in some cases in softmmu too,
> judging by the way that qdev_get_hotplug_handler() does an
> object_dynamic_cast() check that it really got back a TYPE_MACHINE.
As I recall only bus or machine provide hotplug_handler currently,
but it's possible to extend to other objects if we find use-case.

We could do static cast to machine instead dynamic there but
in hotplug case it will abort QEMU if error happens,
hence dynamic check to avoid be more resilient during hotplug.
(well, if qdev_get_machine() returns not machine during startup
we would be screwed anyways, but that should break much earlier)

> Is this intentional? Does anything rely on qdev_get_machine()
> returning something odd like this?
> 
> In the code I have which ran into this I can just make it do an
> object_dynamic_cast() check like the hotplug_handler code does,
> but if the current implementation is intentional we should
> probably document that this is what you're supposed to do.
> 
> thanks
> -- PMM
