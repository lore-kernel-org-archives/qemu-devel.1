Received: from eggs.gnu.org ([2001:4830:134:3::10]:36624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV1oD-0000QT-NV
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV1o9-00054k-NM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:35:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fV1o9-00054N-Fy
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:35:29 -0400
Date: Mon, 18 Jun 2018 18:35:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180618213526.GJ24764@localhost.localdomain>
References: <20180618175958.29073-1-armbru@redhat.com>
	<20180618175958.29073-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618175958.29073-2-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qapi: Open files with
 encoding='utf-8'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, tamiko@43-1.org, arfrever.fta@gmail.com

On Mon, Jun 18, 2018 at 07:59:57PM +0200, Markus Armbruster wrote:
> Python 2 happily reads UTF-8 files in text mode, but Python 3 requires
> either UTF-8 locale or an explicit encoding passed to open().  Commit
> d4e5ec877ca fixed this by setting the en_US.UTF-8 locale.  Falls apart
> when the locale isn't be available.
> 
> Matthias Maier and Arfrever Frehtes Taifersar Arahesis proposed to use
> binary mode instead, with manual conversion from bytes to str.  Works,
> but opening with an explicit encoding is simpler, so do that.
> 
> Since Python 2's open() doesn't support the encoding parameter, we
> need to suppress it with a version check.
> 
> Reported-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
> Reported-by: Matthias Maier <tamiko@43-1.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 2462fc0291..832f11438a 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -16,6 +16,7 @@ import errno
>  import os
>  import re
>  import string
> +import sys
>  from collections import OrderedDict
>  
>  builtin_types = {
> @@ -340,7 +341,10 @@ class QAPISchemaParser(object):
>              return None
>  
>          try:
> -            fobj = open(incl_fname, 'r')
> +            if sys.version_info[0] >= 3:
> +                fobj = open(incl_fname, 'r', encoding='utf-8')
> +            else:
> +                fobj = open(incl_fname, 'r')

I dislike the Python version check, but getting rid of it would
require rewriting the QAPI modules to not use the Python 2 str
type (that has different semantics from Python 3 str type).

The python-future package would help us write code for a single
file/string API instead of two different APIs, but it's not a
QEMU build dependency (yet?), so this patch is good enough for
now.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>

>          except IOError as e:
>              raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname))
>          return QAPISchemaParser(fobj, previously_included, info)
> @@ -1492,7 +1496,11 @@ class QAPISchemaEvent(QAPISchemaEntity):
>  class QAPISchema(object):
>      def __init__(self, fname):
>          self._fname = fname
> -        parser = QAPISchemaParser(open(fname, 'r'))
> +        if sys.version_info[0] >= 3:
> +            f = open(fname, 'r', encoding='utf-8')
> +        else:
> +            f = open(fname, 'r')
> +        parser = QAPISchemaParser(f)
>          exprs = check_exprs(parser.exprs)
>          self.docs = parser.docs
>          self._entity_list = []
> @@ -2006,7 +2014,10 @@ class QAPIGen(object):
>                  if e.errno != errno.EEXIST:
>                      raise
>          fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
> -        f = os.fdopen(fd, 'r+')
> +        if sys.version_info[0] >= 3:
> +            f = open(fd, 'r+', encoding='utf-8')
> +        else:
> +            f = os.fdopen(fd, 'r+')
>          text = (self._top(fname) + self._preamble + self._body
>                  + self._bottom(fname))
>          oldtext = f.read(len(text) + 1)
> -- 
> 2.17.1
> 
> 

-- 
Eduardo
