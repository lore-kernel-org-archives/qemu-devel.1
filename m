Received: from eggs.gnu.org ([209.51.188.92]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBzLc-0002kB-HM
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBzLb-00011p-KF
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:11:52 -0400
Date: Thu, 4 Apr 2019 12:05:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190404120533.427a2beb@redhat.com>
In-Reply-To: <CAFEAcA8ogWn50wWBttM2QpfQoZ8UYnXfG3NSkuSc8j8WOWt6FA@mail.gmail.com>
References: <1554194900-22817-1-git-send-email-like.xu@linux.intel.com>
	<871s2kejg1.fsf@dusky.pond.sub.org>
	<e72befe5-c931-5c80-6769-12e1a8e7d4fa@linux.intel.com>
	<20190402174749.71da1efe@redhat.com>
	<871s2k8jxo.fsf@dusky.pond.sub.org>
	<CAFEAcA8ogWn50wWBttM2QpfQoZ8UYnXfG3NSkuSc8j8WOWt6FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vl.c: make current_machine as
 non-global variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 2 Apr 2019 23:23:42 +0700
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 2 Apr 2019 at 23:13, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Igor Mammedov <imammedo@redhat.com> writes:  
> > > maybe we can assert in qdev_get_machine() if machine hasn't been created yet?
> > > with this at least it will be hard to misuse function or catch invalid users.
> > > (but it still might miss some use cases/CLI options which are not tested)  
> >
> > Good idea.  When my code created "/machine" as a container, debugging
> > the resulting crash took me a bit of time.  The assertion you propose
> > would've saved me some.  
> 
> One wrinkle to watch out for is code paths that are used in the
> linux-user emulator, where there is no machine at all... For instance
> cpu_common_realizefn() handles this case by explicitly checking
> whether the thing it gets back from qdev_get_machine() is a
> TYPE_MACHINE or not.
this one can be solved by adding 'ignore_memory_transaction_failures'
property to the CPU class where it applies (I'm not sure why it's
in generic cpu code instead of ARM only) and then setting compat
property in affected boards code.

but looking at users qdev_get_machine() it's not the only place where it
would explode in *-user build, so it would need to be taken care of
as well.

> 
> thanks
> -- PMM
> 
