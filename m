Received: from eggs.gnu.org ([209.51.188.92]:58153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGo0i-0005Lc-Fh
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGo0Y-0002vK-4q
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:06:06 -0400
Date: Wed, 17 Apr 2019 14:05:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190417170549.GB25134@habkost.net>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-2-git-send-email-like.xu@linux.intel.com>
	<87bm1519u1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm1519u1.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Like Xu <like.xu@linux.intel.com>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, like.xu@intel.com, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Wed, Apr 17, 2019 at 07:26:14AM +0200, Markus Armbruster wrote:
> Like Xu <like.xu@linux.intel.com> writes:
> 
> > This patch makes the remaining dozen or so uses of the global
> > current_machine outside vl.c use qdev_get_machine() instead,
> > and then make current_machine local to vl.c instead of global.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> 
> I'm afraid I dislike this one, too.
> 
> The patch does not reduce global state, it's merely MICAHI (make it
> complicated and hide it).
> 
> It does not improve safety, it merely turns dereferences of null
> current_machine into unwanted creation of "/machine" as container (ugh),
> which the next patch then fixes up to assertion failure.
> 
> The only benefit I can see is you can't assign to current_machine
> outside vl.c anymore.  Nobody ever did, thus complete non-issue.

The benefit I see is that we now have a single way to access the
existing global state instead of two.

> 
> If you want to hide global state without actually reducing it, create an
> accessor function.  You can then use that to replace qdev_get_machine(),
> getting rid of its surprising side effect.  *That* would be an
> improvement I could get behind.
> 
> Better that *hiding* use of global state would be *eliminating* use of
> global state: pass current_machine around.  This isn't always practical.
> But where it is, the dependence on "machine created" becomes obvious in
> the code.

I agree qdev_get_machine() has many issues.  I dislike
qdev_get_machine() a lot, and I think I had suggested we stop
using it and use current_machine instead.

But at least now we have one imperfect API instead of two
imperfect APIs.  I do think this makes future clean up work
easier.

-- 
Eduardo
