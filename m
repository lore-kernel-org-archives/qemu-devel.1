Received: from eggs.gnu.org ([2001:4830:134:3::10]:47324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eDKJZ-0008Nx-G9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 20:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eDKJV-0004BR-9m
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 20:10:29 -0500
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:54678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eDKJU-0004B5-OA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 20:10:25 -0500
Received: by mail-pf0-x230.google.com with SMTP id n89so7829139pfk.11
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 17:10:24 -0800 (PST)
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
	<20171108130102.GS12670@redhat.com>
	<fd7bb230-bbe3-ce3c-3026-d3d51544a14a@ozlabs.ru>
	<20171110104135.GB30685@redhat.com>
	<a1d39dc8-72e1-55a6-7c36-4bbe8b6142fa@ozlabs.ru>
	<20171110142240.GC30685@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e5bb3da2-6098-917f-5ce0-1fa1a1986714@ozlabs.ru>
Date: Sat, 11 Nov 2017 12:10:16 +1100
MIME-Version: 1.0
In-Reply-To: <20171110142240.GC30685@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>

On 11/11/17 01:22, Daniel P. Berrange wrote:
> On Sat, Nov 11, 2017 at 12:46:36AM +1100, Alexey Kardashevskiy wrote:
>> On 10/11/17 21:41, Daniel P. Berrange wrote:
>>> On Fri, Nov 10, 2017 at 09:35:54PM +1100, Alexey Kardashevskiy wrote:
>>>> On 09/11/17 00:01, Daniel P. Berrange wrote:
>>>>> On Wed, Nov 08, 2017 at 09:26:01AM -0300, Philippe Mathieu-Daudé wrote:
>>>>>> On 11/08/2017 06:57 AM, Thomas Huth wrote:
>>>>>>>
>>>>>>> That automatic git submodule stuff now broke my workflow again. I
>>>>>>> usually keep the git repository on my laptop and then simply rsync the
>>>>>>> sources (without .git directories) to my target machine to compile it
>>>>>>> there. Used to work great for years. Now it's broken, the build process
>>>>>>> complains:
>>>>>>>
>>>>>>> GIT submodule checkout is out of date. Please run
>>>>>>>   scripts/git-submodule.sh update
>>>>>>> from the source directory checkout /home/thuth/devel/qemu
>>>>>>>
>>>>>>> Running "scripts/git-submodule.sh update" did not fix the issue at all -
>>>>>>> I first had to tinker with it for a while to find out that I simply have
>>>>>>> to delete ".git-submodule-status" in my git tree to fix the issue.
>>>>>>>
>>>>>>> I've got the feeling that all this submodule crap is constantly causing
>>>>>>> pain ... do we really need this? Can't we find another solution instead?
>>>>>>> Or at least stop modifying files automatically in the $SRC_PATH ?
>>>>>>
>>>>>> Also yesterday on IRC:
>>>>>>
>>>>>> <RaV3N> [...] I downloaded the qemu source from git and tried to compile
>>>>>> it. I am getting this:
>>>>>>
>>>>>> ./configure --static && make && sudo make install
>>>>>>  CC      ui/input-keymap.o
>>>>>> ui/input-keymap.c:8:10: fatal error: ui/input-keymap-linux-to-qcode.c:
>>>>>> No such file or directory
>>>>>
>>>>> I had a pull request merged yesterday later afternoon which possibly
>>>>> would address that problem, though hard hard to say for certain.
>>>>
>>>> wow, already? :(
>>>>
>>>> I still wonder why do not we checkout submodules into the build directory
>>>> and why .git-submodule-status is not there too...
>>>
>>> That simply isn't the way submodules work, they are inherently part of
>>> the source tree, and the status file reflects that too.
>>
>> Sorry, I am missing the point here. What precisely does prevent us from
>> checking out the required modules to the build directory and build them
>> there? git provides a submodule repository url and sha1 for the current
>> qemu branch.
> 
> The build directory should never contain any of your version controlled
> source, as that will get irretrievably lost when the build dir is purged.

I am not suggesting editing submodule sources from the build directory, I
am suggesting not building them from the source directory, in order to keep
them in sync, Makefile can rsync or "git push" them to the build directory.
Yeah, fairly ugly but still more correct than the current solution.

And again, .git-submodule-status is not a source file, what is it doing in
$SRC_PATH?

Now I cannot compile qemu pretty much 50% of time because of that
enhancement. In the today's episode:

ssh aikhostos2 cd /home/aik/pbuild/qemu-aikhostos2-ppc64/ ;
/home/aik/p/qemu/configure --target-list=ppc64-softmmu
--source-path=/home/aik/p/qemu/ --enable-debug --enable-debug-info
--disable-werror --disable-git-update --enable-trace-backend=log

All good. One detail:
capstone          git

ssh aikhostos2 make -C /home/aik/pbuild/qemu-aikhostos2-ppc64/ -j24

make: Entering directory `/home/aik/pbuild/qemu-aikhostos2-ppc64'
  GEN     ppc64-softmmu/config-devices.mak.tmp
mkdir -p dtc/libfdt
mkdir -p dtc/tests
  GEN     config-host.h
  GEN     qemu-options.def
make[1]: *** No rule to make target
`/home/aik/pbuild/qemu-aikhostos2-ppc64/capstone/libcapstone.a'.  Stop.
make: *** [subdir-capstone] Error 2
make: *** Waiting for unfinished jobs....
  GEN     ppc64-softmmu/config-devices.mak


How, why, where are all these nice warning messages? Ah, there they are
(added 'set -x' to the script):

+ substat=.git-submodule-status
+ command=status
+ shift
+ maybe_modules='ui/keycodemapdb dtc capstone'
+ test -z git
+ modules=
+ for m in '$maybe_modules'
+ git submodule status ui/keycodemapdb
+ test 128 = 0
+ echo 'warn: ignoring non-existent submodule ui/keycodemapdb'
+ for m in '$maybe_modules'
+ git submodule status dtc
+ test 128 = 0:m
+ echo 'warn: ignoring non-existent submodule dtc'
+ for m in '$maybe_modules'
+ git submodule status capstone
+ test 128 = 0
+ echo 'warn: ignoring non-existent submodule capstone'
+ test -n 'ui/keycodemapdb dtc capstone'
+ test -e .git
+ case "$command" in
+ test -z 'ui/keycodemapdb dtc capstone'
+ test -f .git-submodule-status
+ exit 1


I assume that 'warn' is not printed because of Makefile's 'quiet-command'.

And this fails because on the server the source directory is created with
'git worktree' which points to bare git repo outside of the source tree and
the git on that build machine has no idea about worktrees (the repo is
visible to the build machine).

[vpl1 ~]$ ssh -x aikhostos2 'cd p/qemu && pwd && git --version && ls -d
../qemu.git && git submodule status'
/home/aik/p/qemu
git version 1.8.3.1
../qemu.git
fatal: Not a git repository: /home/aik/p/qemu.git/worktrees/qemu


Again - ok, when I know what is the problem, I know how to fix it - simply
move .git away when running ./configure and make (as it also runs
./configure some time) - but the messages... Firstly ./configure decides
that 'capstone' comes from 'git', then it simply fails with no indication
why it went wrong.

Ha. I just found another workaround - I can do ./configure --with-git=false
and silently disable git updates. Pretty much pointing a gun to my leg,
ready to shoot.

We could just check git submodule status every build and print a warning if
it is out of sync but continue. This way I would look at the submodules
list and decide what to do.


-- 
Alexey
