Received: from eggs.gnu.org ([209.51.188.92]:52782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBLdq-0001HN-Iy
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBLdp-0002MT-GJ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:48:02 -0400
Date: Tue, 2 Apr 2019 17:47:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190402174749.71da1efe@redhat.com>
In-Reply-To: <e72befe5-c931-5c80-6769-12e1a8e7d4fa@linux.intel.com>
References: <1554194900-22817-1-git-send-email-like.xu@linux.intel.com>
	<871s2kejg1.fsf@dusky.pond.sub.org>
	<e72befe5-c931-5c80-6769-12e1a8e7d4fa@linux.intel.com>
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
To: Like Xu <like.xu@linux.intel.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 2 Apr 2019 21:09:39 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> On 2019/4/2 19:27, Markus Armbruster wrote:
> > Like Xu <like.xu@linux.intel.com> writes:
> >   
> >> This patch makes the remaining dozen or so uses of the global
> >> current_machine outside vl.c use qdev_get_machine() instead,
> >> and then make current_machine local to vl.c instead of global.
> >>
> >> Signed-off-by: Like Xu <like.xu@linux.intel.com>  
> > 
> > You effectively replace
> > 
> >      current_machine
> > 
> > by
> > 
> >      MACHINE(qdev_get_machine())
> > 
> > qdev_get_machine() uses container_get(), which has a side effect: any
> > path component that doesn't exist already gets created as "container"
> > object.  In case of qdev_get_machine(), that's just "/machine".
> > 
> > Creating "/machine" as "container" is of course wrong.  You therefore
> > must not use qdev_get_machine() before main() creates "/machine".  It
> > does like this:
> > 
> >      object_property_add_child(object_get_root(), "machine",
> >                                OBJECT(current_machine), &error_abort);
> > 
> > I recently had several cases of code rearrangements explode because the
> > reordered code called qdev_get_machine() too early.  Makes me rather
> > skeptical about this patch.  To be frank, I consider qdev_get_machine()
> > a trap for the unwary.  container_get(), too.
> > 
> > If we decide using it to make current_machine static a good idea anyway,
> > we need to check the new uses carefully to make sure they can't run
> > before main() creates "/machine".

maybe we can assert in qdev_get_machine() if machine hasn't been created yet?
with this at least it will be hard to misuse function or catch invalid users.
(but it still might miss some use cases/CLI options which are not tested)

> >   
> 
> Thanks for your comments and this issue may not exist in this patch.
> 
> I am curious when and where we would call qdev_get_machine() before 
> main() initializes current_machine and adds it to QOM store which is
> called very early.
