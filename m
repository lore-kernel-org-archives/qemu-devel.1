Received: from eggs.gnu.org ([209.51.188.92]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghwiZ-00037a-Gj
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghwiP-0000Se-9b
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:21 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghwiO-0000Rv-Mj
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:12 -0500
Received: by mail-wr1-f47.google.com with SMTP id 96so15183246wrb.2
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:19:12 -0800 (PST)
References: <20190110205129.22851-1-pbonzini@redhat.com>
	<CAFEAcA8V+HNGS_8da2qHTAzj_Dxi8+s5xojq6dErRCpnC8ci_g@mail.gmail.com>
	<832b5ca4-c671-e6ce-b0dd-0c02f8d4ed7b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7c515dc1-3108-d62f-34d6-b0def0f5e951@redhat.com>
Date: Fri, 11 Jan 2019 14:19:09 +0100
MIME-Version: 1.0
In-Reply-To: <832b5ca4-c671-e6ce-b0dd-0c02f8d4ed7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v7 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 1/11/19 11:58 AM, Paolo Bonzini wrote:
> On 11/01/19 11:51, Peter Maydell wrote:
>> make: Entering directory
>> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>>   BUILD   debian9
>> The command '/bin/sh -c DEBIAN_FRONTEND=noninteractive eatmydata
>> apt install -y --no-install-recommends         bison
>> build-essential         ca-certificates         clang         flex
>>     gettext         git         perl         pkg-config         psmisc
>>         python         texinfo         $(apt-get -s build-dep qemu |
>> egrep ^Inst | fgrep '[all]' | cut -d\  -f2)' returned a non-zero code:
>> 100
>> Traceback (most recent call last):
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 563, in <module>
>>     sys.exit(main())
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 560, in main
>>     return args.cmdobj.run(args, argv)
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 376, in run
>>     extra_files_cksum=cksum)
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 254, in build_image
>>     quiet=quiet)
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 181, in _do_check
>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>   File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
>> 'qemu:debian9', '-f', '/tmp/docker_buildsLHwaa/tmpXGE1LW.docker',
>> '/tmp/docker_buildsLHwaa']' returned non-zero exit status 100
>> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
>> recipe for target 'docker-image-debian9' failed
>> make: *** [docker-image-debian9] Error 1
>> make: Leaving directory
>> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
> 
> Well, this time I absolutely cannot reproduce this...  can you try "make
> docker-image-debian9 V=1"?

I can not reproduce it neither :/

If this error is related to Docker cache, Alex noticed my patch merged
by Fam isn't enough and suggested a better fix in
20190110174516.21586-17-alex.bennee@linaro.org:

-- >8 --
diff --git a/tests/docker/dockerfiles/debian9.docker
b/tests/docker/dockerfiles/debian9.docker
index 154ae2a455..9b7e4523e2 100644
@@ -7,7 +7,13 @@
 # On its own you can't build much but the docker-foo-cross targets
 # build on top of the base debian image.
 #
-FROM debian:stretch-slim
+
+# This must be earlier than the snapshot date we are aiming for
+FROM debian:sid-20181011-slim
+
+# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
+ENV DEBIAN_SNAPSHOT_DATE "20181030"
+RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb
[check-valid-until=no]
\1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%"
/etc/apt/sources.list

---
