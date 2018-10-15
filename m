Received: from eggs.gnu.org ([2001:4830:134:3::10]:57619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCBWG-0004Bm-8Y
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCBWF-0004u2-DH
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:39:24 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-6-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <84df80ea-f9c8-f953-9e4d-f4af8351edf2@redhat.com>
Date: Mon, 15 Oct 2018 18:39:14 -0400
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: Different iterator behavior
 in Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 10/15/18 10:14 AM, Max Reitz wrote:
> In Python 3, several functions now return iterators instead of lists.
> This includes range(), items(), map(), and filter().  This means that if
> we really want a list, we have to wrap those instances with list().  On
> the other hand, sometimes we do just want an iterator, in which case we
> have sometimes used xrange() and iteritems() which no longer exist in
> Python 3.  Just change these calls to be range() and items(), which
> costs a bit of performance in Python 2, but will do the right thing in
> Python 3 (which is what is important).
> 
> In one instance, we only wanted the first instance of the result of a
> filter() call.  Instead of using next(filter()) which would work only in
> Python 3, or list(filter())[0] which would work everywhere but is a bit
> weird, this instance is changed to a single-line for with next() wrapped
> around, which works both in 2.7 and 3.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/044 | 12 ++++++------
>  tests/qemu-iotests/056 |  2 +-
>  tests/qemu-iotests/065 |  4 ++--
>  tests/qemu-iotests/124 |  4 ++--
>  tests/qemu-iotests/139 |  2 +-
>  tests/qemu-iotests/163 |  6 +++---
>  6 files changed, 15 insertions(+), 15 deletions(-)
> 

You have 2 files here which use xrange (which is a manageable size, and
whose occurrences involve a moderate size of items) to also consider:

if sys.version_info.major == 2:
   range = xrange

Defaulting to the Python 3 names, but behaving the same across Python 2
and 3.

To do the same for dict.iteritems() => dict.items() requires a lot more
code, so I'd stay away from it for now.  Also, it looks like most of
those dicts are small in size (**kwargs and the like).

Other than that suggestion,

Reviewed-by: Cleber Rosa <crosa@redhat.com>
