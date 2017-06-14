Received: from eggs.gnu.org ([2001:4830:134:3::10]:35685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL9zr-0004ML-MP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL9zn-0004vu-Mr
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:14:15 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL9zn-0004vV-Fa
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:14:11 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 77so4864288wrb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:14:11 -0700 (PDT)
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-4-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1497369290-20401-4-git-send-email-peter.maydell@linaro.org>
Date: Wed, 14 Jun 2017 16:14:44 +0100
Message-ID: <874lviob2z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add config to travis to do a Coverity Scan build and upload, using
> the new run-coverity-scan script.
>
> There is an official integration between Travis and Coverity Scan:
>  https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/addons/coverity_scan.rb
> which slurps values out of the .travis.yml and downloads a build
> script from Coverity which does the bulk of the work:
>  https://scan.coverity.com/scripts/travisci_build_coverity_scan.sh
>
> However we choose to roll our own since this seems less
> confusing and also allows us to include debug features
> (notably the ability to do a "dry run" test which doesn't
> actually upload anything).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  .travis.yml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 26dabb6..d772a4a 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -210,3 +210,27 @@ matrix:
>          - TEST_CMD=""
>        before_script:
>          - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
> +    # Build and upload to Coverity Scan.
> +    # We do not impose any rate limiting here, but instead rely on the
> +    # limiting done by the coverity servers, which for a project of QEMU's
> +    # size means one build a day. The run-coverity-scan script will exit
> +    # early if the limiter does not permit a new upload, so the effect will
> +    # be that the first build (only) in each 24 hour period will be scanned.
> +    # If we needed to apply a limit at the Travis end, the simplest approach
> +    # would be to run the scan only if the branch was 'coverity-scan', and
> +    # use a cron job to push master to the 'coverity-scan' branch periodically.
> +    # We run on the trusty Travis hosts so that there's a wider set of
> +    # dependencies satisfied to improve coverage.
> +    - dist: trusty

I think we ought to add a sudo: stanza here to make it explicit if we
want the containerised or VM based trusty image here. I'm wildly
assuming we need lots of memory for this build so I would suggest:

 sudo: required

> +      env:
> +        - COVERITY=1
> +        - COVERITY_BUILD_CMD="make -j3"
> +        - COVERITY_EMAIL=peter.maydell@linaro.org
> +        # This 'secure' setting sets COVERITY_TOKEN=<secret token>
> +        # and was created with travis encrypt -r qemu/qemu COVERITY_TOKEN=...
> +        - secure: "D3E6E5bacui53fYBQrx0wQr8ZTvo6VIBPKfg0QHj2uwa6OPFkUlcMr/EHWvdbZNAa4Q1bv1vhlED5OPRfPmQYzxQNT4SAxDZeuZnikgIymfqQXNOjKw4kRUDO9P42QanyFd+EAu2JDVClAeJPgBpa/ns4CNrGDK+Q3coGndCP8o="
> +      before_script:
> +        - if [ "$TRAVIS_PULL_REQUEST" = "true" ]; then echo "Skipping Coverity (pullreq)"; exit 0; fi
> +        - if [ "$TRAVIS_BRANCH" != "master" ]; then echo "Skipping
> Coverity (wrong branch)"; exit 0; fi

This doesn't actually skip anything - but you can't exit non-zero
without breaking the build. You would need to touch a file or something
to make run-coverity-scan skip its work.

> +      script:
> +        - ./scripts/run-coverity-scan


--
Alex Bennée
