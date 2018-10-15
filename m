Received: from eggs.gnu.org ([2001:4830:134:3::10]:44000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCABV-0007cV-ES
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCABU-0006ha-IR
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:13:53 -0400
Date: Mon, 15 Oct 2018 18:13:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015211337.GF31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-8-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015141453.32632-8-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests: 'new' module replacement in
 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Oct 15, 2018 at 04:14:51PM +0200, Max Reitz wrote:
> iotest 169 uses the 'new' module to add methods to a class.  This module
> no longer exists in Python 3.  Instead, we can use a lambda.  Best of
> all, this works in 2.7 just as well.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/169 | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
> index f243db9955..e5614b159d 100755
> --- a/tests/qemu-iotests/169
> +++ b/tests/qemu-iotests/169
> @@ -23,7 +23,6 @@ import iotests
>  import time
>  import itertools
>  import operator
> -import new
>  from iotests import qemu_img
>  
>  
> @@ -144,7 +143,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>  
>  def inject_test_case(klass, name, method, *args, **kwargs):
>      mc = operator.methodcaller(method, *args, **kwargs)
> -    setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
> +    setattr(klass, 'test_' + name, lambda self: mc(self))

The "lambda self: mc(self)" expression looks weird and
unnecessary at first look, but I have just confirmed that this
doesn't work:

    setattr(klass, 'test_' + name, mc)

Probably because the methodcaller object won't automatically
become a instance method after the TestCase class is
instantiated.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>  
>  for cmb in list(itertools.product((True, False), repeat=4)):
>      name = ('_' if cmb[0] else '_not_') + 'persistent_'
> -- 
> 2.17.1
> 

-- 
Eduardo
