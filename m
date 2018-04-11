Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6DSw-0003bu-8U
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6DSt-0004Pt-Nk
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:59:02 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:56149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6DSt-0004PR-H0
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:58:59 -0400
Received: by mail-wm0-x244.google.com with SMTP id b127so3256187wmf.5
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 03:58:59 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-2-alex.bennee@linaro.org>
	<20180411085054.GC2785@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180411085054.GC2785@lemon.usersys.redhat.com>
Date: Wed, 11 Apr 2018 11:58:56 +0100
Message-ID: <87y3hu3t73.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 01/24] configure: add test for docker
 availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, cota@braap.org


Fam Zheng <famz@redhat.com> writes:

> On Tue, 04/10 20:38, Alex Benn=C3=A9e wrote:
>> This tests for a working docker installation without sudo and sets up
>> config-host.mak accordingly. This will be useful from cross compiling
>> things in the future.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  configure | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 4d0e92c96c..b402befe94 100755
>> --- a/configure
>> +++ b/configure
>> @@ -451,6 +451,7 @@ jemalloc=3D"no"
>>  replication=3D"yes"
>>  vxhs=3D""
>>  libxml2=3D""
>> +docker=3D"no"
>>
>>  supported_cpu=3D"no"
>>  supported_os=3D"no"
>> @@ -5396,6 +5397,23 @@ EOF
>>    fi
>>  fi
>>
>> +##########################################
>> +# Docker and cross-compiler support
>> +#
>> +# This is specifically for building test
>> +# cases for foreign architectures, not
>> +# cross-compiling QEMU itself.
>> +
>> +if has "docker"; then
>> +    if docker images  >/dev/null 2>&1 ; then
>> +        docker=3D"yes"
>> +    else
>> +        # docker may be available but using sudo
>> +        # so we won't use it for cross-building
>> +        docker=3D"maybe"
>
> What is the problem with using sudo for cross-building?

Nothing in particular but we need someway of testing if the sudo is
passwordless otherwise you might find the build stuck waiting for user
interaction. This is fine for "make docker-foo" but for an eventual
unattended "make check" this may cause problems.

Is there a way we can test for this? Maybe we can push the docker probe
into docker.py and just return to configure if it can run docker
unattended?

--
Alex Benn=C3=A9e
