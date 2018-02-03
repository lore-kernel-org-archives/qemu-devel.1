Received: from eggs.gnu.org ([2001:4830:134:3::10]:35933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtoq-0002WT-Sz
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtol-0008Ud-Tz
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:09:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtol-0008Tr-Nv
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:09:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-10-armbru@redhat.com>
	<1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com>
Date: Sat, 03 Feb 2018 10:08:58 +0100
In-Reply-To: <1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 14:22:59 -0600")
Message-ID: <878tca4ez9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 09/21] qapi: Don't absolutize include
 file name in error messages
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
>> Error messages print absolute filenames of included files even gave a
>
> s/even gave/even when given/

I meant to write "even if the user gave".  Is that okay?

>> relative one on the command line:
>> 
>>      PYTHONPATH=scripts python -B tests/qapi-schema/test-qapi.py tests/qapi-schema/include-cycle.json
>>     In file included from tests/qapi-schema/include-cycle.json:1:
>>     In file included from /work/armbru/qemu/tests/qapi-schema/include-cycle-b.json:1:
>>     /work/armbru/qemu/tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cycle.json
>> 
>> Improve this to
>> 
>>     In file included from tests/qapi-schema/include-cycle.json:1:
>>     In file included from tests/qapi-schema/include-cycle-b.json:1:
>>     tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cycle.json
>
> Nice, and makes developing new qapi tests a little less painful since
> it's less modification to qapi-schema/*.err additions.

Probably not, as our make rule strips off $(SRC_PATH):

	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/$*.err -

I've kept that, because it might also occur in stack backtraces.  I
think.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py                | 12 ++++++------
>>  tests/qapi-schema/include-no-file.err |  2 +-
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
