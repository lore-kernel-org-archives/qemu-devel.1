Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e7dtQ-0000WA-LE
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e7dtL-00054V-NA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:52:00 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:24586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1e7dtL-00051Y-Fn
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:51:55 -0400
Date: Thu, 26 Oct 2017 09:51:47 +0100
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171026085147.xja2lh5s6tvu7je5@starbug-vm.ie.oracle.com>
References: <20171026013445.45605-1-aik@ozlabs.ru>
	<20171026071317.y3qjb2rsire25bz3@starbug-vm.ie.oracle.com>
	<8e81eed1-d16a-a289-f07e-4a083e232b79@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <8e81eed1-d16a-a289-f07e-4a083e232b79@ozlabs.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v2] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

On Thu, Oct 26, 2017 at 07:18:24PM +1100, Alexey Kardashevskiy wrote:
>On 26/10/17 18:13, Darren Kenny wrote:
>> Hi Alexey,
>>
>> On Thu, Oct 26, 2017 at 12:34:45PM +1100, Alexey Kardashevskiy wrote:
>>> The new git-submodule.sh script writes .git-submodule-status to
>>> the source directory every time no matter what. This makes it conditi=
onal.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>> Changes:
>>> v2:
>>> * fixed "status" branch too
>>> ---
>>> scripts/git-submodule.sh | 15 ++++++++++-----
>>> 1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>>> index d8fbc7e47e..ae038d2e58 100755
>>> --- a/scripts/git-submodule.sh
>>> +++ b/scripts/git-submodule.sh
>>> @@ -23,16 +23,21 @@ then
>>> =C2=A0=C2=A0=C2=A0 exit 1
>>> fi
>>>
>>> +substat_tmp=3D$(mktemp)
>>> +
>>> case "$command" in
>>> status)
>>> =C2=A0=C2=A0=C2=A0 test -f "$substat" || exit 1
>>> -=C2=A0=C2=A0=C2=A0 trap "rm -f ${substat}.tmp" EXIT
>>> -=C2=A0=C2=A0=C2=A0 git submodule status $modules > "${substat}.tmp"
>>> -=C2=A0=C2=A0=C2=A0 diff "${substat}" "${substat}.tmp" >/dev/null
>>> -=C2=A0=C2=A0=C2=A0 exit $?
>>> +=C2=A0=C2=A0=C2=A0 git submodule status $modules > "$substat_tmp"
>>> +=C2=A0=C2=A0=C2=A0 diff "${substat_tmp}" "${substat}" > /dev/null
>>> =C2=A0=C2=A0=C2=A0 ;;
>>> update)
>>> =C2=A0=C2=A0=C2=A0 git submodule update --init $modules 1>/dev/null 2=
>&1
>>> -=C2=A0=C2=A0=C2=A0 git submodule status $modules > "${substat}"
>>> +=C2=A0=C2=A0=C2=A0 git submodule status $modules > "$substat_tmp"
>>> +=C2=A0=C2=A0=C2=A0 diff "${substat_tmp}" "${substat}" || mv "${subst=
at_tmp}" "${substat}"
>>
>> Maybe you intended this, but the diff output here will be output to
>> the screen - if you don't mean this to happen you might want to
>> redirect the output.
>
>
>Well, if I do:
>
>diff "${substat_tmp}" "${substat}" 1>/dev/null 2>&1 || mv "${substat_tmp=
}"
>"${substat}"
>
>mv: inter-device move failed: '/tmp/tmp.gfcsXCSv4W' to
>'.git-submodule-status'; unable to remove target: Read-only file system
>
>
>and with my current variant it is:
>
>
>  GIT     ui/keycodemapdb dtc
>1d0
><  558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
>2a2
>>  558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
>mv: inter-device move failed: '/tmp/tmp.4ol9mymsZj' to
>'.git-submodule-status'; unable to remove target: Read-only file system
>
>

That's strange behaviour for adding a redirect... Maybe it's your
use of 1>/dev/null instead of just >/dev/null.

TBH, /tmp should not be read-only in a normally running system.

To avoid the redirect at all then maybe use 'diff -q' instead.

>which gives some clue about what is going on (I swapped 2 lines in
>.git-submodule-status to trigger this).
>
>
>>
>> From other lines it looks like you would prefer it wasn't output.
>>
>>> =C2=A0=C2=A0=C2=A0 ;;
>>> esac
>>> +
>>> +myret=3D$?
>>
>> Any small change is likely to break the value of myret here.
>>
>> You may want to put the above assignment as directly below the
>> commands that you want to record as the exit status, and maybe
>> initialize it before the case statement to the default value.
>>
>> For example, if somehow (not sure it's possible today) $command was
>> not one of the values in the case statement, the value of $? here
>> would be the return value of mktemp, which may not be your
>> intention.
>>
>>
>>> +rm "${substat_tmp}" 2>/dev/null
>>
>> Rather than doing this redirect, a simple rm -f will achieve what
>> you want here - that is why makefiles tend to use it.
>
>I really do not like shell :) I gave up to using "trap", seems doing the
>right thing and no messing is needed with "exit".
>
>
>diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>index d8fbc7e47e..12f80c14a0 100755
>--- a/scripts/git-submodule.sh
>+++ b/scripts/git-submodule.sh
>@@ -23,16 +23,18 @@ then
>     exit 1
> fi
>
>+substat_tmp=3D$(mktemp)
>+trap "rm -f $substat_tmp" 0
>+
> case "$command" in
> status)
>     test -f "$substat" || exit 1
>-    trap "rm -f ${substat}.tmp" EXIT
>-    git submodule status $modules > "${substat}.tmp"
>-    diff "${substat}" "${substat}.tmp" >/dev/null
>-    exit $?
>+    git submodule status $modules > "$substat_tmp"
>+    diff "${substat_tmp}" "${substat}" > /dev/null
>     ;;
> update)
>     git submodule update --init $modules 1>/dev/null 2>&1
>-    git submodule status $modules > "${substat}"
>+    git submodule status $modules > "$substat_tmp"
>+    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substa=
t}"
>     ;;
> esac
>
>
>Is this good enough to repost?

If the exit code is not important here, then it should be OK,
subject to my comments about using 'diff -q' instead.

If the exit code is important in this script I would still suggest
being explicit about it, by setting myret=3D0 before the case, and
then myret=3D$? after calls to diff, and finally an exit $myret.

>
>
>
>ps. out of curiosity - your mail has "Mail-Followup-To" - is that intent=
ional?

I'm using the default in Neomutt, which suggests that is should be
used to avoid duplicate e-mails when responding to lists.=20

   https://www.neomutt.org/guide/advancedusage.html#using-lists

I've not changed from the default behaviour, but maybe it's not how
people like to do it here... ;)

Thanks,

Darren.
>
>
>>
>> Thanks,
>>
>> Darren.
>>
>>> +exit $myret
>>> --=C2=A0
>>> 2.11.0
>>>
>>>
>
>
>--=20
>Alexey
>
