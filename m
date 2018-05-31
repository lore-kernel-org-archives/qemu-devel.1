Received: from eggs.gnu.org ([2001:4830:134:3::10]:40878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOTyL-0002c0-CQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOTyH-0006dq-B1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:14:57 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:45741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOTyH-0006da-3Q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:14:53 -0400
Received: by mail-wr0-x22d.google.com with SMTP id o12-v6so3111086wrm.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:14:53 -0700 (PDT)
References: <20180530110655.22022-1-alex.bennee@linaro.org>
	<20180530110655.22022-5-alex.bennee@linaro.org>
	<b69677f3-f87f-14f5-06c3-4ad68a68a191@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b69677f3-f87f-14f5-06c3-4ad68a68a191@amsat.org>
Date: Thu, 31 May 2018 21:14:50 +0100
Message-ID: <8736y71t1h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/8] docker: update Travis docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 05/30/2018 08:06 AM, Alex Benn=C3=A9e wrote:
>> This is still poorly documented by Travis but according to:
>>
>>   https://docs.travis-ci.com/user/common-build-problems/#Running-a-Conta=
iner-Based-Docker-Image-Locally
>>
>> their reference images are now hosted on Docker Hub. So we update the
>> FROM line to refer to the new default image. We also need a few
>> additional tweaks:
>>
>>   - re-enable deb-src lines for our build-dep install
>>   - add explicit PATH definition for tools
>
> I don't understand how this is related to QEMU testing, isn't it rather
> some Travis-ci bug? We don't need to use PhantomJS / Neo4j / Maven.

It's oddly constructed I'll grant you but I just set the path to what a
running image has. The normal image is started up with a full systemd
init whereas we drop directly into the shell.

>
>>   - force the build USER to be Travis
>>   - add clang to FEATURES for our test-clang machinery
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/dockerfiles/travis.docker | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/docke=
rfiles/travis.docker
>> index 605b6e429b..6e90f033d5 100644
>> --- a/tests/docker/dockerfiles/travis.docker
>> +++ b/tests/docker/dockerfiles/travis.docker
>> @@ -1,8 +1,11 @@
>> -FROM quay.io/travisci/travis-ruby
>> +FROM travisci/ci-garnet:packer-1512502276-986baf0
>>  ENV DEBIAN_FRONTEND noninteractive
>>  ENV LANG en_US.UTF-8
>>  ENV LC_ALL en_US.UTF-8
>> +RUN cat /etc/apt/sources.list | sed "s/# deb-src/deb-src/" >> /etc/apt/=
sources.list
>>  RUN apt-get update
>>  RUN apt-get -y build-dep qemu
>>  RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-au=
toreconf gdb strace lsof net-tools
>> -ENV FEATURES pyyaml
>> +ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j=
-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local=
/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/b=
in
>> +ENV FEATURES clang pyyaml
>> +USER travis
>>


--
Alex Benn=C3=A9e
