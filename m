Received: from eggs.gnu.org ([2001:4830:134:3::10]:41124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d842A-0001yf-EY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8427-0001xo-9a
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:14:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8427-0001xi-3u
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:14:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so13443291qte.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:14:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-3-f4bug@amsat.org>
	<20170509040115.GA18973@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <666da677-0975-a6fa-0d39-07d1d3165e97@amsat.org>
Date: Tue, 9 May 2017 09:14:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170509040115.GA18973@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/21] docker: add --include-file
 argument to 'build' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/09/2017 01:01 AM, Fam Zheng wrote:
> On Mon, 05/08 19:17, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/Makefile.include | 3 ++-
>>  tests/docker/docker.py        | 5 +++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index 03eda37bf4..c99ce702ea 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -51,7 +51,8 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>>  		$(if $(NOUSER),,--add-current-user) \
>> -		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
>> +		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE))\
>> +		$(if $(EXTRA_FILE),--include-file=$(EXTRA_FILE)),\
>>  		"BUILD","$*")
>>
>>  # Enforce dependancies for composite images
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 6ddc6e4c2a..90520e4bca 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -237,6 +237,9 @@ class BuildCommand(SubCommand):
>>                              help="""Specify a binary that will be copied to the
>>                              container together with all its dependent
>>                              libraries""")
>> +        parser.add_argument("--include-file", "-f",
>> +                            help="""Specify a file that will be copied to the
>> +                            container""")
>
> Is it more useful if it's '--include-files' that accepts multiple files? Or
> alternatively allow this option to be use multiple times:
>
>     -f foo -f bar -f ...

I agree, since I'm not confident with Python so I tried to touch as 
little as possible.

One iter I'm thinking about do a consistent rename with the 
"dockerfiles/%.docker -> docker.d/%/Dockerfile" pattern and adding git 
symlinks to required EXTRA_FILES in each dir, to avoid the call to 
docker.py and be able to build/push images on hub.docker.com directly.

> Similarly, should EXTRA_FILE be EXTRA_FILES or something?

Yes.

> We are already lacking this with --include-executable's documentation, but
> please also document "where" is it copied to in the container's filesystem.

Ok.

Thank for the review,

Phil.

> Fam
>
>>          parser.add_argument("--add-current-user", "-u", dest="user",
>>                              action="store_true",
>>                              help="Add the current user to image's passwd")
>> @@ -274,6 +277,8 @@ class BuildCommand(SubCommand):
>>              if args.include_executable:
>>                  _copy_binary_with_libs(args.include_executable,
>>                                         docker_dir)
>> +            if args.include_file:
>> +                _copy_with_mkdir(args.include_file, docker_dir)
>>
>>              argv += ["--build-arg=" + k.lower() + "=" + v
>>                          for k, v in os.environ.iteritems()
>> --
>> 2.11.0
>>
>
