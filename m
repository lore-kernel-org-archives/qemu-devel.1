Received: from eggs.gnu.org ([2001:4830:134:3::10]:50188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cTRnd-0002cT-HI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cTRnZ-0002Uf-2Z
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:19:37 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cTRnY-0002Ts-JM
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:19:33 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r144so217307533wme.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:19:30 -0800 (PST)
References: <20161213132205.9114-1-alex.bennee@linaro.org>
	<20170117094953.GA6199@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170117094953.GA6199@lemon>
Date: Tue, 17 Jan 2017 11:19:26 +0000
Message-ID: <87ziiqszlt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] tests/docker: add basic user mapping
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: bobby.prani@gmail.com, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Tue, 12/13 13:22, Alex Bennée wrote:
>> Currently all docker builds are done by exporting a tarball to the
>> docker container and running the build as the containers root user.
>> Other use cases are possible however and it is possible to map a part
>> of users file-system to the container. This is useful for example for
>> doing cross-builds of arbitrary source trees. For this to work
>> smoothly the container needs to have a user created that maps cleanly
>> to the host system.
>>
>> This adds a -u option to the docker script so that:
>>
>>   DEB_ARCH=armhf DEB_TYPE=stable ./tests/docker/docker.py build \
>>     -u --include-executable=arm-linux-user/qemu-arm \
>>     debian:armhf ./tests/docker/dockerfiles/debian-bootstrap.docker
>>
>> Will build a container that can then be run like:
>>
>>   docker run --rm -it -v /home/alex/lsrc/qemu/risu.git/:/src \
>>     --user=alex:alex -w /src/ debian:armhf \
>>     sh -c "make clean && ./configure -s && make"
>
> Sorry for the late reply!

No worries - I only got back to work last week myself ;-)

>
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  tests/docker/docker.py                           | 19 +++++++++++++++++++
>>  tests/docker/dockerfiles/debian-bootstrap.docker |  3 +++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 37d83199e7..59baac6bae 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -12,6 +12,7 @@
>>  # the top-level directory.
>>
>>  import os
>> +import stat
>>  import sys
>>  import subprocess
>>  import json
>> @@ -25,6 +26,7 @@ import signal
>>  from tarfile import TarFile, TarInfo
>>  from StringIO import StringIO
>>  from shutil import copy, rmtree
>> +from pwd import getpwuid
>>
>>
>>  DEVNULL = open(os.devnull, 'wb')
>> @@ -225,6 +227,8 @@ class BuildCommand(SubCommand):
>>                              help="""Specify a binary that will be copied to the
>>                              container together with all its dependent
>>                              libraries""")
>> +        parser.add_argument("--user", "-u", action="store_true",
>> +                            help="Add the current user to images passwd")
>
> Maybe use --add-current-user for the full argument name?

Sounds good.

>
>>          parser.add_argument("tag",
>>                              help="Image Tag")
>>          parser.add_argument("dockerfile",
>> @@ -260,6 +264,21 @@ class BuildCommand(SubCommand):
>>                  _copy_binary_with_libs(args.include_executable,
>>                                         docker_dir)
>>
>> +            if args.user:
>> +                uid = os.getuid()
>> +                uname = getpwuid(uid).pw_name
>> +                scriptlet = docker_dir+"/setup_user.sh"
>> +
>> +                # write scriptlet
>> +                setup = open(scriptlet, "w")
>> +                setup.write("#!/bin/sh\n")
>> +                setup.write("useradd -u %d -U %s" % (uid, uname))
>> +                setup.close()
>> +
>> +                st = os.stat(scriptlet)
>> +                os.chmod(scriptlet,
>> +                         st.st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)
>
> Is it cleaner we inject commands into the docker file directly?

How do you mean? Running a second docker run command after we have built
the image?

IIRC I'd previously tried having a template approach where we took a
docker.in and generated a final template for the build but we abandoned
that approach.

>
>> +
>>              dkr.build_image(tag, docker_dir, dockerfile,
>>                              quiet=args.quiet, argv=argv)
>>
>> diff --git a/tests/docker/dockerfiles/debian-bootstrap.docker b/tests/docker/dockerfiles/debian-bootstrap.docker
>> index 3a9125e497..127782eedf 100644
>> --- a/tests/docker/dockerfiles/debian-bootstrap.docker
>> +++ b/tests/docker/dockerfiles/debian-bootstrap.docker
>> @@ -14,6 +14,9 @@ RUN sed -i 's/in_target mount/echo not for docker in_target mount/g' /debootstra
>>  # Run stage 2
>>  RUN /debootstrap/debootstrap --second-stage
>>
>> +# Do we want to tweak the user?
>> +RUN if test -e /setup_user.sh; then /setup_user.sh; fi
>
> If we do above, there is no need to manually add this in dockerfile.
>
>> +
>>  # At this point we can install additional packages if we want
>>  # Duplicate deb line as deb-src
>>  RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>> --
>> 2.11.0
>>
>>
>
> Fam


--
Alex Bennée
