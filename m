Received: from eggs.gnu.org ([2001:4830:134:3::10]:38770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSQZ-0003cu-NH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSQV-0005oq-F3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:02:15 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:46251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSQV-0005oE-8Q
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:02:11 -0400
Received: by mail-vk0-x244.google.com with SMTP id b14-v6so856914vke.13
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:02:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1061e94e-debe-a92c-a300-ebc68835fa56@amsat.org>
Date: Tue, 17 Jul 2018 13:02:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 00/16] various docker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, Laurent Vivier <laurent@vivier.eu>
Cc: cota@braap.org, qemu-devel@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> Hi,
> 
> Unfortunately this series grew a little while I was re-basing as I
> noticed a couple of bugs. An upstream change in debootstrap which I'd
> been happily using for Ubuntu images caused a breakage which I've
> hopefully now fixed:
> 
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=903657
> 
> However since I upgraded by devbox I hadn't clocked to the fact I
> should have been using the stable debootstrap anyway but our ugly
> shell version check failed to pick it up. That's now fixed and I can
> now bootstrap away.
> 
> I grabbed a couple of Philippe's patches while I was at it as they
> were relevant to the other changes. It does mean the un-reviewed count
> has gone up slightly:
> 
>   patch docker/base debian tricore on qemu debian9.patch
>   patch docker/split configure_qemu from build_qemu.patch
>   patch docker/move make check into check_qemu helper.patch
>   patch docker/gracefully skip check_qemu.patch
>   patch docker/Makefile.include don t include partial images.patch
>   patch docker/disable debian powerpc user cross.patch
>   patch docker/add test unit runner.patch
>   patch docker/add expansion for docker test FOO to Makefile.patch
>   patch docker/drop QEMU_TARGET check fallback in EXECUTABLE.patch
>   patch docker/add hint to docker.py check.patch
>   patch docker/add commentary to debian bootstrap.docker.patch
>   patch docker/ignore distro versioning of debootstrap.patch

[Note]

I hit:

$ make docker-binfmt-image-debian-powerpc-user
  BUILD   binfmt debian-powerpc-user (debootstrapped)
Cloning into './debootstrap.git'...
remote: Enumerating objects: 3262, done.
remote: Counting objects: 100% (3262/3262), done.
remote: Compressing objects: 100% (902/902), done.
remote: Total 3262 (delta 2353), reused 3245 (delta 2339)
Receiving objects: 100% (3262/3262), 531.08 KiB | 335.00 KiB/s, done.
Resolving deltas: 100% (2353/2353), done.
The command '/bin/sh -c /debootstrap/debootstrap --second-stage'
returned a non-zero code: 139
Traceback (most recent call last):
  File "tests/docker/docker.py", line 536, in <module>
    sys.exit(main())
  File "tests/docker/docker.py", line 533, in main
    return args.cmdobj.run(args, argv)
  File "tests/docker/docker.py", line 348, in run
    extra_files_cksum=cksum)
  File "tests/docker/docker.py", line 231, in build_image
    quiet=quiet)
  File "tests/docker/docker.py", line 158, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t',
'qemu:debian-powerpc-user', '-f',
'/tmp/docker_buildPNDAtz/tmpIVpPn7.docker', '/tmp/docker_buildPNDAtz']'
returned non-zero exit status 139
make: *** [tests/docker/Makefile.include:62:
docker-binfmt-image-debian-powerpc-user] Error 1

"returned non-zero exit status 139" seems to be qemu-user crashing for
not being statistically linked.
Once rebuilt after ./configure --static, it worked:

$ make docker-binfmt-image-debian-powerpc-user V=1
[...]
I: Extracting zlib1g...
ppc-linux-user/qemu-ppc had no associated libraries (static build?)
Sending build context to Docker daemon  226.5MB
Step 1/7 : FROM scratch
Step 2/7 : ADD . /
Step 3/7 : RUN sed -i 's/in_target mount/echo not for docker in_target
mount/g' /debootstrap/functions
Step 4/7 : RUN /debootstrap/debootstrap --second-stage
I: Installing core packages...
[...]
