Received: from eggs.gnu.org ([2001:4830:134:3::10]:41540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1df0Ej-00039M-Pj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1df0Eg-0006aE-M4
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:51:37 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1df0Eg-0006Zi-Ee
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:51:34 -0400
Received: by mail-wm0-x229.google.com with SMTP id m85so1528546wma.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 01:51:34 -0700 (PDT)
References: <20170807153934.29477-1-alex.bennee@linaro.org>
	<20170807153934.29477-5-alex.bennee@linaro.org>
	<20170808014310.GP14780@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170808014310.GP14780@lemon>
Date: Tue, 08 Aug 2017 09:51:31 +0100
Message-ID: <87shh2v3vw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v3 4/6] docker: docker.py make
 --no-cache skip checksum test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Ma?= =?utf-8?Q?thieu-Daud=C3=A9?= <f4bug@amsat.org>


Fam Zheng <famz@redhat.com> writes:

> On Mon, 08/07 16:39, Alex Bennée wrote:
>> If you invoke with NOCACHE=1 we pass --no-cache in the argv to
>> docker.py but may still not force a rebuild if the dockerfile checksum
>> hasn't changed. By testing for its presence we can force builds
>> without having to manually remove the docker image.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  tests/docker/docker.py | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index ee40ca04d9..aab1648cc5 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -261,7 +261,8 @@ class BuildCommand(SubCommand):
>>          tag = args.tag
>>
>>          dkr = Docker()
>> -        if dkr.image_matches_dockerfile(tag, dockerfile):
>> +        if "--no-cache" not in argv and \
>> +           dkr.image_matches_dockerfile(tag, dockerfile):
>>              if not args.quiet:
>>                  print "Image is up to date."
>>          else:
>> --
>> 2.13.0
>>
>>
>
> NACK.
>
> Please add "--no-cache" to BuildCommand.args, and use args.no_cache.
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index ee40ca04d9..530bc62d40 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -251,6 +251,8 @@ class BuildCommand(SubCommand):
>          parser.add_argument("--add-current-user", "-u", dest="user",
>                              action="store_true",
>                              help="Add the current user to image's passwd")
> +        parser.add_argument("--no-cache", action="store_true",
> +                            help="Disable docker cache and checksum")
>          parser.add_argument("tag",
>                              help="Image Tag")
>          parser.add_argument("dockerfile",

Fair enough, I just didn't want to clash with what usually gets passed
directly to the docker command.


--
Alex Bennée
