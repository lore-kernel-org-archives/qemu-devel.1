Received: from eggs.gnu.org ([2001:4830:134:3::10]:55139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8oGy-0000pc-R9
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 10:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8oGv-0002jB-Gk
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 10:09:08 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:56720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e8oGv-0002hZ-6h
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 10:09:05 -0400
Received: by mail-pf0-x243.google.com with SMTP id b85so8674280pfj.13
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 07:09:04 -0700 (PDT)
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-2-berrange@redhat.com>
	<f1716a0f-6c6d-7704-e628-3c4cfc1a6bf2@ozlabs.ru>
	<20171028204505.GA21304@redhat.com>
	<8f0324f3-a0c8-a4b0-357b-8b8ff7e75d08@ozlabs.ru>
	<20171029075727.GA21571@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a34b48cd-c112-7812-4e8a-2ba2db1a18e2@ozlabs.ru>
Date: Mon, 30 Oct 2017 01:08:56 +1100
MIME-Version: 1.0
In-Reply-To: <20171029075727.GA21571@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] build: allow setting a custom GIT
 binary for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On 29/10/17 18:57, Daniel P. Berrange wrote:
> On Sun, Oct 29, 2017 at 12:47:07PM +1100, Alexey Kardashevskiy wrote:
>> On 29/10/17 07:45, Daniel P. Berrange wrote:
>>> On Sat, Oct 28, 2017 at 12:53:50PM +1100, Alexey Kardashevskiy wrote:
>>>> On 28/10/17 00:14, Daniel P. Berrange wrote:
>>>>> Some users can't run a bare 'git' command, due to need for a transparent
>>>>> proxying solution such as 'tsocks'. This adds an argument to configure to
>>>>> let users specify such a thing:
>>>>>
>>>>>   ./configure --with-git="tsocks git"
>>>>>
>>>>> The submodule script is also updated to give the user a hint about using this
>>>>> flag, if we fail to checkout modules.
>>>>>
>>>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>>>> ---
>>>>>  Makefile                 |  4 ++--
>>>>>  configure                |  5 +++++
>>>>>  scripts/git-submodule.sh | 30 +++++++++++++++++++++++++-----
>>>>>  3 files changed, 32 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/Makefile b/Makefile
>>>>> index 9372742f86..4c9d0eaef2 100644
>>>>> --- a/Makefile
>>>>> +++ b/Makefile
>>>>> @@ -21,14 +21,14 @@ git-submodule-update:
>>>>>  ifeq (0,$(MAKELEVEL))
>>>>>    git_module_status := $(shell \
>>>>>      cd '$(SRC_PATH)' && \
>>>>> -    ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
>>>>> +    GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
>>>>>      echo $$?; \
>>>>>    )
>>>>>  
>>>>>  ifeq (1,$(git_module_status))
>>>>>  git-submodule-update:
>>>>>  	$(call quiet-command, \
>>>>> -          (cd $(SRC_PATH) && ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
>>>>> +          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
>>>>>            "GIT","$(GIT_SUBMODULES)")
>>>>>  endif
>>>>>  endif
>>>>> diff --git a/configure b/configure
>>>>> index 03547cea6a..65765968f3 100755
>>>>> --- a/configure
>>>>> +++ b/configure
>>>>> @@ -271,6 +271,7 @@ then
>>>>>  else
>>>>>      git_submodules=""
>>>>>  fi
>>>>> +git="git"
>>>>>  
>>>>>  # Don't accept a target_list environment variable.
>>>>>  unset target_list
>>>>> @@ -1294,6 +1295,8 @@ for opt do
>>>>>            error_exit "vhost-user isn't available on win32"
>>>>>        fi
>>>>>    ;;
>>>>> +  --with-git=*) git="$optarg"
>>>>> +  ;;
>>>>>    *)
>>>>>        echo "ERROR: unknown option $opt"
>>>>>        echo "Try '$0 --help' for more information"
>>>>> @@ -5338,6 +5341,7 @@ echo "local state directory   queried at runtime"
>>>>>  echo "Windows SDK       $win_sdk"
>>>>>  fi
>>>>>  echo "Source path       $source_path"
>>>>> +echo "GIT binary        $git"
>>>>>  echo "GIT submodules    $git_submodules"
>>>>>  echo "C compiler        $cc"
>>>>>  echo "Host C compiler   $host_cc"
>>>>> @@ -5528,6 +5532,7 @@ echo "extra_cxxflags=$EXTRA_CXXFLAGS" >> $config_host_mak
>>>>>  echo "extra_ldflags=$EXTRA_LDFLAGS" >> $config_host_mak
>>>>>  echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
>>>>>  echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
>>>>> +echo "GIT=$git" >> $config_host_mak
>>>>>  echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
>>>>>  
>>>>>  echo "ARCH=$ARCH" >> $config_host_mak
>>>>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>>>>> index 08932a35f0..c66567d409 100755
>>>>> --- a/scripts/git-submodule.sh
>>>>> +++ b/scripts/git-submodule.sh
>>>>> @@ -3,14 +3,19 @@
>>>>>  # This code is licensed under the GPL version 2 or later.  See
>>>>>  # the COPYING file in the top-level directory.
>>>>>  
>>>>> -set -e
>>>>> -
>>>>>  substat=".git-submodule-status"
>>>>>  
>>>>>  command=$1
>>>>>  shift
>>>>>  modules="$@"
>>>>>  
>>>>> +test -z "$GIT" && GIT=git
>>>>> +
>>>>> +error() {
>>>>> +    printf "$0: %s\n" "$*" >&2
>>>>> +    exit 1
>>>>> +}
>>>>> +
>>>>>  if test -z "$modules"
>>>>>  then
>>>>>      test -e $substat || touch $substat
>>>>> @@ -27,12 +32,27 @@ case "$command" in
>>>>>  status)
>>>>>      test -f "$substat" || exit 1
>>>>>      trap "rm -f ${substat}.tmp" EXIT
>>>>> -    git submodule status $modules > "${substat}.tmp"
>>>>> +    $GIT submodule status $modules > "${substat}.tmp"
>>>>> +    test $? -ne 0 && error "failed to query git submodule status"
>>>>>      diff "${substat}" "${substat}.tmp" >/dev/null
>>>>>      exit $?
>>>>>      ;;
>>>>>  update)
>>>>> -    git submodule update --init $modules 1>/dev/null
>>>>> -    git submodule status $modules > "${substat}"
>>>>> +    $GIT submodule update --init $modules 1>/dev/null
>>>>> +    if test $? -ne 0 ; then
>>>>> +        echo
>>>>> +        echo "Unable to automatically checkout GIT submodules '$modules'."
>>>>> +        echo "If you require use of an alternative GIT binary (for example to"
>>>>> +        echo "enable use of a transparent proxy), then please specify it by"
>>>>> +        echo "running configure by with the '--with-git' argument. e.g."
>>>>> +        echo
>>>>> +        echo " $ ./configure --with-git='tsocks git'"
>>>>> +        echo
>>>>> +        exit 1
>>>>> +    fi
>>>>> +    $GIT submodule status $modules > "${substat}"
>>>>> +    test $? -ne 0 && error "failed to save git submodule status"
>>>>
>>>>
>>>> The way I am testing it - I simply delete .git-submodule-status (I used to
>>>> change it but deleting works as well) and then I get:
>>>>
>>>> ./scripts/git-submodule.sh: 74: ./scripts/git-submodule.sh: cannot create
>>>> .git-submodule-status: Read-only file system
>>>>
>>>> because "git submodule update" returns 0 (as everything is up to date) but
>>>> updating status fails. Which is fine, I would just like to get a better
>>>> message as even after few days of reading this script, I do not remember in
>>>> what order I should pass submodules to scripts/git-submodule.sh. Yeah, I
>>>> can find it in output but even the name of script to run does not stick to
>>>> my brain :(
>>>>
>>>> Something like this:
>>>>
>>>> -    test $? -ne 0 && error "failed to save git submodule status"
>>>> +    test $? -ne 0 && error "\"$GIT submodule status $modules\" failed to
>>>> save git submodule status"
>>>
>>> Take a look at the 3rd patch - it now prints out the exact command you
>>> would need to run in the writable-source dir.
>>
>> For the message in 3/4 to show up, I need to 1) know about
>> --disable-git-update and 2) use it. My testcase is lot more common - I did
>> not use --disable-git-update, and a strange message about writing read-only
>> folder appears, exactly like when I started the conversation.
> 
> That isn't the behaviour I get with this patch series applied. I made my
> source dir readonly, and then tried a VPATH build and got the expected
> messages

