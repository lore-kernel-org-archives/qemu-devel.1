Received: from eggs.gnu.org ([2001:4830:134:3::10]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7dN4-0001aj-Ga
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7dMz-0000ft-W8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:18:33 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:50111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7dMz-0000fN-Od
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:18:29 -0400
Received: by mail-io0-x241.google.com with SMTP id n137so3830015iod.6
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 01:18:29 -0700 (PDT)
References: <20171026013445.45605-1-aik@ozlabs.ru>
	<20171026071317.y3qjb2rsire25bz3@starbug-vm.ie.oracle.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8e81eed1-d16a-a289-f07e-4a083e232b79@ozlabs.ru>
Date: Thu, 26 Oct 2017 19:18:24 +1100
MIME-Version: 1.0
In-Reply-To: <20171026071317.y3qjb2rsire25bz3@starbug-vm.ie.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
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
To: qemu-devel@nongnu.org, Darren Kenny <darren.kenny@oracle.com>

On 26/10/17 18:13, Darren Kenny wrote:
> Hi Alexey,
> 
> On Thu, Oct 26, 2017 at 12:34:45PM +1100, Alexey Kardashevskiy wrote:
>> The new git-submodule.sh script writes .git-submodule-status to
>> the source directory every time no matter what. This makes it conditional.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * fixed "status" branch too
>> ---
>> scripts/git-submodule.sh | 15 ++++++++++-----
>> 1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>> index d8fbc7e47e..ae038d2e58 100755
>> --- a/scripts/git-submodule.sh
>> +++ b/scripts/git-submodule.sh
>> @@ -23,16 +23,21 @@ then
>>     exit 1
>> fi
>>
>> +substat_tmp=$(mktemp)
>> +
>> case "$command" in
>> status)
>>     test -f "$substat" || exit 1
>> -    trap "rm -f ${substat}.tmp" EXIT
>> -    git submodule status $modules > "${substat}.tmp"
>> -    diff "${substat}" "${substat}.tmp" >/dev/null
>> -    exit $?
>> +    git submodule status $modules > "$substat_tmp"
>> +    diff "${substat_tmp}" "${substat}" > /dev/null
>>     ;;
>> update)
>>     git submodule update --init $modules 1>/dev/null 2>&1
>> -    git submodule status $modules > "${substat}"
>> +    git submodule status $modules > "$substat_tmp"
>> +    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
> 
> Maybe you intended this, but the diff output here will be output to
> the screen - if you don't mean this to happen you might want to
> redirect the output.


Well, if I do:

diff "${substat_tmp}" "${substat}" 1>/dev/null 2>&1 || mv "${substat_tmp}"
"${substat}"

mv: inter-device move failed: '/tmp/tmp.gfcsXCSv4W' to
'.git-submodule-status'; unable to remove target: Read-only file system


and with my current variant it is:


  GIT     ui/keycodemapdb dtc
1d0
<  558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
2a2
>  558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
mv: inter-device move failed: '/tmp/tmp.4ol9mymsZj' to
'.git-submodule-status'; unable to remove target: Read-only file system


which gives some clue about what is going on (I swapped 2 lines in
.git-submodule-status to trigger this).


> 
> From other lines it looks like you would prefer it wasn't output.
> 
>>     ;;
>> esac
>> +
>> +myret=$?
> 
> Any small change is likely to break the value of myret here.
> 
> You may want to put the above assignment as directly below the
> commands that you want to record as the exit status, and maybe
> initialize it before the case statement to the default value.
> 
> For example, if somehow (not sure it's possible today) $command was
> not one of the values in the case statement, the value of $? here
> would be the return value of mktemp, which may not be your
> intention.
> 
> 
>> +rm "${substat_tmp}" 2>/dev/null
> 
> Rather than doing this redirect, a simple rm -f will achieve what
> you want here - that is why makefiles tend to use it.

I really do not like shell :) I gave up to using "trap", seems doing the
right thing and no messing is needed with "exit".


diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index d8fbc7e47e..12f80c14a0 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -23,16 +23,18 @@ then
     exit 1
 fi

+substat_tmp=$(mktemp)
+trap "rm -f $substat_tmp" 0
+
 case "$command" in
 status)
     test -f "$substat" || exit 1
-    trap "rm -f ${substat}.tmp" EXIT
-    git submodule status $modules > "${substat}.tmp"
-    diff "${substat}" "${substat}.tmp" >/dev/null
-    exit $?
+    git submodule status $modules > "$substat_tmp"
+    diff "${substat_tmp}" "${substat}" > /dev/null
     ;;
 update)
     git submodule update --init $modules 1>/dev/null 2>&1
-    git submodule status $modules > "${substat}"
+    git submodule status $modules > "$substat_tmp"
+    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
     ;;
 esac


Is this good enough to repost?



ps. out of curiosity - your mail has "Mail-Followup-To" - is that intentional?


> 
> Thanks,
> 
> Darren.
> 
>> +exit $myret
>> -- 
>> 2.11.0
>>
>>


-- 
Alexey
