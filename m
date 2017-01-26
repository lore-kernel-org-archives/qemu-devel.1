Received: from eggs.gnu.org ([2001:4830:134:3::10]:35768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWkH9-0001ye-Go
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWkH4-00034l-Vc
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:39:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWkH4-00034f-NN
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:39:38 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95A7B624C8
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:39:38 +0000 (UTC)
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-6-git-send-email-thuth@redhat.com>
	<195c3d94-9a9c-6e48-954c-b2769691929e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <850aa48b-a5ea-782b-b245-5549ec5f08ea@redhat.com>
Date: Thu, 26 Jan 2017 14:39:35 +0100
MIME-Version: 1.0
In-Reply-To: <195c3d94-9a9c-6e48-954c-b2769691929e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/5] checkpatch: reduce MAINTAINERS
 update message frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 26.01.2017 14:28, Paolo Bonzini wrote:
>=20
>=20
> On 26/01/2017 14:11, Thomas Huth wrote:
>> This is a port of the following commit from the Linux kernel:
>>
>> commit e0d975b1b439c4fef58fbc306c542c94f48bb849
>> Author: Joe Perches <joe@perches.com>
>> Date:   Wed Dec 10 15:51:49 2014 -0800
>>
>>     checkpatch: reduce MAINTAINERS update message frequency
>>
>>     When files are being added/moved/deleted and a patch contains an u=
pdate to
>>     the MAINTAINERS file, assume it's to update the MAINTAINERS file c=
orrectly
>>     and do not emit the "does MAINTAINERS need updating?" message.
>>
>>     Reported by many people.
>>
>>     Signed-off-by: Joe Perches <joe@perches.com>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  scripts/checkpatch.pl | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index e1be7b3..555a5b6 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1300,6 +1300,12 @@ sub process {
>>  			}
>>  		}
>> =20
>> +# Check if MAINTAINERS is being updated.  If so, there's probably no =
need to
>> +# emit the "does MAINTAINERS need updating?" message on file add/move=
/delete
>> +		if ($line =3D~ /^\s*MAINTAINERS\s*\|/) {
>> +			$reported_maintainer_file =3D 1;
>> +		}
>> +
>>  # Check for added, moved or deleted files
>>  		if (!$reported_maintainer_file && !$in_commit_log &&
>>  		    ($line =3D~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
>>
>=20
> Maybe leave it as a warning given this change?

I think chances are high that it still pops up quite frequently with
false positives:

1) The above regex only triggers for patches that contain a diffstat. If
you run the script on patches without diffstat, you always get the
warning as soon as you add, delete or move a file, even if you update
the MAINTAINERS file in the same patch.

2) I think it is quite common in patch series to first introduce new
files in the first patches, and then update MAINTAINERS only once at the
end.

3) The MAINTAINERS file often covers whole folders with wildcard
expressions. So if you add/delete/rename a file within such a folder,
you don't need to update MAINTAINERS thanks to the wildcard.

I guess people might be annoyed if checkpatch.pl throws a warning in
these cases. So a "NOTE: ..." sounds more sane to me. But if you like,
we can also start with a WARNING first and only ease it if people start
to complain?

 Thomas
