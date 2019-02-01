Received: from eggs.gnu.org ([209.51.188.92]:60619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gphQV-00079I-O9
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gphQR-0005uO-LL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:36:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gphQQ-0005M9-8Z
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:36:43 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-5-lersek@redhat.com>
	<6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
	<f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
Message-ID: <74cf6f64-254f-1a15-4071-0b73daef02a6@redhat.com>
Date: Fri, 1 Feb 2019 23:35:49 +0100
MIME-Version: 1.0
In-Reply-To: <f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/31/19 19:55, Laszlo Ersek wrote:
> On 01/31/19 18:07, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/24/19 9:39 PM, Laszlo Ersek wrote:

>>> +# "build.sh" invokes the "build" utility of edk2 BaseTools. In any g=
iven edk2
>>> +# workspace, at most one "build" instance may be operating at a time=
. Therefore
>>> +# we must serialize the rebuilding of targets in this Makefile.
>>> +.NOTPARALLEL:
>>
>> Well this doesn't seem to improve my case :|
>>
>> You can test with:
>>
>> $ alias make=3D'make -j8 -l7.5'
>>
>> So you get:
>>
>> $ make print-MAKEFLAGS
>> MAKEFLAGS=3DrR -j8 -l7.5 --jobserver-auth=3D3,4
>
> I get something different (with make-3.82-23.el7.x86_64):
>
> MAKEFLAGS=3DRrl 7.5 - --jobserver-fds=3D3,4 -j
>
> Notably, the argument 8 of "-j" is dropped.
>
> Anyway, I think this is a side topic.
>
>
>> and this command fails:
>>
>> $ make -C tests/uefi-test-tools Build/bios-tables-test.x86_64.efi
>
> (1) How *exactly* does it fail for you?
>
> (2) What operating system and "make" are you using?
>
> Because, the command completes perfectly fine for me. (Just for this
> test, I rebased the v2 branch on top of current master, i.e. commit
> aefcd2836620, and re-tested there.)
>
> (3) Also, did you update all submodules first? (git submodule update
> --init --force)
>
> (4) IMPORTANT: did you make sure you didn't have an earlier
> *mis-built* BaseTools directory in the submodule? For that, run "make
> clean" in the QEMU project root. Note that "git clean -ffdx" will
> *not* clean submodules, when issued from the QEMU project root.

I've found the issue myself, through using an up to date Fedora 29 guest
for the build.

(a) On RHEL7, I got "make-3.82-23.el7.x86_64". On Fedora 29, it's
"make-4.2.1-10.fc29.x86_64". Note in particular "4.2", on Fedora.

(b) In the earlier discussion on help-make
<http://lists.gnu.org/archive/html/help-make/2019-01/msg00004.html>,
Paul Smith responded to me,

On 01/23/19 14:45, Paul Smith wrote:
> On Wed, 2019-01-23 at 11:24 +0100, Laszlo Ersek wrote:
>> In particular, "--jobserver-fds" is not documented in end-user
>> documentation, apparently, so I get a feeling this option could
>> change at any time, as an implementation detail of distributing jobs.
>
> In fact it DID change, in GNU make 4.2, to be --jobserver-auth.  At
> the same time this new option was published in the documentation and
> made an official part of the GNU make interface.

(c) That is, the version bump from RHEL7's make to Fedora29's make
triggered, in our testing, this change. This explains why

  make print-MAKEFLAGS

printed

  MAKEFLAGS=3DrR -j8 -l7.5 --jobserver-auth=3D3,4

for you, and returned

  MAKEFLAGS=3DRrl 7.5 - --jobserver-fds=3D3,4 -j

for me.

(d) The build *indeed* fails on Fedora29, with the following obscure
error:

> make[1]: *** read jobs pipe: Bad file descriptor.  Stop.
> make[1]: *** Waiting for unfinished jobs....

(e) The documentation that Paul referenced, after I found it, provided
the critical hint.

https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html

> If your tool determines that the --jobserver-auth option is available
> in MAKEFLAGS but that the file descriptors specified are closed, this
> means that the calling make process did not think that your tool was a
> recursive make invocation (e.g., the command line was not prefixed
> with a + character). [...]

This means that the inner (=3D edk2's) make process inherits the
"--jobserver-auth=3D3,4" option from the outer (=3D qemu's) make process,
through the MAKEFLAGS variable. However, it does not inherit the file
descriptors themselves! And the reason is that the outer make does not
believe that the recipe that invokes "build.sh" is in fact an (indirect)
recursive make invocation. Therefore the outer make never bothers
passing down the file descriptors for the jobserver pipe.

The documentation writes,

> [...] only command lines that make understands to be recursive
> invocations of make [...] will have access to the jobserver. When
> writing makefiles you must be sure to mark the command as recursive
> (most commonly by prefixing the command line with the + indicator
> [...]

(Also:

> Using the MAKE variable has the same effect as using a '+' character
> at the beginning of the recipe line.

This is why an explicit "+" is needed only infrequently; most recursive
invocations are performed via $(MAKE), and the outer make recognizes
that automatically).

(f) So, the solution is to prefix the "./build.sh" recipe with a "+"
sign, to mark it as "recursive":

> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Mak=
efile
> index 61d263861e..449b81d8ba 100644
> --- a/tests/uefi-test-tools/Makefile
> +++ b/tests/uefi-test-tools/Makefile
> @@ -87,7 +87,7 @@ Build/%.fat: Build/%.efi
>  .NOTPARALLEL:
>
>  Build/bios-tables-test.%.efi: build-edk2-tools
> -	./build.sh $(edk2_dir) BiosTablesTest $* $@
> +	+./build.sh $(edk2_dir) BiosTablesTest $* $@
>
>  build-edk2-tools:
>  	$(MAKE) -C $(edk2_dir)/BaseTools

This fixes the issue for me on Fedora 29, without breaking the behavior
on RHEL7.

I'll submit v3 later. Thank you for catching this error.

Laszlo
