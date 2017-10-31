Received: from eggs.gnu.org ([2001:4830:134:3::10]:57777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e9NFs-0001tY-I1
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 23:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e9NFo-0005kg-J9
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 23:30:20 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:49365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e9NFo-0005js-BY
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 23:30:16 -0400
Received: by mail-pf0-x242.google.com with SMTP id i5so12691525pfe.6
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 20:30:15 -0700 (PDT)
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-2-berrange@redhat.com>
	<f1716a0f-6c6d-7704-e628-3c4cfc1a6bf2@ozlabs.ru>
	<20171028204505.GA21304@redhat.com>
	<8f0324f3-a0c8-a4b0-357b-8b8ff7e75d08@ozlabs.ru>
	<20171029075727.GA21571@redhat.com>
	<a34b48cd-c112-7812-4e8a-2ba2db1a18e2@ozlabs.ru>
	<20171029162902.GA14433@redhat.com>
	<a3f3604c-4a6d-f99b-0542-f8a4d02a3c7f@ozlabs.ru>
	<20171030075244.GB31767@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8ad0a68b-f089-ff81-1d46-919c1b104cb5@ozlabs.ru>
Date: Tue, 31 Oct 2017 14:30:08 +1100
MIME-Version: 1.0
In-Reply-To: <20171030075244.GB31767@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
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

On 30/10/17 18:52, Daniel P. Berrange wrote:
> On Mon, Oct 30, 2017 at 10:49:01AM +1100, Alexey Kardashevskiy wrote:
>> On 30/10/17 03:29, Daniel P. Berrange wrote:
>>> On Mon, Oct 30, 2017 at 01:08:56AM +1100, Alexey Kardashevskiy wrote:
>>>>
>>>> I run ./scripts/git-submodule.sh on a server (where source directory is
>>>> writeable), them "rm .git-submodule-status", then run "Makefile" on a build
>>>> machine (which has the source directory mounted as read-only). I basically
>>>> recreate the situation where I was when I just discovered this brand new
>>>> ./scripts/git-submodule.sh.
>>>
>>> Don't rm the .git-submodule-status. That means 'make' thinks the modules
>>> are out of date.
>>>
>>> Just run 'scripts/git-submodules.sh ...mods..' on the writable source
>>> dir, and then run 'make' on the build machine.
>>>
>>>> I know that now, all I am asking is an error message to print exact command
>>>> to run...
>>>
>>> If you hadn't deleted the .git-submodule-status, it would have worked fine.
>>
>> No.
>>
>> I do this on a server:
>>
>> [vpl1 qemu]$ git co v2.10.0
>> At this point no .git-submodule-status is expected/required/exist.
>>
>> [vpl1 qemu]$ ssh aikhostos2 make -C /home/aik/pbuild/qemu-aikhostos2-ppc64/
>> -j24
>>
>> Configure succeeds, compiles just fine, it has been working like this for
>> years.
>>
>>
>> Now:
>>
>> [vpl1 qemu]$ git co git-submodule  (this is your stuff)
>> [vpl1 qemu]$ ssh aikhostos2 make -C /home/aik/pbuild/qemu-aikhostos2-ppc64/
>> -j24
>> touch: cannot touch ‘.git-submodule-status’: Read-only file system
>> make: Entering directory `/home/aik/pbuild/qemu-aikhostos2-ppc64'
>>   GEN     ppc64-softmmu/config-devices.mak.tmp
>> [...]
>>
>> ./scripts/git-submodule.sh: line 74: .git-submodule-status: Read-only file
>> system
>> ./scripts/git-submodule.sh: failed to save git submodule status
>> make: *** [git-submodule-update] Error 1
> 
> Oh I see, the git submodules list is empty because you have a previous
> built source tree, so its shortcircuiting the extra check I added. Tihs
> is easy enough to address


btw why is the name "git-submodule.sh", not update-submodule.sh or
update-git-submodule.sh on a par with update-linux-headers.sh?




-- 
Alexey
