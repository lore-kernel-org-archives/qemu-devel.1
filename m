Received: from eggs.gnu.org ([209.51.188.92]:50163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGd5Q-0006i3-LL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGd5P-0006Pt-FE
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:26:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-2-git-send-email-like.xu@linux.intel.com>
Date: Wed, 17 Apr 2019 07:26:14 +0200
In-Reply-To: <1555315185-16414-2-git-send-email-like.xu@linux.intel.com> (Like
	Xu's message of "Mon, 15 Apr 2019 15:59:44 +0800")
Message-ID: <87bm1519u1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vl.c: refactor current_machine as
 non-global variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, like.xu@intel.com, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Like Xu <like.xu@linux.intel.com> writes:

> This patch makes the remaining dozen or so uses of the global
> current_machine outside vl.c use qdev_get_machine() instead,
> and then make current_machine local to vl.c instead of global.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

I'm afraid I dislike this one, too.

The patch does not reduce global state, it's merely MICAHI (make it
complicated and hide it).

It does not improve safety, it merely turns dereferences of null
current_machine into unwanted creation of "/machine" as container (ugh),
which the next patch then fixes up to assertion failure.

The only benefit I can see is you can't assign to current_machine
outside vl.c anymore.  Nobody ever did, thus complete non-issue.

If you want to hide global state without actually reducing it, create an
accessor function.  You can then use that to replace qdev_get_machine(),
getting rid of its surprising side effect.  *That* would be an
improvement I could get behind.

Better that *hiding* use of global state would be *eliminating* use of
global state: pass current_machine around.  This isn't always practical.
But where it is, the dependence on "machine created" becomes obvious in
the code.
