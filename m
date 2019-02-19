Received: from eggs.gnu.org ([209.51.188.92]:35836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3k2-0001WA-Dp
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3k1-0007nG-7M
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:39:14 -0500
Date: Tue, 19 Feb 2019 12:38:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219113840.GK4727@localhost.localdomain>
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
	<28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
	<20190219075333.GA4727@localhost.localdomain>
	<d7a55ce9-a83c-12fe-fd16-d45dff67630a@redhat.com>
	<20190219093716.GF4727@localhost.localdomain>
	<6d9d1a3c-7310-3134-ea5c-a03d451b8982@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9d1a3c-7310-3134-ea5c-a03d451b8982@redhat.com>
Subject: Re: [Qemu-devel] Failing iotests in CI (was: Add a gitlab-ci file
 for Continuous Integration testing on Gitlab)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, berrange@redhat.com

Am 19.02.2019 um 11:11 hat Thomas Huth geschrieben:
> On 19/02/2019 10.37, Kevin Wolf wrote:
> > Am 19.02.2019 um 10:04 hat Thomas Huth geschrieben:
> >> On 19/02/2019 08.53, Kevin Wolf wrote:
> [...]
> >>> Which are the cases that fail for you with '--disable-tcg'?
> >>
> >> These tests are failing: 087 169 188 232 235 238
> > 
> > Hm, 087 and 232 just do something like:
> > 
> >     $QEMU_PROG -nodefaults -machine accel=qtest -nographic \
> >                -qmp stdio -serial none \
> >                ...some -drive and -object options...
> > 
> > This should be fine with --disable-tcg, I think?
> > 
> > 169 runs a VM, but I don't see anything that makes it use TCG.
> > 
> > 188 doesn't even run QEMU at all, it's only qemu-io. I don't see how
> > this could be possibly related to --disable-tcg.
> 
> 087 and 188 obviously simply lack a check for the required crypto
> support.

Ah, okay, I thought you meant your whole list fails because of
--disable-tcg. Makes sense then.

> 169 got killed via abort():
> 
> 169                [08:34:39] [08:34:46] [failed, exit status 1] - output mismatch (see 169.out.bad)
> --- /builds/huth/qemu/tests/qemu-iotests/169.out	2019-02-19 08:23:54.000000000 +0000
> +++ /builds/huth/qemu/tests/qemu-iotests/169.out.bad	2019-02-19 08:34:46.000000000 +0000
> @@ -1,5 +1,29 @@
> -....................
> +WARNING:qemu:qemu received signal 6: /builds/huth/qemu/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=mon,path=/tmp/qemu-iotests-quick-25045/tmpGQOExQ/qemua-13044-monitor.sock -mon chardev=mon,mode=control -display none -vga none -qtest unix:path=/tmp/qemu-iotests-quick-25045/qemua-13044-qtest.sock -machine accel=qtest -nodefaults -machine accel=qtest -drive if=virtio,id=drive0,file=/tmp/qemu-iotests-quick-25045/disk_a,format=qcow2,cache=writeback
> [...]
> 
> No clue why.

In order to debug failures like this, I usually enable core dumps.

> 232 is also strange, no idea what is going on here:
> 
> 232                [08:38:53] [08:38:56] - output mismatch (see 232.out.bad)
> --- /builds/huth/qemu/tests/qemu-iotests/232.out	2019-02-19 08:23:54.000000000 +0000
> +++ /builds/huth/qemu/tests/qemu-iotests/232.out.bad	2019-02-19 08:38:56.000000000 +0000
> @@ -21,13 +21,13 @@
>  NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>  NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>  
> -QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> -
> -QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
> +
> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
> +NODE_NAME: TEST_DIR/t.IMGFMT (file)

Do you run the tests as root? This messes with any tests that try to
test read-only cases because root can write to everything, no matter
what the permissions say.

> >> By the way, 235 and 238 also fail on my normal laptop with RHEL7:
> >> [...]
> >> Any ideas what might be going on here?
> > 
> > I think it's most likely that QEMU just prints an error message on
> > startup and exits.
> Right, I finally found the issue:
> 
> qemu-system-x86_64: -machine accel=kvm: No accelerator found
> 
> I apparently compiled my QEMU with --disable-kvm at one point in time and
> forgot to enable it later again. ==> These tests should really check whether
> KVM is available in QEMU before they blindly use this feature.

Ideally, they shouldn't use it at all.

Kevin
