Received: from eggs.gnu.org ([2001:4830:134:3::10]:43498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWgr-0006oa-IL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWgo-0007Uu-Ap
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:09:05 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:43725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWgo-0007Ua-4q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:09:02 -0400
Received: by mail-qk0-x22c.google.com with SMTP id h19-v6so18509902qkj.10
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 16:09:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
	<20180530110655.22022-5-alex.bennee@linaro.org>
	<b69677f3-f87f-14f5-06c3-4ad68a68a191@amsat.org>
	<8736y71t1h.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20d56636-9776-a4cc-f906-dc9f148aeea3@amsat.org>
Date: Thu, 31 May 2018 20:08:56 -0300
MIME-Version: 1.0
In-Reply-To: <8736y71t1h.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/8] docker: update Travis docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, agraf@suse.de, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com, famz@redhat.com, aurelien@aurel32.net

On 05/31/2018 05:14 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Hi Alex,
>>
>> On 05/30/2018 08:06 AM, Alex Bennée wrote:
>>> This is still poorly documented by Travis but according to:
>>>
>>>   https://docs.travis-ci.com/user/common-build-problems/#Running-a-Container-Based-Docker-Image-Locally
>>>
>>> their reference images are now hosted on Docker Hub. So we update the
>>> FROM line to refer to the new default image. We also need a few
>>> additional tweaks:
>>>
>>>   - re-enable deb-src lines for our build-dep install
>>>   - add explicit PATH definition for tools
>>
>> I don't understand how this is related to QEMU testing, isn't it rather
>> some Travis-ci bug? We don't need to use PhantomJS / Neo4j / Maven.
> 
> It's oddly constructed I'll grant you but I just set the path to what a
> running image has. The normal image is started up with a full systemd
> init whereas we drop directly into the shell.

OK, can you add a comment about it? (so we don't remove what seems
unrelated).

> 
>>
>>>   - force the build USER to be Travis
>>>   - add clang to FEATURES for our test-clang machinery
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  tests/docker/dockerfiles/travis.docker | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
>>> index 605b6e429b..6e90f033d5 100644
>>> --- a/tests/docker/dockerfiles/travis.docker
>>> +++ b/tests/docker/dockerfiles/travis.docker
>>> @@ -1,8 +1,11 @@
>>> -FROM quay.io/travisci/travis-ruby
>>> +FROM travisci/ci-garnet:packer-1512502276-986baf0
>>>  ENV DEBIAN_FRONTEND noninteractive
>>>  ENV LANG en_US.UTF-8
>>>  ENV LC_ALL en_US.UTF-8
>>> +RUN cat /etc/apt/sources.list | sed "s/# deb-src/deb-src/" >> /etc/apt/sources.list
>>>  RUN apt-get update
>>>  RUN apt-get -y build-dep qemu
>>>  RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
>>> -ENV FEATURES pyyaml

# Travis tools require PhantomJS / Neo4j / Maven accessible
# in their PATH (QEMU build won't access them).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>> +ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
>>> +ENV FEATURES clang pyyaml
>>> +USER travis
>>>
> 
> 
> --
> Alex Bennée
> 
