Received: from eggs.gnu.org ([2001:4830:134:3::10]:44792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYvOk-0007YP-Oh
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYvOh-0002sG-Ks
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:33:22 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:36091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYvOh-0002rP-G3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:33:19 -0400
Received: by mail-qt0-x231.google.com with SMTP id f1-v6so1149403qti.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:33:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180628164643.9668-1-f4bug@amsat.org>
	<20180628164643.9668-6-f4bug@amsat.org> <874lhlvg15.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5fe12e7-561e-dde8-a427-7191f2ec1292@amsat.org>
Date: Fri, 29 Jun 2018 12:33:14 -0300
MIME-Version: 1.0
In-Reply-To: <874lhlvg15.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 5/8] docker: Restrict the 'travis' job
 to the Travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 06/29/2018 11:11 AM, Alex Bennée wrote:> Philippe Mathieu-Daudé
<f4bug@amsat.org> writes:
> 
>> We can still run any test in Travis.
> 
> 
> I don't know about this one. The travis job isn't a fill in for real
> travis, but a way to work through the matrix. I don't think it needs to
> be restricted to any particular image.

I had forgotten the context of this one.

IIRC, at some point the time expensive "make docker-test" try to run the
'travis' script in all docker images available, and failed with the
Debian ones. I now tested again with a single image and it did not fail.

As said Fam in the other reply to this tread, the script is protected by
the 'requires pyyaml' which isn't installed on the Debian images:

$ make docker-travis@debian-armhf-cross
  BUILD   debian9
  BUILD   debian-armhf-cross
  COPY    RUNNER
    RUN travis in qemu:debian-armhf-cross
Prerequisite 'pyyaml' not present, skip
$ echo $?
0

Anyway you are correct, this test isn't mean for a Travis builder but
for a developer to check what matrix will be run on Travis, so don't
need any image restriction.

(patch dropped).

Regards,

Phil.

>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/Makefile.include | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index 91d9665517..7d9d568eee 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -99,11 +99,17 @@ docker-image-tricore-cross: docker-image-debian9
>>
>>  # Expand all the pre-requistes for each docker image and test combination
>>  $(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
>> -	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>> +	$(foreach t,$(DOCKER_TESTS), \
>>  		$(eval .PHONY: docker-$t@$i) \
>>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>> +		$(eval docker-test: docker-$t@$i) \
>>  	) \
>> -	$(foreach t,$(DOCKER_TESTS), \
>> +)
>> +# we only run Travis tests on the Travis image
>> +$(foreach i,travis, \
>> +	$(foreach t,$(DOCKER_TOOLS), \
>> +		$(eval .PHONY: docker-$t@$i) \
>> +		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>>  		$(eval docker-test: docker-$t@$i) \
>>  	) \
>>  )
> 
> 
> --
> Alex Bennée
> 
