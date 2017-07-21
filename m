Received: from eggs.gnu.org ([2001:4830:134:3::10]:51976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYYVP-00076h-4a
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYYVO-0003ds-5C
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:02:11 -0400
Date: Fri, 21 Jul 2017 15:01:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170721140155.GQ17693@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170721123325.GC18014@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
> > This is a follow up to a previous discussion about reported failures when
> > running some qemu-iotests.  Turns out the failures were due to missing
> > libraries, which in turn, reflected on the host build configuration.
> > 
> > This series introduces a tool that can check both host and target level
> > build configurations.  On top of that, it adds a function to to be used
> > on qemu-iotests.  Finally, as an example, it sets a test to be skipped
> > if the required feature is not enable on the host build configuration.
> > 
> > Cleber Rosa (3):
> >   scripts: introduce buildconf.py
> >   qemu-iotests: add _require_feature() function
> >   qemu-iotests: require CONFIG_LINUX_AIO for test 087
> > 
> >  scripts/buildconf.py         | 278 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/087       |   1 +
> >  tests/qemu-iotests/check     |   2 +
> >  tests/qemu-iotests/common.rc |   7 ++
> >  4 files changed, 288 insertions(+)
> > 
> 
> It should be possible to run iotests against any
> qemu/qemu-img/qemu-io/qemu-nbd binaries - even if no build root is
> available.

For sake of argument, two options for non-buildroot scenario

 - assume all features are present, so we're no worse than we are today.
 - install config.h (or same data in a structured format) to
   /usr/share/qemu so its available for query

Downside of 2 of course is that other non-iotests apps might start
to depend on it

> How about invoking qemu-img and tools to determine their capabilities?
> 
> At the beginning of ./check, query the qemu/qemu-img/qemu-io/qemu-nbd
> binaries for specific features.  This produces a set of available
> features and tests can say:
> 
>   _supported_feature aio_native
> 
> This feature can be checked by opening an image file:
> 
>   qemu-io --format raw --nocache --native-aio --cmd quit test.img

I think this is useful as a general approach, because there are bound
to be a number of features which are available at compile time, but
cannot actually be used at runtime. eg not every filesystem supports
O_DIRECT, even if we've built support for it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
