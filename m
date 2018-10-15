Received: from eggs.gnu.org ([2001:4830:134:3::10]:44106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC9Gp-0007jn-Ed
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC9Gk-0007u1-4h
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:15:17 -0400
Date: Mon, 15 Oct 2018 17:15:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015201501.GD31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-9-mreitz@redhat.com>
	<a797c85a-97c8-37c8-2a39-7ce33478a425@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a797c85a-97c8-37c8-2a39-7ce33478a425@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: Modify imports for Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon, Oct 15, 2018 at 02:59:28PM -0400, Cleber Rosa wrote:
> 
> 
> On 10/15/18 10:14 AM, Max Reitz wrote:
> > There are two imports that need to be modified when running the iotests
> > under Python 3: One is StringIO, which no longer exists; instead, the
> > StringIO class comes from the io module, so import it from there.  The
> > other is the ConfigParser, which has just been renamed to configparser.
> > 
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  tests/qemu-iotests/iotests.py            | 8 ++++++--
> >  tests/qemu-iotests/nbd-fault-injector.py | 7 +++++--
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > index 7ca94e9278..a64ea90fb4 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -683,13 +683,17 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
> >  
> >      # We need to filter out the time taken from the output so that qemu-iotest
> >      # can reliably diff the results against master output.
> > -    import StringIO
> > +    if sys.version_info.major >= 3:
> > +        from io import StringIO
> > +    else:
> > +        from StringIO import StringIO
> > +
> >      if debug:
> >          output = sys.stdout
> >          verbosity = 2
> >          sys.argv.remove('-d')
> >      else:
> > -        output = StringIO.StringIO()
> > +        output = StringIO()
> >  
> >      logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
> >  
> > diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
> > index d45e2e0a6a..6b2d659dee 100755
> > --- a/tests/qemu-iotests/nbd-fault-injector.py
> > +++ b/tests/qemu-iotests/nbd-fault-injector.py
> > @@ -48,7 +48,10 @@ import sys
> >  import socket
> >  import struct
> >  import collections
> > -import ConfigParser
> > +if sys.version_info.major >= 3:
> > +    import configparser
> > +else:
> > +    import ConfigParser as configparser
> >  
> >  FAKE_DISK_SIZE = 8 * 1024 * 1024 * 1024 # 8 GB
> >  
> > @@ -225,7 +228,7 @@ def parse_config(config):
> >      return rules
> >  
> >  def load_rules(filename):
> > -    config = ConfigParser.RawConfigParser()
> > +    config = configparser.RawConfigParser()
> >      with open(filename, 'rt') as f:
> >          config.readfp(f, filename)
> >      return parse_config(config)
> > 
> 
> This may be a type of culture clash (on my side, due to not enough QEMU
> culture), but shouldn't this be applied before anything else on this series?
> 
> I mean, PATCH 1/9 is supposed to fix the reliability aspects of
> nbd-fault-injector under Python 3, but without this patch, it won't
> actually run on Python 3.

Both patches are required to make the code run on Python 3, and
they don't depend on each other.  So I think the order doesn't
matter.

But I think the order chosen by Max is slightly more intuitive:
having explicit mentions of Python 3 in the code would be
confusing if we didn't fix the compatibility issues on patches
1-7 first.

-- 
Eduardo
