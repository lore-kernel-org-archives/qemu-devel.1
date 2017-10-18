Received: from eggs.gnu.org ([2001:4830:134:3::10]:38073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4efk-0000Jg-9u
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 23:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4efj-0002ER-7h
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 23:05:32 -0400
Date: Tue, 17 Oct 2017 23:05:20 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171018030520.GA17962@localhost.localdomain>
References: <cover.1508257445.git.jcody@redhat.com>
	<399631b6632f0a605339391ff76c90468ebd54ee.1508257445.git.jcody@redhat.com>
	<9eec2de6-5b7d-0450-8882-d2606d24fc0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eec2de6-5b7d-0450-8882-d2606d24fc0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu-iotests: refuse to run if
 TEST_DIR contains spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

On Tue, Oct 17, 2017 at 08:03:56PM -0500, Eric Blake wrote:
> On 10/17/2017 11:31 AM, Jeff Cody wrote:
> > Currently, not all qemu-iotests work if TEST_DIR has spaces, and they
> > also might not be safe.  Refuse to run if TEST_DIR in this case, at
> > least until all tests are fixed sometime in the future.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  tests/qemu-iotests/check | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > index e6b6ff7..e2163cc 100755
> > --- a/tests/qemu-iotests/check
> > +++ b/tests/qemu-iotests/check
> > @@ -102,6 +102,14 @@ if [ -z "$TEST_DIR" ]; then
> >          TEST_DIR=`pwd`/scratch
> >  fi
> >  
> > +case $TEST_DIR in
> > +    *[[:blank:]]*)
> > +        echo "The TEST_DIR pathname '$TEST_DIR' contains whitespace. "
> 
> Echoes a trailing space. Do we care?
> 

Heh, spurious whitespcae, a bit ironic, I suppose...

Might as well take care of it with a v6, along with expanding the tests as
you hint at below.

> > +        echo "This is currently unsupported by qemu-iotests"
> 
> Is it just whitespace, or should we also be wary of other shell
> metacharacters (such as quotes or glob characters)?  In test 197, I did
> an alternative check for anything that is not alphanumeric, -, or _ (and
> allowing / between names).

I know that '-' works, because for years my work directory has been called
"qemu-kvm".  I'm not sure about globbing characters like *, or quotes, but
probably not a bad idea to exclude them as well (although, someone that
uses '*' in their directory names is probably no stranger to data
catastrophe!).

> 
> > +        exit 1
> > +        ;;
> > +esac
> > +
> >  if [ ! -e "$TEST_DIR" ]; then
> >          mkdir "$TEST_DIR"
> >  fi
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
