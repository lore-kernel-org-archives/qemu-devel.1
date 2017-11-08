Received: from eggs.gnu.org ([2001:4830:134:3::10]:44482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCFPK-0004F2-A5
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 20:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCFPH-0005or-4f
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 20:43:58 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eCFPG-0005oS-Tt
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 20:43:55 -0500
Received: by mail-pl0-x244.google.com with SMTP id g16so250533plj.1
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 17:43:54 -0800 (PST)
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-6-berrange@redhat.com>
	<d1704cf4-d3d4-cc69-df96-1298c11e1295@ozlabs.ru>
	<1dee5931-84f6-89e5-54e0-5a61cda23ccf@ozlabs.ru>
	<20171107101254.GA3213@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b063c284-4537-2f5b-7c69-969331520c3f@ozlabs.ru>
Date: Wed, 8 Nov 2017 12:43:47 +1100
MIME-Version: 1.0
In-Reply-To: <20171107101254.GA3213@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] build: delay check for empty git
 submodule list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/11/17 21:12, Daniel P. Berrange wrote:
> On Tue, Nov 07, 2017 at 04:13:27PM +1100, Alexey Kardashevskiy wrote:
>> On 07/11/17 15:12, Alexey Kardashevskiy wrote:
>>> On 04/11/17 02:33, Daniel P. Berrange wrote:
>>>> We short circuit the git submodule update when passed an empty module list.
>>>> This accidentally causes the 'status' command to write to the status file. The
>>>> test needs to be delayed into the individual commands to avoid this premature
>>>> writing of the status file.
>>>>
>>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>>> ---
>>>>  scripts/git-submodule.sh | 19 ++++++++++++-------
>>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>>>> index 2857fc57c4..90376a7dae 100755
>>>> --- a/scripts/git-submodule.sh
>>>> +++ b/scripts/git-submodule.sh
>>>> @@ -33,12 +33,6 @@ error() {
>>>>      exit 1
>>>>  }
>>>>  
>>>> -if test -z "$maybe_modules"
>>>> -then
>>>> -    test -e $substat || touch $substat
>>>> -    exit 0
>>>> -fi
>>>> -
>>>>  modules=""
>>>>  for m in $maybe_modules
>>>>  do
>>>> @@ -51,7 +45,7 @@ do
>>>>      fi
>>>>  done
>>>>  
>>>> -if ! test -e ".git"
>>>> +if test -n "$maybe_modules" && ! test -e ".git"
>>>
>>>
>>> $GIT_DIR should be checked too imho:
>>>
>>> if test -n "$maybe_modules" && ! test -e ".git" && test "$GIT_DIR" = ""
>>
>> Uff. Just this won't help, it is assumed everywhere that the ".git" folder
>> exists :(
>>
>> I was hoping to use "git --work-dir=" for the source tree to have a full
>> complete source tree to compile on a build machine but
>> "./scripts/git-submodule.sh status" is always called, no matter what.
> 
> If you need to pass extra args to 'git' this is supported already by


Missed that. No, I do not need extra args to git, I need configure and
others to stop assuming that the .git folder always exists instead of
calling $(GIT) to know that. "--work-dir" and other things can be
configured via git means or/and environment variables.



> this changeset. Just create a wrapper script containing whatever args
> you need to give git, and use "./configure --with-git=your-wrapper"
> 
>> I'd really love to have some way to disable git activities in Makefile...
> 
> I don't want to add that. We don't want to ever build if we detect that
> the submodules are at a different version to what we expect as it would
> cause obscure hard to diagnose build problems




-- 
Alexey
