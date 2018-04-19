Received: from eggs.gnu.org ([2001:4830:134:3::10]:51586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f91ol-0005cM-9X
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 01:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f91oi-0005ya-3g
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 01:09:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f91oh-0005yB-Uv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 01:09:08 -0400
References: <20180312131806.23209-1-stefanha@redhat.com>
	<43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
	<87604rp7im.fsf@dusky.pond.sub.org>
	<20180419020622.GF29462@lemon.usersys.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e89d215e-8845-5392-dde3-9eb8c6fb2281@redhat.com>
Date: Thu, 19 Apr 2018 07:08:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180419020622.GF29462@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 19.04.2018 04:06, Fam Zheng wrote:
> On Mon, 04/16 16:09, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 12.03.2018 14:18, Stefan Hajnoczi wrote:
>>>> Warn if files are added/renamed/deleted without MAINTAINERS file
>>>> changes.  This has helped me in Linux and we could benefit from this
>>>> check in QEMU.
>>>>
>>>> This patch is a manual cherry-pick of Linux commit
>>>> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warnin=
g on
>>>> file add/move/delete") by Joe Perches <joe@perches.com>.
>>>>
>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> We should really keep upstream's S-o-b intact.  I'd keep the whole
>> commit message intact:
>>
>>     From 7fb819c27bf47041a13feed93f86a15bdb2c681f Mon Sep 17 00:00:00 =
2001
>>     From: Joe Perches <joe@perches.com>
>>     Date: Wed, 6 Aug 2014 16:10:59 -0700
>>     Subject: [PATCH] checkpatch: emit a warning on file add/move/delet=
e
>>
>>     Whenever files are added, moved, or deleted, the MAINTAINERS file
>>     patterns can be out of sync or outdated.
>>
>>     To try to keep MAINTAINERS more up-to-date, add a one-time warning
>>     whenever a patch does any of those.
>>
>>     Signed-off-by: Joe Perches <joe@perches.com>
>>     Acked-by: Andy Whitcroft <apw@canonical.com>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>     [Cherry picked from Linux commit 13f1937ef33950b1112049972249e6191=
b82e6c9]
>>     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Created by running "git-format-patch -1 13f1937ef33" in the kernel,
>> feeding that to git-am (patch doesn't apply), patch -p1 your patch,
>> git-am --continue, git-commit --amend to add a backporting note and yo=
ur
>> S-o-b.
>>
>>>> ---
>>>> Note the 80-char lines are from upstream code.  Keep them as-is.
>>>>
>>>>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>> index d1fe79bcc4..d0d8f63d48 100755
>>>> --- a/scripts/checkpatch.pl
>>>> +++ b/scripts/checkpatch.pl
>>>> @@ -1177,6 +1177,7 @@ sub process {
>>>>  	our $clean =3D 1;
>>>>  	my $signoff =3D 0;
>>>>  	my $is_patch =3D 0;
>>>> +	my $reported_maintainer_file =3D 0;
>>>> =20
>>>>  	our @report =3D ();
>>>>  	our $cnt_lines =3D 0;
>>>> @@ -1379,6 +1380,24 @@ sub process {
>>>>  			}
>>>>  		}
>>>> =20
>>>> +# Check if MAINTAINERS is being updated.  If so, there's probably n=
o need to
>>>> +# emit the "does MAINTAINERS need updating?" message on file add/mo=
ve/delete
>>>> +		if ($line =3D~ /^\s*MAINTAINERS\s*\|/) {
>>>> +			$reported_maintainer_file =3D 1;
>>>> +		}
>>>> +
>>>> +# Check for added, moved or deleted files
>>>> +		if (!$reported_maintainer_file &&
>>>> +		    ($line =3D~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
>>>> +		     $line =3D~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
>>>> +		     ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\-]*)\s*\=
}/ &&
>>>> +		      (defined($1) || defined($2))))) {
>>>> +			$is_patch =3D 1;
>>>> +			$reported_maintainer_file =3D 1;
>>>> +			WARN("added, moved or deleted file(s), does MAINTAINERS need upd=
ating?\n" .
>>>> +				$herecurr);
>>>
>>> Could you please turn this into a notification instead of a warning? =
For
>>> rationale, please see the discussion of this patch last year:
>>>
>>> http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05753.html
[...]
> Patchew doesn't speak up unless there is an "error". Warnings and notes=
 are not
> complained about to keep good signal-to-noise ratio.

Ah, ok, didn't know that, that makes sense. Then I'm fine with the code
above. But while you're at it, could you please also include the other
patches that I posted last year, e.g. to warn on wrong utf-8 in the
message? We've had mojibaked commit messages a couple of times already,
and I hope that patch will help to reduce this a little bit...

 Thomas
