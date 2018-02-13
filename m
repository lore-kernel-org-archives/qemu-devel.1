Received: from eggs.gnu.org ([2001:4830:134:3::10]:46721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcPl-0002MN-74
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcPf-0007mg-Uu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:22:34 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:43338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1elcPf-0007mW-PR
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:22:31 -0500
Received: by mail-qk0-f170.google.com with SMTP id i184so11772590qkf.10
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:22:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e989b2d3-cb5f-d378-763f-560174772b5b@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-11-armbru@redhat.com>
	<e989b2d3-cb5f-d378-763f-560174772b5b@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 16:22:30 +0100
Message-ID: <CAMxuvawNSxW9F84jZoAn2-Zxor_fK8P2s0ZksuTSCZWH1Vu1Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 10/29] qapi: Touch generated files only
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>

Hi

On Mon, Feb 12, 2018 at 8:48 PM, Eric Blake <eblake@redhat.com> wrote:
> On 02/11/2018 03:35 AM, Markus Armbruster wrote:
>>
>> A massive number of objects depends on QAPI-generated headers.  In my
>> "build everything" tree, it's roughly 4800 out of 5100.  This is
>> particularly annoying when only some of the generated files change,
>> say for a doc fix.
>>
>> Improve qapi-gen.py to touch its output files only if they actually
>> change.  Rebuild time for a QAPI doc fix drops from many minutes to a
>> few seconds.  Rebuilds get faster for certain code changes, too.  For
>> instance, adding a simple QMP event now recompiles less than 200
>> instead of 4800 objects.  But adding a QAPI type is as bad as ever;
>> we've clearly got more work to do.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   scripts/qapi/common.py | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 8290795dc1..2e58573a39 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -1951,9 +1951,16 @@ class QAPIGen(object):
>>               except os.error as e:
>>                   if e.errno != errno.EEXIST:
>>                       raise
>> -        f = open(os.path.join(output_dir, fname), 'w')
>> -        f.write(self._top(fname) + self._preamble + self._body
>> +        fd = os.open(os.path.join(output_dir, fname),
>> +                     os.O_RDWR | os.O_CREAT, 0666)
>
>
> patchew complained here for mingw; I'm not sure why.

python3 syntax error.
https://stackoverflow.com/questions/1837874/invalid-token-when-using-octal-numbers

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
