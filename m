Received: from eggs.gnu.org ([2001:4830:134:3::10]:53439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cfjqU-0002mO-I6
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cfjqQ-00059f-LU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:01:22 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cfjqQ-000596-Co
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:01:18 -0500
Received: by mail-wr0-x230.google.com with SMTP id s27so12947842wrb.2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 01:01:17 -0800 (PST)
References: <20170216123456.28621-1-alex.bennee@linaro.org>
	<20170216123456.28621-2-alex.bennee@linaro.org>
	<622dafb3-11e0-92fd-f26d-13e096e8dda6@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <622dafb3-11e0-92fd-f26d-13e096e8dda6@amsat.org>
Date: Mon, 20 Feb 2017 09:01:21 +0000
Message-ID: <87k28lw80u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] tests/docker: add basic user
 mapping support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: famz@redhat.com, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Hi Alex,
>
> I first tried "make docker-image-debian-armhf-cross NOUSER=1 V=1"
> which worked fine, then "make docker-image-debian-armhf-cross
> NOUSER=0" but got a "Image is up to date." I thought I should have to
> remove the image manually so I typed "docker rmi
> qemu:debian-armhf-cross" and tried again but still no change in my
> tests/docker/dockerfiles/debian-armhf-cross.docker adding my username,
> then I reviewed your change in the Makefile and got it, setting NOUSER
> to '0' has the same behavior, it's just set. To build the image with
> my user I had to _not_ use the flag or use it unset "NOUSER=" and it
> worked like charm.

Ahh yes. I followed the same pattern as NOCACHE which does the same
thing. I've made it clearer:

	@echo '    NOUSER               Define to disable adding current user to containers passwd.'

>
>
> On 02/16/2017 09:34 AM, Alex Bennée wrote:
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
>>
>> All docker containers built will add the current user unless
>> explicitly disabled by specifying NOUSER when invoking the Makefile:
>>
>>   make docker-image-debian-armhf-cross NOUSER=1
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks

>
>> ---
>> v2
>>   - write the useradd directly
>>   - change long option to --add-current-user
>> v3
>>   - images -> image's
>>   - add r-b
>>   - add USER to Makefile
>> v4
>>   - s/USER/NOUSER/ and default to on
>>   - fix the add-user code to skip if user already setup (for chained images)
>> ---
>>  tests/docker/Makefile.include |  2 ++
>>  tests/docker/docker.py        | 16 ++++++++++++++--
>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index 3f15d5aea8..4778b27ca8 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -50,6 +50,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>>  	$(call quiet-command,\
>>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>> +		$(if $(NOUSER),,--add-current-user) \
>>  		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
>>  		"BUILD","$*")
>>
>> @@ -99,6 +100,7 @@ docker:
>>  	@echo '                         (default is 1)'
>>  	@echo '    DEBUG=1              Stop and drop to shell in the created container'
>>  	@echo '                         before running the command.'
>> +	@echo '    NOUSER=1		Disable adding current user to containers passwd.'
>>  	@echo '    NOCACHE=1            Ignore cache when build images.'
>>  	@echo '    EXECUTABLE=<path>    Include executable in image.'
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 37d83199e7..d277a2268f 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -25,6 +25,7 @@ import signal
>>  from tarfile import TarFile, TarInfo
>>  from StringIO import StringIO
>>  from shutil import copy, rmtree
>> +from pwd import getpwuid
>>
>>
>>  DEVNULL = open(os.devnull, 'wb')
>> @@ -149,13 +150,21 @@ class Docker(object):
>>          labels = json.loads(resp)[0]["Config"].get("Labels", {})
>>          return labels.get("com.qemu.dockerfile-checksum", "")
>>
>> -    def build_image(self, tag, docker_dir, dockerfile, quiet=True, argv=None):
>> +    def build_image(self, tag, docker_dir, dockerfile,
>> +                    quiet=True, user=False, argv=None):
>>          if argv == None:
>>              argv = []
>>
>>          tmp_df = tempfile.NamedTemporaryFile(dir=docker_dir, suffix=".docker")
>>          tmp_df.write(dockerfile)
>>
>> +        if user:
>> +            uid = os.getuid()
>> +            uname = getpwuid(uid).pw_name
>> +            tmp_df.write("\n")
>> +            tmp_df.write("RUN id %s || useradd -u %d -U %s" %
>> +                         (uname, uid, uname))
>> +
>>          tmp_df.write("\n")
>>          tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
>>                       _text_checksum(dockerfile))
>> @@ -225,6 +234,9 @@ class BuildCommand(SubCommand):
>>                              help="""Specify a binary that will be copied to the
>>                              container together with all its dependent
>>                              libraries""")
>> +        parser.add_argument("--add-current-user", "-u", dest="user",
>> +                            action="store_true",
>> +                            help="Add the current user to image's passwd")
>>          parser.add_argument("tag",
>>                              help="Image Tag")
>>          parser.add_argument("dockerfile",
>> @@ -261,7 +273,7 @@ class BuildCommand(SubCommand):
>>                                         docker_dir)
>>
>>              dkr.build_image(tag, docker_dir, dockerfile,
>> -                            quiet=args.quiet, argv=argv)
>> +                            quiet=args.quiet, user=args.user, argv=argv)
>>
>>              rmtree(docker_dir)
>>
>>


-- 
Alex Bennée
