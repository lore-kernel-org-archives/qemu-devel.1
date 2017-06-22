Received: from eggs.gnu.org ([2001:4830:134:3::10]:36531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dO2VZ-0006xV-A6
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dO2VV-00048z-6U
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:50:53 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dO2VU-00048r-Vi
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:50:49 -0400
Received: by mail-wr0-x231.google.com with SMTP id c11so24384178wrc.3
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 06:50:48 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-12-f4bug@amsat.org>
	<87a850tjft.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87a850tjft.fsf@linaro.org>
Date: Thu, 22 Jun 2017 14:51:31 +0100
Message-ID: <87y3skruzg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/21] travis: cache git submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


Alex Bennée <alex.bennee@linaro.org> writes:

> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> Travis caching uses the branch name to store packed cache, so each new branch
>> will trigger a cache miss and will clone all submodules. Subsequent builds will
>> benefit from the cache.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
> \o/
>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Hmmm looking deeper it doesn't look as though we are benefiting from the
caching here. The submodule checkout is around 60-70s with some jobs
coming down to 30-40s. The old system seems to be ~20s for the
wget/checkout step (assuming the wget is cached).

>
>
>> ---
>>  .travis.yml | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 62b9dfd2ae..777914f759 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -7,6 +7,8 @@ compiler:
>>  cache:
>>    ccache: true
>>    timeout: 1200 # https://docs.travis-ci.com/user/caching#setting-the-timeout
>> +  directories:
>> +  - $HOME/qemu/.git/modules
>>  addons:
>>    apt:
>>      packages:
>> @@ -74,7 +76,6 @@ git:
>>  before_install:
>>    - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
>>    - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
>> -  - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>>    - git submodule update --init --recursive
>>  before_script:
>>    - ./configure ${CONFIG}
>> @@ -113,7 +114,6 @@ matrix:
>>        before_install:
>>          - sudo apt-get update -qq
>>          - sudo apt-get build-dep -qq qemu
>> -        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>>          - git submodule update --init --recursive
>>      # Plain Trusty Linux User Build
>>      - env: CONFIG="--disable-system"
>> @@ -124,7 +124,6 @@ matrix:
>>        before_install:
>>          - sudo apt-get update -qq
>>          - sudo apt-get build-dep -qq qemu
>> -        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>>          - git submodule update --init --recursive
>>      # Trusty System build with latest stable clang
>>      - sudo: required
>> @@ -142,7 +141,6 @@ matrix:
>>          - travis_retry sudo apt-get update -qq
>>          - travis_retry sudo apt-get install -qq -y clang-3.9
>>          - sudo apt-get build-dep -qq qemu
>> -        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>>          - git submodule update --init --recursive
>>        before_script:
>>          - ./configure ${CONFIG} || cat config.log
>> @@ -162,7 +160,6 @@ matrix:
>>          - travis_retry sudo apt-get update -qq
>>          - travis_retry sudo apt-get install -qq -y clang-3.9
>>          - sudo apt-get build-dep -qq qemu
>> -        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>>          - git submodule update --init --recursive
>>        before_script:
>>          - ./configure ${CONFIG} || cat config.log


--
Alex Bennée
