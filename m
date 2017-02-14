Received: from eggs.gnu.org ([2001:4830:134:3::10]:38926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdelG-0007yP-MH
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdelC-0000xK-Ih
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:11:22 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdelC-0000wz-C3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:11:18 -0500
Received: by mail-wm0-x234.google.com with SMTP id v77so19502537wmv.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:11:18 -0800 (PST)
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-2-alex.bennee@linaro.org>
	<20170214142204.GA20715@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170214142204.GA20715@lemon.lan>
Date: Tue, 14 Feb 2017 15:11:36 +0000
Message-ID: <87d1ekvmc7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] tests/docker: add basic user
 mapping support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Tue, 02/14 10:07, Alex Bennée wrote:
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
>> Alternatively specifying USER will add the appropriate stanza when
>> building via the Makefile:
>>
>>   make docker-image-debian-armhf-cross USER=1
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>
>> ---
>> v2
>>   - write the useradd directly
>>   - change long option to --add-current-user
>> v3
>>   - images -> image's
>>   - add r-b
>>   - add USER to Makefile
>> ---
>>  tests/docker/Makefile.include |  2 ++
>>  tests/docker/docker.py        | 15 +++++++++++++--
>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index 3f15d5aea8..8db55e43aa 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -50,6 +50,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>>  	$(call quiet-command,\
>>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>> +		$(if $(USER),--add-current-user,) \
>>  		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
>>  		"BUILD","$*")
>>
>> @@ -99,6 +100,7 @@ docker:
>>  	@echo '                         (default is 1)'
>>  	@echo '    DEBUG=1              Stop and drop to shell in the created container'
>>  	@echo '                         before running the command.'
>> +	@echo '    USER=1		Add current user to docker image.'
>
> This is a bad choice of name, $USER is "$(id -un)", maybe
> ADD_CUR_USER?

Or we could just enable it by default? Is there a reason not to enable
the current user for these images?

>
> Fam
>
>
>>  	@echo '    NOCACHE=1            Ignore cache when build images.'
>>  	@echo '    EXECUTABLE=<path>    Include executable in image.'
>>


--
Alex Bennée
