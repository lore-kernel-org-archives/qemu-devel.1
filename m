Received: from eggs.gnu.org ([2001:4830:134:3::10]:34836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtl8-00009Y-DP
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtl5-00061y-5z
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:05:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtl4-00061P-Kz
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:05:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-9-armbru@redhat.com>
	<3195606a-d39c-63db-f5bd-bc258f8d6fd4@redhat.com>
Date: Sat, 03 Feb 2018 10:05:08 +0100
In-Reply-To: <3195606a-d39c-63db-f5bd-bc258f8d6fd4@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 13:42:24 -0600")
Message-ID: <87d11m4f5n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 08/21] qapi: Touch generated files only
 when they change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>> A massive number of objects depends on QAPI-generated headers.  In my
>> "build everything" tree, it's roughly 4500 out of 4800.  This is
>> particularly annoying when only some of the generated files change,
>> say for a doc fix.
>> 
>> Improve qapi-gen.py to touch its output files only if they actually
>> change.  Rebuild time for a QAPI doc fix drops from many minutes to a
>> few seconds.  Rebuilds get faster for certain code changes, too.  For
>> instance, adding a simple QMP event now recompiles less than 200
>> instead of 4500 objects.  But adding a QAPI type is as bad as ever; we
>> clearly got more work to do.
>
> The last phrase sounds quite colloquial.  It may have been intentional;
> but if not, s/we/we've/

I'll change it.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index cfa2671ca3..be0fcc548a 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -1944,9 +1944,16 @@ class QAPIGen(object):
>>              except os.error as e:
>>                  if e.errno != errno.EEXIST:
>>                      raise
>> -        f = open(os.path.join(output_dir, fname), 'w')
>> -        f.write(self.top(fname) + self._preamble + self._body
>> +        fd = os.open(os.path.join(output_dir, fname),
>> +                     os.O_RDWR | os.O_CREAT, 0666)
>> +        f = os.fdopen(fd, 'r+')
>> +        text = (self.top(fname) + self._preamble + self._body
>>                  + self.bottom(fname))
>> +        oldtext = f.read(len(text) + 1)
>> +        if text != oldtext:
>> +            f.seek(0)
>> +            f.truncate(0)
>> +            f.write(text)
>
> In-memory rewrite rather than playing games with a secondary file
> combined with the rename(2) syscall.  It means you're not atomic (an
> external reader has a window of time where they can see an incomplete
> version of the file).

Same as before.

>                        But I think make dependency rules mean we don't
> care - even in a parallel rule, as long as all clients depend on the
> timestamp file, and the timestamp file isn't updated until all our
> rewrites (if any) have settled, then we don't create any of those
> external readers that can find the window of incomplete contents.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
