Received: from eggs.gnu.org ([2001:4830:134:3::10]:53400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTqhl-0001AR-7e
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTqhk-0001mW-26
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:32:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTqhj-0001mM-Ss
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:32:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615044042.7928-1-tamiko@43-1.org>
	<20180615044042.7928-3-tamiko@43-1.org>
Date: Fri, 15 Jun 2018 17:31:57 +0200
In-Reply-To: <20180615044042.7928-3-tamiko@43-1.org> (Matthias Maier's message
	of "Thu, 14 Jun 2018 23:40:42 -0500")
Message-ID: <87602kysk2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: open files in binary mode and
 use explicit decoding/encoding in common.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Maier <tamiko@43-1.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

Matthias Maier <tamiko@43-1.org> writes:

> This is a different approach to fix the locale dependent encode/decode
> problem in common.py utilizing the binary read/write mode [1,2] and
> decode/encode with explicit UTF-8 encoding arguments [3].

Why can't we simply pass encoding='utf-8' to open()?

> This approach is preferred over the fix in commit d4e5ec877ca because it
> is (a) locale independent, and (b) does not depend on the en_US.UTF_8
> locale to be available.
>
> [1] https://docs.python.org/3.6/library/stdtypes.html#bytes.decode
> [2] https://docs.python.org/3.6/library/stdtypes.html#str.encode
> [3] https://docs.python.org/3/howto/unicode.html
>
> Signed-off-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
> Signed-off-by: Matthias Maier <tamiko@43-1.org>
> ---
>  scripts/qapi/common.py | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 2462fc0291..44270cd703 100644
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
> @@ -259,6 +260,8 @@ class QAPISchemaParser(object):
>          previously_included.append(os.path.abspath(fp.name))
>          self.incl_info = incl_info
>          self.src = fp.read()
> +        if sys.version_info[0] >= 3:
> +            self.src = self.src.decode("UTF-8")

If I understand 7.2.3. Standard Encodings[*] correctly, the canonical
name is "utf-8".  Let's use that.  Wait, it's the default, no need to
pass an argument.

>          if self.src == '' or self.src[-1] != '\n':
>              self.src += '\n'
>          self.cursor = 0
> @@ -340,7 +343,7 @@ class QAPISchemaParser(object):
>              return None
>  
>          try:
> -            fobj = open(incl_fname, 'r')
> +            fobj = open(incl_fname, 'rb')
>          except IOError as e:
>              raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname))
>          return QAPISchemaParser(fobj, previously_included, info)
> @@ -1492,7 +1495,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
>  class QAPISchema(object):
>      def __init__(self, fname):
>          self._fname = fname
> -        parser = QAPISchemaParser(open(fname, 'r'))
> +        parser = QAPISchemaParser(open(fname, 'rb'))
>          exprs = check_exprs(parser.exprs)
>          self.docs = parser.docs
>          self._entity_list = []
> @@ -2006,9 +2009,11 @@ class QAPIGen(object):
>                  if e.errno != errno.EEXIST:
>                      raise
>          fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
> -        f = os.fdopen(fd, 'r+')
> +        f = os.fdopen(fd, 'r+b')
>          text = (self._top(fname) + self._preamble + self._body
>                  + self._bottom(fname))
> +        if sys.version_info[0] >= 3:
> +            text = text.encode("UTF-8")

Likewise.

>          oldtext = f.read(len(text) + 1)
>          if text != oldtext:
>              f.seek(0)

[*] https://docs.python.org/3/library/codecs.html#standard-encodings
