Received: from eggs.gnu.org ([2001:4830:134:3::10]:44185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co332-0005A4-5Y
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co32z-00009W-1c
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co32y-000096-Pl
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:08:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-8-git-send-email-armbru@redhat.com>
	<1617dab3-b1cd-c24b-5084-e39af4683ed8@redhat.com>
Date: Wed, 15 Mar 2017 08:08:33 +0100
In-Reply-To: <1617dab3-b1cd-c24b-5084-e39af4683ed8@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 10:55:14 -0500")
Message-ID: <874lyvt3ta.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 07/47] qapi: Clean up build of
 generated documentation
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

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> Rename intermediate qemu-qapi.texi to qemu-qmp-qapi.texi to match its
>> user qemu-qmp-ref.texi, just like qemu-ga-qapi.texi matches
>> qemu-ga-ref.texi.
>> 
>> Build the intermediate .texi next to the sources and the final output
>> in docs/ instead of dumping them into the build root.
>> 
>> Fix version.texi dependencies so that only the targets that actually
>> need it depend on it.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  .gitignore             | 10 +++++-----
>>  Makefile               | 27 +++++++++++++++------------
>>  docs/qemu-qmp-ref.texi |  2 +-
>>  rules.mak              |  2 +-
>>  4 files changed, 22 insertions(+), 19 deletions(-)
>> 
>> diff --git a/.gitignore b/.gitignore
>> index 2849d75..0e99e6a 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -103,11 +103,11 @@
>>  /docs/qemu-ga-ref.txt
>
> [1]
>
>>  /docs/qemu-qmp-ref.html
>>  /docs/qemu-qmp-ref.txt
>> -docs/qemu-ga-ref.info*
>> -docs/qemu-qmp-ref.info*
>> -/qemu-ga-qapi.texi
>> -/qemu-qapi.texi
>> -/version.texi
>> +/docs/qemu-ga-ref.info*
>
> worth sorting this line up by [1]?

Fine with me, except I think we should either not mess with the order,
or go all the way, i.e. ...

>> +/docs/qemu-qmp-ref.info*
>> +/docs/qemu-ga-qapi.texi

... move this one, too.  Feeding to sort leads to this incremental
patch:

@@ -99,14 +99,14 @@
 /pc-bios/optionrom/kvmvapic.img
 /pc-bios/s390-ccw/s390-ccw.elf
 /pc-bios/s390-ccw/s390-ccw.img
+/docs/qemu-ga-qapi.texi
 /docs/qemu-ga-ref.html
+/docs/qemu-ga-ref.info*
 /docs/qemu-ga-ref.txt
+/docs/qemu-qmp-qapi.texi
 /docs/qemu-qmp-ref.html
-/docs/qemu-qmp-ref.txt
-/docs/qemu-ga-ref.info*
 /docs/qemu-qmp-ref.info*
-/docs/qemu-ga-qapi.texi
-/docs/qemu-qmp-qapi.texi
+/docs/qemu-qmp-ref.txt
 /docs/version.texi
 *.tps
 .stgit-*

>> +/docs/qemu-qmp-qapi.texi
>> +/docs/version.texi
>>  *.tps
>>  .stgit-*
>>  cscope.*
>> @@ -663,25 +663,28 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
>>  
>>  # documentation
>>  MAKEINFO=makeinfo
>> -MAKEINFOFLAGS=--no-split --number-sections
>> +MAKEINFOFLAGS=--no-split --number-sections -I docs
>
> Will this cause grief on any older makinfo versions (such as RHEL 6)?  I
> didn't test myself on those setups.  I guess if a buildbot doesn't flag
> you, it's okay.

RHEL-6 has texinfo 4.13, and its manual page documents -I.  No mention
in NEWS, which goes back to 2.2.

> The sorting issue is worth fixing, but trivial, so you can add:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