I run ./scripts/git-submodule.sh on a server (where source directory is
writeable), them "rm .git-submodule-status", then run "Makefile" on a build
machine (which has the source directory mounted as read-only). I basically
recreate the situation where I was when I just discovered this brand new
./scripts/git-submodule.sh.

> 
>   ...snip....
>   GIT     ui/keycodemapdb
> error: could not lock config file .git/config: Permission denied
> error: could not lock config file .git/config: Permission denied
> fatal: Failed to register url for submodule path 'ui/keycodemapdb'


I added "set -x" to the script and this is what I got:

make: Entering directory '/home/aik/pbuild/qemu-fstn1-ppc64'
+ substat=.git-submodule-status
+ command=status
+ shift
+ maybe_modules=ui/keycodemapdb dtc
+ test -z git
+ test -z ui/keycodemapdb dtc
+ modules=
+ git submodule status ui/keycodemapdb
+ test 0 -eq 0
+ modules= ui/keycodemapdb
+ git submodule status dtc
+ test 0 -eq 0
+ modules= ui/keycodemapdb dtc
+ test -e .git
+ test -f .git-submodule-status
+ exit 1
  GIT     ui/keycodemapdb dtc
+ substat=.git-submodule-status
+ command=update
+ shift
+ maybe_modules=ui/keycodemapdb dtc
+ test -z git
+ test -z ui/keycodemapdb dtc
+ modules=
+ git submodule status ui/keycodemapdb
+ test 0 -eq 0
+ modules= ui/keycodemapdb
+ git submodule status dtc
+ test 0 -eq 0
+ modules= ui/keycodemapdb dtc
+ test -e .git
+ git submodule update --init ui/keycodemapdb dtc
+ test 0 -ne 0
./scripts/git-submodule.sh: 74: ./scripts/git-submodule.sh: cannot create
.git-submodule-status: Read-only file system
+ git submodule status ui/keycodemapdb dtc
+ test 2 -ne 0
+ error failed to save git submodule status
+ printf ./scripts/git-submodule.sh: %s\n failed to save git submodule status
./scripts/git-submodule.sh: failed to save git submodule status
+ exit 1
Makefile:40: recipe for target 'git-submodule-update' failed
make: *** [git-submodule-update] Error 1
make: *** Waiting for unfinished jobs....
make: Leaving directory '/home/aik/pbuild/qemu-fstn1-ppc64'


"git submodule update" does not fail, why would it - the submodules are up
to date.


> 
> Unable to automatically checkout GIT submodules ' ui/keycodemapdb'.
> If you require use of an alternative GIT binary (for example to
> enable use of a transparent proxy), then please specify it by
> running configure by with the '--with-git' argument. e.g.
> 
>  $ ./configure --with-git='tsocks git'
> 
> Alternatively you may disable automatic GIT submodule checkout
> with:
> 
>  $ ./configure --disable-git-update'
> 
> and then manually update submodules prior to running make, with:
> 
>  $ scripts/git-sbumodule.sh update  ui/keycodemapdb


I know that now, all I am asking is an error message to print exact command
to run...


> 
> make: *** [Makefile:40: git-submodule-update] Error 1
> 
> Regards,
> Daniel
> 


-- 
Alexey
