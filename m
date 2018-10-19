Received: from eggs.gnu.org ([2001:4830:134:3::10]:47262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDb7M-0004Uq-Cy
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDb7L-0003h2-Hm
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:11:32 -0400
Date: Fri, 19 Oct 2018 17:11:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181019201121.GL31060@habkost.net>
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-9-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019191523.12157-9-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/9] iotests: Modify imports for Python 3
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

On Fri, Oct 19, 2018 at 09:15:22PM +0200, Max Reitz wrote:
> There are two imports that need to be modified when running the iotests
> under Python 3: One is StringIO, which no longer exists; instead, the
> StringIO class comes from the io module, so import it from there (and
> use the BytesIO class for Python 2).  The other is the ConfigParser,
> which has just been renamed to configparser.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py            | 13 +++++++++----
>  tests/qemu-iotests/nbd-fault-injector.py |  7 +++++--
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 7ca94e9278..ed91095505 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -29,6 +29,7 @@ import json
>  import signal
>  import logging
>  import atexit
> +import io
>  
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
>  import qtest
> @@ -681,15 +682,19 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
>      verify_platform(supported_oses)
>      verify_cache_mode(supported_cache_modes)
>  
> -    # We need to filter out the time taken from the output so that qemu-iotest
> -    # can reliably diff the results against master output.
> -    import StringIO
>      if debug:
>          output = sys.stdout
>          verbosity = 2
>          sys.argv.remove('-d')
>      else:
> -        output = StringIO.StringIO()
> +        # We need to filter out the time taken from the output so that
> +        # qemu-iotest can reliably diff the results against master output.
> +        if sys.version_info.major >= 3:
> +            output = io.StringIO()
> +        else:
> +            # StringIO() is for unicode strings, which is not what

Nit: I would change the comment to say "io.StringIO" instead of
"StringIO", to avoid confusion with StringIO.StringIO.

Not a big deal, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> +            # 2.x's test runner emits.
> +            output = io.BytesIO()
>  
>      logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
>  
> diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
> index d45e2e0a6a..6b2d659dee 100755
> --- a/tests/qemu-iotests/nbd-fault-injector.py
> +++ b/tests/qemu-iotests/nbd-fault-injector.py
> @@ -48,7 +48,10 @@ import sys
>  import socket
>  import struct
>  import collections
> -import ConfigParser
> +if sys.version_info.major >= 3:
> +    import configparser
> +else:
> +    import ConfigParser as configparser
>  
>  FAKE_DISK_SIZE = 8 * 1024 * 1024 * 1024 # 8 GB
>  
> @@ -225,7 +228,7 @@ def parse_config(config):
>      return rules
>  
>  def load_rules(filename):
> -    config = ConfigParser.RawConfigParser()
> +    config = configparser.RawConfigParser()
>      with open(filename, 'rt') as f:
>          config.readfp(f, filename)
>      return parse_config(config)
> -- 
> 2.17.1
> 

-- 
Eduardo
