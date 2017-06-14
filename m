Received: from eggs.gnu.org ([2001:4830:134:3::10]:47868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLAVd-0006R6-9X
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLAVY-00050w-VS
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:47:05 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLAVY-00050k-NX
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:47:00 -0400
Received: by mail-wr0-x22f.google.com with SMTP id r103so3899933wrb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:47:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lviob2z.fsf@linaro.org>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-4-git-send-email-peter.maydell@linaro.org>
	<874lviob2z.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Jun 2017 16:46:38 +0100
Message-ID: <CAFEAcA_qyLNh2vsZROh+QgWkmqhn1kvO+CFJigVVXSY_qRDDgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] travis: Add config to do a Coverity
 Scan upload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 14 June 2017 at 16:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Add config to travis to do a Coverity Scan build and upload, using
>> the new run-coverity-scan script.
>>
>> There is an official integration between Travis and Coverity Scan:
>>  https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/=
addons/coverity_scan.rb
>> which slurps values out of the .travis.yml and downloads a build
>> script from Coverity which does the bulk of the work:
>>  https://scan.coverity.com/scripts/travisci_build_coverity_scan.sh
>>
>> However we choose to roll our own since this seems less
>> confusing and also allows us to include debug features
>> (notably the ability to do a "dry run" test which doesn't
>> actually upload anything).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  .travis.yml | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 26dabb6..d772a4a 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -210,3 +210,27 @@ matrix:
>>          - TEST_CMD=3D""
>>        before_script:
>>          - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3D=
thread -fuse-ld=3Dgold" || cat config.log
>> +    # Build and upload to Coverity Scan.
>> +    # We do not impose any rate limiting here, but instead rely on the
>> +    # limiting done by the coverity servers, which for a project of QEM=
U's
>> +    # size means one build a day. The run-coverity-scan script will exi=
t
>> +    # early if the limiter does not permit a new upload, so the effect =
will
>> +    # be that the first build (only) in each 24 hour period will be sca=
nned.
>> +    # If we needed to apply a limit at the Travis end, the simplest app=
roach
>> +    # would be to run the scan only if the branch was 'coverity-scan', =
and
>> +    # use a cron job to push master to the 'coverity-scan' branch perio=
dically.
>> +    # We run on the trusty Travis hosts so that there's a wider set of
>> +    # dependencies satisfied to improve coverage.
>> +    - dist: trusty
>
> I think we ought to add a sudo: stanza here to make it explicit if we
> want the containerised or VM based trusty image here. I'm wildly
> assuming we need lots of memory for this build so I would suggest:
>
>  sudo: required

It works with both, and the default as set in the top of the travis
config is for not-required so that's what I went with. I think the
sudo:required setups give you less CPU which makes it even more
likely to hit the 50 minute timeout.

>> +      env:
>> +        - COVERITY=3D1
>> +        - COVERITY_BUILD_CMD=3D"make -j3"
>> +        - COVERITY_EMAIL=3Dpeter.maydell@linaro.org
>> +        # This 'secure' setting sets COVERITY_TOKEN=3D<secret token>
>> +        # and was created with travis encrypt -r qemu/qemu COVERITY_TOK=
EN=3D...
>> +        - secure: "D3E6E5bacui53fYBQrx0wQr8ZTvo6VIBPKfg0QHj2uwa6OPFkUlc=
Mr/EHWvdbZNAa4Q1bv1vhlED5OPRfPmQYzxQNT4SAxDZeuZnikgIymfqQXNOjKw4kRUDO9P42Qa=
nyFd+EAu2JDVClAeJPgBpa/ns4CNrGDK+Q3coGndCP8o=3D"
>> +      before_script:
>> +        - if [ "$TRAVIS_PULL_REQUEST" =3D "true" ]; then echo "Skipping=
 Coverity (pullreq)"; exit 0; fi
>> +        - if [ "$TRAVIS_BRANCH" !=3D "master" ]; then echo "Skipping
>> Coverity (wrong branch)"; exit 0; fi
>
> This doesn't actually skip anything - but you can't exit non-zero
> without breaking the build. You would need to touch a file or something
> to make run-coverity-scan skip its work.

Yes, you're right. That's a bit awkward.

thanks
-- PMM
