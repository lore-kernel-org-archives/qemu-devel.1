Received: from eggs.gnu.org ([2001:4830:134:3::10]:40383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHFx-0007mf-Ex
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHFv-0007iG-Bv
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:35:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHFv-0007hg-3G
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:35:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-20-armbru@redhat.com>
	<151905557279.12376.11982412186477174825@sif>
Date: Fri, 23 Feb 2018 18:35:23 +0100
In-Reply-To: <151905557279.12376.11982412186477174825@sif> (Michael Roth's
	message of "Mon, 19 Feb 2018 09:52:52 -0600")
Message-ID: <87o9kfk3s4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 19/29] qapi: Make code-generating
 visitors use QAPIGen more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Quoting Markus Armbruster (2018-02-11 03:35:57)
>> The use of QAPIGen is rather shallow so far: most of the output
>> accumulation is not converted.  Take the next step: convert output
>> accumulation in the code-generating visitor classes.  Helper functions
>> outside these classes are not converted.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/commands.py   | 71 ++++++++++++++++------------------------
>>  scripts/qapi/common.py     | 13 ++++++++
>>  scripts/qapi/doc.py        | 74 ++++++++++++++++++++----------------------
>>  scripts/qapi/events.py     | 55 ++++++++++++-------------------
>>  scripts/qapi/introspect.py | 56 +++++++++++++-------------------
>>  scripts/qapi/types.py      | 81 +++++++++++++++++++---------------------------
>>  scripts/qapi/visit.py      | 80 +++++++++++++++++++--------------------------
>>  7 files changed, 188 insertions(+), 242 deletions(-)
>> 
>
> <snip>
>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 29d98ca934..31d2f73e7e 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -2049,3 +2049,16 @@ class QAPIGenDoc(QAPIGen):
>>      def _top(self, fname):
>>          return (QAPIGen._top(self, fname)
>>                  + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
>> +
>> +
>> +class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
>> +
>> +    def __init__(self, prefix, what, blurb, pydoc):
>> +        self._prefix = prefix
>> +        self._what = what
>> +        self._genc = QAPIGenC(blurb, pydoc)
>> +        self._genh = QAPIGenH(blurb, pydoc)
>> +
>> +    def write(self, output_dir):
>> +        self._genc.write(output_dir, self._prefix + self._what + '.c')
>> +        self._genh.write(output_dir, self._prefix + self._what + '.h')
>
> minor nit: since subclasses of QAPISchemaVisitor and
> QAPISchemaMonolithicCVisitor all rely on .write() now, should we declare it
> in the abstract QAPISchemaVisitor?

Perhaps.  If they had more in common, the case for an abstract super
class would be clearer.

> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks!
