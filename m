Received: from eggs.gnu.org ([2001:4830:134:3::10]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBwCi-0006RZ-K2
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 00:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBwCe-0005U2-KI
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 00:13:40 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:46480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBwCe-0005TH-C2
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 00:13:36 -0500
Received: by mail-io0-x243.google.com with SMTP id 101so838761ioj.3
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 21:13:35 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-6-berrange@redhat.com>
	<d1704cf4-d3d4-cc69-df96-1298c11e1295@ozlabs.ru>
Message-ID: <1dee5931-84f6-89e5-54e0-5a61cda23ccf@ozlabs.ru>
Date: Tue, 7 Nov 2017 16:13:27 +1100
MIME-Version: 1.0
In-Reply-To: <d1704cf4-d3d4-cc69-df96-1298c11e1295@ozlabs.ru>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/11/17 15:12, Alexey Kardashevskiy wrote:
> On 04/11/17 02:33, Daniel P. Berrange wrote:
>> We short circuit the git submodule update when passed an empty module list.
>> This accidentally causes the 'status' command to write to the status file. The
>> test needs to be delayed into the individual commands to avoid this premature
>> writing of the status file.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  scripts/git-submodule.sh | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>> index 2857fc57c4..90376a7dae 100755
>> --- a/scripts/git-submodule.sh
>> +++ b/scripts/git-submodule.sh
>> @@ -33,12 +33,6 @@ error() {
>>      exit 1
>>  }
>>  
>> -if test -z "$maybe_modules"
>> -then
>> -    test -e $substat || touch $substat
>> -    exit 0
>> -fi
>> -
>>  modules=""
>>  for m in $maybe_modules
>>  do
>> @@ -51,7 +45,7 @@ do
>>      fi
>>  done
>>  
>> -if ! test -e ".git"
>> +if test -n "$maybe_modules" && ! test -e ".git"
> 
> 
> $GIT_DIR should be checked too imho:
> 
> if test -n "$maybe_modules" && ! test -e ".git" && test "$GIT_DIR" = ""

Uff. Just this won't help, it is assumed everywhere that the ".git" folder
exists :(

I was hoping to use "git --work-dir=" for the source tree to have a full
complete source tree to compile on a build machine but
"./scripts/git-submodule.sh status" is always called, no matter what.

With this new and improved git-submodule.sh I have to have a separate
source folder per a building machine as different machines may or may not
have a required "dtc" installed so the correct "git submodule status" will
differ from machine to machine which is quite annoying and not really
necessary in everyday life.

As for now, "configure" tries to use the system libfdt and only if it is
not found, goes for git submodule.

I'd really love to have some way to disable git activities in Makefile...

-- 
Alexey
