Received: from eggs.gnu.org ([2001:4830:134:3::10]:37464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVA7i-0005DN-C2
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVA7e-0001mZ-E8
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:28:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVA7e-0001lq-8A
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:28:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180618175958.29073-1-armbru@redhat.com>
	<20180618175958.29073-2-armbru@redhat.com>
	<20180618213526.GJ24764@localhost.localdomain>
Date: Tue, 19 Jun 2018 08:28:08 +0200
In-Reply-To: <20180618213526.GJ24764@localhost.localdomain> (Eduardo Habkost's
	message of "Mon, 18 Jun 2018 18:35:26 -0300")
Message-ID: <87tvpzz3wn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, tamiko@43-1.org, qemu-devel@nongnu.org, arfrever.fta@gmail.com

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Jun 18, 2018 at 07:59:57PM +0200, Markus Armbruster wrote:
>> Python 2 happily reads UTF-8 files in text mode, but Python 3 requires
>> either UTF-8 locale or an explicit encoding passed to open().  Commit
>> d4e5ec877ca fixed this by setting the en_US.UTF-8 locale.  Falls apart
>> when the locale isn't be available.
>> 
>> Matthias Maier and Arfrever Frehtes Taifersar Arahesis proposed to use
>> binary mode instead, with manual conversion from bytes to str.  Works,
>> but opening with an explicit encoding is simpler, so do that.
>> 
>> Since Python 2's open() doesn't support the encoding parameter, we
>> need to suppress it with a version check.
>> 
>> Reported-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
>> Reported-by: Matthias Maier <tamiko@43-1.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>> 
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 2462fc0291..832f11438a 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -16,6 +16,7 @@ import errno
>>  import os
>>  import re
>>  import string
>> +import sys
>>  from collections import OrderedDict
>>  
>>  builtin_types = {
>> @@ -340,7 +341,10 @@ class QAPISchemaParser(object):
>>              return None
>>  
>>          try:
>> -            fobj = open(incl_fname, 'r')
>> +            if sys.version_info[0] >= 3:
>> +                fobj = open(incl_fname, 'r', encoding='utf-8')
>> +            else:
>> +                fobj = open(incl_fname, 'r')
>
> I dislike the Python version check, but getting rid of it would
> require rewriting the QAPI modules to not use the Python 2 str
> type (that has different semantics from Python 3 str type).

The version check is ugly, but it has a property I rather like: when we
drop support for Python 2, the conditional becomes True, and partial
evaluation results in the Python 3 code we actually want.

> The python-future package would help us write code for a single
> file/string API instead of two different APIs, but it's not a
> QEMU build dependency (yet?), so this patch is good enough for
> now.

Please do not invest more than absolutely necessary in Python 2 support.
All such investment will turn into technical debt in less than two
years.  If you must invest, pick a solution that will result in less
technical debt.  We can accept local ugliness for that.

In my personal opinion, dumb ideas like supporting Python 2 this close
to its EOL ought to look ugly.

> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>

Uh, what does "Acked-by" add over "Reviewed-by"?
