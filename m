Received: from eggs.gnu.org ([2001:4830:134:3::10]:54931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBVBK-0003ZU-8A
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBVBH-00043S-0t
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:22:26 -0500
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:55379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBVBG-000433-QZ
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:22:22 -0500
Received: by mail-pf0-x22b.google.com with SMTP id 17so6423297pfn.12
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 16:22:22 -0800 (PST)
References: <20171103153333.6416-1-berrange@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c20a8639-8288-3525-2ebf-76681e2e9243@ozlabs.ru>
Date: Mon, 6 Nov 2017 11:22:15 +1100
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Various improvements/bugfixes to
 submodule handling
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

On 04/11/17 02:33, Daniel P. Berrange wrote:
> This short series of patches improves the reliability of the submodule
> handling to cope with various dev env scenarios that have since emerged
> 
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg06272.html
> 
> Changed in v3:
> 
>  - Avoid use of mktemp
>  - Use '=' instead of '==' (bashism) in conditional tests
>  - Fix problem with short-circuiting for empty submodule list
>  - Ensure help message is displayed on all errors
> 
> Daniel P. Berrange (5):
>   build: allow setting a custom GIT binary for transparent proxying
>   build: don't create temporary files in source dir
>   build: allow automatic git submodule updates to be disabled
>   build: don't fail if given a git submodule which does not exist
>   build: delay check for empty git submodule list
> 
>  Makefile                 | 15 ++++++++--
>  configure                | 12 ++++++++
>  scripts/git-submodule.sh | 72 ++++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 83 insertions(+), 16 deletions(-)


It is getting more complicated.

So, same setup,
git checkout v2.10.0
./configure --target-list=ppc64-softmmu
make

All good.
Then:

git checkout git-submodule (upstream + this patchset)
./configure --target-list=ppc64-softmmu

I see an error and educational page about --disable-git-update, good.
./configure --target-list=ppc64-softmmu --disable-git-update
make

Now I get:

GIT submodule checkout is out of date. Please run
  scripts/git-submodule.sh update ui/keycodemapdb dtc capstone
from the source directory checkout /home/aik/p/qemu

Good, as I wanted.
I do this on the server:
scripts/git-submodule.sh update ui/keycodemapdb dtc capstone

and repeat "make" on the build machine but get the very same error. Then I
add "set -x" to scripts/git-submodule.sh and see:

+ substat=.git-submodule-status
+ command=status
+ shift
+ maybe_modules=ui/keycodemapdb dtc capstone
+ test -z git
+ modules=
+ git submodule status ui/keycodemapdb
+ test 0 = 0
+ modules= ui/keycodemapdb
+ git submodule status dtc
+ test 0 = 0
+ modules= ui/keycodemapdb dtc
+ git submodule status capstone
+ test 0 = 0
+ modules= ui/keycodemapdb dtc capstone
+ test -n ui/keycodemapdb dtc capstone
+ test -e .git
+ test -z ui/keycodemapdb dtc capstone
+ test -f .git-submodule-status
+ git submodule status ui/keycodemapdb dtc capstone
+ CURSTATUS=-22ead3e0bfdb87516656453336160e0a37b066bf capstone
 558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
 10739aa26051a5d49d88132604539d3ed085e72e ui/keycodemapdb (heads/master)

+ cat .git-submodule-status
+ OLDSTATUS= 558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
 10739aa26051a5d49d88132604539d3ed085e72e ui/keycodemapdb (heads/master)

+ test -22ead3e0bfdb87516656453336160e0a37b066bf capstone
 558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
 10739aa26051a5d49d88132604539d3ed085e72e ui/keycodemapdb (heads/master) =
558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
 10739aa26051a5d49d88132604539d3ed085e72e ui/keycodemapdb (heads/master)

+ exit 1


What is that new module - capstone - about? It is not in the status file:

[vpl1 qemu]$ cat .git-submodule-status
 558cd81bdd432769b59bff01240c44f82cfb1a9d dtc (v1.4.4)
 10739aa26051a5d49d88132604539d3ed085e72e ui/keycodemapdb (heads/master)



-- 
Alexey
